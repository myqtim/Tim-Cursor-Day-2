import { motion } from "framer-motion";
import { BadgeCheck, LucideIcon, MapPin, Radio, ScanFace, UserPlus } from "lucide-react";
import { useAppState } from "../state/AppState";
import { PrimaryButton, SecondaryButton } from "../components/buttons";

export function Success() {
  const { lock, setRoute } = useAppState();
  const name = lock.name.trim().length > 0 ? lock.name : "Your myQ Smart Lock";

  return (
    <div className="screen">
      <div className="flex-1 flex flex-col items-center justify-center px-6 pt-10 pb-4 text-center">
        <motion.div
          className="relative"
          initial={{ scale: 0.6, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          transition={{ type: "spring", stiffness: 240, damping: 18 }}
        >
          <div className="w-36 h-36 rounded-full bg-success-tint flex items-center justify-center">
            <BadgeCheck className="w-16 h-16 text-success" strokeWidth={2.2} />
          </div>
        </motion.div>

        <h1 className="mt-6 font-display text-[30px] font-bold text-ink">
          You're all set
        </h1>
        <p className="mt-2 text-[16px] text-ink-muted max-w-[360px]">
          {name} is connected and ready to use.
        </p>

        <div className="mt-6 flex flex-col items-center gap-2">
          {lock.requiresFaceID && (
            <Chip icon={ScanFace} label="Face ID is on" />
          )}
          {lock.remoteUnlockEnabled && (
            <Chip icon={Radio} label="Remote unlock enabled" />
          )}
          {lock.autoUnlockEnabled && (
            <Chip icon={MapPin} label="Auto-Unlock enabled" />
          )}
        </div>
      </div>

      <div className="px-6 pb-5 space-y-2">
        <PrimaryButton
          label="Go to lock controls"
          onClick={() => setRoute("lockControls")}
        />
        <SecondaryButton
          label="Invite someone"
          icon={UserPlus}
          onClick={() => setRoute("lockControls")}
        />
      </div>
    </div>
  );
}

function Chip({
  icon: Icon,
  label,
}: {
  icon: LucideIcon;
  label: string;
}) {
  return (
    <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-brand-tint text-ink">
      <Icon className="w-4 h-4 text-brand" />
      <span className="text-[14px] font-medium">{label}</span>
    </div>
  );
}
