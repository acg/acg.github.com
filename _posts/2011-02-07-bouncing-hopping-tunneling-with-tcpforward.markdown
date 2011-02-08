---
layout: post
title: Bouncing, Hopping and Tunneling with tcpforward
root: ../../..
---

This weekend I dusted off a little network utility of mine called [tcpforward](https://github.com/acg/tcpforward). It proved its worth once again, so instead of throwing it back into the rusty toolbox like I always do, here's why you might want to throw it into your very own rusty toolbox. ;)

<ul class="toc">
  <li><a href="#bouncing">Scenario: Remote Assistance, AKA "Bouncing Your Signal Off The Moon"</a></li>
  <li><a href="#hopping">Scenario: Hopping Over the Middleman</a></li>
  <li><a href="#tunneling">Scenario: Tunneling Through Corporate Firewalls </a></li>
  <li><a href="#how-it-works">How it Works</a></li>
</ul>

<span id="bouncing"></span> 
### Scenario: Remote Assistance, AKA "Bouncing Your Signal Off The Moon" ###

Suppose you need to SSH to a friend's machine, but you're both behind NATs.

If your friend is savvy enough to compile it, and you've got time for that, you could use [pwnat](http://samy.pl/pwnat/). You could also have your friend configure port forwarding on his router -- again, only if your friend is savvy enough, and doesn't mind punching a hole in his firewall. Yet another option: give your friend an SSH account on a public machine, and go look up the SSH arguments for reverse port forwarding for the bazillionth time.

The lowest-hassle option I can think of is to use tcpforward. Suppose you and your friend can both reach a 3rd machine, a public server you own called *moon*.

Run the following on *moon*:

{% highlight bash %}
tcpforward -v -N 1 -l moon:9922 -l moon:9921
{% endhighlight %}

Arrange for your friend to run the following on his local machine:

{% highlight bash %}
./tcpforward -v -N 1 -c moon:9922 -c localhost:22
{% endhighlight %}

Now, on your machine, run:

{% highlight bash %}
ssh -p 9921 moon
{% endhighlight %}

And voila, your SSH connection is forwarded past your friend's NAT, to his machine. The <code>-N 1</code> option makes this a one-shot connection. The <code>-v</code> option gives him something to watch while you go to work -- some realtime transfer statistics.

(This example assumes port 9921 and 9922 are open on *moon*, and that your friend is running sshd).

<span id="hopping"></span> 
### Scenario: Hopping Over the Middleman ###

Ever wanted to copy files to a machine you could only reach from an intermediate machine? For no particular reason, let's call these machines *production* and *gateway*. I bet you usually end up scp'ing or rsync'ing files to *gateway*, ssh'ing to *gateway*, then running scp or rsync again, then cleaning up the files, etc.

"There must be a better way!" I hear you scream.

Yes. First, ssh to *gateway* and run:

{% highlight bash %}
tcpforward -v -k -l 0.0.0.0:9922 -c production:22
{% endhighlight %}

In another tty on your local machine, you can now run:

{% highlight bash %}
scp -o Port=9922 somefile gateway:somefile
{% endhighlight %}

Or, rsync:

{% highlight bash %}
rsync -e "ssh -p 9922" -avzp somedir/ gateway:somedir/
{% endhighlight %}

Remember to kill the tcpforward session on *gateway*, or your sysadmin may get angry, annoyed, frightened, or all of the above.

(Once again, assumes port 9922 is open on *gateway*.)

<span id="tunneling"></span> 
### Scenario: Tunneling Through Corporate Firewalls ###

Let's continue with the slightly subversive examples. Suppose you're behind a corporate firewall that doesn't allow SSH connections out, only web traffic. You've got a public server out there called *freedom*, and you want to log in once in a while.

You could run `hts` from [httptunnel](http://www.nocrew.org/software/httptunnel.html) on *freedom*. That's a fair bit of C code to expose to the world though. ;)

Alternately, let's say you're not running anything on *freedom:443*. Most corporate firewalls will allow https out, and most of them don't do deep packet inspection to verify that the initial handshake actually conforms to the TLS protocol.

Before going off to work, run the following on *freedom*:

{% highlight bash %}
tcpforward -v -k -l 0.0.0.0:443 -c localhost:22
{% endhighlight %}

From work:

{% highlight bash %}
ssh -p 443 freedom  # scream FREEEEEEDOOOOMMM!!! as you're doing this
{% endhighlight %}

<span id="how-it-works"></span> 
### How it Works ###

The time has come to pull back the curtain, revealing the wizened figure of a [160 line Perl script](https://github.com/acg/tcpforward/blob/master/tcpforward).

How does it work?

Well, you always run `tcpforward` with two arguments that specify a pair of TCP sockets to set up, then copy bytes between. Each socket argument is either a listen / accept socket -- if you specify the `-l` flag -- or a connect socket, if you specify the `-c` flag. Once both sockets of a pair are accepted or connected, a little async I/O copy loop runs until both sockets close for reading. If you pass the `-k` flag, the I/O copy loop runs in a forked process and another socket pair is immediately ready for setup.

There's more documentation in the [POD](https://github.com/acg/tcpforward/blob/master/README.md).

Happy connection hacking!

