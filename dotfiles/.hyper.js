module.exports = {
  config: {

    // =============================================================================================
    // General
    // =============================================================================================

    // choose either "stable" for receiving highly polished,
    // or "canary" for less polished but more frequent updates
    updateChannel: "stable",

    // =============================================================================================
    // Fonts
    // =============================================================================================

    fontSize: 15,
    fontFamily: "JetBrainsMono Nerd Font",

    // =============================================================================================
    // UI
    // =============================================================================================

    css: "",
    termCSS: "",
    showHamburgerMenu: "",
    showWindowControls: "",
    padding: "12px 14px",
    catppuccinTheme: "macchiato",
  },

  // =============================================================================================
  // Plugins
  // =============================================================================================

  plugins: [
    "hypurr#latest",
    "hyper-tabs-enhanced",
    "hyperminimal",
    "hyperterm-summon",
    "hypercwd",
    "hyper-search",
  ],

  hyperTabs: {
    trafficButtons: true,
    border: true
  },
};
