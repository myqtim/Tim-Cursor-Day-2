import React, {
  createContext,
  useCallback,
  useContext,
  useMemo,
  useState,
} from "react";
import { Lock, Route, defaultLock } from "../types";

interface AppStateContextValue {
  route: Route;
  setRoute: (route: Route) => void;
  lock: Lock;
  updateLock: (patch: Partial<Lock>) => void;
  resetLock: () => void;
}

const AppStateContext = createContext<AppStateContextValue | null>(null);

export function AppStateProvider({ children }: { children: React.ReactNode }) {
  const [route, setRoute] = useState<Route>("onboarding");
  const [lock, setLock] = useState<Lock>(defaultLock);

  const updateLock = useCallback((patch: Partial<Lock>) => {
    setLock((prev) => ({ ...prev, ...patch }));
  }, []);

  const resetLock = useCallback(() => setLock(defaultLock), []);

  const value = useMemo(
    () => ({ route, setRoute, lock, updateLock, resetLock }),
    [route, lock, updateLock, resetLock],
  );

  return (
    <AppStateContext.Provider value={value}>
      {children}
    </AppStateContext.Provider>
  );
}

export function useAppState() {
  const ctx = useContext(AppStateContext);
  if (!ctx) throw new Error("useAppState must be used inside AppStateProvider");
  return ctx;
}
