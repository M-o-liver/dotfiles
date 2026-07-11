config.load_autoconfig()

# Play the current page's video in mpv (via yt-dlp) instead of the
# embedded Chromium player -- smoother than QtWebEngine for YouTube.
config.bind('m', 'spawn --detach mpv {url}')

# Same, but for a hinted link instead of the current page.
config.bind('M', 'hint links spawn --detach mpv {hint-url}')
