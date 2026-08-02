import starlight from "@astrojs/starlight";
import { defineConfig } from "astro/config";

// https://astro.build/config
export default defineConfig({
  site: "https://gdpatch.dev",
  integrations: [
    starlight({
      title: "GDPatch",
      logo: {
        src: "./public/favicon.svg",
      },
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/GDPatch/GDPatch",
        },
      ],
      editLink: {
        baseUrl: "https://github.com/GDPatch/website/edit/main/",
      },

      sidebar: [
        {
          label: "Using GDPatch",
          items: [{ autogenerate: { directory: "using" } }],
        },
        {
          label: "Mod developers",
          items: [{ autogenerate: { directory: "modding" } }],
        },
        {
          label: "GDPatch developers",
          items: [{ autogenerate: { directory: "developing" } }],
        },
      ],

      components: {
        Pagination: "./src/components/overrides/Pagination.astro",
      },
      customCss: ["./src/styles/godot.css"],
    }),
  ],
});
