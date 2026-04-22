import SwiftUI

struct SuccessView: View {
    @EnvironmentObject var flow: OnboardingState
    @EnvironmentObject var appState: AppState
    @State private var appear = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: DS.Spacing.lg) {
                ZStack {
                    Circle()
                        .fill(DS.Color.successTint)
                        .frame(width: 140, height: 140)
                        .scaleEffect(appear ? 1 : 0.6)
                        .opacity(appear ? 1 : 0)
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundStyle(DS.Color.success)
                        .scaleEffect(appear ? 1 : 0.4)
                }
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: appear)

                VStack(spacing: DS.Spacing.sm) {
                    Text("You're all set")
                        .font(DS.Font.largeTitle)
                        .foregroundStyle(DS.Color.textPrimary)
                    Text(summary)
                        .multilineTextAlignment(.center)
                        .font(DS.Font.body)
                        .foregroundStyle(DS.Color.textSecondary)
                        .padding(.horizontal, DS.Spacing.md)
                }

                featureChips
            }
            .padding(.horizontal, DS.Spacing.lg)
            Spacer()

            VStack(spacing: DS.Spacing.sm) {
                PrimaryButton(title: "Go to lock controls") {
                    appState.route = .lockControls
                }
                SecondaryButton(title: "Invite someone", systemImage: "person.badge.plus") {
                    appState.route = .lockControls
                }
            }
            .padding(.horizontal, DS.Spacing.lg)
            .padding(.bottom, DS.Spacing.lg)
        }
        .onAppear { appear = true }
    }

    private var summary: String {
        let name = appState.lock.name.isEmpty ? "Your myQ Smart Lock" : appState.lock.name
        return "\(name) is connected and ready to use."
    }

    private var featureChips: some View {
        VStack(spacing: DS.Spacing.xs) {
            if appState.lock.requiresFaceID {
                chip(icon: "faceid", title: "Face ID is on")
            }
            if appState.lock.remoteUnlockEnabled {
                chip(icon: "antenna.radiowaves.left.and.right", title: "Remote unlock enabled")
            }
            if appState.lock.autoUnlockEnabled {
                chip(icon: "location.north.line.fill", title: "Auto-Unlock enabled")
            }
        }
    }

    private func chip(icon: String, title: String) -> some View {
        HStack(spacing: DS.Spacing.xs) {
            Image(systemName: icon)
                .foregroundStyle(DS.Color.primary)
            Text(title)
                .font(DS.Font.callout.weight(.medium))
                .foregroundStyle(DS.Color.textPrimary)
        }
        .padding(.horizontal, DS.Spacing.md)
        .padding(.vertical, DS.Spacing.xs)
        .background(DS.Color.primaryTint)
        .clipShape(Capsule())
    }
}
