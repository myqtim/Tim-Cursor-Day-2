import SwiftUI

struct TroubleshootingSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: DS.Spacing.lg) {
                    Text("We'll get this sorted")
                        .font(DS.Font.title)
                        .foregroundStyle(DS.Color.textPrimary)
                    Text("Pick what best matches what you're seeing.")
                        .font(DS.Font.body)
                        .foregroundStyle(DS.Color.textSecondary)

                    section(title: "Bluetooth is off or denied") {
                        row(icon: "dot.radiowaves.left.and.right", title: "Turn Bluetooth on in Settings", subtitle: "Then come back and we'll pick up where we left off.")
                        linkButton(title: "Open Settings") {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        }
                    }

                    section(title: "Camera access is off") {
                        row(icon: "camera.fill", title: "Allow camera to scan the code", subtitle: "You can grant access in iOS Settings.")
                        linkButton(title: "Open Settings") {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        }
                    }

                    section(title: "Lock won't verify") {
                        row(icon: "ruler", title: "Move closer", subtitle: "Stand within 3 feet of the lock.")
                        row(icon: "bolt.fill", title: "Check batteries or power", subtitle: "Replace or charge the battery if it's low.")
                        row(icon: "arrow.clockwise", title: "Try verification again", subtitle: "Hold the inside button for a full 2 seconds.")
                    }

                    section(title: "Still stuck?") {
                        linkButton(title: "View installation guide") {}
                        linkButton(title: "Contact myQ support") {}
                    }
                }
                .padding(DS.Spacing.lg)
            }
            .background(DS.Color.surfaceAlt)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(DS.Color.primary)
                }
            }
        }
    }

    @ViewBuilder
    private func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: DS.Spacing.sm) {
            Text(title)
                .font(DS.Font.callout.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(DS.Color.textSecondary)
            content()
        }
    }

    private func row(icon: String, title: String, subtitle: String) -> some View {
        HStack(alignment: .top, spacing: DS.Spacing.md) {
            Image(systemName: icon)
                .foregroundStyle(DS.Color.primary)
                .font(.system(size: 18, weight: .semibold))
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.textPrimary)
                Text(subtitle)
                    .font(DS.Font.callout)
                    .foregroundStyle(DS.Color.textSecondary)
            }
            Spacer(minLength: 0)
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }

    private func linkButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(DS.Color.textMuted)
            }
            .padding(DS.Spacing.md)
            .background(DS.Color.primaryTint)
            .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct FindCodeHelpSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: DS.Spacing.lg) {
                    Text("Find your lock's code")
                        .font(DS.Font.title)
                        .foregroundStyle(DS.Color.textPrimary)
                    Text("Every myQ Smart Lock ships with a unique QR code and serial number.")
                        .font(DS.Font.body)
                        .foregroundStyle(DS.Color.textSecondary)

                    locationCard(
                        icon: "square.on.square",
                        title: "On the inside plate",
                        detail: "Peel back the battery cover—look for a white label with the QR code and a serial starting with MYQL."
                    )
                    locationCard(
                        icon: "shippingbox.fill",
                        title: "On the product box",
                        detail: "The same code is printed on the label on the side of the box."
                    )
                    locationCard(
                        icon: "doc.text.fill",
                        title: "In your order confirmation",
                        detail: "If you bought from myq.com, the serial is listed in your order email."
                    )
                }
                .padding(DS.Spacing.lg)
            }
            .background(DS.Color.surfaceAlt)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(DS.Color.primary)
                }
            }
        }
    }

    private func locationCard(icon: String, title: String, detail: String) -> some View {
        HStack(alignment: .top, spacing: DS.Spacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                    .fill(DS.Color.primaryTint)
                    .frame(width: 56, height: 56)
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(DS.Color.primary)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(DS.Font.bodyStrong)
                    .foregroundStyle(DS.Color.textPrimary)
                Text(detail)
                    .font(DS.Font.callout)
                    .foregroundStyle(DS.Color.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(DS.Spacing.md)
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }
}
