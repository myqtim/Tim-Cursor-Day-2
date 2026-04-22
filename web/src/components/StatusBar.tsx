import { useEffect, useState } from "react";

interface StatusBarProps {
  style: "dark" | "light";
  overlay?: boolean;
}

export function StatusBar({ style, overlay }: StatusBarProps) {
  const [time, setTime] = useState(() => formatTime(new Date()));

  useEffect(() => {
    const id = window.setInterval(() => setTime(formatTime(new Date())), 30_000);
    return () => window.clearInterval(id);
  }, []);

  const color = style === "dark" ? "text-black" : "text-white";

  return (
    <div
      className={`${
        overlay ? "absolute" : "absolute"
      } top-0 inset-x-0 h-[44px] flex items-center justify-between px-7 pt-2 z-30 pointer-events-none select-none ${color}`}
    >
      <span className="font-semibold text-[15px] tabular-nums tracking-tight">
        {time}
      </span>

      {/* Dynamic Island */}
      <div className="absolute left-1/2 -translate-x-1/2 top-[10px] h-[26px] w-[102px] rounded-full bg-black shadow-[inset_0_0_0_1px_#000]" />

      <div className="flex items-center gap-1.5">
        <SignalIcon className="h-[11px]" />
        <WifiIcon className="h-[11px]" />
        <BatteryIcon className="h-[12px]" />
      </div>
    </div>
  );
}

function formatTime(d: Date) {
  let hours = d.getHours();
  const minutes = d.getMinutes().toString().padStart(2, "0");
  hours = hours % 12 || 12;
  return `${hours}:${minutes}`;
}

function SignalIcon({ className }: { className?: string }) {
  return (
    <svg
      aria-hidden
      viewBox="0 0 18 12"
      className={className}
      fill="currentColor"
    >
      <rect x="0" y="8" width="3" height="4" rx="0.8" />
      <rect x="5" y="5" width="3" height="7" rx="0.8" />
      <rect x="10" y="2" width="3" height="10" rx="0.8" />
      <rect x="15" y="0" width="3" height="12" rx="0.8" />
    </svg>
  );
}

function WifiIcon({ className }: { className?: string }) {
  return (
    <svg
      aria-hidden
      viewBox="0 0 16 11"
      className={className}
      fill="currentColor"
    >
      <path d="M8 11a1.25 1.25 0 110-2.5A1.25 1.25 0 018 11z" />
      <path
        d="M3 6.8a7 7 0 0110 0"
        stroke="currentColor"
        strokeWidth="1.4"
        fill="none"
        strokeLinecap="round"
      />
      <path
        d="M0.8 4a11 11 0 0114.4 0"
        stroke="currentColor"
        strokeWidth="1.4"
        fill="none"
        strokeLinecap="round"
      />
    </svg>
  );
}

function BatteryIcon({ className }: { className?: string }) {
  return (
    <svg
      aria-hidden
      viewBox="0 0 28 12"
      className={className}
      fill="none"
    >
      <rect
        x="0.6"
        y="0.6"
        width="24.8"
        height="10.8"
        rx="2.4"
        stroke="currentColor"
        strokeOpacity="0.5"
        strokeWidth="1"
      />
      <rect x="2" y="2" width="20" height="8" rx="1.2" fill="currentColor" />
      <rect
        x="26"
        y="4"
        width="1.6"
        height="4"
        rx="0.6"
        fill="currentColor"
        fillOpacity="0.5"
      />
    </svg>
  );
}
