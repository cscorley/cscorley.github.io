---
layout: post
title: "Using Gensim for LDA"
tags:
    - python
    - topic modeling
    - gensim
    - lda
---
This is a short tutorial on how to use Gensim for LDA topic modeling.
What is topic modeling? It is basically taking a number of documents (new
articles, wikipedia articles, books, &c) and sorting them out into different
topics. For example, documents on Babe Ruth and baseball should end up in the
same topic, while [Dennis Rodman][] and basketball should end up in another.

LDA is an extension of LSI/pLSI using some crazy statistical stuff.
Most of that will not matter to us since we aren't implementing LDA.
One important thing to consider about LDA, however, is that it is a
[mixture model][], which is statistical mumbojumbo for "documents can be
associated with more than one topic." That is, and article about Dennis Rodman
could be related to multiple topics: basketball, tattoos, and crazy hair colors.

Right now, Gensim is in the process of being ported to Python 3.
This tutorial is written for Gensim 0.9.1.
I'll assume that you've got Gensim installed and working on Python 2 already.

[mixture model]: https://en.wikipedia.org/wiki/Mixture_model
[Dennis Rodman]: https://en.wikipedia.org/wiki/Dennis_Rodman


Let's start, go ahead and import gensim:

<div class="in_prompt">in [1]:</div>

{% highlight python %}
from __future__ import print_function
import gensim
{% endhighlight %}

In LDA, we infer a certain number of topics from a given corpus.
I prefer the Mallet format for corpora,
namely because each document has an associated document name or id.
Other formats require you to maintain this separately with a key file,
but that's just dumb.

I've got handy a corpus of every title (already preprocessed) of the Android
issue report database.
You can download that [here](/x/android_titles.tar.gz).

Here are the first three lines (aka the first three documents (aka the first
three issue report titles))
of the corpus file:

<div class="in_prompt">in [2]:</div>

{% highlight python %}
!head -3 android.mallet
{% endhighlight %}

<div class="output_prompt">out [2]:</div>

    1 en incorrect url address project
    2 en good luck
    3 en http proxy support


Luckily, Gensim supports reading this format directly!
So, let's load up our corpus into something Gensim can use internally:

<div class="in_prompt">in [3]:</div>

{% highlight python %}
corpus = gensim.corpora.MalletCorpus('android.mallet')
{% endhighlight %}

This might take awhile, because it is building some metadata about the corpus
itself.

Typically, you would use the corpus in a loop like so:

``` python
for document in corpus:
    blah(document)
```

But, just for our purposes, let's look at the first document it's holding:

<div class="in_prompt">in [4]:</div>

{% highlight python %}
next(iter(corpus))
{% endhighlight %}

<div class="output_prompt">out [4]:</div>




    [(6936, 1), (15314, 1), (300, 1), (10981, 1)]



Um, what? That doesn't look anything like the first document from before.
That's because this is the internal representation Gensim (and all of its
modeling algorithms) uses.
This is a document, but instead of a list of words, it is a list of tuples where
each tuple is
a *word id* and frequency pair.

So we can see word #6936 appears 1 time in the first document.
But what is word #6936?
Again, let's do that crazy `next(iter(` business so we don't end up going over
every document in the corpus.
Check this out:

<div class="in_prompt">in [5]:</div>

{% highlight python %}
for word_id, freq in next(iter(corpus)):
    print(corpus.id2word[word_id], freq)
{% endhighlight %}

<div class="output_prompt">out [5]:</div>

    incorrect 1
    url 1
    address 1
    project 1


<div class="in_prompt">in [6]:</div>

{% highlight python %}
!head -1 android.mallet
{% endhighlight %}

<div class="output_prompt">out [6]:</div>

    1 en incorrect url address project


Badass, yeah?

<br /><br />

Okay, not really, that's not very interesting.
I did something a little different here, and that's using the `corpus.id2word`
attribute.
It's simply a Python dictionary that maps `id->word` for all words in the
corpus.

Alright, let's actually generate a model (go ahead and get a sandwich, it'll be
a minute):

<div class="in_prompt">in [7]:</div>

{% highlight python %}
model = gensim.models.LdaModel(corpus, id2word=corpus.id2word, alpha='auto', num_topics=25) 
model.save('android.lda')
#model = gensim.models.LdaModel.load('android.lda')
{% endhighlight %}

We can save/load the model for later use
instead of having to rebuild it every time, as shown in the comment.
As much as I enjoy sandwiches, I don't want to do this all the time.

There are a couple of parameters other than the corpurs that I've set there.
Let's talk about those for a sec:

1. **id2word**: Although you can build a model from just a corpus, I've gone
ahead and let the LdaModel know about the `corpus.id2word`.
It just makes some of the things I'll show you next nicer.
2. **alpha**: This particular LDA implementation uses something that can
automatically update the `alpha` value for us.
This determines how 'smooth' the model is, which makes no damned sense if you
aren't working in the area (it doesn't make much sense to me).
Here's what alpha does: as it gets smaller, each document is going to be *more
specific*, i.e., likely to only made up of a few topics. As it gets
bigger, a document can begin to appear in multiple topics, which is what we want.
It's not good to have a large alpha either, because then all our topics will
start intermingling and making out and that's gross.
I have no idea how the `'auto'` setting really works, but it seems pretty legit
to me so I'll just use that for now.
3. **num_topics**:
The `num_topics` parameter just determines how many topics we want the model to
give us.
I've used 25 here since we are only looking at a corpus of titles.

