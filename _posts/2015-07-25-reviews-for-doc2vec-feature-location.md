---
layout: post
title:  "Reviews for \"Exploring the Use of Deep Learning for Feature Location\""
tags:
    - reviews
    - feature location
    - open science
    - doc2vec
    - word2vec
    - lda
    - topic models
---

I've been blessed with a second publication at [ICSME'15][]!  This one is an
Early Research Achievements (ERA) track paper on using Gensim's [Doc2Vec][] for
feature location.

Overall, I am very happy with the comments we received!  Below are the reviews.

Here is the [preprint](/publications/pdfs/Corley-etal_2015a.pdf). You'll find
more information about this paper on my [publications](/publications) page as I
add it.


[ICSME'15]: http://www.icsme.uni-bremen.de/
[Doc2Vec]: http://radimrehurek.com/gensim/models/doc2vec.html



# Review 1

Summary:

The goal of this work is to support feature location using deep learning approaches. The authors claim that deep learning provides the ability to incorporate the order of terms as opposed to traditional feature location techniques, which have treated source code as an unordered set of terms.The authors report improvements in performance (using mean reciprocal rank) using a particular deep learning model over a set of six software systems. Additionally the authors estimate the average time to rank per query and the model training time.

Strengths:

* +Emerging area in SE research
* +Using real systems

Weaknesses:

* -Conceptual gaps in the presentation
* -Study design

Comments:

Feature location is a critical maintenance task, and bringing deep learning models to bear is a new approach certainly worth examination. Please consider the following comments and questions to strengthen the paper.

"Therefore, when querying for diagram, program elements where redraw is also present are considered more relevant and thus are boosted in the rankings." Technically, LDA would consider the co-occurrence in this example too. (Yes, LDA would discard information on the order.) So what precisely will distinguish the approach based on deep learning models in this respect? Is it exclusively the order of terms? Would n-gram topic models be relevant here?

"We also suggest directions for future work on the use of DVs (or other deep learning models) to improve developer effectiveness in feature location." I recommend rewording this statement since the concern is not improving *developer* effectiveness per se. The concern is improving the effectiveness of feature location engines.

"A deep learning neural network encodes source code identifiers, in the order they appear in the source code." Technically, this statement is not correct. Imagine a software corpus with |I| source code identifiers. Consider a neural network with several hidden layers and an input layer with size |I|, where each unit in the input layer corresponds to an identifier. If we represent source code files as vectors of relative frequencies of identifiers and train the model to learn a compact representation of its input, then this deep learning neural network does not encode identifiers in the order they appear in the source code.

The semantic similarity example given in Sec. II.B should be ported to the SE domain for effect. Moreover, at the end of Sec. II, I still don’t have a good understanding of the model nor how the model is designed to address concerns inherent to feature location in a new or more efficient way.

Please consider adding research questions to Sec. III.

A general summary of tests supporting the statistical significance and effect of the results reported in Sec. III would rigorously support the authors’ claims on the performance gains.

Re: Tab. IV: Is model training time really a concern? LDA—the baseline model—appears to be on the order of one second (for 100 topics).

Why is the related work started by referring to n-grams, which do not appear to bear on the problem at hand? I would expect a reference to n-grams in the paper (aside from the second sentence of the abstract) if they are in fact related.

"statistical models of natural language text able to capture more complex patterns while being trained using smaller corpora relative to the n-gram model [3] [8]" It is not clear how these references substantiate the claim of using smaller corpora. I also don’t see the need to even emphasize smaller corpora.

Another related paper that should be discussed is on configuring LDA for SE tasks: Panichella, A., Dit, B., Oliveto, R., Di Penta, M., Poshyvanyk, D., and De Lucia, A., "How to Effectively Use Topic Models for Software Engineering Tasks? An Approach based on Genetic Algorithms", in Proceedings of 35th IEEE/ACM International Conference on Software Engineering (ICSE'13), San Francisco, CA, May 18-26, 2013, pp. 522-531

Minor points:

* "Deep learning models are a class of neural networks." I recommend rewording this statement. Fundamentally, deep learning models are characterized by multiple "levels" of nonlinear transformations. Neural networks are a convenient abstraction for deep learning, but I would shy away from explicitly subtyping deep learning models from neural networks even though neural networks dominate deep learning applications;

* "that has shown promising results in modeling natural language" needs citation(s);

* In the third paragraph of the Introduction, the last sentence needs a citation;

* "4Hz processor" should probably be 4GHz processor.

There are several grammatical and typographical issues in the current version. Should the paper be accepted, the authors should fix these issues to ensure the paper is in the best possible shape for the camera-ready version.



# Review 2

Summary

The paper describes an initial study of using a neural network machine learning approach for feature location.  They use document vectors (DV) and compare it to LDA.

Comments

Pretty straightforward paper without any big surprises or critical missing information.  They leveraged Dit et al work for the experiment and setup.

DV appears to be about the same accuracy as LDA but looks to be much faster in query time and training time.  So some trade offs.

DV is a technique not previously applied to this problem and could be another useful tool for addressing SE problems.

Overall I see these as pretty interesting results that would be a nice addition to the technical program.



# Review 3

In this paper, the authors investigate the use of a deep learning model, document vectors (DV), for feature location. The authors compare DV with LDA on 633 queries from 6 versions of 4 software systems.

The paper is clearly written and presents an intriguing new approach worthy of further investigation. Although DV has been applied to source code in the past by White, et al., this work is the first time it has been trained on specific software systems, rather than a larger corpus.

The authors cited a number of FLTs in the related work. This paper would be strengthened by comparing with other approaches. I was disappointed not to see a simple baseline such as tf-idf included. At minimum, the choice of LDA should be justified. Is it the current most accurate FLT out there? Is it the most similar to DV?

Key points:

* + results of study intriguing for future FLT investigation (important for community)
* + clearly written
* - stronger case if other FLTs included

Specific comments:

I applaud the author’s use of the standard IR measure of mean reciprocal rank (MRR) to evaluate their proposed FLT. However, the authors incorrectly attribute the definition of MRR to Poshyvanyk, et al. It would be more appropriate to say something like: "Similar to the study by Poshyvanyk, et al., we use MRR to compare…"
