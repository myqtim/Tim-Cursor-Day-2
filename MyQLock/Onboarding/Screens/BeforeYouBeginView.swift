import SwiftUI

struct BeforeYouBeginView: View {
    @EnvironmentObject var flow: OnboardingState

    var body: some View {
        OnboardingScaffold(
            title: "Before you begin",
            subtitle: "A few quick checks so setup goes smoothly.",
            onBack: { flow.back(to: .welcome) },
            progress: (current: 0, total: 6),
            content: {
                VStack(spacing: DS.Spacing.sm) {
                    ChecklistRow(
                        systemImage: "ruler",
                        title: "Stand within 3 feet of the lock",
                        subtitle: "Staying close helps your phone pair quickly and reliably."
                    )
                    ChecklistRow(
                        systemImage: "bolt.fill",
                        title: "Make sure the lock has power",
                        subtitle: "Install the included battery or keep it charged."
                    )
                    ChecklistRow(
                        systemImage: "wave.3.right",
                        title: "Turn Bluetooth on",
                        subtitle: "We'll use Bluetooth to verify your lock securely."
                    )
                }
            },
            footer: {
                PrimaryButton(title: "Continue") {
                    flow.advance(to: .bluetoothPermission)
                }
                Button("Need help?") {
                    flow.showTroubleshooting = true
                }
                .font(DS.Font.bodyStrong)
                .foregroundStyle(DS.Color.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
            }
        )
    }
}
