import SwiftUI

struct SecurityConvenienceView: View {
    @EnvironmentObject var flow: OnboardingState
    @EnvironmentObject var appState: AppState

    var body: some View {
        OnboardingScaffold(
            title: "Security & convenience",
            subtitle: "Turn on the features that fit your routine. You can change any of these later in Settings.",
            onBack: { flow.back(to: .nameLocation) },
            progress: (current: 6, total: 7),
            content: {
                VStack(alignment: .leading, spacing: DS.Spacing.lg) {
                    section(title: "Confirm it's you") {
                        ToggleRow(
                            title: "Require Face ID to unlock",
                            subtitle: "Adds a quick glance check before the door opens. Recommended.",
                            systemImage: "faceid",
                            isOn: $appState.lock.requiresFaceID
                        )
                    }

                    section(title: "From anywhere") {
                        ToggleRow(
                            title: "Remote unlock",
                            subtitle: "Unlock your door from the app when you're away. You can turn this off anytime.",
                            systemImage: "antenna.radiowaves.left.and.right",
                            isOn: $appState.lock.remoteUnlockEnabled
                        )
                    }

                    section(title: "Auto-Unlock") {
                        VStack(spacing: DS.Spacing.sm) {
                            ToggleRow(
                                title: "Unlock when I arrive",
                                subtitle: "Uses your location to open the door as you approach home.",
                                systemImage: "location.north.line.fill",
                                isOn: $appState.lock.autoUnlockEnabled
                            )
                            if appState.lock.autoUnlockEnabled {
                                SecondaryButton(title: "Set up Auto-Unlock", systemImage: "location.fill") {
                                    flow.advance(to: .autoUnlockSetup)
                                }
                            }
                        }
                    }
                }
            },
            footer: {
                PrimaryButton(title: appState.lock.autoUnlockEnabled ? "Review Auto-Unlock" : "Finish setup") {
                    if appState.lock.autoUnlockEnabled {
                        flow.advance(to: .autoUnlockSetup)
                    } else {
                        flow.advance(to: .success)
                    }
                }
                Button("Skip for now") {
                    flow.advance(to: .success)
                }
                .font(DS.Font.bodyStrong)
                .foregroundStyle(DS.Color.textSecondary)
                .frame(maxWidth: .infinity).frame(height: 44)
            }
        )
    }

    @ViewBuilder
    private func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: DS.Spacing.sm) {
            Text(title)
                .font(DS.Font.callout.weight(.semibold))
                .foregroundStyle(DS.Color.textSecondary)
                .textCase(.uppercase)
            content()
        }
    }
}
