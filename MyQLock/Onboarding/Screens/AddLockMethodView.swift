import SwiftUI

struct AddLockMethodView: View {
    @EnvironmentObject var flow: OnboardingState

    var body: some View {
        OnboardingScaffold(
            title: "Let's find your lock",
            subtitle: "Choose how you'd like to add it. Scanning is the fastest.",
            onBack: { flow.back(to: .bluetoothPermission) },
            progress: (current: 2, total: 6),
            content: {
                VStack(spacing: DS.Spacing.sm) {
                    methodCard(
                        icon: "qrcode.viewfinder",
                        title: "Scan QR code",
                        subtitle: "Use the camera to scan the code printed on your lock.",
                        recommended: true
                    ) {
                        flow.advance(to: .cameraScan)
                    }
                    methodCard(
                        icon: "textformat.123",
                        title: "Enter serial number",
                        subtitle: "Type the serial number printed on the inside plate."
                    ) {
                        flow.advance(to: .serialEntry)
                    }
                    Button(action: { flow.showFindCodeHelp = true }) {
                        HStack(spacing: DS.Spacing.xs) {
                            Image(systemName: "questionmark.circle")
                            Text("Where do I find this?")
                                .font(DS.Font.bodyStrong)
                        }
                        .foregroundStyle(DS.Color.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                    }
                    .buttonStyle(.plain)
                }
            },
            footer: { EmptyView() }
        )
    }

    private func methodCard(
        icon: String,
        title: String,
        subtitle: String,
        recommended: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: DS.Spacing.md) {
                ZStack {
                    RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                        .fill(DS.Color.primaryTint)
                        .frame(width: 56, height: 56)
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(DS.Color.primary)
                }
                VStack(alignment: .leading, spacing: DS.Spacing.xxs) {
                    HStack(spacing: DS.Spacing.xs) {
                        Text(title)
                            .font(DS.Font.bodyStrong)
                            .foregroundStyle(DS.Color.textPrimary)
                        if recommended {
                            Text("Recommended")
                                .font(DS.Font.footnote.weight(.semibold))
                                .foregroundStyle(DS.Color.primary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(DS.Color.primaryTint)
                                .clipShape(Capsule())
                        }
                    }
                    Text(subtitle)
                        .font(DS.Font.callout)
                        .foregroundStyle(DS.Color.textSecondary)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer(minLength: 0)
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(DS.Color.textMuted)
                    .padding(.top, DS.Spacing.xs)
            }
            .padding(DS.Spacing.md)
            .background(DS.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                    .stroke(DS.Color.border, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}
