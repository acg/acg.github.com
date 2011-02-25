---
layout: post
title: Profiling every command in a Makefile
root: ../../..
---

Here's the scenario. I've got a batch data processing pipeline implemented as a Makefile. (Hey! It's only a prototype! Trust me, I'm a make hater just like you!) There's already a lot of data, so an end-to-end full run can take about a day, with some of the individual stages taking hours.

Now I'm thinking, wouldn't it be nice to know how long each rule took? Even better, wouldn't it be nice to get a report of how much cpu it consumed, how much memory it used, how much I/O it performed, etc.? Armed with this information, I could start optimizing poorly performing stages.

So, let's suppose we cook up some wrapper program that runs a subordinate program, collects [rusage](http://www.freebsd.org/cgi/man.cgi?query=getrusage&apropos=0&sektion=2&format=html) when it exits, and prints out the interesting info. Fortunately, such a wrapper program basically already exists.

I'd rather not go rewrite every rule in the Makefile, prefixing it with this wrapper program. That wouldn't even work if the rule was a pipeline: since `make(1)` executes rules by wrapping them with `$(SHELL) -c`, only the first command in the pipeline would actually run under the wrapper.

The solution is to [set the shell](http://www.gnu.org/software/make/manual/make.html#Choosing-the-Shell) in your Makefile to:

    SHELL = rusage sh

Where `rusage` is a wrapper shell script that looks like this:

{% highlight bash %}
#!/bin/sh
exec time -f 'rc=%x elapsed=%e user=%U system=%S maxrss=%M avgrss=%t ins=%I outs=%O minflt=%R majflt=%F swaps=%W avgmem=%K avgdata=%D argv="%C"' "$@"
{% endhighlight %}

Note that this uses `/usr/bin/time`, **not to be confused** with the bash builtin `time`, which is what you're using probably 90% of the time at the command line.

Note also, this unfortunately only works with GNU `time(1)`. The BSD (and probably Darwin, haven't actually checked) versions of `time(1)` don't support the `-f` argument to specify a format string. But on BSD derivatives, you should be able to at least get a human readable dump of the rusage structure by using `/usr/bin/time -l`. Which looks equivalent to the `/usr/bin/time -v` output from GNU time. (It's just not as convenient if you plan to analyze the logs later.)

