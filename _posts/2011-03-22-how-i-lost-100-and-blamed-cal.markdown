---
layout: post
title: How I Lost $100 and Blamed It On cal(1)
root: ../../..
---

True story. Back in September 2008, I decided that this year, I would **not** wait until the last minute to book my Thanksgiving flight home.

What's the rule for Thanksgiving again? Oh right, fourth Thursday in November. So I busted out [cal(1)](http://www.freebsd.org/cgi/man.cgi?query=cal&apropos=0&sektion=0&manpath=FreeBSD+8.2-RELEASE&format=html):

    $ cal
       September 2008
    Su Mo Tu We Th Fr Sa
        1  2  3  4  5  6
     7  8  9 10 11 12 13
    14 15 16 17 18 19 20
    21 22 23 24 25 26 27
    28 29 30

Whoops, it only shows the current month. So I passed it the year:

    $ cal 08
                                   8

          January               February               March
    Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
     1  2  3  4  5  6  7            1  2  3  4               1  2  3
     8  9 10 11 12 13 14   5  6  7  8  9 10 11   4  5  6  7  8  9 10
    15 16 17 18 19 20 21  12 13 14 15 16 17 18  11 12 13 14 15 16 17
    22 23 24 25 26 27 28  19 20 21 22 23 24 25  18 19 20 21 22 23 24
    29 30 31              26 27 28 29           25 26 27 28 29 30 31

           April                  May                   June
    Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
     1  2  3  4  5  6  7         1  2  3  4  5                  1  2
     8  9 10 11 12 13 14   6  7  8  9 10 11 12   3  4  5  6  7  8  9
    15 16 17 18 19 20 21  13 14 15 16 17 18 19  10 11 12 13 14 15 16
    22 23 24 25 26 27 28  20 21 22 23 24 25 26  17 18 19 20 21 22 23
    29 30                 27 28 29 30 31        24 25 26 27 28 29 30

            July                 August              September
    Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
     1  2  3  4  5  6  7            1  2  3  4                     1
     8  9 10 11 12 13 14   5  6  7  8  9 10 11   2  3  4  5  6  7  8
    15 16 17 18 19 20 21  12 13 14 15 16 17 18   9 10 11 12 13 14 15
    22 23 24 25 26 27 28  19 20 21 22 23 24 25  16 17 18 19 20 21 22
    29 30 31              26 27 28 29 30 31     23 24 25 26 27 28 29
                                                30
          October               November              December
    Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
        1  2  3  4  5  6               1  2  3                     1
     7  8  9 10 11 12 13   4  5  6  7  8  9 10   2  3  4  5  6  7  8
    14 15 16 17 18 19 20  11 12 13 14 15 16 17   9 10 11 12 13 14 15
    21 22 23 24 25 26 27  18 19 20 21 22 23 24  16 17 18 19 20 21 22
    28 29 30 31           25 26 27 28 29 30     23 24 25 26 27 28 29
                                                30 31

I booked my flight for Tuesday, November 20th, and forgot about it.

The day approached. I called home just to make sure someone could pick me up from the airport. That's when I discovered that Thanksgiving was actually the following week. __I had booked my flight based on the calendar for the year 8 A.D.__

What I should have done was this:

    $ cal 2008
                                 2008

          January               February               March
    Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
           1  2  3  4  5                  1  2                     1
     6  7  8  9 10 11 12   3  4  5  6  7  8  9   2  3  4  5  6  7  8
    13 14 15 16 17 18 19  10 11 12 13 14 15 16   9 10 11 12 13 14 15
    20 21 22 23 24 25 26  17 18 19 20 21 22 23  16 17 18 19 20 21 22
    27 28 29 30 31        24 25 26 27 28 29     23 24 25 26 27 28 29
                                                30 31
           April                  May                   June
    Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
           1  2  3  4  5               1  2  3   1  2  3  4  5  6  7
     6  7  8  9 10 11 12   4  5  6  7  8  9 10   8  9 10 11 12 13 14
    13 14 15 16 17 18 19  11 12 13 14 15 16 17  15 16 17 18 19 20 21
    20 21 22 23 24 25 26  18 19 20 21 22 23 24  22 23 24 25 26 27 28
    27 28 29 30           25 26 27 28 29 30 31  29 30

            July                 August              September
    Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
           1  2  3  4  5                  1  2      1  2  3  4  5  6
     6  7  8  9 10 11 12   3  4  5  6  7  8  9   7  8  9 10 11 12 13
    13 14 15 16 17 18 19  10 11 12 13 14 15 16  14 15 16 17 18 19 20
    20 21 22 23 24 25 26  17 18 19 20 21 22 23  21 22 23 24 25 26 27
    27 28 29 30 31        24 25 26 27 28 29 30  28 29 30
                          31
          October               November              December
    Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
              1  2  3  4                     1      1  2  3  4  5  6
     5  6  7  8  9 10 11   2  3  4  5  6  7  8   7  8  9 10 11 12 13
    12 13 14 15 16 17 18   9 10 11 12 13 14 15  14 15 16 17 18 19 20
    19 20 21 22 23 24 25  16 17 18 19 20 21 22  21 22 23 24 25 26 27
    26 27 28 29 30 31     23 24 25 26 27 28 29  28 29 30 31
                          30

When all was said and done -- with the change fee and the fare difference -- the mistake cost me $100. But it "inspired" me to actually learn a thing or two about cal(1).

__TL;DR__: RTFM, or you will pay.

    CAL(1)
    ...
    A single parameter specifies the year (1 - 5875706) to be displayed; note the year must be fully specified: “cal 89” will not display a calendar
    for 1989.

