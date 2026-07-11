config.load_autoconfig()

# Google rejects sign-in from qutebrowser's default UA ("unsupported browser")
config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'https://accounts.google.com/*')

# Play the current page's video in mpv (via yt-dlp) instead of the
# embedded Chromium player -- smoother than QtWebEngine for YouTube.
config.bind('m', 'spawn --detach mpv {url}')

# Same, but for a hinted link instead of the current page.
config.bind('M', 'hint links spawn --detach mpv {hint-url}')
