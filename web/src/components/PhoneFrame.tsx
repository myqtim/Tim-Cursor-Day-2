import { useEffect, useState } from "react";
import { StatusBar } from "./StatusBar";

interface PhoneFrameProps {
  children: React.ReactNode;
  statusBarStyle?: "dark" | "light";
}

/**
 * Wraps the app in an iPhone-like device frame on desktop.
 * On narrow viewports (real phones), it collapses to full-screen so
 * the prototype feels native.
 */
export function PhoneFrame({
  children,
  statusBarStyle = "dark",
}: PhoneFrameProps) {
  const isDevice = useIsDeviceSize();

  if (isDevice) {
    return (
      <div className="relative w-full min-h-[100dvh] bg-surface-alt overflow-hidden">
        <StatusBar style={statusBarStyle} overlay />
        <div className="pt-[env(safe-area-inset-top,44px)] min-h-[100dvh] flex flex-col">
          {children}
        </div>
        <div className="pointer-events-none absolute bottom-1 left-1/2 -translate-x-1/2 h-1 w-32 rounded-full bg-black/40" />
      </div>
    );
  }

  return (
    <div className="min-h-screen w-full flex items-center justify-center py-10 px-4 bg-gradient-to-br from-[#E6ECF4] via-[#EEF3FA] to-[#DCE5F1]">
      <div
        className="relative shrink-0"
        style={{ width: 400, height: 844 }}
        aria-label="iPhone preview"
      >
        {/* Outer titanium-like bezel */}
        <div
          className="absolute inset-0 rounded-[60px] p-[10px] shadow-[0_30px_80px_rgba(15,23,42,0.25)]"
          style={{
            background:
              "linear-gradient(145deg, #2A2F3A 0%, #14181F 40%, #0B0D12 100%)",
          }}
        >
          {/* Inner bezel ring */}
          <div
            className="w-full h-full rounded-[52px] p-[3px]"
            style={{
              background:
                "linear-gradient(145deg, #3B4150 0%, #1C2028 55%, #0B0D12 100%)",
            }}
          >
            {/* Screen */}
            <div className="relative w-full h-full rounded-[50px] overflow-hidden bg-surface-alt">
              <StatusBar style={statusBarStyle} />
              <div className="absolute inset-0 pt-[44px] flex flex-col">
                {children}
              </div>
              {/* Home indicator */}
              <div className="pointer-events-none absolute bottom-[8px] left-1/2 -translate-x-1/2 h-[5px] w-[134px] rounded-full bg-black/80" />
            </div>
          </div>
        </div>

        {/* Side buttons (decorative) */}
        <div className="absolute -left-[3px] top-[150px] w-[4px] h-[32px] rounded-l-sm bg-[#1a1d24]" />
        <div className="absolute -left-[3px] top-[200px] w-[4px] h-[56px] rounded-l-sm bg-[#1a1d24]" />
        <div className="absolute -left-[3px] top-[270px] w-[4px] h-[56px] rounded-l-sm bg-[#1a1d24]" />
        <div className="absolute -right-[3px] top-[210px] w-[4px] h-[90px] rounded-r-sm bg-[#1a1d24]" />
      </div>
    </div>
  );
}

function useIsDeviceSize() {
  const [isDevice, setIsDevice] = useState<boolean>(() => {
    if (typeof window === "undefined") return false;
    return window.matchMedia("(max-width: 480px)").matches;
  });

  useEffect(() => {
    const mq = window.matchMedia("(max-width: 480px)");
    const handler = (e: MediaQueryListEvent) => setIsDevice(e.matches);
    mq.addEventListener("change", handler);
    return () => mq.removeEventListener("change", handler);
  }, []);

  return isDevice;
}
