---
layout: post
title: "Turn Vim Into Excel: Tips for Editing Tabular Data"
root: ../../..
---

I tried to edit data in spreadsheet programs, I really did.

But it's a fact: Vim ruins you for life. Power corrupts.

Of course, Vim can edit tabular data too, but there are a few things that will make your life easier. For this discussion I'm assuming you're editing files in tab-separated value format (TSV).

"But what about CSV files?" [Just](http://en.wikipedia.org/wiki/Comma-separated_values#Lack_of_a_standard). [Don't](http://www.catb.org/esr/writings/taoup/html/ch05s02.html).

Do: convert your CSV to TSV and back for editing.

## Setting up Tabular Editing ##

Open the file:

    :e foo.tsv

Excel numbers the rows, why can't we?

    :set number

Adjust your tab settings so you're editing with hard tabs:

    :setlocal noexpandtab

Now, widen the columns enough so they're aligned:

    :setlocal shiftwidth=20
    :setlocal softtabstop=20
    :setlocal tabstop=20

Fiddle with that number 20 as needed. As far as I can tell, Vim doesn't support variable tab stops. It would be real nifty if I was wrong about this. It would be even niftier if column width detection / tabstop setting could be automated.

## Tall Spreadsheets: Always-Visible Column Names Above ##

Typically, the first line of the tsv file is a header containing the column names. We want those column names to always be visible, no matter how far down in the file we scroll. The way we'll do this is by splitting the current window in two. The top window will only be 1 line high and will show the headers. The bottom window will be for data editing.

    :sp
    CTRL-W k
    :0
    1 CTRL-W _
    CTRL-W j

At this point you should have two windows, one above the other showing the first row of column headers. If you don't have very many columns, then you're done.

## Wide Spreadsheets: Horizontal Scrolling ##

If you do have lots of columns, or very wide columns, you're probably noticing how confusing it looks when lines wrap. Your columns don't line up so well anymore. So turn off wrapping for both windows:

    :set nowrap
    CTRL-W k
    :set nowrap
    CTRL-W j

One problem remains: when you scroll right to edit columns in the data pane, the header pane doesn't scroll to the right with it. Once again, your columns aren't aligned.

Fortunately Vim has a solution: you can "bind" horizontal scrolling of the two windows. This forces them to scroll left and right in tandem.

    :set scrollopt=hor
    :set scrollbind
    CTRL-W k
    :set scrollbind
    CTRL-W j

## But What About Formulas and Calculations?! ##

It's true, Excel does far more than just edit tabular data. Vim is just ("just") an editor.

However, if you're using Vim, chances are you're a competent programmer. Chances are you can write programs to manipulate tabular data. So how about this arrangement:

1. A tsv that contains formulas, calculations, and other potentially interpreted data.
2. A program that will process that tsv and "render" a tsv with calculated data.
3. The ability to quickly switch between these tsvs.

I haven't put this to the test, just throwing out ideas.

