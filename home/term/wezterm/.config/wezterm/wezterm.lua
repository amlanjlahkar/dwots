local term = require("wezterm")
local act = term.action

local conf = {}

if term.config_builder then
    conf = term.config_builder()
end

conf.check_for_updates = false

conf.term = "wezterm"
conf.default_prog = { "/opt/homebrew/bin/bash", "-l", "-c", "tmux_bind_fzf" }

-- Appearance
conf.enable_tab_bar = false

conf.window_padding = {
    left = "10pt",
    right = "10pt",
    top = "10pt",
    bottom = "5pt",
}

conf.animation_fps = 1
conf.default_cursor_style = "BlinkingBlock"
conf.cursor_blink_ease_in = "Constant"
conf.cursor_blink_ease_in = "Constant"

-- Colors
conf.color_scheme_dirs = { "$HOME/.config/wezterm/colors/" }
conf.color_scheme = "boo"

-- Font
conf.font = term.font_with_fallback({ "MonaspiceAr NF" })
conf.font_rules = {
    {
        intensity = "Normal",
        italic = true,
        font = term.font("MonaspiceRn NF", { weight = "Regular" }),
    },

    {
        intensity = "Bold",
        italic = false,
        font = term.font("MonaspiceXe NF", { weight = "Medium" }),
    },

    {
        intensity = "Bold",
        italic = true,
        font = term.font("MonaspiceXe NF", { weight = "Bold" }),
    },
}

conf.font_size = 15.0
conf.line_height = 1.0

conf.freetype_load_target = "Light"
conf.freetype_render_target = "HorizontalLcd"

-- Keybinds
conf.disable_default_key_bindings = true
conf.keys = {
    { key = "=", mods = "SUPER", action = act.IncreaseFontSize },
    { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
    { key = "0", mods = "SUPER", action = act.ResetFontSize },
    { key = "y", mods = "SUPER", action = act.CopyTo("Clipboard") },
    { key = "p", mods = "SUPER", action = act.PasteFrom("Clipboard") },
}

return conf
