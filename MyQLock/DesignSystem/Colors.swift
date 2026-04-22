import SwiftUI

enum DS {}

extension DS {
    enum Color {
        static let primary = SwiftUI.Color(hex: 0x1F6FEB)
        static let primaryPressed = SwiftUI.Color(hex: 0x1657B5)
        static let primaryTint = SwiftUI.Color(hex: 0xE8F1FE)

        static let success = SwiftUI.Color(hex: 0x2E7D32)
        static let successTint = SwiftUI.Color(hex: 0xE8F3EA)
        static let warning = SwiftUI.Color(hex: 0xC45A00)
        static let danger = SwiftUI.Color(hex: 0xB42318)
        static let dangerTint = SwiftUI.Color(hex: 0xFDECEA)

        static let textPrimary = SwiftUI.Color(hex: 0x0F172A)
        static let textSecondary = SwiftUI.Color(hex: 0x475569)
        static let textMuted = SwiftUI.Color(hex: 0x64748B)
        static let textOnPrimary = SwiftUI.Color.white

        static let surface = SwiftUI.Color.white
        static let surfaceAlt = SwiftUI.Color(hex: 0xF5F7FA)
        static let surfaceOverlay = SwiftUI.Color.black.opacity(0.45)
        static let border = SwiftUI.Color(hex: 0xE2E8F0)
        static let borderStrong = SwiftUI.Color(hex: 0xCBD5E1)
        static let divider = SwiftUI.Color(hex: 0xEDF1F6)
    }
}

extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self = Color(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}
