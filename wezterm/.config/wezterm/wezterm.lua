-- Leader Key:
-- The leader key is set to ALT + q, with a timeout of 2000 milliseconds (2 seconds).
-- To execute any keybinding, press the leader key (ALT + q) first, then the corresponding key.

-- Keybindings:
-- 1. Tab Management:
--    - LEADER + c: Create a new tab in the current pane's domain.
--    - LEADER + x: Close the current pane (with confirmation).
--    - LEADER + b: Switch to the previous tab.
--    - LEADER + n: Switch to the next tab.
--    - LEADER + <number>: Switch to a specific tab (0-9).

-- 2. Pane Splitting:
--    - LEADER + |: Split the current pane horizontally into two panes.
--    - LEADER + -: Split the current pane vertically into two panes.

-- 3. Pane Navigation:
--    - LEADER + h: Move to the pane on the left.
--    - LEADER + j: Move to the pane below.
--    - LEADER + k: Move to the pane above.
--    - LEADER + l: Move to the pane on the right.
--    - NOTE: Panes can alternatively be navigated with Neovim keybindings.

-- 4. Pane Resizing:
--    - LEADER + LeftArrow: Increase the pane size to the left by 5 units.
--    - LEADER + RightArrow: Increase the pane size to the right by 5 units.
--    - LEADER + DownArrow: Increase the pane size downward by 5 units.
--    - LEADER + UpArrow: Increase the pane size upward by 5 units.

-- 5. Status Line:
--    - The status line indicates when the leader key is active, displaying an ocean wave emoji.

-- Miscellaneous Configurations:
-- - Tabs are shown even if there's only one tab.
-- - The tab bar is located at the bottom of the terminal window.
-- - Tab and split indices are zero-based.

-- Pull in the wezterm API and plugins
local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local tab = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- This table will hold the configuration
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Helper function to determine if we're on Windows or not
function is_windows()
  return wezterm.target_triple:find("windows") ~= nil
end

-- The default shell backing wezterm depends on our OS
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  -- Windows: Git Bash
  config.default_prog = { "C:/Program Files/Git/bin/bash.exe" }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  -- Linux: zsh
  config.default_prog = { "zsh" }
end

-- Configuration to make things look pretty
config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.force_reverse_video_cursor = true
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color"
config.color_scheme = "Catppuccin Mocha"
config.font_size = 14
config.window_background_opacity = 0.9
config.tab_bar_at_bottom = true

-- Configuration to mimic tmux behavior
config.leader = {
  key = "q",
  mods = "ALT",
  timeout_milliseconds = 2000,
}
config.keys = {
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  {
    mods = "LEADER",
    key = "b",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = "LEADER",
    key = "n",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = "LEADER",
    key = "\\",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = "-",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    mods = "LEADER",
    key = "LeftArrow",
    action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
  },
  {
    mods = "LEADER",
    key = "RightArrow",
    action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
  },
  {
    mods = "LEADER",
    key = "UpArrow",
    action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
  },
}

-- Trigger event for leader extension
wezterm.on("update-status", function(window, _)
  if window:leader_is_active() then
    wezterm.emit("leader.show")
  else
    wezterm.emit("leader.hide")
  end
end)

for i = 1, 9 do
  -- Enables leader + number to activate specified tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

wezterm.on("gui-startup", function(cmd)
  -- Set a workspace for coding on a current project
  -- Top pane is for the editor, bottom pane is for the build tool
  local tab, build_pane, window = wezterm.mux.spawn_window({})

  -- We want to startup in the default workspace
  tab:set_title("default")
  wezterm.mux.set_active_workspace("default")
end)

local leader_extension = {
  "leader",
  events = {
    show = "leader.show",
    hide = "leader.hide",
    delay = 2,
  },
  sections = {
    tabline_a = { " 🌊 " },
  },
}
tab.setup({
  options = {
    -- These are known as powerline symbols
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    tab_separators = { left = "", right = "" },
  },
  sections = {
    tabline_a = {}, -- Shows leader key
    tabline_b = { "workspace" },
    tabline_c = {},
    tab_active = {
      "index",
      { "parent", padding = 0 },
      "/",
      { "cwd", padding = { left = 0, right = 1 } },
    },
    tab_inactive = {
      "index",
      { "process", padding = { left = 0, right = 1 } },
    },
    tabline_x = {},
    tabline_y = { "datetime" },
    tabline_z = { "domain" },
  },
  extensions = { leader_extension },
})

-- Applys the required configuration for plugins
-- NOTE: This must be done right before returning the configuration
smart_splits.apply_to_config(config)
tab.apply_to_config(config)

-- Return the configuration to Wezterm
return config
