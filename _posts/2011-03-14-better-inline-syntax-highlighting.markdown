---
layout: post
title: "Coding for the Web: A Proposal for Better Inline Syntax Highlighting"
root: ../../..
---

[Markdown](http://daringfireball.net/projects/markdown/syntax) is great for semi-structured text. [Pygments](http://pygments.org/) is great for syntax highlighting. This blog uses both: [jekyll](https://github.com/mojombo/jekyll) passes code snippets surrounded by \{`% highlight languageX %`\} and \{`% endhighlight %`\} to pygments, and processes the rest with markdown.

So is there anything to complain about here? As usual, the answer is yes.

* The \{`% highlight languageX %`\} syntax isn't supported by github's default markdown renderer, so if I use it in the README.md file for a project, it will appear literally around the un-highlighted output. This may well confuse the hell out of someone trying to copy and paste some code or shell commands. If the github guys don't want to pay the penalty for parsing and syntax highlighting in markdown everywhere, I completely understand. But then let's try find a relatively inert way of specifying the language of a code snippet.
* The \{`% highlight languageX %`\} syntax is also jekyll/liquid-specific. I don't see support for this elsewhere. I do see people rolling their own syntax [like this one](http://zerokspot.com/weblog/2008/06/18/syntax-highlighting-in-markdown-with-pygments/), which was later incorporated into the python markdown package, and looks for code snippets surrounded by `[sourcecode:languageX]` `[/sourcecode]`. It's similarly deficient in that code snippets must be surrounded by special beginning and ending tokens that will be confusing if emitted literally.
* The \{`% highlight languageX %`\} syntax doesn't actually play nice with markdown code blocks: you can't indent the code snippet with 4 spaces and wrap it with \{`% highlight languageX %`\} \{`% endhighlight %`\}. You must use no indentation for the snippet. This means a markdown processor that doesn't understand the syntax won't even know to emit an html code element; you'll get plain, wrapped text, probably not in a monospace font. Not good. These unindented code snippets also look like shit with [markdown.vim](http://www.vim.org/scripts/script.php?script_id=2882).

To summarize, a better solution:

* Should be "inert", ie not confusing or ugly if output literally as part of the snippet.
* Should gracefully degrade when a markdown processor doesn't implement special syntax highlighting.
* Doesn't need both beginning and ending tags. Just scope the syntax highlighting to the current code block.

On to the proposal, which is really nothing fancy or new:

* put a shebang line at the beginning of the code block

In a sense, this is a **solved problem**.

My [editor](http://www.vim.org) already does syntax highlighting based on the shebang line, and chances are, so does yours. In many cases it also makes the code snippet more complete: if you're going to copy and paste it into a new script, you're going to add the shebang line anyway. But you could also choose to suppress the shebang line when rendering.

Here's an example from my [python-percentcoding](https://github.com/acg/python-percentcoding) project:

{% highlight python %}
#!/usr/bin/env python
from percentcoding import quote, unquote
str = "This is a test!"
escaped = quote(str)
print escaped
assert(str == unquote(escaped))
{% endhighlight %}

I've already implemented the proposal in Python [here](https://github.com/acg/python-percentcoding/blob/master/hilite_markdown.py). Would need to be ported over to Ruby for use in jekyll / liquid.

