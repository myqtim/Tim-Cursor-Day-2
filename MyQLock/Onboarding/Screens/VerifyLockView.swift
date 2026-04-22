import SwiftUI

struct VerifyLockView: View {
    @EnvironmentObject var flow: OnboardingState
    @EnvironmentObject var appState: AppState

    enum Phase {
        case idle, listening, verified, timedOut
    }

    @State private var phase: Phase = .idle
    @State private var progress: CGFloat = 0
    @State private var timer: Timer?

    var body: some View {
        OnboardingScaffold(
            title: titleCopy,
            subtitle: subtitleCopy,
            onBack: { stopTimer(); flow.back(to: .addLockMethod) },
            progress: (current: 4, total: 6),
            content: {
                VStack(spacing: DS.Spacing.lg) {
                    statusRing
                    statusCaption
                    infoCard
                }
            },
            footer: {
                switch phase {
                case .idle:
                    PrimaryButton(title: "I'm ready") {
                        startListening()
                    }
                    Button("Show me where the button is") {
                        flow.showFindCodeHelp = true
                    }
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.primary)
                    .frame(maxWidth: .infinity).frame(height: 44)

                case .listening:
                    PrimaryButton(title: "Listening…", isLoading: true, isEnabled: false) {}
                    Button("Cancel") {
                        cancelListening()
                    }
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.textSecondary)
                    .frame(maxWidth: .infinity).frame(height: 44)

                case .verified:
                    PrimaryButton(title: "Continue") {
                        appState.lock.isVerified = true
                        flow.advance(to: .nameLocation)
                    }

                case .timedOut:
                    PrimaryButton(title: "Try again") {
                        startListening()
                    }
                    Button("Troubleshoot") {
                        flow.showTroubleshooting = true
                    }
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.primary)
                    .frame(maxWidth: .infinity).frame(height: 44)
                }
            }
        )
        .onDisappear { stopTimer() }
    }

    private var titleCopy: String {
        switch phase {
        case .idle: return "Let's make sure it's yours"
        case .listening: return "Listening for your lock…"
        case .verified: return "Lock verified"
        case .timedOut: return "We didn't hear your lock"
        }
    }

    private var subtitleCopy: String {
        switch phase {
        case .idle:
            return "On the inside of the lock, press and hold the button for 2 seconds. When you're ready, tap below."
        case .listening:
            return "Keep the lock powered and your phone nearby. This usually takes a few seconds."
        case .verified:
            return "We paired with your myQ Smart Lock. You're ready to personalize it."
        case .timedOut:
            return "Try pressing the inside button again. Move closer and make sure the lock has power."
        }
    }

    private var statusRing: some View {
        ZStack {
            Circle()
                .stroke(DS.Color.border, lineWidth: 8)
                .frame(width: 180, height: 180)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(ringColor, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 180, height: 180)
                .animation(.linear(duration: 0.1), value: progress)
            Image(systemName: statusIcon)
                .font(.system(size: 56, weight: .semibold))
                .foregroundStyle(ringColor)
        }
    }

    private var statusIcon: String {
        switch phase {
        case .idle: return "hand.tap.fill"
        case .listening: return "dot.radiowaves.left.and.right"
        case .verified: return "checkmark.seal.fill"
        case .timedOut: return "exclamationmark.triangle.fill"
        }
    }

    private var ringColor: Color {
        switch phase {
        case .idle: return DS.Color.primary
        case .listening: return DS.Color.primary
        case .verified: return DS.Color.success
        case .timedOut: return DS.Color.warning
        }
    }

    private var statusCaption: some View {
        Text(statusCaptionText)
            .font(DS.Font.callout)
            .foregroundStyle(DS.Color.textSecondary)
            .multilineTextAlignment(.center)
    }

    private var statusCaptionText: String {
        switch phase {
        case .idle: return "Press and hold the inside button for 2 seconds."
        case .listening: return "Hold tight—this usually takes just a moment."
        case .verified: return "You're all set. Let's give it a name."
        case .timedOut: return "Still no signal. We can help you troubleshoot."
        }
    }

    private var infoCard: some View {
        HStack(alignment: .top, spacing: DS.Spacing.md) {
            Image(systemName: "info.circle.fill")
                .foregroundStyle(DS.Color.primary)
            Text("This quick check makes sure only you can add this lock to your account.")
                .font(DS.Font.callout)
                .foregroundStyle(DS.Color.textPrimary)
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.primaryTint)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
    }

    private func startListening() {
        phase = .listening
        progress = 0
        let duration: TimeInterval = 6 // demo
        let tick: TimeInterval = 0.1
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: tick, repeats: true) { t in
            progress += CGFloat(tick / duration)
            if progress >= 1.0 {
                progress = 1.0
                t.invalidate()
                phase = .verified
            }
        }
    }

    private func cancelListening() {
        stopTimer()
        phase = .idle
        progress = 0
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
