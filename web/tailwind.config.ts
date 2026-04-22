import type { Config } from "tailwindcss";

export default {
  content: ["./index.html", "./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        brand: {
          DEFAULT: "#1F6FEB",
          pressed: "#1657B5",
          tint: "#E8F1FE",
        },
        ink: {
          DEFAULT: "#0F172A",
          muted: "#475569",
          subtle: "#64748B",
        },
        surface: {
          DEFAULT: "#FFFFFF",
          alt: "#F5F7FA",
        },
        line: {
          DEFAULT: "#E2E8F0",
          strong: "#CBD5E1",
          soft: "#EDF1F6",
        },
        success: {
          DEFAULT: "#2E7D32",
          tint: "#E8F3EA",
        },
        warn: "#C45A00",
        danger: {
          DEFAULT: "#B42318",
          tint: "#FDECEA",
        },
      },
      fontFamily: {
        display: [
          "'SF Pro Rounded'",
          "system-ui",
          "-apple-system",
          "Segoe UI",
          "Roboto",
          "sans-serif",
        ],
        sans: [
          "-apple-system",
          "system-ui",
          "Segoe UI",
          "Roboto",
          "sans-serif",
        ],
      },
      borderRadius: {
        lg: "12px",
        xl: "16px",
      },
      boxShadow: {
        card: "0 6px 24px rgba(15, 23, 42, 0.06)",
        hero: "0 14px 40px rgba(31, 111, 235, 0.18)",
      },
    },
  },
  plugins: [],
} satisfies Config;
