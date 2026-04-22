import SwiftUI

struct LockControlsView: View {
    @EnvironmentObject var appState: AppState
    @State private var isLocked: Bool = true
    @State private var isBusy: Bool = false
    @State private var lastAction: String = "Locked automatically 2 minutes ago"

    var body: some View {
        ScrollView {
            VStack(spacing: DS.Spacing.lg) {
                header
                lockHero
                quickActions
                featureStatus
                activity
            }
            .padding(.horizontal, DS.Spacing.lg)
            .padding(.vertical, DS.Spacing.lg)
        }
        .background(DS.Color.surfaceAlt.ignoresSafeArea())
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(appState.lock.home)
                    .font(DS.Font.footnote.weight(.semibold))
                    .foregroundStyle(DS.Color.textMuted)
                    .textCase(.uppercase)
                Text(appState.lock.name.isEmpty ? "myQ Smart Lock" : appState.lock.name)
                    .font(DS.Font.title)
                    .foregroundStyle(DS.Color.textPrimary)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(DS.Color.textSecondary)
                    .frame(width: 44, height: 44)
                    .background(DS.Color.surface)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(DS.Color.border, lineWidth: 1))
            }
            .buttonStyle(.plain)
        }
    }

    private var lockHero: some View {
        VStack(spacing: DS.Spacing.md) {
            ZStack {
                Circle()
                    .fill(isLocked ? DS.Color.primaryTint : DS.Color.successTint)
                    .frame(width: 200, height: 200)
                Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                    .font(.system(size: 80, weight: .semibold))
                    .foregroundStyle(isLocked ? DS.Color.primary : DS.Color.success)
            }
            VStack(spacing: DS.Spacing.xxs) {
                Text(isLocked ? "Locked" : "Unlocked")
                    .font(DS.Font.title)
                    .foregroundStyle(DS.Color.textPrimary)
                Text(lastAction)
                    .font(DS.Font.callout)
                    .foregroundStyle(DS.Color.textSecondary)
            }
            Button(action: toggleLock) {
                HStack(spacing: DS.Spacing.xs) {
                    if isBusy {
                        ProgressView().tint(.white)
                    }
                    Image(systemName: isLocked ? "lock.open.fill" : "lock.fill")
                    Text(isLocked ? "Unlock" : "Lock")
                        .font(DS.Font.buttonLabel)
                }
                .foregroundStyle(DS.Color.textOnPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(DS.Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: DS.Radius.lg, style: .continuous))
            }
            .buttonStyle(.plain)
            .disabled(isBusy)
        }
        .padding(DS.Spacing.lg)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.lg, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.lg, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }

    private var quickActions: some View {
        HStack(spacing: DS.Spacing.sm) {
            actionTile(icon: "person.badge.plus", title: "Invite")
            actionTile(icon: "number.square", title: "PIN codes")
            actionTile(icon: "bell.badge.fill", title: "Alerts")
        }
    }

    private func actionTile(icon: String, title: String) -> some View {
        VStack(spacing: DS.Spacing.xs) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(DS.Color.primary)
            Text(title)
                .font(DS.Font.callout.weight(.medium))
                .foregroundStyle(DS.Color.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, DS.Spacing.md)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }

    private var featureStatus: some View {
        VStack(alignment: .leading, spacing: DS.Spacing.sm) {
            Text("Features")
                .font(DS.Font.callout.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(DS.Color.textSecondary)

            statusRow(
                icon: "faceid",
                title: "Face ID",
                value: appState.lock.requiresFaceID ? "Required to unlock" : "Off"
            )
            statusRow(
                icon: "antenna.radiowaves.left.and.right",
                title: "Remote unlock",
                value: appState.lock.remoteUnlockEnabled ? "On" : "Off"
            )
            statusRow(
                icon: "location.north.line.fill",
                title: "Auto-Unlock",
                value: appState.lock.autoUnlockEnabled
                    ? "\(appState.lock.autoUnlockRange.title) range"
                    : "Off"
            )
        }
    }

    private func statusRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: DS.Spacing.md) {
            Image(systemName: icon)
                .foregroundStyle(DS.Color.primary)
                .frame(width: 28)
            Text(title)
                .font(DS.Font.body)
                .foregroundStyle(DS.Color.textPrimary)
            Spacer()
            Text(value)
                .font(DS.Font.callout)
                .foregroundStyle(DS.Color.textSecondary)
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(DS.Color.textMuted)
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }

    private var activity: some View {
        VStack(alignment: .leading, spacing: DS.Spacing.sm) {
            HStack {
                Text("Recent activity")
                    .font(DS.Font.callout.weight(.semibold))
                    .textCase(.uppercase)
                    .foregroundStyle(DS.Color.textSecondary)
                Spacer()
                TextLinkButton(title: "See all") {}
            }
            activityRow(icon: "lock.fill", title: "Auto-locked", subtitle: "2 minutes ago")
            activityRow(icon: "person.fill", title: "Unlocked by you", subtitle: "Today, 8:14 AM")
            activityRow(icon: "checkmark.seal.fill", title: "Setup completed", subtitle: "Today")
        }
    }

    private func activityRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: DS.Spacing.md) {
            ZStack {
                Circle()
                    .fill(DS.Color.primaryTint)
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .foregroundStyle(DS.Color.primary)
                    .font(.system(size: 15, weight: .semibold))
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.textPrimary)
                Text(subtitle)
                    .font(DS.Font.footnote)
                    .foregroundStyle(DS.Color.textMuted)
            }
            Spacer()
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }

    private func toggleLock() {
        isBusy = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            isLocked.toggle()
            lastAction = isLocked ? "Locked just now" : "Unlocked just now"
            isBusy = false
        }
    }
}
