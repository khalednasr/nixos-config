-- Pull in the wezterm API
local wezterm = require "wezterm"

config = wezterm.config_builder()

config.color_scheme = 'GruvboxDarkHard'

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.5,
}

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 48
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(
    config,
    {
        position = "top",
        modules = {
            workspace = { enabled = false },
            leader = { enabled = false },
            pane = { enabled = false },
            username = { enabled = false },
            hostname = { enabled = false },
            cwd = { enabled = false },

        }
    }
)

config.font = wezterm.font 'Maple Mono'
config.colors.background = 'black'

config.window_decorations = "NONE"
config.window_close_confirmation = 'NeverPrompt'

config.disable_default_key_bindings = true

config.keys = {
    -- Tabs
    { mods = "ALT|SHIFT", key = "t", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
    { mods = "ALT|SHIFT", key = "q", action = wezterm.action.CloseCurrentTab { confirm = false } },
    { mods = "ALT|SHIFT", key = "h", action = wezterm.action.ActivateTabRelative(-1) },
    { mods = "ALT|SHIFT", key = "l", action = wezterm.action.ActivateTabRelative(1) },

    -- Panes
    { mods = "ALT", key = "q", action = wezterm.action.CloseCurrentPane { confirm = false } },
    { mods = "ALT", key = "<", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { mods = "ALT", key = "-", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { mods = "ALT", key = "h", action = wezterm.action.ActivatePaneDirection "Left" },
    { mods = "ALT", key = "j", action = wezterm.action.ActivatePaneDirection "Down" },
    { mods = "ALT", key = "k", action = wezterm.action.ActivatePaneDirection "Up" },
    { mods = "ALT", key = "l", action = wezterm.action.ActivatePaneDirection "Right" },
    { mods = "ALT", key = "z", action = wezterm.action.TogglePaneZoomState },

    -- Pane sizing
    { mods = "ALT", key = "LeftArrow", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
    { mods = "ALT", key = "RightArrow", action = wezterm.action.AdjustPaneSize { "Right", 5 } },
    { mods = "ALT", key = "DownArrow", action = wezterm.action.AdjustPaneSize { "Down", 5 } },
    { mods = "ALT", key = "UpArrow", action = wezterm.action.AdjustPaneSize { "Up", 5 } },

    -- Clipboard
    { mods = 'CTRL|SHIFT', key = "c", action = wezterm.action.CopyTo "Clipboard" },
    { mods = 'CTRL|SHIFT', key = "v", action = wezterm.action.PasteFrom "Clipboard" },

    -- Command palette
    { mods = 'ALT', key = "d", action = wezterm.action.ActivateCommandPalette },
}

-- Direct tab selection
for i = 1, 9 do
    -- ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "ALT",
        action = wezterm.action.ActivateTab(i - 1),
    })
end


-- and finally, return the configuration to wezterm
return config
