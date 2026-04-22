import { MapPin, Radio, ScanFace } from "lucide-react";
import { useAppState } from "../state/AppState";
import { useOnboarding } from "../state/OnboardingState";
import { OnboardingScaffold } from "../components/OnboardingScaffold";
import { GhostButton, PrimaryButton, SecondaryButton } from "../components/buttons";
import { ToggleRow } from "../components/Rows";

export function SecurityConvenience() {
  const { goTo, goBack } = useOnboarding();
  const { lock, updateLock } = useAppState();

  const primaryLabel = lock.autoUnlockEnabled ? "Review Auto-Unlock" : "Finish setup";

  return (
    <OnboardingScaffold
      title="Security & convenience"
      subtitle="Turn on the features that fit your routine. You can change any of these later in Settings."
      onBack={() => goBack("nameLocation")}
      progress={{ current: 6, total: 7 }}
      footer={
        <>
          <PrimaryButton
            label={primaryLabel}
            onClick={() => {
              goTo(lock.autoUnlockEnabled ? "autoUnlockSetup" : "success");
            }}
          />
          <GhostButton
            tone="muted"
            label="Skip for now"
            onClick={() => goTo("success")}
          />
        </>
      }
    >
      <Section title="Confirm it's you">
        <ToggleRow
          icon={ScanFace}
          title="Require Face ID to unlock"
          subtitle="Adds a quick glance check before the door opens. Recommended."
          checked={lock.requiresFaceID}
          onChange={(v) => updateLock({ requiresFaceID: v })}
        />
      </Section>

      <Section title="From anywhere">
        <ToggleRow
          icon={Radio}
          title="Remote unlock"
          subtitle="Unlock your door from the app when you're away. You can turn this off anytime."
          checked={lock.remoteUnlockEnabled}
          onChange={(v) => updateLock({ remoteUnlockEnabled: v })}
        />
      </Section>

      <Section title="Auto-Unlock">
        <ToggleRow
          icon={MapPin}
          title="Unlock when I arrive"
          subtitle="Uses your location to open the door as you approach home."
          checked={lock.autoUnlockEnabled}
          onChange={(v) => updateLock({ autoUnlockEnabled: v })}
        />
        {lock.autoUnlockEnabled && (
          <SecondaryButton
            label="Set up Auto-Unlock"
            icon={MapPin}
            onClick={() => goTo("autoUnlockSetup")}
          />
        )}
      </Section>
    </OnboardingScaffold>
  );
}

function Section({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) {
  return (
    <div className="space-y-2">
      <div className="label-cap">{title}</div>
      <div className="space-y-2">{children}</div>
    </div>
  );
}
