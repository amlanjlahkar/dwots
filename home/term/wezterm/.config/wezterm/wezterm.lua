local term = require("wezterm")
local act = term.action

local conf = {}

if term.config_builder then
    conf = term.config_builder()
end

conf.check_for_updates = false

conf.term = "wezterm"
conf.default_prog = { "/opt/homebrew/bin/bash", "-l", "-c", "tmux_bind_fzf" }
conf.audible_bell = "Disabled"

conf.window_decorations = "RESIZE"
term.on("gui-startup", function()
    local _, _, window = term.mux.spawn_window({})
    window:gui_window():maximize()
end)

-- Appearance
conf.enable_tab_bar = false

conf.window_padding = {
    left = "1cell",
    right = "1cell",
    top = "1cell",
    bottom = "0.5cell",
}

conf.animation_fps = 1
conf.default_cursor_style = "SteadyBlock"
-- conf.window_background_opacity = 0.9
-- conf.macos_window_background_blur = 0

-- conf.background = {
--     {
--         source = { File = "" },
--         hsb = { brightness = 0.05, saturation = 0.8 },
--         vertical_align = "Bottom",
--         vertical_offset = "4cell",
--     },
-- }

-- Colors
conf.color_scheme_dirs = { "$HOME/.config/wezterm/colors/" }
conf.color_scheme = "boo"

-- Font
conf.font = term.font_with_fallback({
    "Serious Sans",
    { family = "Symbols Nerd Font", scale = 0.85 },
    { family = "Apple Symbols", scale = 1 },
    { family = "Apple Color Emoji", assume_emoji_presentation = true },
})

conf.font_rules = {
    {
        intensity = "Normal",
        italic = true,
        font = term.font({
            family = "Serious Sans Italic",
            style = "Normal",
        }),
    },

    {
        intensity = "Bold",
        italic = false,
        font = term.font({
            family = "Serious Sans Bold",
            style = "Normal",
        }),
    },

    {
        intensity = "Bold",
        italic = true,
        font = term.font({
            family = "Serious Sans Bold Italic",
            style = "Normal",
        }),
    },
}

conf.font_size = 18
conf.line_height = 1.1

conf.freetype_load_target = "Light"
conf.freetype_render_target = "HorizontalLcd"
conf.freetype_load_flags = "NO_HINTING"

-- Keybinds
conf.disable_default_key_bindings = true
conf.keys = {
    { key = "l", mods = "SUPER|SHIFT", action = act.ToggleFullScreen },
    { key = "=", mods = "SUPER", action = act.IncreaseFontSize },
    { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
    { key = "0", mods = "SUPER", action = act.ResetFontSize },
    { key = "y", mods = "SUPER", action = act.CopyTo("Clipboard") },
    { key = "p", mods = "SUPER", action = act.PasteFrom("Clipboard") },
    { key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
}

return conf
