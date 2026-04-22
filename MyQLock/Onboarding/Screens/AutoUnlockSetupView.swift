import SwiftUI

struct AutoUnlockSetupView: View {
    @EnvironmentObject var flow: OnboardingState
    @EnvironmentObject var appState: AppState
    @State private var requestingLocation = false

    var body: some View {
        OnboardingScaffold(
            title: "Set up Auto-Unlock",
            subtitle: "We'll use your location to open the door as you get home. You're in control—turn it off anytime.",
            onBack: { flow.back(to: .securityConvenience) },
            progress: (current: 6, total: 7),
            content: {
                VStack(alignment: .leading, spacing: DS.Spacing.lg) {
                    reassurance

                    VStack(alignment: .leading, spacing: DS.Spacing.sm) {
                        Text("Unlock range")
                            .font(DS.Font.callout.weight(.semibold))
                            .foregroundStyle(DS.Color.textSecondary)
                            .textCase(.uppercase)
                        VStack(spacing: DS.Spacing.sm) {
                            ForEach(AutoUnlockRange.allCases) { range in
                                rangeRow(range)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: DS.Spacing.sm) {
                        Text("Quiet hours")
                            .font(DS.Font.callout.weight(.semibold))
                            .foregroundStyle(DS.Color.textSecondary)
                            .textCase(.uppercase)
                        ToggleRow(
                            title: "Don't Auto-Unlock at night",
                            subtitle: "Pauses Auto-Unlock between 10:00 PM and 6:00 AM.",
                            systemImage: "moon.stars.fill",
                            isOn: $appState.lock.suppressAutoUnlockAtNight
                        )
                    }
                }
            },
            footer: {
                PrimaryButton(
                    title: requestingLocation ? "Waiting for permission" : "Enable Auto-Unlock",
                    systemImage: "location.fill",
                    isLoading: requestingLocation
                ) {
                    requestLocation()
                }
                Button("Maybe later") {
                    appState.lock.autoUnlockEnabled = false
                    flow.advance(to: .success)
                }
                .font(DS.Font.bodyStrong)
                .foregroundStyle(DS.Color.textSecondary)
                .frame(maxWidth: .infinity).frame(height: 44)
            }
        )
    }

    private var reassurance: some View {
        HStack(alignment: .top, spacing: DS.Spacing.md) {
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(DS.Color.primary)
            VStack(alignment: .leading, spacing: DS.Spacing.xxs) {
                Text("Private by design")
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.textPrimary)
                Text("Your location is only used to unlock this door. Nothing is sold or shared.")
                    .font(DS.Font.callout)
                    .foregroundStyle(DS.Color.textSecondary)
            }
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.primaryTint)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
    }

    private func rangeRow(_ range: AutoUnlockRange) -> some View {
        let isSelected = appState.lock.autoUnlockRange == range
        return Button(action: { appState.lock.autoUnlockRange = range }) {
            HStack(alignment: .top, spacing: DS.Spacing.md) {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundStyle(isSelected ? DS.Color.primary : DS.Color.textMuted)
                    .font(.system(size: 22))
                VStack(alignment: .leading, spacing: DS.Spacing.xxs) {
                    Text(range.title)
                        .font(DS.Font.bodyStrong)
                        .foregroundStyle(DS.Color.textPrimary)
                    Text(range.description)
                        .font(DS.Font.callout)
                        .foregroundStyle(DS.Color.textSecondary)
                }
                Spacer(minLength: 0)
            }
            .padding(DS.Spacing.md)
            .background(DS.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                    .stroke(isSelected ? DS.Color.primary : DS.Color.border, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }

    private func requestLocation() {
        requestingLocation = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            requestingLocation = false
            appState.lock.autoUnlockEnabled = true
            flow.advance(to: .success)
        }
    }
}
