---
layout: post
title: Saving Flash Videos with Linux
root: ../../..
---

Sometimes, when I'm watching a flash video in my browser, I'd like to download the video file itself and watch it later, offline.

With older versions of the linux flash plugin this was easy: the flash video file was downloaded to a temporary path like `/tmp/FlashXX1sjAm9`. You could just copy the file to somewhere outside of `/tmp`.

The most recent linux flash plugin makes this a bit harder, but it's still no match for a wily unix user. The new problem is that flash deletes the `/tmp/FlashXYZblah` video file. But the key is that the flash process still has the deleted file open for reading and writing.

The following instructions work for both Firefox and Chrome. (But they certainly won't work forever; I'm sure future versions of the flash plugin will find a way to make this even more convoluted.)

First, load the page with the video, start playing it, and wait for the video to finish buffering.

Next, track down the flash plugin process.

    $ ps ax | grep flash
    28988 ?        Sl     0:03 /usr/lib/firefox-3.6.13/plugin-container /usr/lib/flashplugin-installer/libflashplayer.so 28970 plugin

Now, we're going to use the `/proc` filesystem.

    $ cd /proc/28988/fd/

    $ ls -l
    total 0K
    lr-x------ 1 user user 64 2011-02-28 13:05 0 -> /dev/null
    lrwx------ 1 user user 64 2011-02-28 13:05 1 -> /mnt/common/home/user/.xsession-errors
    lrwx------ 1 user user 64 2011-02-28 13:05 10 -> pipe:[7860847]
    lrwx------ 1 user user 64 2011-02-28 13:05 11 -> pipe:[7860848]
    lrwx------ 1 user user 64 2011-02-28 13:05 12 -> pipe:[7860848]
    lrwx------ 1 user user 64 2011-02-28 13:05 13 -> socket:[7860851]
    lrwx------ 1 user user 64 2011-02-28 13:05 14 -> /mnt/common/home/user/.mozilla/firefox/abc123.default/cert8.db
    l-wx------ 1 user user 64 2011-02-28 13:05 15 -> /mnt/common/home/user/.mozilla/firefox/abc123.default/key3.db
    lrwx------ 1 user user 64 2011-02-28 13:05 16 -> /tmp/FlashXX1sjAm9 (deleted)
    lrwx------ 1 user user 64 2011-02-28 13:05 17 -> pipe:[7860983]
    lrwx------ 1 user user 64 2011-02-28 13:05 18 -> pipe:[7860983]
    lr-x------ 1 user user 64 2011-02-28 13:05 19 -> pipe:[7860984]
    lrwx------ 1 user user 64 2011-02-28 13:05 2 -> /mnt/common/home/user/.xsession-errors
    l-wx------ 1 user user 64 2011-02-28 13:05 20 -> pipe:[7860984]
    lr-x------ 1 user user 64 2011-02-28 13:05 21 -> socket:[7860988]
    lrwx------ 1 user user 64 2011-02-28 13:05 3 -> socket:[7860769]
    lr-x------ 1 user user 64 2011-02-28 13:05 4 -> anon_inode:[eventpoll]
    l-wx------ 1 user user 64 2011-02-28 13:05 5 -> socket:[7860844]
    lr-x------ 1 user user 64 2011-02-28 13:05 6 -> socket:[7860845]
    l-wx------ 1 user user 64 2011-02-28 13:05 7 -> pipe:[7860846]
    lr-x------ 1 user user 64 2011-02-28 13:05 8 -> pipe:[7860846]
    l-wx------ 1 user user 64 2011-02-28 13:05 9 -> pipe:[7860847]

Okay, there's a bunch of junk we don't care about. But see file descriptor 16? That's a symlink to the deleted flash video. Save it:

    $ cp 16 ~/movie.flv

Test that you can play the video:

    $ mplayer ~/movie.flv

