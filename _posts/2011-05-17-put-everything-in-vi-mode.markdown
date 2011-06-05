---
layout: post
title: Put *Everything* in vi Mode
root: ../../..
---

It's the little things in life. Especially when they add up. Consider, for instance, the calculus of a productivity tweak you should have made half a decade ago.

If you're a vi user like me, try adding these two lines to your `~/.inputrc` file:

    set keymap vi
    set editing-mode vi

Now, every program that uses the readline library for tty input ( `perl -d`, the `python` REPL, `psql`, `gdb`, anything you run under `rlwrap`, etc.) has vi key bindings instead of the default emacs bindings.

In short, this means things like:

* `0` and `$` for beginning and end of line
* `k` and `j` for navigating history forwards and backwards
* `b` and `e` for skipping words
* `u` for undo

The full list is in the [readline man page](http://www.freebsd.org/cgi/man.cgi?query=readline&apropos=0&sektion=0&manpath=FreeBSD+8.2-RELEASE&format=html#DEFAULT_KEY_BINDINGS).

I've been using this for years with bash, where one can do `set -o vi`. Are full vi bindings a recent feature of readline? Or do I really have no excuse for this one?

