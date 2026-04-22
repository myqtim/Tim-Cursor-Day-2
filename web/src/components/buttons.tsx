import clsx from "clsx";
import { Loader2, LucideIcon } from "lucide-react";
import React from "react";

interface PrimaryButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  label: string;
  icon?: LucideIcon;
  loading?: boolean;
}

export function PrimaryButton({
  label,
  icon: Icon,
  loading,
  disabled,
  className,
  ...rest
}: PrimaryButtonProps) {
  return (
    <button
      {...rest}
      disabled={disabled || loading}
      className={clsx("btn-primary", className)}
      aria-label={label}
    >
      {loading ? (
        <Loader2 className="w-5 h-5 animate-spin" />
      ) : Icon ? (
        <Icon className="w-5 h-5" />
      ) : null}
      <span>{label}</span>
    </button>
  );
}

interface SecondaryButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  label: string;
  icon?: LucideIcon;
}

export function SecondaryButton({
  label,
  icon: Icon,
  className,
  ...rest
}: SecondaryButtonProps) {
  return (
    <button {...rest} className={clsx("btn-secondary", className)}>
      {Icon && <Icon className="w-5 h-5" />}
      <span>{label}</span>
    </button>
  );
}

interface GhostButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  label: string;
  icon?: LucideIcon;
  tone?: "brand" | "muted";
}

export function GhostButton({
  label,
  icon: Icon,
  tone = "brand",
  className,
  ...rest
}: GhostButtonProps) {
  return (
    <button
      {...rest}
      className={clsx(
        "inline-flex items-center justify-center gap-1 h-11 w-full font-semibold text-[15px]",
        tone === "brand" ? "text-brand" : "text-ink-muted",
        className,
      )}
    >
      {Icon && <Icon className="w-4 h-4" />}
      <span>{label}</span>
    </button>
  );
}
