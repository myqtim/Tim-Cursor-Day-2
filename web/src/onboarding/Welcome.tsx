import { BadgeCheck, Hand, LucideIcon, ShieldCheck, Zap } from "lucide-react";
import { useAppState } from "../state/AppState";
import { useOnboarding } from "../state/OnboardingState";
import { PrimaryButton, GhostButton } from "../components/buttons";

export function Welcome() {
  const { setRoute } = useAppState();
  const { goTo } = useOnboarding();

  return (
    <div className="screen">
      <div className="screen-scroll pt-16">
        <div className="rounded-3xl bg-brand-tint h-60 flex flex-col items-center justify-center gap-3 mb-8">
          <div className="w-28 h-28 rounded-full bg-white shadow-hero flex items-center justify-center">
            <ShieldCheck className="w-14 h-14 text-brand" strokeWidth={2.2} />
          </div>
          <div className="font-semibold text-ink">myQ Smart Lock</div>
        </div>

        <h1 className="text-center font-display text-[30px] font-bold leading-tight text-ink">
          Let's set up your
          <br />
          myQ Smart Lock
        </h1>
        <p className="text-center text-[16px] text-ink-muted mt-3 px-4">
          Takes about 2 minutes. You'll need the code printed on your lock or
          its packaging.
        </p>

        <div className="grid grid-cols-3 gap-2 mt-8">
          <Badge icon={Zap} label="Encrypted setup" />
          <Badge icon={Hand} label="You're in control" />
          <Badge icon={BadgeCheck} label="Verified device" />
        </div>
      </div>

      <div className="px-6 pb-5 pt-2 space-y-2">
        <PrimaryButton label="Get started" onClick={() => goTo("beforeYouBegin")} />
        <GhostButton
          tone="muted"
          label="Not now"
          onClick={() => setRoute("lockControls")}
        />
      </div>
    </div>
  );
}

function Badge({
  icon: Icon,
  label,
}: {
  icon: LucideIcon;
  label: string;
}) {
  return (
    <div className="card flex flex-col items-center gap-1 py-3">
      <Icon className="w-5 h-5 text-brand" />
      <div className="text-[12px] text-ink-muted text-center leading-tight">
        {label}
      </div>
    </div>
  );
}
