# myQ Smart Lock — Web (Vite + React + Tailwind)

Browser port of the iPhone onboarding flow. Mobile-first; looks best at iPhone widths but is responsive.

## Setup

```bash
cd web
npm install
npm run dev
```

Then open the URL Vite prints (default `http://localhost:5173`). Use your browser's device-emulation mode for an iPhone viewport.

## Stack

- Vite + React 18 + TypeScript
- Tailwind CSS (design tokens in `tailwind.config.ts`)
- Framer Motion for transitions
- lucide-react for icons

## Scripts

- `npm run dev` — dev server
- `npm run build` — production build
- `npm run typecheck` — TypeScript only
- `npm run preview` — serve the production build

## Structure

```
src/
  App.tsx                        # App shell + onboarding router
  main.tsx
  styles.css                     # Tailwind base + component classes
  types.ts
  state/
    AppState.tsx                 # Route + Lock state
    OnboardingState.tsx          # Step, direction, sheet state
  components/
    buttons.tsx                  # PrimaryButton, SecondaryButton, GhostButton
    Rows.tsx                     # ChecklistRow, ToggleRow, Switch, ProgressDots
    OnboardingScaffold.tsx
    Sheet.tsx
  onboarding/
    Welcome.tsx
    BeforeYouBegin.tsx
    BluetoothPermission.tsx
    AddLockMethod.tsx
    CameraScan.tsx
    SerialEntry.tsx
    VerifyLock.tsx
    NameLocation.tsx
    SecurityConvenience.tsx
    AutoUnlockSetup.tsx
    Success.tsx
    Sheets.tsx                   # Troubleshooting + Find-code help sheets
  lockControls/
    LockControls.tsx
```

## Notes

- Permissions and device verification are simulated with small delays so the flow can be demoed without hardware.
- All copy is final (friendly + trustworthy tone, no placeholder text).
- When real Figma design tokens are available, swap values in `tailwind.config.ts` → `theme.extend.colors` / `fontFamily`.
