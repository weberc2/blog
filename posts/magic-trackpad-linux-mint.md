---
Title: Supporting Magic Trackpad 2 on Linux Mint
Date: 2025-01-23
Tags: [linux, linux-desktop, linux-mint]
---

I bought a $200 Beelink mini PC with some Christmas money. It has 1TB disk and
16GB RAM and an Intel N150 with a TDP of about 6W. I was specifically looking
for a machine that could transcode a 4K stream or two for my Kubernetes cluster,
since the Raspberry Pis still aren't up to the task. But then I got tempted to
run a desktop Linux on it as well, and ended up installing Linux Mint. Then I
got annoyed with the cords and decided to switch to bluetooth
peripherals--keyboard, speaker, and touchpad. This post documents how I got my
Apple Magic Trackpad 2 running on Linux Mint and the problems that I solved as
well as remaining issues.

<!-- more -->

Mostly the trackpad worked as expected. It kept pairing to my MacBook Pro, so I
had to move the latter across the room and then I could pair it to my Linux
machine. The basic clicking and cursor movements worked fine, but scrolling was
really aggressive and I couldn't use gestures to change workspaces like I'm used
to.

## Gestures

This was the easiest part. Just open the "Gestures" app from the menu, enable
gestures (from the Settings tab), and then set the 3 finger swipe gestures
accordingly:

[![Swipe left: Switch to right workspace; Swipe right: Switch to left workspace;
Swipe up: Show the workspace selector (Expo); Swipe down: Show the window
selector (Scale)][gestures]][gestures]

In all cases, "Trigger at gesture start" should be set, or else the gesture will
feel delayed.

If you want to debug gestures, you can run `touchegg --debug` in a terminal
window and it will print the gestures it receives (Linux Mint uses touchegg to
listen for gestures from input devices).

## Scrolling sensitivity 

Linux Mint uses libinput for its input devices. There's no real documentation
about how to change touchpad sensitivity (at least nothing that was coming up in
my extensive Googling), but I was able to piece some stuff together from various
fora and experimentation:

The TL;DR is that you have to paste something like this into your terminal
whenever you log in (not sure how to best persist this yet):

```bash
xinput set-prop "Apple Inc. Magic Trackpad 2" "libinput Scrolling Pixel Distance" 40
```

We're setting the "scrolling pixel distance" property to 40, which roughly
matches my expectations coming from Mac. Lower values are more sensitive, and
valid values are from 10-50 (10 being the most aggressive/sensitive scrolling
and 50 being the least). None of this is documented anywhere online though, and
curiously the valid band of values repeats every 256 values, meaning that -246,
10, and 266 all code for the most sensitive/aggressive scrolling experience and
-206, 50, and 306 all code for the least aggressive experience.

<summary>

<details>

```bash
$ for i in {-247..1034}; do
    if xinput set-prop "Apple Inc. Magic Trackpad 2" "libinput Scrolling Pixel Distance" $i > /dev/null 2>&1; then
        echo "$i success";
    else
        echo "$i failure";
    fi;
done

# -246 through -206 (41)  : success
# -205 through 9    (215) : failure
# 10   through 50   (41)  : success
# 51   through 265  (215) : failure
# 266  through 306  (41)  : success
# 307  through 521  (215) : failure
# 522  through 562  (41)  : success
# 563  through 777  (215) : failure
# 778  through 818  (41)  : success
# 819  through 1033 (215) : failure
```

</details>

</summary>

## Remaining issues

* Bluetooth does not connect automatically when the system starts up. This is true
  for all Bluetooth devices (including the keyboard, which means I can't log in
  without a USB keyboard, and thus I will have to figure something out in the
  near future). I guess no desktop Linux developer has bluetooth peripherals
  that they've wanted to autoconnect before, because there's no canonical tool
  to solve this problem (that I've come across in Googling, anyway), so I
  suspect I'll just write some script around `bluetoothctl` and a corresponding
  `systemd` unit that will make sure the script is always running.

* I can't figure out how to persist the scrolling sensitivity changes, so I
  have to re-run the xinput command every time I log in. I'm sure there's some
  `~/foorc` file I can stick this in--again, it's sort of crazy that no Linux
  developer has ever needed to persist their touchpad settings. Maybe they'll
  address this and the Bluetooth concern and 2026 will truly be the Year of the
  Linux Desktop?

* The touchpad will generally behave sluggishly from time to time. This
  seems to be a common problem across touchpads, and it seems to be related to
  libinput according to other issues I've seen online. Hopefully this will be
  fixed in future updates; it's not intolerable for now.

[gestures]: /assets/posts/magic-trackpad-linux-mint/gestures.png