# configuration file for qutebrowser

config.source('./themes/zenburn.py')

c.url.start_pages = "file:///home/amlan/.config/qutebrowser/startpage.html"
c.url.default_page = "file:///home/amlan/.config/qutebrowser/startpage.html"

c.tabs.favicons.show = "never"
c.tabs.indicator.width = 0  # disable the indicator
c.tabs.show = "multiple"  # hide the tab bar when there's only one
c.tabs.padding = {"bottom": 5, "top": 5, "left": 10, "right": 5}
c.statusbar.padding = {"bottom": 5, "top": 5, "left": 2, "right": 5}
c.hints.padding = {"bottom": 5, "top": 5, "left": 5, "right": 5}
c.scrolling.smooth = False
c.editor.command = ["nvim", "{file}"]

c.fonts.default_family = "Inter"
c.fonts.default_size = "10pt"

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g": "https://google.com/search?q={}",
    "wi": "https://en.wikipedia.org/wiki/Special:Search?search={}",
    "aw": "https://wiki.archlinux.org/title/Special:Search?search={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "dd": "https://devdocs.io/#q={}",
}

config.bind(",sc", "config-source")
config.bind(",hs", "config-cycle statusbar.show never always")
config.bind(",m", "hint links spawn mpv {hint-url}")
config.bind(",do", "download-open")
config.bind("sd", "spawn --userscript dict-search")
config.bind("sm", "set-mark m")
config.bind(",jm", "jump-mark m")

c.content.cookies.accept = "no-unknown-3rdparty"
c.content.cookies.store = True
c.content.blocking.method = "both"  # use both hosts blocking and Brave's ABP-style adblocker(requires the python-adblock library to be installed)

config.load_autoconfig(False)
