import { MapPin, Moon, ShieldCheck } from "lucide-react";
import { useState } from "react";
import { AutoUnlockRange } from "../types";
import { useAppState } from "../state/AppState";
import { useOnboarding } from "../state/OnboardingState";
import { OnboardingScaffold } from "../components/OnboardingScaffold";
import { GhostButton, PrimaryButton } from "../components/buttons";
import { ToggleRow } from "../components/Rows";

const RANGES: { id: AutoUnlockRange; title: string; description: string }[] = [
  {
    id: "veryNear",
    title: "Very near",
    description: "Unlocks within a few steps of the door.",
  },
  {
    id: "near",
    title: "Near",
    description: "Unlocks as you approach the house.",
  },
];

export function AutoUnlockSetup() {
  const { goTo, goBack } = useOnboarding();
  const { lock, updateLock } = useAppState();
  const [busy, setBusy] = useState(false);

  const enable = () => {
    setBusy(true);
    setTimeout(() => {
      setBusy(false);
      updateLock({ autoUnlockEnabled: true });
      goTo("success");
    }, 900);
  };

  return (
    <OnboardingScaffold
      title="Set up Auto-Unlock"
      subtitle="We'll use your location to open the door as you get home. You're in control—turn it off anytime."
      onBack={() => goBack("securityConvenience")}
      progress={{ current: 6, total: 7 }}
      footer={
        <>
          <PrimaryButton
            label={busy ? "Waiting for permission" : "Enable Auto-Unlock"}
            icon={MapPin}
            loading={busy}
            onClick={enable}
          />
          <GhostButton
            tone="muted"
            label="Maybe later"
            onClick={() => {
              updateLock({ autoUnlockEnabled: false });
              goTo("success");
            }}
          />
        </>
      }
    >
      <div className="rounded-xl bg-brand-tint p-4 flex gap-3">
        <ShieldCheck className="w-6 h-6 text-brand shrink-0" />
        <div>
          <div className="font-semibold text-ink">Private by design</div>
          <div className="text-[15px] text-ink-muted leading-snug">
            Your location is only used to unlock this door. Nothing is sold or
            shared.
          </div>
        </div>
      </div>

      <div className="label-cap mt-2">Unlock range</div>
      <div className="space-y-2">
        {RANGES.map((r) => {
          const active = lock.autoUnlockRange === r.id;
          return (
            <button
              key={r.id}
              onClick={() => updateLock({ autoUnlockRange: r.id })}
              className={`card w-full text-left flex gap-3 items-start transition ${
                active ? "border-brand border-2" : ""
              }`}
            >
              <div
                className={`w-5 h-5 rounded-full border-2 mt-0.5 shrink-0 ${
                  active ? "border-brand" : "border-line-strong"
                }`}
              >
                {active && (
                  <div className="w-2.5 h-2.5 rounded-full bg-brand m-[3px]" />
                )}
              </div>
              <div>
                <div className="font-semibold text-ink">{r.title}</div>
                <div className="text-[15px] text-ink-muted leading-snug">
                  {r.description}
                </div>
              </div>
            </button>
          );
        })}
      </div>

      <div className="label-cap mt-3">Quiet hours</div>
      <ToggleRow
        icon={Moon}
        title="Don't Auto-Unlock at night"
        subtitle="Pauses Auto-Unlock between 10:00 PM and 6:00 AM."
        checked={lock.suppressAutoUnlockAtNight}
        onChange={(v) => updateLock({ suppressAutoUnlockAtNight: v })}
      />
    </OnboardingScaffold>
  );
}
