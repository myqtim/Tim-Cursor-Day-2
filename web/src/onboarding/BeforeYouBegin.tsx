import { Bluetooth, Ruler, Zap } from "lucide-react";
import { useOnboarding } from "../state/OnboardingState";
import { OnboardingScaffold } from "../components/OnboardingScaffold";
import { ChecklistRow } from "../components/Rows";
import { GhostButton, PrimaryButton } from "../components/buttons";

export function BeforeYouBegin() {
  const { goTo, goBack, setTroubleshootOpen } = useOnboarding();
  return (
    <OnboardingScaffold
      title="Before you begin"
      subtitle="A few quick checks so setup goes smoothly."
      onBack={() => goBack("welcome")}
      progress={{ current: 0, total: 6 }}
      footer={
        <>
          <PrimaryButton
            label="Continue"
            onClick={() => goTo("bluetoothPermission")}
          />
          <GhostButton
            label="Need help?"
            onClick={() => setTroubleshootOpen(true)}
          />
        </>
      }
    >
      <ChecklistRow
        icon={Ruler}
        title="Stand within 3 feet of the lock"
        subtitle="Staying close helps your phone pair quickly and reliably."
      />
      <ChecklistRow
        icon={Zap}
        title="Make sure the lock has power"
        subtitle="Install the included battery or keep it charged."
      />
      <ChecklistRow
        icon={Bluetooth}
        title="Turn Bluetooth on"
        subtitle="We'll use Bluetooth to verify your lock securely."
      />
    </OnboardingScaffold>
  );
}
