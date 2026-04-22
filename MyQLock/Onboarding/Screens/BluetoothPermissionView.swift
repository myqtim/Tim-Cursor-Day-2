import SwiftUI

struct BluetoothPermissionView: View {
    @EnvironmentObject var flow: OnboardingState
    @State private var isRequesting = false

    var body: some View {
        OnboardingScaffold(
            title: "Allow Bluetooth",
            subtitle: "Bluetooth is how your phone recognizes your myQ Smart Lock during setup. It stays private to your device.",
            onBack: { flow.back(to: .beforeYouBegin) },
            progress: (current: 1, total: 6),
            content: {
                VStack(spacing: DS.Spacing.md) {
                    reassurancePanel
                    bulletList
                }
            },
            footer: {
                PrimaryButton(
                    title: isRequesting ? "Waiting for permission" : "Allow Bluetooth",
                    systemImage: "dot.radiowaves.left.and.right",
                    isLoading: isRequesting
                ) {
                    requestBluetooth()
                }
                Button("Why is this needed?") {
                    flow.showTroubleshooting = true
                }
                .font(DS.Font.bodyStrong)
                .foregroundStyle(DS.Color.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
            }
        )
    }

    private var reassurancePanel: some View {
        HStack(alignment: .top, spacing: DS.Spacing.md) {
            Image(systemName: "lock.shield")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(DS.Color.primary)
            VStack(alignment: .leading, spacing: DS.Spacing.xxs) {
                Text("Your setup stays private")
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.textPrimary)
                Text("We only use Bluetooth during setup and to keep your lock connected.")
                    .font(DS.Font.callout)
                    .foregroundStyle(DS.Color.textSecondary)
            }
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.primaryTint)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
    }

    private var bulletList: some View {
        VStack(alignment: .leading, spacing: DS.Spacing.sm) {
            bullet("Bluetooth is used to verify you own this lock.")
            bullet("We never share setup data with anyone else.")
            bullet("You can change this anytime in iOS Settings.")
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }

    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: DS.Spacing.sm) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(DS.Color.primary)
            Text(text)
                .font(DS.Font.callout)
                .foregroundStyle(DS.Color.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private func requestBluetooth() {
        isRequesting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isRequesting = false
            flow.advance(to: .addLockMethod)
        }
    }
}
