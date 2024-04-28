---
Title: "Fallout: easy(ish) installation on macOS (Apple Silicon)"
Date: 2024-04-28
Tags: [macos, gaming]
---

Having just finished the TV series of the same title, I figured it would be a
good time to replay one of my favorite games from my teenage years: Fallout,
but I don't own a Windows computer and the game was never released for macOS.
Fortunately, the excellent [Fallout Community Edition][fallout1-ce] project
faithfully reimplements the game, although the installation instructions for
macOS are, for the moment, a mess. While those instructions are being ironed
out in the issue tracker, I'm hoping this guide can help anyone who just wants
to play the game on a Mac with minimal fuss.

<!-- more -->

NOTE: This guide still requires you to purchase the game. Presently it's going
for $10 on Steam (and $2.99 on GOG, but I couldn't get the GOG artifacts
working on macOS).

# Instructions

1. Install the [Steam macOS client][install-steam]
2. From the terminal, run Steam with the `-console` flag:
   `/Applications/Steam.app/Contents/MacOS/steam_osx -console`. This will give
   you a new `CONSOLE` tab at the top beside the `STORE`, `LIBRARY`, etc tabs.
3. Find [Fallout on steamdb.info](https://steamdb.info/app/38400/) and grab the
   app ID and the depot ID (for me the app ID was `38400` and the English
   language depot ID was `38409`--you can find more depots on the 'depots' tab
   on the left of the page)
4. In the `CONSOLE` tab of the Steam client, run `download_depot <appid>
   <depotid>` (e.g., `download_depot 38400 38409`). After a moment, the console
   should report that the download has begun and when it completes, it will
   print the download path.
5. Optionally move or copy the depot directory somewhere more accessible, like
   `~/Games/Fallout`
6. Download the Fallout CE installer (the macOS .dmg file) from the [Fallout CE
   releases page][fallout1-ce-releases] if you haven't already. Running the
   installer should open a Finder window with just the `Fallout Community
   Edition` app; drag that into your depot directory (e.g., `~/Games/Fallout`).
7. Open your depot directory in a Finder window and double-click the `Fallout
   Community Edition` application to start the game.

If you find an issue with these instructions, consider [opening an
issue](https://github.com/weberc2/blog/issues) against my blog or submit a pull
request. You can also try emailing me directly (see my contact info at the
bottom of the page).

# Attribution

I was able to piece this together thanks largely to [this comment][mac-gaming]
on r/macgaming. That's probably a good place to look for more general advice or
help with playing games on macOS.

[steam-db-fallout]: https://steamdb.info/app/38400/
[install-steam]: https://store.steampowered.com/about/
[macgaming]: https://www.reddit.com/r/macgaming/comments/2idpsc/comment/kk4z69a/
[fallout1-ce]: https://github.com/alexbatalov/fallout1-ce
[fallout1-ce-releases]: https://github.com/alexbatalov/fallout1-ce/releases
