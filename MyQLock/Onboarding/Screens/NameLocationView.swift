import SwiftUI

struct NameLocationView: View {
    @EnvironmentObject var flow: OnboardingState
    @EnvironmentObject var appState: AppState
    @State private var name: String = ""
    @State private var selectedHome: String = "Home"
    @State private var room: String = ""
    @FocusState private var nameFocused: Bool

    private let suggestedNames = ["Front Door", "Back Door", "Side Entry", "Garage Entry"]
    private let homes = ["Home", "Vacation House", "Rental"]

    private var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        OnboardingScaffold(
            title: "Give it a name",
            subtitle: "A friendly name helps everyone in your home know which door this is.",
            onBack: { flow.back(to: .verifyLock) },
            progress: (current: 5, total: 6),
            content: {
                VStack(alignment: .leading, spacing: DS.Spacing.md) {
                    Text("Lock name")
                        .font(DS.Font.callout.weight(.semibold))
                        .foregroundStyle(DS.Color.textSecondary)
                    TextField("", text: $name)
                        .font(DS.Font.body)
                        .focused($nameFocused)
                        .padding(DS.Spacing.md)
                        .background(DS.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                                .stroke(DS.Color.border, lineWidth: 1)
                        )
                    chips
                    Divider().background(DS.Color.divider).padding(.vertical, DS.Spacing.xs)

                    Text("Home")
                        .font(DS.Font.callout.weight(.semibold))
                        .foregroundStyle(DS.Color.textSecondary)
                    homePicker

                    Text("Room (optional)")
                        .font(DS.Font.callout.weight(.semibold))
                        .foregroundStyle(DS.Color.textSecondary)
                    TextField("", text: $room)
                        .font(DS.Font.body)
                        .padding(DS.Spacing.md)
                        .background(DS.Color.surface)
                        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                                .stroke(DS.Color.border, lineWidth: 1)
                        )
                }
            },
            footer: {
                PrimaryButton(title: "Save and continue", isEnabled: isValid) {
                    appState.lock.name = name.trimmingCharacters(in: .whitespaces)
                    appState.lock.home = selectedHome
                    appState.lock.room = room.isEmpty ? nil : room
                    flow.advance(to: .securityConvenience)
                }
            }
        )
        .onAppear { nameFocused = true }
    }

    private var chips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DS.Spacing.xs) {
                ForEach(suggestedNames, id: \.self) { suggestion in
                    Button(action: { name = suggestion }) {
                        Text(suggestion)
                            .font(DS.Font.callout.weight(.medium))
                            .foregroundStyle(name == suggestion ? DS.Color.textOnPrimary : DS.Color.primary)
                            .padding(.horizontal, DS.Spacing.md)
                            .padding(.vertical, DS.Spacing.xs)
                            .background(name == suggestion ? DS.Color.primary : DS.Color.primaryTint)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var homePicker: some View {
        VStack(spacing: 0) {
            ForEach(homes, id: \.self) { home in
                Button(action: { selectedHome = home }) {
                    HStack {
                        Text(home)
                            .font(DS.Font.body)
                            .foregroundStyle(DS.Color.textPrimary)
                        Spacer()
                        if selectedHome == home {
                            Image(systemName: "checkmark")
                                .foregroundStyle(DS.Color.primary)
                                .font(.system(size: 15, weight: .semibold))
                        }
                    }
                    .padding(.horizontal, DS.Spacing.md)
                    .padding(.vertical, DS.Spacing.sm)
                }
                .buttonStyle(.plain)
                if home != homes.last {
                    Divider().background(DS.Color.divider).padding(.leading, DS.Spacing.md)
                }
            }
        }
        .background(DS.Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.Radius.md, style: .continuous)
                .stroke(DS.Color.border, lineWidth: 1)
        )
    }
}
