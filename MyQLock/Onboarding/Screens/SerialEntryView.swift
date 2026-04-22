import SwiftUI

struct SerialEntryView: View {
    @EnvironmentObject var flow: OnboardingState
    @EnvironmentObject var appState: AppState
    @State private var serial: String = ""
    @FocusState private var focused: Bool

    private var isValid: Bool {
        let trimmed = serial.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count >= 8
    }

    private var showError: Bool {
        !serial.isEmpty && !isValid
    }

    var body: some View {
        OnboardingScaffold(
            title: "Enter serial number",
            subtitle: "You'll find this on the inside plate of your myQ Smart Lock and on the box label.",
            onBack: { flow.back(to: .addLockMethod) },
            progress: (current: 3, total: 6),
            content: {
                VStack(alignment: .leading, spacing: DS.Spacing.sm) {
                    Text("Serial number")
                        .font(DS.Font.callout.weight(.semibold))
                        .foregroundStyle(DS.Color.textSecondary)
                    TextField("", text: $serial)
                        .font(DS.Font.body)
                        .foregroundStyle(DS.Color.textPrimary)
                        .textInputAutocapitalization(.characters)
                        .autocorrectionDisabled()
                        .focused($focused)
                        .padding(DS.Spacing.md)
                        .background(DS.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                                .stroke(showError ? DS.Color.danger : DS.Color.border, lineWidth: 1)
                        )
                    if showError {
                        HStack(spacing: DS.Spacing.xs) {
                            Image(systemName: "exclamationmark.circle.fill")
                            Text("That doesn't look right. Double-check the serial on your lock.")
                        }
                        .font(DS.Font.footnote)
                        .foregroundStyle(DS.Color.danger)
                    } else {
                        Text("Usually 10–14 characters, letters and numbers.")
                            .font(DS.Font.footnote)
                            .foregroundStyle(DS.Color.textMuted)
                    }

                    Button(action: { flow.showFindCodeHelp = true }) {
                        HStack(spacing: DS.Spacing.xs) {
                            Image(systemName: "questionmark.circle")
                            Text("Where is it printed?")
                                .font(DS.Font.bodyStrong)
                        }
                        .foregroundStyle(DS.Color.primary)
                    }
                    .buttonStyle(.plain)
                    .padding(.top, DS.Spacing.xs)
                }
            },
            footer: {
                PrimaryButton(title: "Continue", isEnabled: isValid) {
                    appState.lock.serialNumber = serial.trimmingCharacters(in: .whitespacesAndNewlines)
                    flow.advance(to: .verifyLock)
                }
            }
        )
        .onAppear { focused = true }
    }
}
