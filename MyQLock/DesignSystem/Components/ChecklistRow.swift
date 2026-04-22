import SwiftUI

struct ChecklistRow: View {
    let systemImage: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(alignment: .top, spacing: DS.Spacing.md) {
            ZStack {
                Circle()
                    .fill(DS.Color.primaryTint)
                    .frame(width: 40, height: 40)
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(DS.Color.primary)
            }
            VStack(alignment: .leading, spacing: DS.Spacing.xxs) {
                Text(title)
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.textPrimary)
                Text(subtitle)
                    .font(DS.Font.callout)
                    .foregroundStyle(DS.Color.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }
}

struct ToggleRow: View {
    let title: String
    let subtitle: String
    var systemImage: String? = nil
    @Binding var isOn: Bool

    var body: some View {
        HStack(alignment: .top, spacing: DS.Spacing.md) {
            if let systemImage {
                ZStack {
                    Circle()
                        .fill(DS.Color.primaryTint)
                        .frame(width: 36, height: 36)
                    Image(systemName: systemImage)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(DS.Color.primary)
                }
            }
            VStack(alignment: .leading, spacing: DS.Spacing.xxs) {
                Text(title)
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.textPrimary)
                Text(subtitle)
                    .font(DS.Font.callout)
                    .foregroundStyle(DS.Color.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(DS.Color.primary)
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }
}

struct ProgressDots: View {
    let total: Int
    let current: Int

    var body: some View {
        HStack(spacing: DS.Spacing.xxs) {
            ForEach(0..<total, id: \.self) { index in
                Capsule()
                    .fill(index <= current ? DS.Color.primary : DS.Color.border)
                    .frame(width: index == current ? 22 : 8, height: 6)
                    .animation(.easeInOut(duration: 0.25), value: current)
            }
        }
        .accessibilityLabel("Step \(current + 1) of \(total)")
    }
}
