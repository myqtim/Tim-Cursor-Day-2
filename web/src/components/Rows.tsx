import { LucideIcon } from "lucide-react";

interface ChecklistRowProps {
  icon: LucideIcon;
  title: string;
  subtitle: string;
}

export function ChecklistRow({ icon: Icon, title, subtitle }: ChecklistRowProps) {
  return (
    <div className="card flex items-start gap-4">
      <div className="w-10 h-10 rounded-full bg-brand-tint flex items-center justify-center shrink-0">
        <Icon className="w-5 h-5 text-brand" />
      </div>
      <div className="min-w-0">
        <div className="font-semibold text-ink">{title}</div>
        <div className="text-[15px] text-ink-muted leading-snug">{subtitle}</div>
      </div>
    </div>
  );
}

interface ToggleRowProps {
  icon?: LucideIcon;
  title: string;
  subtitle: string;
  checked: boolean;
  onChange: (checked: boolean) => void;
}

export function ToggleRow({
  icon: Icon,
  title,
  subtitle,
  checked,
  onChange,
}: ToggleRowProps) {
  return (
    <label className="card flex items-start gap-4 cursor-pointer select-none">
      {Icon && (
        <div className="w-9 h-9 rounded-full bg-brand-tint flex items-center justify-center shrink-0">
          <Icon className="w-4 h-4 text-brand" />
        </div>
      )}
      <div className="flex-1 min-w-0">
        <div className="font-semibold text-ink">{title}</div>
        <div className="text-[15px] text-ink-muted leading-snug">{subtitle}</div>
      </div>
      <Switch checked={checked} onChange={onChange} />
    </label>
  );
}

interface SwitchProps {
  checked: boolean;
  onChange: (v: boolean) => void;
}

export function Switch({ checked, onChange }: SwitchProps) {
  return (
    <button
      type="button"
      role="switch"
      aria-checked={checked}
      onClick={(e) => {
        e.preventDefault();
        onChange(!checked);
      }}
      className={`relative w-[51px] h-[31px] rounded-full transition shrink-0 ${
        checked ? "bg-brand" : "bg-line-strong"
      }`}
    >
      <span
        className={`absolute top-[2px] left-[2px] w-[27px] h-[27px] bg-white rounded-full shadow transition-transform ${
          checked ? "translate-x-[20px]" : "translate-x-0"
        }`}
      />
    </button>
  );
}

interface ProgressDotsProps {
  total: number;
  current: number;
}

export function ProgressDots({ total, current }: ProgressDotsProps) {
  return (
    <div className="flex items-center gap-1" aria-label={`Step ${current + 1} of ${total}`}>
      {Array.from({ length: total }).map((_, i) => (
        <span
          key={i}
          className={`h-1.5 rounded-full transition-all duration-300 ${
            i === current
              ? "w-6 bg-brand"
              : i < current
                ? "w-2 bg-brand"
                : "w-2 bg-line"
          }`}
        />
      ))}
    </div>
  );
}
