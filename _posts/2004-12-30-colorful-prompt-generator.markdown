---
layout: post
title: "Colorful Bash Prompt Generator"
root: ../../..
---

(A very old post, but I've used this prompt ever since.)

Setting your bash prompt is one of those geek machismo things that usually culminates in something like

{% highlight bash %}
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\n\[\e[0m\]$ '
{% endhighlight %}

the idea being that lots of escape sequences = eliteness. (After a while you only see blondes, brunettes, and redheads.) Though, I'd guess most people just copy someone else's bash prompt and foist it off as their own, rather than learn ansi / xterm / bash escape sequences. Like <a href="http://blogs.thegotonerd.com/maelstrom/archives/000453.html">me initially</a>. :)

However, you can easily make your prompt setup readable by breaking it down. I've started doing this in my <a href="http://thegotonerd.com/scripts/agrow/conf/prompt.html">prompt</a> file.

{% highlight bash %}
# ansi color escape sequences
prompt_black='\[\e[30m\]'
prompt_red='\[\e[31m\]'
prompt_green='\[\e[32m\]'
prompt_yellow='\[\e[33m\]'
prompt_blue='\[\e[34m\]'
prompt_magenta='\[\e[35m\]'
prompt_cyan='\[\e[36m\]'
prompt_white='\[\e[37m\]'
prompt_default_color='\[\e[0m\]'
{% endhighlight %}

My motivation initially was to avoid beeping console prompts. The xterm escape sequence to set the window title contains a bell character, which was of course interpreted by xterm and friends, but not when I'd sit down at system consoles (where usually `TERM=cons25`). I needed to set `$PS1` according to `$TERM`.

In the course of things, I discovered the `\t` bash escape sequence, which gives you the current time in `hh:mm:ss` form. Nice. By incorporating this into the prompt you can now tell by inspection how long you've been sitting with your jaw open trying to remember what you were about to do. Or, how severe one's random spastic `ls`-ing has gotten.

<div class="image">
<a href="http://blogs.thegotonerd.com/maelstrom/images/bash-prompt-with-time.png">
<img src="http://blogs.thegotonerd.com/maelstrom/images/bash-prompt-with-time-small.png" />
</a>
</div>

For emergencies, there's also the no-color prompt.

{% highlight bash %}
prompt_nocolor='\n\u@\h \w\n$ '
{% endhighlight %}

For nostalgia (or out of masochism) there's the old dos prompt.

{% highlight bash %}
prompt_dos='\n\w>'
{% endhighlight %}

