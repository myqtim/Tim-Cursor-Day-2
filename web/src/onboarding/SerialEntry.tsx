import { AlertCircle, HelpCircle } from "lucide-react";
import { useMemo, useState } from "react";
import { useAppState } from "../state/AppState";
import { useOnboarding } from "../state/OnboardingState";
import { OnboardingScaffold } from "../components/OnboardingScaffold";
import { PrimaryButton } from "../components/buttons";

export function SerialEntry() {
  const { goTo, goBack, setFindCodeOpen } = useOnboarding();
  const { updateLock } = useAppState();
  const [serial, setSerial] = useState("");

  const trimmed = serial.trim();
  const isValid = useMemo(() => trimmed.length >= 8, [trimmed]);
  const showError = serial.length > 0 && !isValid;

  return (
    <OnboardingScaffold
      title="Enter serial number"
      subtitle="You'll find this on the inside plate of your myQ Smart Lock and on the box label."
      onBack={() => goBack("addLockMethod")}
      progress={{ current: 3, total: 6 }}
      footer={
        <PrimaryButton
          label="Continue"
          disabled={!isValid}
          onClick={() => {
            updateLock({ serialNumber: trimmed });
            goTo("verifyLock");
          }}
        />
      }
    >
      <div className="label-cap">Serial number</div>
      <input
        autoFocus
        value={serial}
        onChange={(e) => setSerial(e.target.value.toUpperCase())}
        className={`w-full rounded-xl bg-surface border px-4 py-4 text-[16px] text-ink tracking-wide outline-none transition ${
          showError ? "border-danger" : "border-line focus:border-brand"
        }`}
        placeholder="MYQL90AXXB..."
        autoCapitalize="characters"
        autoCorrect="off"
      />
      {showError ? (
        <div className="flex items-center gap-2 text-danger text-[13px]">
          <AlertCircle className="w-4 h-4" />
          That doesn't look right. Double-check the serial on your lock.
        </div>
      ) : (
        <div className="text-[13px] text-ink-subtle">
          Usually 10–14 characters, letters and numbers.
        </div>
      )}

      <button
        onClick={() => setFindCodeOpen(true)}
        className="flex items-center gap-1 text-brand font-semibold mt-1"
      >
        <HelpCircle className="w-4 h-4" />
        Where is it printed?
      </button>
    </OnboardingScaffold>
  );
}
