---
layout: post
title: Mapping Python Code Over Records With lwpb
root: ../../..
---

*In which we reimplement `wc(1)` as a [python one-liner](#wc-pbio-example), discover a [neat feature](#python-exec) in the Python interpreter, [rip through](#top10-pbio-example) a bunch of records in a document database, and generally start to wonder if we're converging on the `awk(1)` of Protocol Buffers.*

In my work on [lwpb](https://github.com/acg/lwpb), a library which includes a [fast](https://github.com/acg/lwpb#performance) Python encoder and decoder for [Google Protocol Buffers](http://code.google.com/p/protobuf/), one of the first things I needed was a comfortable way to convert between a protobuf stream and a plain old text stream. You know, the usual Unix tab- and newline-delimited records thing. Once you've got this conversion, your old friends `grep(1)`, `cut(1)`, `sort(1)`, et al. can help you again.

The tool that emerged is [pbio](https://github.com/acg/lwpb/blob/python/python/pbio.py). It converts in both directions, and can also do some other things like extract a range of records. So far, pretty pedestrian right?

But with a mere [8 line patch](https://github.com/acg/lwpb/commit/a64f2f9eeb497cc83e66f4471ddd7ccdebb05c13), *pbio* has suddenly become immensely more useful: you can now map Python code supplied at the command line over your records, producing new calculated fields. This is a big step towards [MapReduce](http://en.wikipedia.org/wiki/MapReduce)-style programming, but without the overhead of having to write a separate program each time which defines a distinct *map* function. As programmers, we should always be looking for ways to write less code and still get the job done.

In the *pbio* case, there is **zero** overhead code required to calculate and output a new field, a surprising and mostly accidental consequence of [lwpb's](https://github.com/acg/lwpb) decision to encode and decode using dictionaries, together with a serendipitous feature of Python's `exec()` built-in. More on that in a second.

To frame all of this with an example, suppose you have the following simple *schema.proto* file for a document database.

    package org;

    message Document {
      required uint64 docid = 1;
      required string url = 2;
      required string content = 3;
    };

Perhaps this database is populated by a web crawler. You'd like to know the length, in bytes, of each document.

Sure, you could dump the entire content of each document with *pbio* and pipe that to a script that calculates lengths, but that's a bit wasteful. And you're also going to have to grok the percent-escaped sequences that *pbio* uses.

Here's a better way:

{% highlight bash %}
pbio.py -F 'url,length' -e 'length=len(content)' -p schema.pb -m org.Document < docs.pb
{% endhighlight %}

Let's break down what's going on here:

* *pbio* is inputting protobuf records, and outputting text records (the default mode)
* `-F 'url,length'` tells *pbio* to output text records with these two fields
* `-p schema.pb` specifies a compiled version of *schema.proto* you've created with `protoc`
* `-m org.Document` says records in *docs.pb* conform to the *org.Document* message type
* `-e 'length=len(content)'` calculates a new field in the output record named *length*

The only interesting option here is `-e`. How does *pbio* know to populate a new field in the output record named *length* with the calculated value? Does it parse the code, looking for assignments that match up with fields specified by `-F`? And how has a field of the input record, `content`, become available as a local variable?

<span id="python-exec"></span>
This is where Python's [exec()](http://docs.python.org/reference/simple_stmts.html#grammar-token-exec_stmt) comes in:

> `exec_stmt ::= "exec" or_expr ["in" expression ["," expression]]`

> In all cases, if the optional parts are omitted, the code is executed in the current scope. If only the first expression after *in* is specified, it should be a dictionary, which will be used for both the global and the local variables... As a side effect, an implementation may insert additional keys into the dictionaries given besides those corresponding to variable names set by the executed code.

The input record, which has been decoded by *lwpb* into a dictionary, becomes the scope in which the user-supplied code executes. Each input field becomes a local variable in the new scope. After execution, any new local variables created by assignments become new fields in the output record.

<span id="wc-pbio-example"></span>
More complicated code is possible. For instance, here's `wc(1)`:

{% highlight bash %}
pbio.py -F 'lines,words,chars,url' -p schema.pb -m org.Document < docs.pb -e '
chars=len(content)
words=len(content.split())
lines=len(content.split("\n"))'
{% endhighlight %}

<span id="top10-pbio-example"></span>
To wrap up the original example, let's find the top 10 longest documents:

{% highlight bash %}
pbio.py -F 'url,length' -e 'length=len(content)' -p schema.pb -m org.Document < docs.pb | sort -k2 -nr | head -10
{% endhighlight %}

