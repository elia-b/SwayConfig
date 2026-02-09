export const NotificationPlugin = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      // This works:
      if (event.type === "permission.asked") {
        await $`speak "Hi! I need a permission: ${event.properties.permission}" "owl"`;
      }
    },
  };
};
