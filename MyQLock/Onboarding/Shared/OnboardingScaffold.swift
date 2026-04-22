import SwiftUI

struct OnboardingScaffold<Content: View, Footer: View>: View {
    let title: String
    let subtitle: String?
    var showBack: Bool = true
    var onBack: (() -> Void)? = nil
    var progress: (current: Int, total: Int)? = nil
    @ViewBuilder var content: () -> Content
    @ViewBuilder var footer: () -> Footer

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                VStack(alignment: .leading, spacing: DS.Spacing.lg) {
                    VStack(alignment: .leading, spacing: DS.Spacing.sm) {
                        Text(title)
                            .font(DS.Font.largeTitle)
                            .foregroundStyle(DS.Color.textPrimary)
                            .fixedSize(horizontal: false, vertical: true)
                        if let subtitle {
                            Text(subtitle)
                                .font(DS.Font.body)
                                .foregroundStyle(DS.Color.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    content()
                }
                .padding(.horizontal, DS.Spacing.lg)
                .padding(.top, DS.Spacing.md)
                .padding(.bottom, DS.Spacing.xl)
            }
            VStack(spacing: DS.Spacing.sm) {
                footer()
            }
            .padding(.horizontal, DS.Spacing.lg)
            .padding(.bottom, DS.Spacing.lg)
            .padding(.top, DS.Spacing.sm)
            .background(DS.Color.surfaceAlt)
        }
    }

    private var header: some View {
        HStack {
            if showBack, let onBack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(DS.Color.textPrimary)
                        .frame(width: 44, height: 44)
                        .background(DS.Color.surface)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(DS.Color.border, lineWidth: 1))
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Back")
            } else {
                Color.clear.frame(width: 44, height: 44)
            }
            Spacer()
            if let progress {
                ProgressDots(total: progress.total, current: progress.current)
            }
            Spacer()
            Color.clear.frame(width: 44, height: 44)
        }
        .padding(.horizontal, DS.Spacing.md)
        .padding(.top, DS.Spacing.sm)
        .padding(.bottom, DS.Spacing.xs)
    }
}
