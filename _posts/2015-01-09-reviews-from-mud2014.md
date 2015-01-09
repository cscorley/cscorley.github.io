---
layout: post
title:  "Reviews from MUD2014"
tags:
    - reviews
    - mining software repositories
    - mining unstructured data
    - open science
    - lda
    - topic models
---

To keep up with practicing some [open
science](http://en.wikipedia.org/wiki/Open_Science), here are the reviews to
the MUD'2014 paper I "recently" published.

You can find a link to the PDF, code, slides, and talk in my
[publications](/publications).

## Review #1

This paper describes an evaluation of the inputs to LDA topic models.  Topic models are a very valuable tool in software engineering research, and too often they are used without much configuration.  This paper presents a study of an aspect of this configuration, to help other researchers: whether change sets or "snapshots" produce more-distinct topics and use the same vocabulary.

The authors found mixed results, in that the changesets did seem to result in more-distinct topics for 2 systems, but in the another 2 systems, there were not noticeable differences.  Likewise, the vocabulary used in the changesets was measurably different than the snapshots.

While the scale of the study is small, and the results somewhat mixed, the paper does have the capacity to cause good discussion at the workshop, given the importance of topic models in SE.  For example, researchers using SE can take guidance from this paper that it may be necessary to try both changesets and snapshots.

The chief improvement to this paper would be to increase the number of programs that are studied.  With more systems, it might be possible for the paper to make a recommendation more-strongly for one or the other dataset.


## Review #2

Summary:
The paper investigates whether topics extracted from chagesets are different from topics extracted from snapshots. The study has been performed on four systems and the authors exploited LDA to extract topics. Results are somehow in contrast between the four object systems.

Evaluation:
The paper is well written and easy to follow. The posed research questions make sense, and the paper's topic is for sure of interest for the MUD audience. However, I am not sure what I can learn from such a paper. 

I mean, I cannot understand how the findings reported in the paper can be used in any SE application or can impact the way of conducting SE Empirical studies. The authors should spend some words (during the results discussion and the conclusions) to explain why their findings are of interest for the research community. For instance, what should I learn from the fact that the cosine distance between the two corpus (i.e., changeset and release) is very small for three out of the four systems? Has PostgreSQL something special? The authors could remove Figure 3 (not useful at all) and use the saved space to better present and discuss the implications behind their findings.


## Review #3
Desc.:

Most bug localization, feature location, and link traceability studies extract topics from one snapshot of a software repository. Rather than extracting topics from one snapshot of a software repository, another alternative is to extract topics from the differences (lines added and lines added) between two consecutive revisions in a repository. The paper extracts topics this way and evaluate the quality of the resultant topics by using the concept of topic distinctness. To extract changeset topics several steps are performed: first, git diff is used to get the changeset; second, tokens are extracted and split based on camel case, underscores, and non-letters; third, stop words are removed; finally, the documents are input to an LDA implementation (Gensim's LDA). An experiment on changeset corpora from 4 systems, ant, AspectJ, Joda-Time, and PostgreSQL have been performed. The experiment show that for two of the systems, the words that appear in a changeset corpus are similar!
  to words that appear in a corpus extracted from one snapshot of a software repository (release corpora). Furthermore, for two out of the four systems, the topics that are extracted from changeset corpus have higher topic distinctness scores than topics that are extracted from release corpus.

Pros:

+ The paper analyzes 4 software systems and compares the topics extracted from changeset corpus and release corpus using topic distinctness.
+ Experiment shows that at least for some software systems word distribution in a changeset corpus are rather different than word distribution in a release corpus (cosine distance of 0.3 or higher).
+ Experiment shows that in two software systems the topic distinctness score of topics extracted from a changeset corpus is higher than the topic distinctness score of topics extracted from a release corpus.

Comments for Improvement:

+ It seems Thomas et al. have also modelled changeset topics before (Reference [3]). It is not clear what are the differences between Thomas et al.'s approach and the proposed approach. The paper states: "we find similar topic distinctness scores" and "our approach is feasible, as it captures distinct topics while not needing post-processing and is always up-to-date with the source code repository". What kind of post-processing was performed by Thomas et al.'s approach that is not performed by the proposed approach? Is it bad to perform post-processing? Can't Thomas et al.'s approach generate topics that are up-to-date with a source code repository? Please elaborate more. If the technical difference between the paper and Thomas et al.'s approach is small it is better to reposition the paper as a replication study. It seems the paper investigates more systems and the findings provide additional insights not provided by Thomas et al.'s paper.

+ It will be good to add some additional details to the paper to answer the following questions:

- (Section IIID) Is the higher a topic distinctness score, the better a set of extracted topics is? Please elaborate more.
- (Section IIIE) After the encoding errors are removed, is the words that appear in a release corpus always the same as the words that appear in a changeset corpus? Why does the encoding error only affect either one of the corpus but not both of them?
- (Section IIIE) Please explain more how cosine distance is computed. Cosine similarity is well known, but cosine distance is not so well known.
- (Section IIIE) Please provide more insight on the cosine distance scores. Is a cosine distance of 0.00396 good or bad? Why some systems have much higher cosine distance score than others (e.g., 0.33957 vs. 0.00396)?
- (Section IIIE) "Ant and PostgreSQL have drastically more documents in their respective change set corpora than Joda-Time and AspectJ" It is good to also mention how many documents are in the change set corpus of each of the four systems.

+ There are many other studies that use topic modelling for software maintenance; it will be good to add them to the related work section especially those that use topic model for bug localization, feature location, or traceability link recovery which is the motivation of the work (as stated in the abstract), e.g.,:

- Stacy K. Lukins, Nicholas A. Kraft, Letha H. Etzkorn: Bug localization using latent Dirichlet allocation. Information & Software Technology 52(9): 972-990 (2010)
- Anh Tuan Nguyen, Tung Thanh Nguyen, Tien N. Nguyen, David Lo, Chengnian Sun: Duplicate bug report detection with a combination of information retrieval and topic modeling. ASE 2012: 70-79
- Tien-Duy B. Le, Shaowei Wang, David Lo: Multi-abstraction Concern Localization. ICSM 2013: 364-367

