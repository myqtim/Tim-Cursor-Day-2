import {
  BadgeCheck,
  Bell,
  ChevronRight,
  KeyRound,
  Loader2,
  Lock,
  LockOpen,
  LucideIcon,
  MapPin,
  Radio,
  ScanFace,
  Settings,
  UserPlus,
} from "lucide-react";
import { useState } from "react";
import { useAppState } from "../state/AppState";

export function LockControls() {
  const { lock } = useAppState();
  const [isLocked, setLocked] = useState(true);
  const [busy, setBusy] = useState(false);
  const [lastAction, setLastAction] = useState(
    "Locked automatically 2 minutes ago",
  );

  const toggle = () => {
    setBusy(true);
    setTimeout(() => {
      const next = !isLocked;
      setLocked(next);
      setLastAction(next ? "Locked just now" : "Unlocked just now");
      setBusy(false);
    }, 600);
  };

  return (
    <div className="screen bg-surface-alt">
      <div className="screen-scroll pt-6 pb-8 space-y-4">
        <header className="flex items-center justify-between">
          <div>
            <div className="label-cap">{lock.home}</div>
            <div className="font-display text-[24px] font-semibold text-ink">
              {lock.name || "myQ Smart Lock"}
            </div>
          </div>
          <button
            aria-label="Settings"
            className="w-11 h-11 rounded-full bg-surface border border-line flex items-center justify-center"
          >
            <Settings className="w-5 h-5 text-ink-muted" />
          </button>
        </header>

        <section className="card p-6 flex flex-col items-center gap-4 shadow-card">
          <div
            className={`w-48 h-48 rounded-full flex items-center justify-center transition-colors ${
              isLocked ? "bg-brand-tint" : "bg-success-tint"
            }`}
          >
            {isLocked ? (
              <Lock className="w-20 h-20 text-brand" strokeWidth={2} />
            ) : (
              <LockOpen className="w-20 h-20 text-success" strokeWidth={2} />
            )}
          </div>
          <div className="text-center">
            <div className="font-display text-[22px] font-semibold text-ink">
              {isLocked ? "Locked" : "Unlocked"}
            </div>
            <div className="text-[15px] text-ink-muted">{lastAction}</div>
          </div>
          <button
            onClick={toggle}
            disabled={busy}
            className="inline-flex items-center justify-center gap-2 h-14 w-full rounded-2xl bg-brand text-white font-semibold text-[17px] active:scale-[0.99] disabled:opacity-70"
          >
            {busy ? (
              <Loader2 className="w-5 h-5 animate-spin" />
            ) : isLocked ? (
              <LockOpen className="w-5 h-5" />
            ) : (
              <Lock className="w-5 h-5" />
            )}
            <span>{isLocked ? "Unlock" : "Lock"}</span>
          </button>
        </section>

        <div className="grid grid-cols-3 gap-2">
          <Tile icon={UserPlus} title="Invite" />
          <Tile icon={KeyRound} title="PIN codes" />
          <Tile icon={Bell} title="Alerts" />
        </div>

        <section className="space-y-2">
          <div className="label-cap">Features</div>
          <StatusRow
            icon={ScanFace}
            title="Face ID"
            value={lock.requiresFaceID ? "Required to unlock" : "Off"}
          />
          <StatusRow
            icon={Radio}
            title="Remote unlock"
            value={lock.remoteUnlockEnabled ? "On" : "Off"}
          />
          <StatusRow
            icon={MapPin}
            title="Auto-Unlock"
            value={
              lock.autoUnlockEnabled
                ? `${lock.autoUnlockRange === "veryNear" ? "Very near" : "Near"} range`
                : "Off"
            }
          />
        </section>

        <section className="space-y-2">
          <div className="flex items-center justify-between">
            <div className="label-cap">Recent activity</div>
            <button className="text-brand font-semibold text-[14px]">
              See all
            </button>
          </div>
          <Activity icon={Lock} title="Auto-locked" subtitle="2 minutes ago" />
          <Activity
            icon={UserPlus}
            title="Unlocked by you"
            subtitle="Today, 8:14 AM"
          />
          <Activity
            icon={BadgeCheck}
            title="Setup completed"
            subtitle="Today"
          />
        </section>
      </div>
    </div>
  );
}

function Tile({
  icon: Icon,
  title,
}: {
  icon: LucideIcon;
  title: string;
}) {
  return (
    <button className="card flex flex-col items-center py-3 gap-1">
      <Icon className="w-5 h-5 text-brand" />
      <div className="text-[14px] font-medium text-ink">{title}</div>
    </button>
  );
}

function StatusRow({
  icon: Icon,
  title,
  value,
}: {
  icon: LucideIcon;
  title: string;
  value: string;
}) {
  return (
    <button className="card w-full flex items-center gap-3 text-left">
      <Icon className="w-5 h-5 text-brand shrink-0" />
      <div className="text-ink">{title}</div>
      <div className="ml-auto text-[15px] text-ink-muted">{value}</div>
      <ChevronRight className="w-4 h-4 text-ink-subtle" />
    </button>
  );
}

function Activity({
  icon: Icon,
  title,
  subtitle,
}: {
  icon: LucideIcon;
  title: string;
  subtitle: string;
}) {
  return (
    <div className="card flex items-center gap-3">
      <div className="w-9 h-9 rounded-full bg-brand-tint flex items-center justify-center">
        <Icon className="w-4 h-4 text-brand" />
      </div>
      <div>
        <div className="font-semibold text-ink">{title}</div>
        <div className="text-[13px] text-ink-subtle">{subtitle}</div>
      </div>
    </div>
  );
}
