import SwiftUI

@main
struct MyQLockApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .tint(DS.Color.primary)
        }
    }
}

final class AppState: ObservableObject {
    enum Route {
        case onboarding
        case lockControls
    }

    @Published var route: Route = .onboarding
    @Published var lock: LockModel = .placeholderNew
}

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        switch appState.route {
        case .onboarding:
            OnboardingCoordinator()
        case .lockControls:
            LockControlsView()
        }
    }
}
