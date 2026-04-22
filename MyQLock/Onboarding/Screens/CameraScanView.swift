import SwiftUI

struct CameraScanView: View {
    @EnvironmentObject var flow: OnboardingState
    @EnvironmentObject var appState: AppState
    @State private var flashOn = false
    @State private var showNotRecognized = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            cameraBackdrop

            VStack {
                topBar
                Spacer()
                scanFrame
                Spacer()
                instructions
                footer
            }
            .padding(.horizontal, DS.Spacing.lg)
            .padding(.bottom, DS.Spacing.lg)

            if showNotRecognized {
                notRecognizedBanner
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .preferredColorScheme(.dark)
    }

    private var cameraBackdrop: some View {
        LinearGradient(
            colors: [Color(hex: 0x101828), Color(hex: 0x1F2937)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private var topBar: some View {
        HStack {
            circleIconButton(icon: "chevron.left") {
                flow.back(to: .addLockMethod)
            }
            Spacer()
            Text("Scan the code on your lock")
                .font(DS.Font.bodyStrong)
                .foregroundStyle(.white)
            Spacer()
            circleIconButton(icon: flashOn ? "bolt.fill" : "bolt") {
                flashOn.toggle()
            }
        }
        .padding(.top, DS.Spacing.sm)
    }

    private var scanFrame: some View {
        ZStack {
            Rectangle()
                .fill(Color.black.opacity(0.6))
                .ignoresSafeArea()
                .mask(
                    ZStack {
                        Rectangle()
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .frame(width: 260, height: 260)
                            .blendMode(.destinationOut)
                    }
                    .compositingGroup()
                )
                .frame(height: 320)
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(DS.Color.primary, lineWidth: 3)
                .frame(width: 260, height: 260)
            VStack {
                Spacer()
                Capsule()
                    .fill(DS.Color.primary)
                    .frame(width: 220, height: 2)
                    .opacity(0.8)
                Spacer()
            }
            .frame(width: 260, height: 260)
        }
    }

    private var instructions: some View {
        Text("Center the QR code inside the frame. We'll capture it automatically.")
            .multilineTextAlignment(.center)
            .font(DS.Font.callout)
            .foregroundStyle(Color.white.opacity(0.85))
            .padding(.horizontal, DS.Spacing.md)
            .padding(.top, DS.Spacing.md)
    }

    private var footer: some View {
        VStack(spacing: DS.Spacing.sm) {
            Button(action: simulateSuccess) {
                Text("Simulate scan success")
                    .font(DS.Font.buttonLabel)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(DS.Color.primary)
                    .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
            }
            .buttonStyle(.plain)
            Button("Enter serial number instead") {
                flow.advance(to: .serialEntry)
            }
            .font(DS.Font.bodyStrong)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            Button("Having trouble?") {
                withAnimation { showNotRecognized = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation { showNotRecognized = false }
                }
            }
            .font(DS.Font.callout)
            .foregroundStyle(Color.white.opacity(0.7))
            .frame(height: 32)
        }
        .padding(.top, DS.Spacing.md)
    }

    private var notRecognizedBanner: some View {
        VStack {
            HStack(alignment: .top, spacing: DS.Spacing.sm) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 2) {
                    Text("We couldn't read that code")
                        .font(DS.Font.bodyStrong)
                        .foregroundStyle(.white)
                    Text("Try more light, or enter the serial number instead.")
                        .font(DS.Font.callout)
                        .foregroundStyle(Color.white.opacity(0.9))
                }
                Spacer(minLength: 0)
            }
            .padding(DS.Spacing.md)
            .background(DS.Color.warning)
            .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
            .padding(.horizontal, DS.Spacing.lg)
            .padding(.top, 60)
            Spacer()
        }
    }

    private func simulateSuccess() {
        appState.lock.serialNumber = "MYQL90AXXB-DEMO"
        flow.advance(to: .verifyLock)
    }

    private func circleIconButton(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(Color.white.opacity(0.12))
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
