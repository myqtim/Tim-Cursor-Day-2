import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var flow: OnboardingState
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: DS.Spacing.xl) {
                    heroIllustration
                    VStack(spacing: DS.Spacing.sm) {
                        Text("Let's set up your\nmyQ Smart Lock")
                            .multilineTextAlignment(.center)
                            .font(DS.Font.largeTitle)
                            .foregroundStyle(DS.Color.textPrimary)
                        Text("Takes about 2 minutes. You'll need the code printed on your lock or its packaging.")
                            .multilineTextAlignment(.center)
                            .font(DS.Font.body)
                            .foregroundStyle(DS.Color.textSecondary)
                            .padding(.horizontal, DS.Spacing.md)
                    }
                    trustBadges
                }
                .padding(.horizontal, DS.Spacing.lg)
                .padding(.top, DS.Spacing.xxl)
                .padding(.bottom, DS.Spacing.xl)
            }

            VStack(spacing: DS.Spacing.sm) {
                PrimaryButton(title: "Get started") {
                    flow.advance(to: .beforeYouBegin)
                }
                Button("Not now") {
                    appState.route = .lockControls
                }
                .font(DS.Font.bodyStrong)
                .foregroundStyle(DS.Color.textSecondary)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
            }
            .padding(.horizontal, DS.Spacing.lg)
            .padding(.bottom, DS.Spacing.lg)
        }
    }

    private var heroIllustration: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(DS.Color.primaryTint)
                .frame(height: 240)
            VStack(spacing: DS.Spacing.sm) {
                ZStack {
                    Circle()
                        .fill(DS.Color.surface)
                        .frame(width: 120, height: 120)
                        .shadow(color: DS.Color.primary.opacity(0.15), radius: 14, y: 6)
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundStyle(DS.Color.primary)
                }
                Text("myQ Smart Lock")
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.textPrimary)
            }
        }
    }

    private var trustBadges: some View {
        HStack(spacing: DS.Spacing.sm) {
            badge(icon: "bolt.shield.fill", label: "Encrypted setup")
            badge(icon: "hand.raised.fill", label: "You're in control")
            badge(icon: "checkmark.seal.fill", label: "Verified device")
        }
    }

    private func badge(icon: String, label: String) -> some View {
        VStack(spacing: DS.Spacing.xs) {
            Image(systemName: icon)
                .foregroundStyle(DS.Color.primary)
                .font(.system(size: 18, weight: .semibold))
            Text(label)
                .font(DS.Font.footnote)
                .foregroundStyle(DS.Color.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, DS.Spacing.sm)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }
}
