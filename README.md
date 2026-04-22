# myQ Smart Lock — Onboarding Prototypes

Onboarding flow for a newly connected **myQ Smart Lock**, delivered in two implementations:

- **`MyQLock/`** — Native iOS (SwiftUI, iOS 16+)
- **`web/`** — Web app (Vite + React + TypeScript + Tailwind CSS)

Both share the same designed flow, copy, and design tokens.

## Flow

1. Welcome
2. Before you begin (proximity, power, Bluetooth)
3. Allow Bluetooth
4. Add a lock — scan QR or enter serial
5. Camera scan (with retry/switch)
6. Serial entry (validated)
7. Verify this is your lock (listen → verified/timeout)
8. Give it a name (chips, home picker, room)
9. Security & convenience (Face ID, Remote Unlock, Auto-Unlock)
10. Auto-Unlock setup (range, quiet hours)
11. You're all set
12. Lock Controls landing (lock/unlock, features, activity)

Supporting sheets: Troubleshooting, Find your lock's code.

## Native iOS app (`MyQLock/`)

Requires [XcodeGen](https://github.com/yonaskolb/XcodeGen):

```bash
brew install xcodegen
xcodegen generate
open MyQLock.xcodeproj
```

Run on an iPhone simulator (iOS 16+). Details in the source tree under `MyQLock/`.

## Web app (`web/`)

```bash
cd web
npm install
npm run dev
```

Open the URL Vite prints; use browser device emulation for iPhone widths. See `web/README.md` for more.

## Design tokens

A trustworthy-modern palette and system type scale, centralized:
- iOS: `MyQLock/DesignSystem/Colors.swift` + `Typography.swift`
- Web: `web/tailwind.config.ts`

When the real Figma design-system tokens are available, swap those values and the whole app re-skins.
