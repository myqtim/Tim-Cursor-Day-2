import SwiftUI

extension DS {
    enum Font {
        static let largeTitle = SwiftUI.Font.system(size: 30, weight: .bold, design: .rounded)
        static let title = SwiftUI.Font.system(size: 24, weight: .semibold, design: .rounded)
        static let titleSmall = SwiftUI.Font.system(size: 20, weight: .semibold, design: .rounded)
        static let body = SwiftUI.Font.system(size: 16, weight: .regular)
        static let bodyStrong = SwiftUI.Font.system(size: 16, weight: .semibold)
        static let callout = SwiftUI.Font.system(size: 15, weight: .regular)
        static let footnote = SwiftUI.Font.system(size: 13, weight: .regular)
        static let buttonLabel = SwiftUI.Font.system(size: 17, weight: .semibold)
    }

    enum Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    enum Radius {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let pill: CGFloat = 999
    }
}
