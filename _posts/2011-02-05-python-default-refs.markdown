---
layout: post
title: "A Python Gotcha: References as Default Parameters"
root: ../../..
---

Suppose you're writing a Python function like [this one](https://github.com/acg/lwpb/blob/python/python/flat.py) that unpacks data into a dictionary; optionally, an existing dictionary instead of an empty one.

*Surprise*!

{% highlight python %}
$ python
Python 2.6.4
[GCC 4.4.1] on linux2
>>> def hashcopy(src, dst={}):
...   for k, v in src.items():
...     dst[k] = v
...   return dst
...
>>> hashcopy({1:2,3:4})
{1: 2, 3: 4}
>>> hashcopy({5:6,7:8})
{1: 2, 3: 4, 5: 6, 7: 8}
{% endhighlight %}

I haven't looked deeply into this, but it seems like default parameters must be bound to object instances at compile time.

In Perl 5 you typically only set default parameters at runtime, so the empty hashref you get is always the freshest in the land:

{% highlight perl %}
sub hashcopy
{
  my $src = shift;
  my $dst = shift || {};
  %$dst = (%$dst, %$src);
  return $dst;
}
{% endhighlight %}

All other things equal, this is undoubtedly slower, but considerably less wtf-subtle.

