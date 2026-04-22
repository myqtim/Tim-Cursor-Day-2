import { Bluetooth, CheckCircle2, ShieldCheck } from "lucide-react";
import { useState } from "react";
import { useOnboarding } from "../state/OnboardingState";
import { OnboardingScaffold } from "../components/OnboardingScaffold";
import { GhostButton, PrimaryButton } from "../components/buttons";

export function BluetoothPermission() {
  const { goTo, goBack, setTroubleshootOpen } = useOnboarding();
  const [busy, setBusy] = useState(false);

  const handleAllow = () => {
    setBusy(true);
    setTimeout(() => {
      setBusy(false);
      goTo("addLockMethod");
    }, 900);
  };

  return (
    <OnboardingScaffold
      title="Allow Bluetooth"
      subtitle="Bluetooth is how your phone recognizes your myQ Smart Lock during setup. It stays private to your device."
      onBack={() => goBack("beforeYouBegin")}
      progress={{ current: 1, total: 6 }}
      footer={
        <>
          <PrimaryButton
            label={busy ? "Waiting for permission" : "Allow Bluetooth"}
            icon={Bluetooth}
            loading={busy}
            onClick={handleAllow}
          />
          <GhostButton
            label="Why is this needed?"
            onClick={() => setTroubleshootOpen(true)}
          />
        </>
      }
    >
      <div className="rounded-xl bg-brand-tint p-4 flex gap-3">
        <ShieldCheck className="w-6 h-6 text-brand shrink-0" />
        <div>
          <div className="font-semibold text-ink">Your setup stays private</div>
          <div className="text-[15px] text-ink-muted leading-snug">
            We only use Bluetooth during setup and to keep your lock connected.
          </div>
        </div>
      </div>

      <div className="card space-y-3">
        <Point text="Bluetooth is used to verify you own this lock." />
        <Point text="We never share setup data with anyone else." />
        <Point text="You can change this anytime in iOS Settings." />
      </div>
    </OnboardingScaffold>
  );
}

function Point({ text }: { text: string }) {
  return (
    <div className="flex items-start gap-2">
      <CheckCircle2 className="w-5 h-5 text-brand shrink-0 mt-0.5" />
      <div className="text-[15px] text-ink">{text}</div>
    </div>
  );
}
