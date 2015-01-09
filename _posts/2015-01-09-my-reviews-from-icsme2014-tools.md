---
layout: post
title:  "My reviews from ICMSE2014 Tool track"
tags:
    - reviews
    - icsme
    - open science
---

This past year, I had the privilege to serve on the
[ICSME2014](http://www.icsme.org/) Tool demo track.

Of the four papers I helped review, two were accepted. Here are those reviews.

## Paper 1

*[Context-sensitive Code Completion Tool for Better API Usability][doi1]*

By Muhammad Asaduzzaman, Chanchal K. Roy, Kevin Schneider and Daqing Hou.

- Overall: 3 (strong accept)
- Confidence: 3 (medium)

This paper presents a tool for code completion. In particular, it builds
a model of common patterns of API usage and uses the context of the code
currently being written to find a similar pattern for suggestions.
Benefits of this model is that the autocompletion is quick and
can recommend without needing to know what the developer is looking for
(e.g., any method starting with a typed letter).

Suggestions for improvement:

- References 10-13 would be better off as footnote URLs.
- There is a bad citation at the top of the second column of the first page.

Overall, this paper is clean and straightforward. I like the context
usage of the current code being written. While the demo video was
geared toward code being written for the first time, I wonder how it
performs in a maintenance context.

[doi1]: http://dx.doi.org/10.1109/ICSME.2014.110

## Paper 2

*[Reviewer Recommender of Pull-Request in GitHub][doi2]*

By Yue Yu, Huaimin Wang, Gang Yin and Charles Ling. 


- Overall: -1 (weak reject)
- Confidence: 4 (high)

This paper presents a tool for automatically recommending code reviewers
to pull requests (PR) on Github. A reviewer is considered as anyone that
has commented on a PR in the past. Using past PRs, they combine the
semantic similarity of the text of the new PR and the social network of
developers of previous PRs. The semantic similarity is a simple VSM.
The social network is built by extracting developer mentions in the
comments. They report on a study of several popular Github projects,
reaching 0.74 precision and 0.71 recall for top-1 and top-10
recommendation, respectively.


Problems:

- In the approach, what stemmer is used?

- What are the list of stopwords?

- It is unclear if developers commenting on their own PR are included.
Several projects use Github PRs as a code review tool, and
a conversation occurs between contributors, including the PR
requester. Including or excluding the original requester based on
their developer status at the time may affect the results.

- It is unclear exactly how the recommendation from the vector space
model is combined with the social network. Is more weight put in to
the semantic similarity or the network? Subsection 3-D, reviewer
recommendation, needs elaboration. It is a key factor to how the
approach works.

- I could not find a way to download and use the tool on the given
website. How do I run this on my own projects? The website presented
seems mostly like a browser for output of the actual tool.

- The demo video seems more of a presentation than a demo. Perhaps this
is due to my previous bullet point.

Overall, I think the approach is interesting. But I don't see how I can
apply this tool on other projects.

[doi2]: http://dx.doi.org/10.1109/ICSME.2014.107
