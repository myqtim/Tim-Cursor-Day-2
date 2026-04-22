import { AnimatePresence, motion } from "framer-motion";
import {
  AlertTriangle,
  ChevronLeft,
  Flashlight,
  FlashlightOff,
} from "lucide-react";
import { useState } from "react";
import { useAppState } from "../state/AppState";
import { useOnboarding } from "../state/OnboardingState";

export function CameraScan() {
  const { goTo, goBack } = useOnboarding();
  const { updateLock } = useAppState();
  const [flash, setFlash] = useState(false);
  const [warn, setWarn] = useState(false);

  const simulateSuccess = () => {
    updateLock({ serialNumber: "MYQL90AXXB-DEMO" });
    goTo("verifyLock");
  };

  const showWarn = () => {
    setWarn(true);
    setTimeout(() => setWarn(false), 3200);
  };

  return (
    <div className="screen bg-[#101828] text-white">
      <header className="flex items-center justify-between px-4 pt-4 pb-2">
        <button
          onClick={() => goBack("addLockMethod")}
          aria-label="Back"
          className="w-11 h-11 rounded-full bg-white/10 flex items-center justify-center"
        >
          <ChevronLeft className="w-5 h-5" />
        </button>
        <div className="font-semibold">Scan the code on your lock</div>
        <button
          onClick={() => setFlash((f) => !f)}
          aria-label="Toggle flashlight"
          className="w-11 h-11 rounded-full bg-white/10 flex items-center justify-center"
        >
          {flash ? <Flashlight className="w-5 h-5" /> : <FlashlightOff className="w-5 h-5" />}
        </button>
      </header>

      <div className="flex-1 flex flex-col items-center justify-center px-6 relative">
        <div className="relative w-[260px] h-[260px]">
          <div className="absolute inset-0 rounded-3xl border-[3px] border-brand" />
          <motion.div
            className="absolute left-4 right-4 h-[2px] bg-brand/80"
            initial={{ top: "10%" }}
            animate={{ top: ["10%", "88%", "10%"] }}
            transition={{ duration: 2.8, repeat: Infinity, ease: "easeInOut" }}
          />
        </div>
        <p className="text-center text-[15px] text-white/80 mt-8 max-w-[320px]">
          Center the QR code inside the frame. We'll capture it automatically.
        </p>
      </div>

      <div className="px-6 pb-6 space-y-2">
        <button
          onClick={simulateSuccess}
          className="btn-primary"
        >
          Simulate scan success
        </button>
        <button
          onClick={() => goTo("serialEntry")}
          className="h-11 w-full font-semibold text-white"
        >
          Enter serial number instead
        </button>
        <button
          onClick={showWarn}
          className="h-8 w-full text-white/70 text-[14px]"
        >
          Having trouble?
        </button>
      </div>

      <AnimatePresence>
        {warn && (
          <motion.div
            initial={{ y: -40, opacity: 0 }}
            animate={{ y: 60, opacity: 1 }}
            exit={{ y: -40, opacity: 0 }}
            className="absolute inset-x-0 top-0 flex justify-center px-6"
          >
            <div className="bg-warn rounded-xl p-4 w-full max-w-[420px] flex gap-3 items-start shadow-card">
              <AlertTriangle className="w-5 h-5 shrink-0 mt-0.5" />
              <div>
                <div className="font-semibold">We couldn't read that code</div>
                <div className="text-[14px] opacity-90">
                  Try more light, or enter the serial number instead.
                </div>
              </div>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}
