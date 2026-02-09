import type { Plugin } from "@opencode-ai/plugin";

export const TerminalBell: Plugin = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        try {
          await $`speak "Hi! I am done" "owl"`;
        } catch (err) {
          console.warn("Failed to use speak:", err);
        }
      }
    },
  };
};
