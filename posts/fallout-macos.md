---
Title: "Fallout: easy(ish) installation on macOS (Apple Silicon)"
# NB: post thumbnails aren't yet supported in futhorc, but this is the one to
# use if support gets added
Thumbnail: /assets/posts/fallout-macos/fallout.jpg
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

1. Install the [Steam macOS client][install-steam] ![install steam](/assets/posts/fallout-macos/install-steam.png)

2. From the terminal, run Steam with the `-console` flag:
   `/Applications/Steam.app/Contents/MacOS/steam_osx -console`. This will give
   you a new `CONSOLE` tab at the top beside the `STORE`, `LIBRARY`, etc tabs.
   ```bash
   $ /Applications/Steam.app/Contents/MacOS/steam_osx -console
   src/vstdlib/osversion.cpp (393) : Assertion Failed: Unsupported macOS version 14.2.0
   src/vstdlib/osversion.cpp (393) : Assertion Failed: Unsupported macOS version 14.2.0
   [2024-04-28 14:12:23] Startup - updater built Mar 15 2022 17:15:24
   [2024-04-28 14:12:23] Startup - updater built Mar  6 2024 12:28:54
   [2024-04-28 14:12:23] Startup - Steam Client launched with: '/Users/weberc2/Library/Application Support/Steam/Steam.AppBundle/Steam/Contents/MacOS/steam_osx' '-console'
   found breakpad via in process memory: '/Users/weberc2/Library/Application Support/Steam/Steam.AppBundle/Steam/Contents/MacOS/Frameworks/Breakpad.framework/Versions/A/Resources'
   Installing breakpad crash handler
   [2024-04-28 14:12:23] Loading cached metrics from disk (/Users/weberc2/Library/Application Support/Steam/Steam.AppBundle/Steam/Contents/MacOS/package/steam_client_metrics.bin)
   [2024-04-28 14:12:23] Using the following download hosts for Public, Realm steamglobal
   [2024-04-28 14:12:23] 1. https://client-update.akamai.steamstatic.com, /, Realm 'steamglobal', weight was 1000, source = 'update_hosts_cached.vdf'
   [2024-04-28 14:12:23] 2. https://cdn.cloudflare.steamstatic.com, /client/, Realm 'steamglobal', weight was 1, source = 'update_hosts_cached.vdf'
   [2024-04-28 14:12:23] 3. https://cdn.steamstatic.com, /client/, Realm 'steamglobal', weight was 1, source = 'baked in'
   SteamID:  0, universe Public
   [2024-04-28 14:12:23] Verifying installation...
   [2024-04-28 14:12:24] Verification complete
   [2024-04-28 14:12:24] Not updating bootstrapper: No update necessary: current version 4.0, package version 4.0
   [2024-04-28 14:12:24] Shutdown
   ```

3. In the `CONSOLE` tab of the Steam client, run `download_depot 38400
   38409`[^1]. After a moment, the console should report that the download has
   begun and when it completes, it will print the download path. Optionally
   move or copy the depot directory somewhere more accessible, like
   `~/Games/Fallout` ![download game from steam
   console](/assets/posts/fallout-macos/steam-console.png)

4. Download the Fallout CE installer (the macOS .dmg file) from the [Fallout CE
   releases page][fallout1-ce-releases] if you haven't already. Running the
   installer should open a Finder window with just the `Fallout Community
   Edition` app; drag that into your depot directory (e.g., `~/Games/Fallout`).
   ![drag fallout-ce to depot
   directory](/assets/posts/fallout-macos/fallout-ce-installer.png)

5. Open your depot directory in a Finder window and double-click the `Fallout
   Community Edition` application to start the game.
   ![fallout](/assets/posts/fallout-macos/fallout.jpg)

If you find an issue with these instructions, consider [opening an
issue](https://github.com/weberc2/blog/issues) against my blog or submit a pull
request. You can also try messaging me directly (see my contact info at the
bottom of the page).

# Attribution

I was able to piece this together thanks largely to [this comment][macgaming]
on r/macgaming. That's probably a good place to look for more general advice or
help with playing games on macOS.

[^1]: I got the app ID and depot IDs from [the Fallout page on
    steamdb.info](https://steamdb.info/app/38400/). The app ID was `38400` and
    the English language depot ID was `38409`--you can find more depots on the
    'depots' tab on the left of that page)

[steam-db-fallout]: https://steamdb.info/app/38400/
[install-steam]: https://store.steampowered.com/about/
[macgaming]: https://www.reddit.com/r/macgaming/comments/2idpsc/comment/kk4z69a/
[fallout1-ce]: https://github.com/alexbatalov/fallout1-ce
[fallout1-ce-releases]: https://github.com/alexbatalov/fallout1-ce/releases
