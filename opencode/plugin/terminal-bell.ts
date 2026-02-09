import type { Plugin } from "@opencode-ai/plugin";

export const TerminalBell: Plugin = async ({
  project,
  client,
  $,
  directory,
  worktree,
}) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        try {
          await $`speak "Hi! I am done" "owl"`;
        } catch (err) {
          console.warn("Failed to play audible bell:", err);
        }
        // } else if (event.type === "permission.updated") {
        //   try {
        //     await $`speak "Hi! I need a permission" "owl"`;
        //   } catch (err) {
        //     console.warn("Failed to play audible bell:", err);
        //   }
      }
    },
  };
};
