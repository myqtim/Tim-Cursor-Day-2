import Foundation

struct LockModel: Equatable {
    var name: String
    var home: String
    var room: String?
    var serialNumber: String?
    var isVerified: Bool
    var requiresFaceID: Bool
    var remoteUnlockEnabled: Bool
    var autoUnlockEnabled: Bool
    var autoUnlockRange: AutoUnlockRange
    var suppressAutoUnlockAtNight: Bool

    static let placeholderNew = LockModel(
        name: "",
        home: "Home",
        room: nil,
        serialNumber: nil,
        isVerified: false,
        requiresFaceID: true,
        remoteUnlockEnabled: false,
        autoUnlockEnabled: false,
        autoUnlockRange: .near,
        suppressAutoUnlockAtNight: false
    )
}

enum AutoUnlockRange: String, CaseIterable, Identifiable {
    case veryNear
    case near

    var id: String { rawValue }

    var title: String {
        switch self {
        case .veryNear: return "Very near"
        case .near: return "Near"
        }
    }

    var description: String {
        switch self {
        case .veryNear: return "Unlocks within a few steps of the door."
        case .near: return "Unlocks as you approach the house."
        }
    }
}
