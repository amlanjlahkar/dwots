# configuration file for qutebrowser

# colorscheme
config.source('themes/material.py')

# start page
c.url.start_pages = 'file:///home/amlan/projects/startpage/index.html'
c.url.default_page = 'file:///home/amlan/projects/startpage/index.html'

# general configurations
c.tabs.favicons.show = 'never'
c.tabs.indicator.width = 0      # disable the indicator
c.tabs.show = 'multiple'        # hide the tab bar when there's only one
c.tabs.padding = {"bottom": 2, "top": 2, "left": 10, "right": 5}

c.statusbar.padding = {"bottom": 2, "top": 2, "left": 2, "right": 5}
c.scrolling.smooth = False

c.editor.command = ["nvim", "{file}"]

## fonts
c.fonts.default_family = 'Input Sans Condensed'
c.fonts.default_size = '10pt'

# search engines
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g" : "https://google.com/search?q={}",
    "wi": "https://en.wikipedia.org/wiki/Special:Search?search={}",
    "aw": "https://wiki.archlinux.org/title/Special:Search?search={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "dd": "https://devdocs.io/#q={}"
}


# keybindings
config.bind(',sc', 'config-source')
config.bind(',hs', 'config-cycle statusbar.show never always')
config.bind(',m',  'hint links spawn mpv {hint-url}')
config.bind(',do', 'download-open')
config.bind('sd',  'spawn --userscript dict-search')

#config.bind(',gd', 'config-cycle content.user_stylesheets ./stylesheets/gruvbox_dark.css ""')
config.bind(',sl', 'config-cycle content.user_stylesheets ./stylesheets/solarized_light.css ""')
config.bind(',sd', 'config-cycle content.user_stylesheets ./stylesheets/solarized_dark.css ""')

# Privacy
c.content.cookies.accept = 'no-3rdparty'
c.content.blocking.method = 'both'      # use both hosts blocking and Brave's ABP-style adblocker(requires the python-adblock library to be installed)

# disable loadng the autoconfig.yml file upon restart
config.load_autoconfig(False)
