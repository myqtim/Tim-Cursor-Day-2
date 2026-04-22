import { ChevronRight, Hash, HelpCircle, LucideIcon, QrCode } from "lucide-react";
import { useOnboarding } from "../state/OnboardingState";
import { OnboardingScaffold } from "../components/OnboardingScaffold";

export function AddLockMethod() {
  const { goTo, goBack, setFindCodeOpen } = useOnboarding();

  return (
    <OnboardingScaffold
      title="Let's find your lock"
      subtitle="Choose how you'd like to add it. Scanning is the fastest."
      onBack={() => goBack("bluetoothPermission")}
      progress={{ current: 2, total: 6 }}
      footer={<div />}
    >
      <MethodCard
        icon={QrCode}
        title="Scan QR code"
        subtitle="Use the camera to scan the code printed on your lock."
        recommended
        onClick={() => goTo("cameraScan")}
      />
      <MethodCard
        icon={Hash}
        title="Enter serial number"
        subtitle="Type the serial number printed on the inside plate."
        onClick={() => goTo("serialEntry")}
      />
      <button
        onClick={() => setFindCodeOpen(true)}
        className="flex items-center justify-center gap-1 text-brand font-semibold h-11 w-full"
      >
        <HelpCircle className="w-4 h-4" />
        <span>Where do I find this?</span>
      </button>
    </OnboardingScaffold>
  );
}

function MethodCard({
  icon: Icon,
  title,
  subtitle,
  recommended,
  onClick,
}: {
  icon: LucideIcon;
  title: string;
  subtitle: string;
  recommended?: boolean;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className="card w-full flex items-start gap-4 text-left hover:border-line-strong transition"
    >
      <div className="w-14 h-14 rounded-xl bg-brand-tint flex items-center justify-center shrink-0">
        <Icon className="w-6 h-6 text-brand" />
      </div>
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2">
          <div className="font-semibold text-ink">{title}</div>
          {recommended && (
            <span className="text-[12px] font-semibold text-brand bg-brand-tint px-2 py-0.5 rounded-full">
              Recommended
            </span>
          )}
        </div>
        <div className="text-[15px] text-ink-muted leading-snug">{subtitle}</div>
      </div>
      <ChevronRight className="w-4 h-4 text-ink-subtle mt-2" />
    </button>
  );
}
