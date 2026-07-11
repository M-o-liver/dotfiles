config.load_autoconfig()

# Real EasyList/EasyPrivacy ad+tracker blocking (Brave's adblock-rust engine,
# via the 'adblock' pip package) instead of the cruder hosts-file fallback.
# Run :adblock-update once to fetch the lists (content.blocking.adblock.lists
# already defaults to EasyList + EasyPrivacy).
config.set('content.blocking.method', 'both')

# Google rejects sign-in from qutebrowser's default UA ("unsupported browser")
config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'https://accounts.google.com/*')

# Play the current page's video in mpv (via yt-dlp) instead of the
# embedded Chromium player -- smoother than QtWebEngine for YouTube.
config.bind('m', 'spawn --detach mpv {url}')

# Same, but for a hinted link instead of the current page.
config.bind('M', 'hint links spawn --detach mpv {hint-url}')

# Explicit tab controls: familiar Ctrl-based bindings alongside the vim-style
# defaults (t/T open, d close, u reopen, J/K or gt/gT switch, H/L back/forward)
config.bind('<Ctrl-t>', 'open -t')
config.bind('<Ctrl-w>', 'tab-close')
config.bind('<Ctrl-Shift-t>', 'undo')
config.bind('<Ctrl-Tab>', 'tab-next')
config.bind('<Ctrl-Shift-Tab>', 'tab-prev')
config.bind('<Alt-Left>', 'back')
config.bind('<Alt-Right>', 'forward')
