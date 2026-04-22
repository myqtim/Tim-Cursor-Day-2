export type AutoUnlockRange = "veryNear" | "near";

export interface Lock {
  name: string;
  home: string;
  room?: string;
  serialNumber?: string;
  isVerified: boolean;
  requiresFaceID: boolean;
  remoteUnlockEnabled: boolean;
  autoUnlockEnabled: boolean;
  autoUnlockRange: AutoUnlockRange;
  suppressAutoUnlockAtNight: boolean;
}

export const defaultLock: Lock = {
  name: "",
  home: "Home",
  room: undefined,
  serialNumber: undefined,
  isVerified: false,
  requiresFaceID: true,
  remoteUnlockEnabled: false,
  autoUnlockEnabled: false,
  autoUnlockRange: "near",
  suppressAutoUnlockAtNight: false,
};

export type Route = "onboarding" | "lockControls";

export type OnboardingStep =
  | "welcome"
  | "beforeYouBegin"
  | "bluetoothPermission"
  | "addLockMethod"
  | "cameraScan"
  | "serialEntry"
  | "verifyLock"
  | "nameLocation"
  | "securityConvenience"
  | "autoUnlockSetup"
  | "success";
