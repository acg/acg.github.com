---
layout: post
title: How Many Consonant Pairs Do We Actually Use?
root: ../../..
---

Of all possible pairs of consonants you could start a word with, how many are actually valid in the English language?

The question came up at a party during a disappointing Ouija board session where the spirits conjured gibberish like "QHPEV." Someone wondered aloud how difficult it was to pick a valid pairs of consonants at random. Instinctively, we felt that most of them were invalid.

This is a nice little problem for the unix text processing toolset. I used the [2006 Scrabble Tournament Word List](http://www.isc.ro/lists/twl06.zip) because /usr/share/dict/words contains many proper names and non-words. To get the count:

    tr '[A-Z]' '[a-z]' < TWL06.txt |
    sed -nEe 's/^([a-z]{2}).*$/\1/p' | 
    grep -v '[aeiouy]' |
    sort -u | 
    wc -l

    82

There are 20 consonants in the language after removing "aeiouy", so that makes 400 possible pairs of consonants.

So only 20.5% of all consonant pairs are valid beginnings for an English word.

To see the 82 valid pairs:

    tr '[A-Z]' '[a-z]' < TWL06.txt |
    sed -nEe 's/^([a-z]{2}).*$/\1/p' | 
    grep -v '[aeiouy]' |
    sort -u |
    tr '\n' ' '

    bd bh bl br bw ch cl cn cr ct cw cz
    dh dj dr dw fj fl fr gh gj gl gn gr
    gw hm hr hw jn kb kh kl kn kr kv kw
    ll lw mb mh mm mn mr ng nt pf ph pl
    pn pr ps pt qw rh sc sf sg sh sj sk
    sl sm sn sp sq sr st sv sw tc th tm
    tr ts tw tz vr wh wr zl zw zz

To see an example word for each valid pair (remember, this is the Scrabble dictionary, so there's some pretty weird stuff in there):

    tr '[A-Z]' '[a-z]' < TWL06.txt |
    tr -d '\r' |
    sed -nEe 's/^([a-z]{2})(.*)$/\1\2 \1/p' |
    grep ' [^aeiouy][^aeiouy]' |
    sort |
    uniq -f1 |
    awk '{ print $2, $1 }'

    bd bdellium
    bh bhakta
    bl blabbed
    br brabble
    bw bwana
    ch chabazite
    cl clabber
    cn cnida
    cr craal
    ct ctenidia
    cw cwm
    cz czar
    dh dhak
    dj djebel
    dr drabbed
    dw dwarf
    fj fjeld
    fl flabbergasted
    fr frabjous
    gh gharial
    gj gjetost
    gl glabellae
    gn gnar
    gr graal
    gw gweduc
    hm hm
    hr hryvna
    hw hwan
    jn jnana
    kb kbar
    kh khaddar
    kl klatches
    kn knacked
    kr kraaled
    kv kvases
    kw kwacha
    ll llama
    lw lwei
    mb mbaqanga
    mh mho
    mm mm
    mn mnemonically
    mr mridangam
    ng ngultrum
    nt nth
    pf pfennige
    ph phaeton
    pl placabilities
    pn pneuma
    pr praam
    ps psalmbook
    pt ptarmigan
    qw qwerty
    rh rhabdocoele
    sc scabbarded
    sf sferics
    sg sgraffiti
    sh shabbatot
    sj sjamboked
    sk skag
    sl slabbed
    sm smacked
    sn snacked
    sp spaceband
    sq squabbier
    sr sraddha
    st stabbed
    sv svarajes
    sw swabbed
    tc tchotchkes
    th thacked
    tm tmeses
    tr trabeated
    ts tsaddikim
    tw twaddled
    tz tzaddikim
    vr vroomed
    wh whacked
    wr wracked
    zl zlote
    zw zwiebacks
    zz zzz

Aside: finding good and freely available (ie opensource or creative commons) word lists is surprisingly annoying.

