---
layout: post
title: Measuring the Measurers
root: ../../..
---

"Projects A and B are your top priority now. Oh, and Project C can't be impacted."

Sound familiar?

It's a common complaint of the project-managed: everything can't be top priority. Something has to give. Resources allocated to Project A must be deallocated from elsewhere, either Project C, or some other project. Declaring everything "top priority" is not helpful.

If project management accomplishes one thing, it should help each of us answer the question, "What should I work on next?"

A friend of mine relates a story about a meeting between tech and client services. The tech team came prepared with a list of development tasks in loose priority order. As the meeting progressed, the client services team found more and more reasons to disagree with the priorities.

Eventually, in frustration, the tech lead said, "Here's the list. You order it."

The client services lead was taken aback and refused: "It all has to be done. As soon as possible."

Not helpful.

While I do think there are better ways of scheduling work than imposing a single ordering -- which breaks down when multiple workers are able to proceed in parallel -- I also think the ability to see and maintain consistent priorities is an important thing to look for in a project manager. Or any manager, really.

Which is why I propose the following fun experiment. Present a manager with two randomly sampled work items from their team, side by side, and ask which is higher priority. Repeat until you've got a decent number of comparisons. Remember xkcd's [project to find the funniest image in the world](http://thefunniest.info/)? Yeah. It's kinda like that.

Now that we've turned a human being into a comparison operator ;) we can ask how good that operator is. Does it define an ordering? For any reasonable sample size, probably not.

Forget about [stable sort](http://en.wikipedia.org/wiki/Sorting_algorithm#Stability). Viewed as a [directed graph](http://en.wikipedia.org/wiki/Directed_graph), there will probably be cycles, like A &gt; B &gt; C &gt; A. In general, you can induce an acyclic digraph from a cyclic digraph by identifying the [strongly connected components](http://en.wikipedia.org/wiki/Strongly_connected_component). So one metric would be to compare the size of the induced acyclic graph to the original graph (`1/|V|` is the worst, `|V|/|V|=1.0` is the best). Another metric would be the height of the induced acyclic graph over the number of nodes (work items). A perfect comparison operator would produce a line of nodes in a well-defined order, and would score 1.0.

Another thing to measure would be the consistency of the ordering over time. Yes, priorities change, but resource re-allocation also has a cost.

Measuring the measurers seems like a good thing for a number of reasons. Among them, that it exposes the often subtle problems of *conflicting directives* and the even subtler problems of *competing directives*. Too often, only the people carrying out the directives are aware of them.

