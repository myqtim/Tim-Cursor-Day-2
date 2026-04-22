import React, {
  createContext,
  useCallback,
  useContext,
  useMemo,
  useState,
} from "react";
import { OnboardingStep } from "../types";

interface OnboardingContextValue {
  step: OnboardingStep;
  direction: 1 | -1;
  goTo: (step: OnboardingStep) => void;
  goBack: (step: OnboardingStep) => void;
  troubleshootOpen: boolean;
  setTroubleshootOpen: (v: boolean) => void;
  findCodeOpen: boolean;
  setFindCodeOpen: (v: boolean) => void;
}

const OnboardingContext = createContext<OnboardingContextValue | null>(null);

export function OnboardingProvider({ children }: { children: React.ReactNode }) {
  const [step, setStep] = useState<OnboardingStep>("welcome");
  const [direction, setDirection] = useState<1 | -1>(1);
  const [troubleshootOpen, setTroubleshootOpen] = useState(false);
  const [findCodeOpen, setFindCodeOpen] = useState(false);

  const goTo = useCallback((next: OnboardingStep) => {
    setDirection(1);
    setStep(next);
  }, []);

  const goBack = useCallback((prev: OnboardingStep) => {
    setDirection(-1);
    setStep(prev);
  }, []);

  const value = useMemo(
    () => ({
      step,
      direction,
      goTo,
      goBack,
      troubleshootOpen,
      setTroubleshootOpen,
      findCodeOpen,
      setFindCodeOpen,
    }),
    [step, direction, goTo, goBack, troubleshootOpen, findCodeOpen],
  );

  return (
    <OnboardingContext.Provider value={value}>
      {children}
    </OnboardingContext.Provider>
  );
}

export function useOnboarding() {
  const ctx = useContext(OnboardingContext);
  if (!ctx) throw new Error("useOnboarding must be inside OnboardingProvider");
  return ctx;
}
