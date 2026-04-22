import { ChevronLeft } from "lucide-react";
import React from "react";
import { ProgressDots } from "./Rows";

interface OnboardingScaffoldProps {
  title: string;
  subtitle?: string;
  onBack?: () => void;
  progress?: { current: number; total: number };
  children: React.ReactNode;
  footer: React.ReactNode;
}

export function OnboardingScaffold({
  title,
  subtitle,
  onBack,
  progress,
  children,
  footer,
}: OnboardingScaffoldProps) {
  return (
    <div className="screen">
      <header className="flex items-center justify-between px-4 pt-3 pb-2">
        {onBack ? (
          <button
            onClick={onBack}
            aria-label="Back"
            className="w-11 h-11 rounded-full bg-surface border border-line flex items-center justify-center text-ink"
          >
            <ChevronLeft className="w-5 h-5" />
          </button>
        ) : (
          <span className="w-11 h-11" />
        )}
        {progress ? (
          <ProgressDots total={progress.total} current={progress.current} />
        ) : (
          <span />
        )}
        <span className="w-11 h-11" />
      </header>

      <div className="screen-scroll pt-2">
        <div className="mb-5">
          <h1 className="font-display text-[30px] leading-[1.15] font-bold text-ink">
            {title}
          </h1>
          {subtitle && (
            <p className="mt-2 text-[16px] text-ink-muted leading-snug">
              {subtitle}
            </p>
          )}
        </div>
        <div className="space-y-3">{children}</div>
      </div>

      <footer className="px-6 pt-2 pb-5 space-y-2 bg-surface-alt">
        {footer}
      </footer>
    </div>
  );
}
