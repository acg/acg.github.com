---
layout: post
title: "LCD Smashed, So...Ratpoison"
root: ../../..
---

I just had a really terrible and wonderful thing happen to me. I dropped my thinkpad T40, shattering the LCD panel at pixel y=514 and below. That's the terrible part. The wonderful part is that I am now running ratpoison with the following fdump to compensate...the upper 2/3 of my screen is usable enough to find a replacement laptop / screen on.

{% highlight scheme %}
(frame :number 2 :x 0 :y 0 :width 1024 :height 514 :screenw 1024 :screenh 768 :window 12582974 :last-access 126 :dedicated 0),(frame :number 0 :x 0 :y 514 :width 1024 :height 254 :screenw 1024 :screenh 768 :window 16777278 :last-access 0 :dedicated 0)
{% endhighlight %}

