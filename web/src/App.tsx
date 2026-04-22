import { AnimatePresence, motion } from "framer-motion";
import { AppStateProvider, useAppState } from "./state/AppState";
import { OnboardingProvider, useOnboarding } from "./state/OnboardingState";
import { OnboardingStep } from "./types";

import { Welcome } from "./onboarding/Welcome";
import { BeforeYouBegin } from "./onboarding/BeforeYouBegin";
import { BluetoothPermission } from "./onboarding/BluetoothPermission";
import { AddLockMethod } from "./onboarding/AddLockMethod";
import { CameraScan } from "./onboarding/CameraScan";
import { SerialEntry } from "./onboarding/SerialEntry";
import { VerifyLock } from "./onboarding/VerifyLock";
import { NameLocation } from "./onboarding/NameLocation";
import { SecurityConvenience } from "./onboarding/SecurityConvenience";
import { AutoUnlockSetup } from "./onboarding/AutoUnlockSetup";
import { Success } from "./onboarding/Success";
import { FindCodeHelpSheet, TroubleshootingSheet } from "./onboarding/Sheets";
import { LockControls } from "./lockControls/LockControls";

export default function App() {
  return (
    <AppStateProvider>
      <OnboardingProvider>
        <Shell />
      </OnboardingProvider>
    </AppStateProvider>
  );
}

function Shell() {
  const { route } = useAppState();

  return (
    <div className="min-h-screen flex items-stretch justify-center bg-gradient-to-b from-[#EEF3FA] to-[#E8ECF3]">
      <div className="w-full max-w-[480px] min-h-screen bg-surface-alt shadow-card relative overflow-hidden">
        <AnimatePresence mode="wait" initial={false}>
          {route === "onboarding" ? (
            <motion.div
              key="onboarding"
              className="absolute inset-0"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.2 }}
            >
              <OnboardingRouter />
            </motion.div>
          ) : (
            <motion.div
              key="lock"
              className="absolute inset-0"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.2 }}
            >
              <LockControls />
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </div>
  );
}

const stepVariants = {
  enter: (d: number) => ({ x: d > 0 ? 24 : -24, opacity: 0 }),
  center: { x: 0, opacity: 1 },
  exit: (d: number) => ({ x: d > 0 ? -24 : 24, opacity: 0 }),
};

function OnboardingRouter() {
  const { step, direction } = useOnboarding();

  return (
    <>
      <AnimatePresence mode="wait" initial={false} custom={direction}>
        <motion.div
          key={step}
          className="absolute inset-0"
          custom={direction}
          variants={stepVariants}
          initial="enter"
          animate="center"
          exit="exit"
          transition={{ duration: 0.26, ease: [0.4, 0, 0.2, 1] }}
        >
          {renderStep(step)}
        </motion.div>
      </AnimatePresence>
      <TroubleshootingSheet />
      <FindCodeHelpSheet />
    </>
  );
}

function renderStep(step: OnboardingStep) {
  switch (step) {
    case "welcome":
      return <Welcome />;
    case "beforeYouBegin":
      return <BeforeYouBegin />;
    case "bluetoothPermission":
      return <BluetoothPermission />;
    case "addLockMethod":
      return <AddLockMethod />;
    case "cameraScan":
      return <CameraScan />;
    case "serialEntry":
      return <SerialEntry />;
    case "verifyLock":
      return <VerifyLock />;
    case "nameLocation":
      return <NameLocation />;
    case "securityConvenience":
      return <SecurityConvenience />;
    case "autoUnlockSetup":
      return <AutoUnlockSetup />;
    case "success":
      return <Success />;
  }
}
