# myQ Smart Lock — iPhone Onboarding

A SwiftUI prototype of the iPhone onboarding flow for setting up a newly connected **myQ Smart Lock**, plus a post-onboarding **Lock Controls** screen.

Tone: friendly and trustworthy. Copy is production-ready (no placeholder text).

## Flow implemented

1. Welcome
2. Before you begin (checklist)
3. Allow Bluetooth (permission rationale)
4. Add a lock — choose method (QR or serial)
5. Camera scan (with retry / switch-to-serial)
6. Serial entry (validated, inline error + helper)
7. Verify this is your lock (idle → listening → verified / timed out)
8. Give it a name (suggested chips, home picker, optional room)
9. Security & convenience (Face ID, Remote Unlock, Auto-Unlock)
10. Auto-Unlock setup (range selection, quiet hours, permission flow)
11. You're all set (summary + enabled features)
12. Lock Controls landing (Lock/Unlock hero, quick actions, feature status, activity)

Supporting sheets:
- Troubleshooting (Bluetooth / camera / verification issues, Open Settings deep links)
- Find your lock's code (inside plate, box label, order email)

## Design system

Lightweight, token-driven:
- `DS.Color` — primary, primary tint, text roles, surface/border, success/warning/danger
- `DS.Font` — rounded display for titles, system for body and labels
- `DS.Spacing`, `DS.Radius`
- Components: `PrimaryButton`, `SecondaryButton`, `TextLinkButton`, `ChecklistRow`, `ToggleRow`, `ProgressDots`, `OnboardingScaffold`

The palette is a modern-minimal default. When the real Figma design-system tokens are available, swap the values in `MyQLock/DesignSystem/Colors.swift` and `Typography.swift`.

## Project structure

```
MyQLock/
  App/
    MyQLockApp.swift            # App entry, AppState, RootView
  DesignSystem/
    Colors.swift
    Typography.swift
    Components/
      PrimaryButton.swift
      ChecklistRow.swift        # ChecklistRow, ToggleRow, ProgressDots
  Models/
    LockModel.swift             # Lock data, AutoUnlockRange
  Onboarding/
    OnboardingCoordinator.swift # Step enum + animated router
    Shared/OnboardingScaffold.swift
    Screens/
      WelcomeView.swift
      BeforeYouBeginView.swift
      BluetoothPermissionView.swift
      AddLockMethodView.swift
      CameraScanView.swift
      SerialEntryView.swift
      VerifyLockView.swift
      NameLocationView.swift
      SecurityConvenienceView.swift
      AutoUnlockSetupView.swift
      SuccessView.swift
    Sheets/TroubleshootingSheet.swift  # Troubleshooting + FindCodeHelp
  LockControls/
    LockControlsView.swift
  Resources/
    Info.plist
    Assets.xcassets/
```

## Running

This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) to generate the Xcode project from `project.yml`.

```bash
brew install xcodegen
xcodegen generate
open MyQLock.xcodeproj
```

Then hit Run in Xcode against an iPhone simulator (iOS 16+).

If you'd rather not use XcodeGen, create a new iOS App in Xcode (SwiftUI, iOS 16+) and drag the `MyQLock/` folder's sources into the target. Copy the Info.plist keys from `MyQLock/Resources/Info.plist`.

## Notes on permissions (demo)

Bluetooth and Location requests in the prototype are simulated with short delays so the flow can be demoed end-to-end without real hardware. The Info.plist usage-description strings are production-quality and can ship as-is.

## Next steps

- Wire CoreBluetooth and CoreLocation to real device discovery + region monitoring.
- Replace camera mock with `AVCaptureSession` + `VNDetectBarcodesRequest` for QR scanning.
- Drop in real Figma design tokens (colors, typography) once accessible.
- Add shared-user invite flow and PIN/credential management.
