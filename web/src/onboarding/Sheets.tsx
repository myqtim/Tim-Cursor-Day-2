import {
  Bluetooth,
  Camera,
  ChevronRight,
  FileText,
  LucideIcon,
  Package,
  Ruler,
  RotateCw,
  SquareStack,
  Zap,
} from "lucide-react";
import { Sheet } from "../components/Sheet";
import { useOnboarding } from "../state/OnboardingState";

export function TroubleshootingSheet() {
  const { troubleshootOpen, setTroubleshootOpen } = useOnboarding();

  return (
    <Sheet
      open={troubleshootOpen}
      onClose={() => setTroubleshootOpen(false)}
      title="We'll get this sorted"
    >
      <p className="text-[15px] text-ink-muted mb-4">
        Pick what best matches what you're seeing.
      </p>

      <Section title="Bluetooth is off or denied">
        <Row
          icon={Bluetooth}
          title="Turn Bluetooth on in Settings"
          subtitle="Then come back and we'll pick up where we left off."
        />
        <LinkRow label="Open Settings" />
      </Section>

      <Section title="Camera access is off">
        <Row
          icon={Camera}
          title="Allow camera to scan the code"
          subtitle="You can grant access in iOS Settings."
        />
        <LinkRow label="Open Settings" />
      </Section>

      <Section title="Lock won't verify">
        <Row
          icon={Ruler}
          title="Move closer"
          subtitle="Stand within 3 feet of the lock."
        />
        <Row
          icon={Zap}
          title="Check batteries or power"
          subtitle="Replace or charge the battery if it's low."
        />
        <Row
          icon={RotateCw}
          title="Try verification again"
          subtitle="Hold the inside button for a full 2 seconds."
        />
      </Section>

      <Section title="Still stuck?">
        <LinkRow label="View installation guide" />
        <LinkRow label="Contact myQ support" />
      </Section>
    </Sheet>
  );
}

export function FindCodeHelpSheet() {
  const { findCodeOpen, setFindCodeOpen } = useOnboarding();
  return (
    <Sheet
      open={findCodeOpen}
      onClose={() => setFindCodeOpen(false)}
      title="Find your lock's code"
    >
      <p className="text-[15px] text-ink-muted mb-4">
        Every myQ Smart Lock ships with a unique QR code and serial number.
      </p>
      <div className="space-y-3">
        <LocationCard
          icon={SquareStack}
          title="On the inside plate"
          detail="Peel back the battery cover—look for a white label with the QR code and a serial starting with MYQL."
        />
        <LocationCard
          icon={Package}
          title="On the product box"
          detail="The same code is printed on the label on the side of the box."
        />
        <LocationCard
          icon={FileText}
          title="In your order confirmation"
          detail="If you bought from myq.com, the serial is listed in your order email."
        />
      </div>
    </Sheet>
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
    <div className="mb-5 space-y-2">
      <div className="label-cap">{title}</div>
      {children}
    </div>
  );
}

function Row({
  icon: Icon,
  title,
  subtitle,
}: {
  icon: LucideIcon;
  title: string;
  subtitle: string;
}) {
  return (
    <div className="card flex gap-3 items-start">
      <Icon className="w-5 h-5 text-brand mt-0.5" />
      <div>
        <div className="font-semibold text-ink">{title}</div>
        <div className="text-[15px] text-ink-muted leading-snug">{subtitle}</div>
      </div>
    </div>
  );
}

function LinkRow({ label }: { label: string }) {
  return (
    <button className="w-full flex items-center justify-between rounded-xl bg-brand-tint px-4 py-3 text-brand font-semibold">
      <span>{label}</span>
      <ChevronRight className="w-4 h-4 text-ink-subtle" />
    </button>
  );
}

function LocationCard({
  icon: Icon,
  title,
  detail,
}: {
  icon: LucideIcon;
  title: string;
  detail: string;
}) {
  return (
    <div className="card flex gap-3 items-start">
      <div className="w-14 h-14 rounded-xl bg-brand-tint flex items-center justify-center shrink-0">
        <Icon className="w-6 h-6 text-brand" />
      </div>
      <div>
        <div className="font-semibold text-ink">{title}</div>
        <div className="text-[15px] text-ink-muted leading-snug">{detail}</div>
      </div>
    </div>
  );
}
