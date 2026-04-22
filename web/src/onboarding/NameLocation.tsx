import { Check } from "lucide-react";
import { useState } from "react";
import { useAppState } from "../state/AppState";
import { useOnboarding } from "../state/OnboardingState";
import { OnboardingScaffold } from "../components/OnboardingScaffold";
import { PrimaryButton } from "../components/buttons";

const SUGGESTED = ["Front Door", "Back Door", "Side Entry", "Garage Entry"];
const HOMES = ["Home", "Vacation House", "Rental"];

export function NameLocation() {
  const { goTo, goBack } = useOnboarding();
  const { updateLock } = useAppState();
  const [name, setName] = useState("");
  const [home, setHome] = useState("Home");
  const [room, setRoom] = useState("");

  const valid = name.trim().length > 0;

  return (
    <OnboardingScaffold
      title="Give it a name"
      subtitle="A friendly name helps everyone in your home know which door this is."
      onBack={() => goBack("verifyLock")}
      progress={{ current: 5, total: 6 }}
      footer={
        <PrimaryButton
          label="Save and continue"
          disabled={!valid}
          onClick={() => {
            updateLock({
              name: name.trim(),
              home,
              room: room.trim() || undefined,
            });
            goTo("securityConvenience");
          }}
        />
      }
    >
      <div className="label-cap">Lock name</div>
      <input
        autoFocus
        value={name}
        onChange={(e) => setName(e.target.value)}
        placeholder="e.g. Front Door"
        className="w-full rounded-xl bg-surface border border-line px-4 py-4 text-[16px] text-ink outline-none focus:border-brand"
      />
      <div className="flex gap-2 overflow-x-auto -mx-1 px-1 py-1">
        {SUGGESTED.map((chip) => {
          const active = name === chip;
          return (
            <button
              key={chip}
              onClick={() => setName(chip)}
              className={`shrink-0 rounded-full px-4 py-1.5 text-[14px] font-medium transition ${
                active
                  ? "bg-brand text-white"
                  : "bg-brand-tint text-brand hover:bg-brand-tint/80"
              }`}
            >
              {chip}
            </button>
          );
        })}
      </div>

      <div className="border-t border-line-soft my-3" />

      <div className="label-cap">Home</div>
      <div className="card p-0 overflow-hidden">
        {HOMES.map((h, i) => (
          <button
            key={h}
            onClick={() => setHome(h)}
            className={`w-full flex items-center justify-between px-4 py-3 text-left ${
              i > 0 ? "border-t border-line-soft" : ""
            }`}
          >
            <span className="text-ink">{h}</span>
            {home === h && <Check className="w-4 h-4 text-brand" />}
          </button>
        ))}
      </div>

      <div className="label-cap mt-2">Room (optional)</div>
      <input
        value={room}
        onChange={(e) => setRoom(e.target.value)}
        placeholder="e.g. Entryway"
        className="w-full rounded-xl bg-surface border border-line px-4 py-4 text-[16px] text-ink outline-none focus:border-brand"
      />
    </OnboardingScaffold>
  );
}
