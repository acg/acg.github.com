---
layout: post
title: Two New Python C Extensions
root: ../../..
---

Today I'm releasing two new Python C extensions. They've been useful in fast text record processing, but could be used for plenty of other things. YMMV.

* __[percentcoding](https://github.com/acg/python-percentcoding)__ -- is a Python C extension for [percent encoding](http://en.wikipedia.org/wiki/Percent-encoding) and decoding. URL encoding is a specific instance of percent encoding, with a set of reserved characters defined by [RFC 3986](http://tools.ietf.org/html/rfc3986#section-2.1) . The `percentcoding` library can be used as a 10x faster drop-in replacement for the [urllib.quote](http://docs.python.org/library/urllib.html?highlight=urllib#urllib.quote) and [urllib.unquote](http://docs.python.org/library/urllib.html?highlight=urllib#urllib.unquote) included with Python. I use it for escaping whitespace and non-printable characters in Unix text record formats.
* __[flattery](https://github.com/acg/python-flattery)__ -- is a Python C extension for converting hierarchical data to and from flat key/value pairs. This comes up in web form processing when you've got many different input elements in a single form -- perhaps even tabular data that can be edited -- and you want to map them onto a nested data structure. I use it together with [percentcoding](https://github.com/acg/python-percentcoding) to process hierarchical record data stored in Unix text formats. Which makes them interchangeable with records in json or protocol buffer format, except that they're `sort(1)`, `cut(1)`, `join(1)` etc. friendly.

I've had pure Python implementations of these kicking around for a while. They were slow, but it didn't matter until recently. See also [a day in the life of a back-end developer](http://news.ycombinator.com/item?id=2290357):

> 1\. Find bottleneck. <br/>
> 2\. Remove bottleneck. <br/>
> 3\. Repeat. <br/>
> 4\. Every once in a while, make a bold move to throw something out that can no longer work that way and replace it with something more scalable. But while this is important, it comes up less often than you might think.

