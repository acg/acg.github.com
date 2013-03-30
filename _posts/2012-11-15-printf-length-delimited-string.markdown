---
layout: post
title: How to printf a length-delimited string
root: ../../..
---

You often see code like this:

    TODO insert example of copying length-delimited string to null-delimited string just for a printf

The extra copying isn't necessary, since printf(3) can format length-delimited strings too.

I always end up looking this one up in the printf(3) man page.

     The precision

     An optional precision, in the form of a period ('.') followed by an optional decimal digit string. Instead of a decimal digit string one may write "*" or "*m$" (for some decimal integer m) to specify that the precision is given in the next argument, or in the m-th argument, respectively, which must be of type int. This gives ... the maximum number of characters to be printed from a string for s and S conversions.

