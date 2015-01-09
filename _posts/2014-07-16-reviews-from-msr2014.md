---
layout: post
title:  "Reviews from MSR2014"
tags:
    - reviews
    - mining software repositories
    - open science
    - lda
    - bugs
---

I've been reviewing some papers for the [ICSME 2014](http://icsme.org/)
tool demo track, and it occurred to me that I could post my own
reviews from previous published papers.
This will (hopefully) share some insight to fledgling researchers
(cough cough, me) on what a short paper review
would roughly contain.

So, here goes.

"New Features for Duplicate Bug Detection" was a study conducted
by an [REU][reu] student over the summer of 2013,
with mentoring and guidance from [Dr. Kraft][kraft] and myself.
Here is a link to the [preprint [PDF]][pdf].
We submitted this to [MSR 2014](http://2014.msrconf.org/) short paper
track, and it was accepted.

Below are the three reviews this paper received.
Note that these reviews were for the submission, and these
comments were geared toward that copy.
I don't have that anywhere that I can remember,
but this should give you an idea.

*Note: I've _slightly_ modified these with whitespace so that they render in markdown*


[kraft]: http://nkraft.cs.ua.edu/
[reu]: http://reu.cs.ua.edu
[pdf]: http://cscorley.students.cs.ua.edu/publications/pdfs/Klein-etal_14.pdf

## Review #1

Summary: The paper proposes a technique that predicts if a pair of bug reports is a duplicate pair or not. It extends the previous work by Alipour et al. by introducing additional features that are based on the differences in the words, topics, priority, reporting time, and components of two bug reports. Several machine learning algorithms from Weka have been used to investigate the effectiveness of the proposed features. Experiments have been performed on the same Android bug report dataset as Alipour et al. The results of the experiments show that the proposed features could improve the result of Alipour et al.’s method by 3.33%, 7.24%, and 11.76% in terms of Accuracy, AUC, and Kappa.

Recommendation: Weak Accept

Pros:

+ A number of new features have been proposed. These features capture differences between two bug reports in terms of their words, topics, priority, reporting time, and component.
+ Experiments using 6 classifiers have been conducted to demonstrate the value of the proposed features.
+ The experiments on the Android datasets show that the proposed approach could improve Alipour et al.'s approach by 3.33%, 7.24%, and 11.76% in terms of Accuracy, AUC, and Kappa.

Suggestion for improvement:

+ Reference [2] is not the paper referred to by Alipour et al. It should be changed to:

    Chengnian Sun, David Lo, Siau-Cheng Khoo, Jing Jiang: Towards more accurate retrieval of duplicate bug reports. ASE 2011: 253-262

    Reference [2] is related to your proposed approach though since it also uses topic modelling. It has not been compared with Alipour et al.'s method. Thus please refer to it too and mention the differences between your approach and the paper, e.g., difference in setting (see next comment).

+ The setting that your paper consider and the setting considered by Sun et al's approach are different. I think there is a need to highlight the difference in the paper.

    In Sun et al.'s approach, the setting is: given a bug report, return a list of top-k most similar bug reports.

    In your approach (and Alipour et al.'s approach), the setting is: given two bug reports, predict if they are a duplicate of each other or not.

    Alipour et al.'s setting is first considered in the following paper:

    David Lo, Hong Cheng, Lucia: Mining closed discriminative dyadic sequential patterns. EDBT 2011: 21-32 (See Case Study section)

    This setting is actually easier, since it is easier to differentiate between “two completely random bug reports” and “duplicate bug reports”, than to differentiate between "two similar bug reports that are not duplicate of each other" and "two similar bug reports that are duplicate of each other".
+ Please describe more about the evaluation metrics (i.e., Accuracy, AUC, and Kappa). In particular, please describe Kappa since it is not a very frequently used metric.
+ Please add a related work section that more comprehensively describes work in the area of duplicate bug report detection.
+ "Alipour et al" => "Alipour et al."
+ "International Workshop on Mining Software Repository" => "Working Conference on Mining Software Repository"
+ Weimar et al => Please add a reference ...
+ I think a better title could have been: "New Features for Duplicate Bug Detection".

In general, I have no major concern with the paper. The writing could be improved in a number of ways though. There is still one more page that the authors can use to improve the writing.



## Review #2

The paper proposes a new set of features to identify duplicate bugs. The efficacy of these new metrics/features is evaluated using 6 machine learning algorithms from Weka. The paper builds on the work of Alipour et al. and uses the same Android bug dataset. The experiments indicate that these new features result in an improvement in accuracy compared to Alipour et. al.'s for all the 6 learners considered.

Though the paper is not significantly novel, the idea of considering the first shared identical topic seems new. The results, at least for the Android data set, seems encouraging.

That said, it is generally necessary to evaluate a new metric rigorously and on several benchmark data sets before we claim that the metric is better. Since using shared identical topic seems to make sense intuitively, this is a ok for a short paper.

Few suggestions:

1. Since you have 1 additional page, and you use the same data set as Alipou's, it would be good to show some examples of pairs of bug reports that are actually duplicates but could not be detected by Alipour et al. but was detected using your new metrics. And also vice-versa. This will also help describe your new metrics in more detail with examples.

2. Ideally, one would want to know the efficacy of each *individual* metric. Which of your metrics would have a better performance? can we rank them?

3. There is a problem with Table III. You say that you added REPTree that Alipour et al. did not use, but then you show the performance improvement over Alipour's metric. This needs some additional explanation.

4. In Section V, you mention Weimar et al. but do not provide any reference.

5. The exposition can be improved. The new metrics (especially the one that you think is very novel) should be highlighted in the introduction itself. Currently, one needs to read till page 2 to figure out that the attributes in Table 1 are the new metrics you refer to in the paper.

## Review #3

The authors replicate a prior bug deduplication study and apply new
metrics and evaluate performance. They improve performance across a
wide range of learners and provide a new learner that works as well.
Furthermore their technique is far more generalized than the work they
replicate and thus is more automatable.

First and foremost, I think these incremental improvements in mining
are actually best served in short form. I think the length of this
submission is almost appropriate (although you had an extra page for
say better descriptions of the results or more comparison).

Second, they argue they have a consider improvement over other techniques

Third, they don't make it clear in their paper but their results all
suggest that LDA based comparisons results for bug deduping improve
performance far more than priority, time, component, or bug type.
Implying that at least in Android the meta-data is poor.

Questions:

* In table III what was reptree compared to ?

* Clarify this statement, you have space: To protect the validity of
our study, we ensured that no two pairs contained identical reports.

Issues:

* I think the wrong style was used for this submission the current
  style is sig-alternate and you're using something else, for instance
  numbering is in roman numerals.

* There's an extra page to go...

* I think in Alipour et al. and in this study that the application of
  KNN is inappropriate. While it works, I think it violates the triangle
  inequality.

* I want to see some time and space given to describing what were in
  your true positives and false negatives and true negatives and false
  positives.

Conclusions:

I think it is a nice short replication. A little more presentation
work would be appreciated but these features are easy to calculate and
easy to integrate into any deduper framework.

