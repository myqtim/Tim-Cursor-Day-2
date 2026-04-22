import SwiftUI

struct PrimaryButton: View {
    let title: String
    var systemImage: String? = nil
    var isLoading: Bool = false
    var isEnabled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: DS.Spacing.xs) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(DS.Color.textOnPrimary)
                }
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(DS.Font.buttonLabel)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundStyle(DS.Color.textOnPrimary)
            .background(isEnabled ? DS.Color.primary : DS.Color.primary.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        }
        .disabled(!isEnabled || isLoading)
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }
}

struct SecondaryButton: View {
    let title: String
    var systemImage: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: DS.Spacing.xs) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(DS.Font.buttonLabel)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundStyle(DS.Color.primary)
            .background(DS.Color.primaryTint)
            .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct TextLinkButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(DS.Font.bodyStrong)
                .foregroundStyle(DS.Color.primary)
        }
        .buttonStyle(.plain)
    }
}
