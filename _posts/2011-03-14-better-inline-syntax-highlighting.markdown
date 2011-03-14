---
layout: post
title: "Coding for the Web: A Proposal for Better Inline Syntax Highlighting"
root: ../../..
---

[Markdown](http://daringfireball.net/projects/markdown/syntax) is great for semi-structured text. [Pygments](http://pygments.org/) is great for syntax highlighting. This blog uses both: [jekyll](https://github.com/mojombo/jekyll)+[liquid](http://www.liquidmarkup.org/) passes code snippets surrounded by \{`% highlight languageX %`\} and \{`% endhighlight %`\} to pygments. The rest gets processed with markdown.

So is there anything to complain about here? As usual, the answer is yes.

* The \{`% highlight languageX %`\} syntax isn't supported by github's default markdown renderer. So if I use it in the README.md file for a project, it will appear literally around the un-highlighted output. This may well confuse the hell out of someone trying to copy and paste some code or shell commands. If the github guys don't want to pay the penalty for parsing and syntax highlighting in markdown everywhere, I completely understand. But then let's try find a relatively inert way of specifying the language of a code snippet.
* The \{`% highlight languageX %`\} syntax is also jekyll+liquid-specific. I don't see support for this elsewhere. I do see people rolling their own syntax [like this one](http://zerokspot.com/weblog/2008/06/18/syntax-highlighting-in-markdown-with-pygments/), which was later incorporated into the python markdown package, and looks for code snippets surrounded by `[sourcecode:languageX]` `[/sourcecode]`. It's similarly deficient in that code snippets must be surrounded by special beginning and ending tokens that will be confusing if emitted literally.
* The \{`% highlight languageX %`\} syntax doesn't actually play nice with markdown code blocks: you can't indent the code snippet with 4 spaces and wrap it with \{`% highlight languageX %`\} \{`% endhighlight %`\}. You must use no indentation for the snippet. This means a markdown processor that doesn't understand the syntax won't even know to emit an html code element; you'll get plain, wrapped text, probably not in a monospace font. Not good. These unindented code snippets also look like shit  [markdown.vim](http://www.vim.org/scripts/script.php?script_id=2882).

To summarize, a better solution:

* Should be "inert", ie not confusing or ugly if output literally as part of the snippet.
* Should gracefully degrade when a markdown processor doesn't implement special syntax highlighting.
* Doesn't need both beginning and ending tags. Just scope the syntax highlighting to the current code block.

On to the specific proposal, which is really nothing fancy or new:

* Put a shebang line at the beginning of the code block.

In a sense, this is a **solved problem**.

My [editor](http://www.vim.org) already does syntax highlighting based on the shebang line, and chances are, so does yours. In many cases it also makes the code snippet more complete: if you're going to copy and paste it into a new script, you're going to add the shebang line anyway. But you could also choose to suppress the shebang line when rendering.

Another solution might be to use a [modeline](http://everything2.com/title/modeline). In either case, you're embedding information in a language-specific comment, and doing so in a way that already has precedent.

Here's an example code snippet from the documentation for [python-percentcoding](https://github.com/acg/python-percentcoding):

{% highlight python %}
#!/usr/bin/env python
from percentcoding import quote, unquote
str = "This is a test!"
escaped = quote(str)
print escaped
assert(str == unquote(escaped))
{% endhighlight %}

I've already implemented the proposal in Python [here](https://github.com/acg/python-percentcoding/blob/master/hilite_markdown.py), in order to generate html documentation for pypi. It would need to be ported over to Ruby for use in jekyll+liquid.

