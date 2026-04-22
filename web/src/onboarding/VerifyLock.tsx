import { AlertTriangle, BadgeCheck, Hand, Info, Radio } from "lucide-react";
import { useEffect, useRef, useState } from "react";
import { useAppState } from "../state/AppState";
import { useOnboarding } from "../state/OnboardingState";
import { OnboardingScaffold } from "../components/OnboardingScaffold";
import { GhostButton, PrimaryButton } from "../components/buttons";

type Phase = "idle" | "listening" | "verified" | "timedOut";

const COPY: Record<
  Phase,
  { title: string; subtitle: string; caption: string }
> = {
  idle: {
    title: "Let's make sure it's yours",
    subtitle:
      "On the inside of the lock, press and hold the button for 2 seconds. When you're ready, tap below.",
    caption: "Press and hold the inside button for 2 seconds.",
  },
  listening: {
    title: "Listening for your lock…",
    subtitle:
      "Keep the lock powered and your phone nearby. This usually takes a few seconds.",
    caption: "Hold tight—this usually takes just a moment.",
  },
  verified: {
    title: "Lock verified",
    subtitle:
      "We paired with your myQ Smart Lock. You're ready to personalize it.",
    caption: "You're all set. Let's give it a name.",
  },
  timedOut: {
    title: "We didn't hear your lock",
    subtitle:
      "Try pressing the inside button again. Move closer and make sure the lock has power.",
    caption: "Still no signal. We can help you troubleshoot.",
  },
};

export function VerifyLock() {
  const { goTo, goBack, setFindCodeOpen, setTroubleshootOpen } = useOnboarding();
  const { updateLock } = useAppState();
  const [phase, setPhase] = useState<Phase>("idle");
  const [progress, setProgress] = useState(0);
  const timerRef = useRef<number | null>(null);

  const clearTimer = () => {
    if (timerRef.current) {
      window.clearInterval(timerRef.current);
      timerRef.current = null;
    }
  };

  useEffect(() => () => clearTimer(), []);

  const start = () => {
    setPhase("listening");
    setProgress(0);
    clearTimer();
    const duration = 4500;
    const tick = 80;
    const start = Date.now();
    timerRef.current = window.setInterval(() => {
      const p = Math.min(1, (Date.now() - start) / duration);
      setProgress(p);
      if (p >= 1) {
        clearTimer();
        setPhase("verified");
      }
    }, tick) as unknown as number;
  };

  const cancel = () => {
    clearTimer();
    setPhase("idle");
    setProgress(0);
  };

  const copy = COPY[phase];
  const { Icon, color } = phaseIcon(phase);

  return (
    <OnboardingScaffold
      title={copy.title}
      subtitle={copy.subtitle}
      onBack={() => {
        clearTimer();
        goBack("addLockMethod");
      }}
      progress={{ current: 4, total: 6 }}
      footer={
        phase === "idle" ? (
          <>
            <PrimaryButton label="I'm ready" onClick={start} />
            <GhostButton
              label="Show me where the button is"
              onClick={() => setFindCodeOpen(true)}
            />
          </>
        ) : phase === "listening" ? (
          <>
            <PrimaryButton label="Listening…" loading disabled />
            <GhostButton tone="muted" label="Cancel" onClick={cancel} />
          </>
        ) : phase === "verified" ? (
          <PrimaryButton
            label="Continue"
            onClick={() => {
              updateLock({ isVerified: true });
              goTo("nameLocation");
            }}
          />
        ) : (
          <>
            <PrimaryButton label="Try again" onClick={start} />
            <GhostButton
              label="Troubleshoot"
              onClick={() => setTroubleshootOpen(true)}
            />
          </>
        )
      }
    >
      <div className="flex flex-col items-center gap-5 pt-2">
        <div className="relative w-[180px] h-[180px]">
          <svg className="absolute inset-0 -rotate-90" viewBox="0 0 100 100">
            <circle
              cx="50"
              cy="50"
              r="46"
              className="stroke-line"
              strokeWidth="8"
              fill="none"
            />
            <circle
              cx="50"
              cy="50"
              r="46"
              className={color.stroke}
              strokeWidth="8"
              strokeLinecap="round"
              fill="none"
              strokeDasharray={`${2 * Math.PI * 46}`}
              strokeDashoffset={`${2 * Math.PI * 46 * (1 - progress)}`}
              style={{ transition: "stroke-dashoffset 0.1s linear" }}
            />
          </svg>
          <div
            className={`absolute inset-0 flex items-center justify-center ${color.text}`}
          >
            <Icon className="w-14 h-14" strokeWidth={2.2} />
          </div>
        </div>
        <p className="text-center text-[15px] text-ink-muted">{copy.caption}</p>
      </div>

      <div className="rounded-xl bg-brand-tint p-4 flex gap-3 items-start">
        <Info className="w-5 h-5 text-brand shrink-0 mt-0.5" />
        <div className="text-[15px] text-ink">
          This quick check makes sure only you can add this lock to your account.
        </div>
      </div>
    </OnboardingScaffold>
  );
}

function phaseIcon(phase: Phase) {
  switch (phase) {
    case "idle":
      return {
        Icon: Hand,
        color: { stroke: "stroke-brand", text: "text-brand" },
      };
    case "listening":
      return {
        Icon: Radio,
        color: { stroke: "stroke-brand", text: "text-brand" },
      };
    case "verified":
      return {
        Icon: BadgeCheck,
        color: { stroke: "stroke-success", text: "text-success" },
      };
    case "timedOut":
      return {
        Icon: AlertTriangle,
        color: { stroke: "stroke-warn", text: "text-warn" },
      };
  }
}