Let's look at a few random topics:

<div class="in_prompt">in [8]:</div>

{% highlight python %}
model.show_topics(topics=5, topn=5)
{% endhighlight %}

<div class="output_prompt">out [8]:</div>




    ['0.047*link + 0.027*ui + 0.018*main + 0.017*level + 0.016*locale',
     '0.107*tap + 0.047*popup + 0.045*appears + 0.031*request + 0.029*tab',
     '0.120*play + 0.096*ics + 0.084*music + 0.049*bug + 0.030*android',
     '0.106*device + 0.078*google + 0.060*talk + 0.057*voice + 0.044*icon',
     '0.191*screen + 0.055*button + 0.034*change + 0.032*page + 0.032*lock']



These are the top 5 words associated with 5 random topics.
The decimal number is the *weight* of the word it is multiplying,
i.e., how much does this word influence the particular topic.
The model knows how to do this because we gave it the `id2word` dictionary.
Without it, we wouldn't be able to read this output (still).

Now, let's do something actually useful: query the model.

Let's say we would like to know which topics a certain string is most associated
with.

<div class="in_prompt">in [9]:</div>

{% highlight python %}
query = 'google maps broken navigation'
query = query.split()
query
{% endhighlight %}

<div class="output_prompt">out [9]:</div>




    ['google', 'maps', 'broken', 'navigation']



We query the model by indexing it with our query!
But first, we need to transform it into a representation the model understands.
We can't just do this (yet):

```python
model[query]
```
That will definitely cause us some heartache, because the query is just words.
LDA technically knows nothing about the actual words, just the ids we've given
them.

So, let's build something to translate those words back to ids and their
frequencies.
Gensim has an awesome built in way of doing this called a Dictionary.
Sure, we *could* use regular old Python `dict`s to map `id->word` and build the
`(word, frequency)` pairs ourselves,
but I'm a fancy person that enjoys fancy things.

Here's what we do:

<div class="in_prompt">in [10]:</div>

{% highlight python %}
id2word = gensim.corpora.Dictionary()
_ = id2word.merge_with(corpus.id2word)
{% endhighlight %}

This creates an empty special Dictionary, and then we merge our original corpus
dictionary into it. Whatever merge_with returns isn't important to us, so throw
it in the Python garbage bin, underscore.

This doesn't seem to gain us much, until we want to translate an entire document
into `(word, frequency)` pairs:

<div class="in_prompt">in [11]:</div>

{% highlight python %}
query = id2word.doc2bow(query)
query
{% endhighlight %}

<div class="output_prompt">out [11]:</div>




    [(1754, 1), (6081, 1), (8441, 1), (9208, 1)]



<div class="in_prompt">in [12]:</div>

{% highlight python %}
model[query]
{% endhighlight %}

<div class="output_prompt">out [12]:</div>




    [(3, 0.20387470260323143),
     (9, 0.35862973787398261),
     (15, 0.010585652382570768),
     (16, 0.010899567346349904),
     (18, 0.011132829837161632),
     (21, 0.22968681811101002),
     (22, 0.010344492016793241),
     (23, 0.010589823218917306),
     (24, 0.010154742173706556)]



*Note: your results absolutely should differ from mine _slightly_, given
the probablistic nature of the model*

Awwwwww yeahhhhhhhhhhh.
Now we're *cookin' with gas*.

From this list, we have each topic and the likelihood that the `query` relates
to that topic.
So, if we sort this a little more meaningfully:

<div class="in_prompt">in [13]:</div>

{% highlight python %}
a = list(sorted(model[query], key=lambda x: x[1]))
print(a[0])
print(a[-1])
{% endhighlight %}

<div class="output_prompt">out [13]:</div>

    (24, 0.010154742173743013)
    (9, 0.35859622416422271)


We can see that the least and the most related topic to our document.
Let's check out what words are most associated with those two topics.

<div class="in_prompt">in [14]:</div>

{% highlight python %}
model.print_topic(a[0][0]) #least related
{% endhighlight %}

<div class="output_prompt">out [14]:</div>




    '0.063*apps + 0.062*wifi + 0.058*calendar + 0.044*exchange + 0.035*changing + 0.030*location + 0.027*latitude + 0.024*automatically + 0.021*event + 0.020*disappears'



<div class="in_prompt">in [15]:</div>

{% highlight python %}
model.print_topic(a[-1][0]) #most related
{% endhighlight %}

<div class="output_prompt">out [15]:</div>




    '0.155*maps + 0.086*issue + 0.054*google + 0.034*android + 0.031*unlock + 0.024*books + 0.020*coming + 0.016*failed + 0.015*note + 0.013*word'



So, the first one looks like garbage for our query, but the second seems to be
mostly about the Google specific applications, including maps! Not the best
results, so this model's number of topics probably needs to be a bit higher, or
`alpha` values played with until results pan out.

Note how our initial query only returned nine or so related topics. Didn't we
ask for 25 of them? Well, we did, but Gensim defaults to only showing the top
ones that meet a certain threshold (`>= 0.01`). Digging deeper than that is
ugly, so for now we will just deal with these results.

I am getting pretty tired of looking at this, so I think this will conclude the
tutorial on using Gensim's LDA stuff for now. Go ahead and try out this code for
yourself.


This notebook on "Using Gensim for LDA" is available for download
[here](/notebooks/Using Gensim for LDA.ipynb).
