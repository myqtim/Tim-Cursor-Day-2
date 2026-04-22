import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    case welcome
    case beforeYouBegin
    case bluetoothPermission
    case addLockMethod
    case cameraScan
    case serialEntry
    case verifyLock
    case nameLocation
    case securityConvenience
    case autoUnlockSetup
    case success
}

final class OnboardingState: ObservableObject {
    @Published var step: OnboardingStep = .welcome
    @Published var path = NavigationPath()
    @Published var showTroubleshooting: Bool = false
    @Published var showFindCodeHelp: Bool = false

    func advance(to step: OnboardingStep) {
        withAnimation(.easeInOut(duration: 0.28)) {
            self.step = step
        }
    }

    func back(to step: OnboardingStep) {
        withAnimation(.easeInOut(duration: 0.28)) {
            self.step = step
        }
    }
}

struct OnboardingCoordinator: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var flow = OnboardingState()

    var body: some View {
        ZStack {
            DS.Color.surfaceAlt.ignoresSafeArea()
            Group {
                switch flow.step {
                case .welcome:
                    WelcomeView()
                case .beforeYouBegin:
                    BeforeYouBeginView()
                case .bluetoothPermission:
                    BluetoothPermissionView()
                case .addLockMethod:
                    AddLockMethodView()
                case .cameraScan:
                    CameraScanView()
                case .serialEntry:
                    SerialEntryView()
                case .verifyLock:
                    VerifyLockView()
                case .nameLocation:
                    NameLocationView()
                case .securityConvenience:
                    SecurityConvenienceView()
                case .autoUnlockSetup:
                    AutoUnlockSetupView()
                case .success:
                    SuccessView()
                }
            }
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
        }
        .environmentObject(flow)
        .sheet(isPresented: $flow.showTroubleshooting) {
            TroubleshootingSheet()
        }
        .sheet(isPresented: $flow.showFindCodeHelp) {
            FindCodeHelpSheet()
        }
    }
}
