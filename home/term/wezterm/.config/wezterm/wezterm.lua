local term = require("wezterm")
local act = term.action

local conf = {}

if term.config_builder then
    conf = term.config_builder()
end

conf.check_for_updates = false

conf.term = "wezterm"
conf.default_prog = { "/opt/homebrew/bin/bash", "-l", "-c", "tmux_bind_fzf" }

-- conf.window_decorations = "RESIZE"
-- term.on("gui-startup", function()
--     local _, _, window = term.mux.spawn_window({})
--     window:gui_window():maximize()
-- end)

-- Appearance
conf.enable_tab_bar = false

conf.window_padding = {
    left = "1cell",
    right = "1cell",
    top = "1cell",
    bottom = "0.5cell",
}

conf.window_background_opacity = 1.0
conf.animation_fps = 1
conf.default_cursor_style = "SteadyBlock"

-- Colors
conf.color_scheme_dirs = { "$HOME/.config/wezterm/colors/" }
conf.color_scheme = "boo"

-- Font
conf.font = term.font_with_fallback({ "MonaspiceNe NF", "Apple Color Emoji" })
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

conf.font_size = 16.0
conf.line_height = 1.2

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
    { key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
}

return conf
