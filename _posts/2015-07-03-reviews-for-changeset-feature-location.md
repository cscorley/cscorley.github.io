---
layout: post
title:  "Reviews for \"Modeling Changeset Topics for Feature Location\""
tags:
    - reviews
    - mining software repositories
    - changesets
    - open science
    - lda
    - topic models
---

Here are the set of reviews for my [ICSME'15](http://www.icsme.uni-bremen.de/)
main track paper! Unfortunately, this bad boy was initially rejected from
[SANER'15](http://www.saner.polymtl.ca/), but we made many changes to the paper
and it got in at ICSME. You can find a link to the PDF, code, and everything
else in my [publications](/publications).


# SANER Rejection

## Reviewer 1

This paper proposes to apply topic-modelling based information retrieval
techniques (i.e., LDA and LSI) for feature location from the incremental
changesets of source code. As an online learning algorithm based on changesets
is adopted, it is not necessary to do retraining and get the updated topic
models frequently.  The authors further conduct evaluation on 14 open source
Java projects to show the feasibility and effectiveness of the changesets
approach. 

Overall, this paper presents an interesting idea of using changesets for better
feature location. Although LDA and LSI have been widely investigated in feature
location domain, it is innovative to use the changesets from the version
control system (e.g., SVN or Git) for feature location. The approach of
modelling changeset topics is originally from reference [7]. This paper’s
contributions mainly lie in the application of the approach of modelling
changeset to feature location problem.  The evaluation also seems to be solid.
The authors publish the experiment data for public review. In the evaluation,
it is good to use Wilcoxon signed-rank test with Holm correction to determine
the statistical significance of the difference between results from LDA and
LSI. However, as the authors mention in evaluation, few of the evaluated
systems presented a statistically significant value between Snapshot based
approach and changeset based approach. 

The following issues need to be clarified: First, in this paper the authors use
commit message in Git and SVN as the representation of a changeset in a version
control system. Although the information among multiple versions of the project
is used, the paper still focuses on feature location in a single version of the
product. My concern is that if a feature that needs to be located is involved
in several changes, how good can the proposed approach handle it? The authors
may also better to show the effectiveness of the approach for features that are
relevant and irrelevant to commit messages. 

Second, the authors may also need to relate their work to the work on feature
location on multiple versions of products. They may refer to the following
literature and discuss about the application of modelling changeset topics for
feature location in multiple versions.

Yinxing Xue, Zhenchang Xing, Stan Jarzabek: Feature Location in a Collection of
Product Variants. WCRE 2012: 145-154

Third, for evaluation, the authors may try different parameter setup and
measures of retrieval accuracy. Currently, the number of topic is set to 500.
Actually, 500 topics may work well for normal documents based on natural
language like English (see S.T. Dumais. LSI meets TREC: A status report, in
Proceeding of Text Retrieval Conference, pp. 137-152. 1992), but a larger size
of topic may be preferred for information retrieval on source code, considering
more identifiers in source code. With regard to the measures, the authors only
use the mean reciprocal rank (MRR). The authors may also consider some measures
used in information retrieval domain, like Percentage of Relevant Queries
(PRQ), Mean Average Precision (MAP) and Average Percentage of Code Units
Investigated (APCUI). The different measures may reveal the different aspects
of the results. 

Below are also some detailed comments on the presentation and language of the paper:

1. In introduction, in the last third paragraph, “Our results show that not
   only is our changeset approach feasible and practical, but in some cases
   out-performs current snapshot approaches.” Here, the authors should be more
   specific about the cases in which the proposed approach performs better. 

2. The approach section is a bit too simple. You may add more details, or merge
   it with some content in Section II.A and Section II.B.

3. In the fourth paragraph of section IV.C, in the first sentence, “we our
   partitioning is inclusive of that commit.” should be “our partitioning is
   inclusive of that commit.”


## Reviewer 2

*Note: I had to leave this beauty verbatim...*

```
Review follows A.J. Smith 4/90 IEEE/Computer 

Recommendation. 
maybe

Summary and Significance. 
 What is the purpose?   Is the the problem clearly stated? 
	Incremental modeling of text-based retrieval systems for program comprehension. This is a significant goal for the SANER audience.

Is there an early description of the accomplishments? 
          No. in particular, the authors fail to mention that the method works only sometimes. 

 Is the problem new?   Using I/R for program comprehension is not; the incremental change set approach is.

     Has the design been built before?  no

     Has the problem been solved before?  no

     Is this a trivial variation on or an extension of a previous result?  no

    Is the author aware of of related work? yes

     Does the author cite previous work and make distinctions from  it?  yes

    If an implementation, are there new ideas?  yes

 Is the method of approach valid?  yes

        Is the approach sufficient for the purpose? yes

        Sufficient discussion of new ideas? no; reasons for failure to reject null hypothesis need to be clarified.

Is the actual execution of the research correct? yes

      Algorithms correct? Convincing?  yes

      Did the author do what was claimed?  no

 Are the correct conclusions drawn from the results?  no

      What are the applications/implications of the results?  I'm not sure.

      Adequate discussion of these results? 
         There is discussion of what happened; not why it happened.

 Is the presentation satisfactory? 

      Readability? yes

      Does abstract describe the paper?  please use a structured abstract.

     Does the introduction describe the problem and the framework?  yes

     Appropriate amount of detail?  yes

     Figures/tables appropriate? too many.

     Self-contained? yes
```

## Reviewer 3


The authors present an incremental topic-model approach to feature location
based on change sets. They evaluate the technique by comparing changes sets,
snapshots, and temporal change sets.

Excellent job sharing materials and making the work replicable by others.

Although the writing was clear, it was difficult to follow the thread of the
research and how the study design answered the research questions. Especially
missing are the big take away messages — what should a researcher or
practitioner take away from this study in using change sets or snapshots for
FLT?

Specific comments:

The explanation in section III seems unclear. Intuitively, I would think the
topic model is run once on a snapshot, and then run incrementally on all the
change sets after that point (up to the commit being searched). This approach
is hinted at in the introduction (“online topic models can be instantiated once
and incrementally updated over time.“) However, the wording in the following
sentence:

“The changeset topic modeling approach requires two types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release, and one for the every changeset in the
source code history leading up to that commit.”

Sounds like topic modeling is run on all the changes leading up to the
snapshot. Is this the target usage scenario? Please clarify the writing to make
the target usage scenario & algorithmic steps more clear. Figure 1 is a good
start, but doesn’t clearly show how the change sets are involved. Figure 1
seems to show that the topic modeler is run on the whole snapshot every time,
which I thought the purpose of the work was to avoid this?

I think the key insight behind the approach — “The key intuition to our
approach is that a topic model such as LDA or LSI can infer any given
document’s topic proportions regardless of the documents used to train the
model.” — needs to be expanded. Isn’t this idea one of the main contributions
of the work? A concrete example showing why this intuition is valid would help.

In section IV.C., the purpose of \theta_Queries is not yet clear, and it is
difficult to see how this fits in to the larger study. It would be helpful if
there were a big picture paragraph in the methodology section describing the
parts of the study and how they are used to answer the research questions
before diving in to the details. For instance, in this section I don’t yet know
what temporal simulations look like, although that is one of the contributions
of the work. It seems as if someone within the research team would perfectly
comprehend section IV.C, but is not written so that a reader familiar with
feature location can discern what is being evaluated and why when reading the
paper from beginning to end.

Section IV.E: “To answer RQ1, we run the experiment on the snapshot and
changeset datasets as outlined in Section IV-C. We then calculate the MRR
between the two.” What two? How does this comparison help us answer RQ1? And
then: “To answer RQ2, we run the experiment temporally as outlined in Section
IV-C” the high-level goals of the temporal experiment and how it differs from a
traditional experiment have not yet been described. Why are traceability links
important to answering the research questions? It seems that the authors had
some trouble making use of the Moreno data set. What is the advantage to
keeping it in? More replications? Why include both Tables I & II, if only the
data from Table II is used in the study?

It seems as if some of the high-level information I’m looking for might be
partially buried in the discussion section in G, rather than being up front to
help the reader understand the design of the experiment.

The work of Rao, et al. Seems closely related. In section II, can you
differentiate why such an approach is less desirable than your proposed
approach? (or evaluate?)

Typos:

- p. 5 C: “the process is varies slightly”
- p. 5 C: “we our partitioning is“
- conclusion: In this paper WE? conducted a study

## (the mytical) Reviewer 4

Dear authors,

We would like to thank you for your submission that has lead to a lively
discussion in the program committee. The main concerns raised by the committee
pertain to:

- the paper's claim that the proposed approach analyzes multi-versions of
  changeset data, yet it seems that the paper did not really make good use of
  multi-version changeset data in the proposed approach and in the evaluation.

- the fact that one of the reviewers familiar with this domain was not able to
  understand the approach since the paper has multiple issues making key points
  clear


# ICSME Acceptance

## Reviewer 1

The authors present a new approach in the context of feature location. They use
information available in the a software configuration management system to
incrementally perform concept location, so reducing time to perform such a kind
of task. I found the idea behind the authors’ proposal very interesting even if
it is not completely new in the context of software maintenance. The results
support the validity of the new approach. The paper flow is adequate even if in
some points I had some difficulties. For such difficulty I was not able to be
completely confident with the the work done. Also, further details and
justifications could be provided by the authors in the experimental part of the
paper. All in all, I’m happy enough with the work done. It is one of the best
papers I reviewed till now this year at ICSME.

In the following I’ll elaborate on the weakness points I see. I hope the
authors will found them useful.

In the motivation part of the introduction, there are some points that seem
contrasting each other. In particular, the authors wrote: “Indeed, given the
current state-of-the-art in TR, it is impossible for an FLT to satisfy all
three criteria while following the standard methodology.” Did Rao [10] and
Hoffman at al. [9] make a contribution to satisfy all the three criteria?
Reading the paper (and the Introduction, in particular) it seems YES.

Online (using fold-in and fold-out) LSI has been also applied in the context of
architecture recovery. Mentioning this paper in the introduction section could
further motivate your wok:

Michele Risi, Giuseppe Scanniello, Genoveffa Tortora: Using fold-in and
fold-out in the architecture recovery of software systems. Formal Asp. Comput.
24(3): 307-330 (2012)

The part where the approach is highlighted in the introduction section needs to
be rewritten because in the current form is not easy to follow. I read that
paragraph more and more, but my comprehension level did not change: completely
unclear.

Please discuss better on [10] and [18] in the related work section. In
addition, it is not completely clear to me what the difference is between the
proposed approach and [28].

Regarding the experimental part of the paper, I found very hard to understand
the methodology (especially second paragraph). Last paragraph, the authors
mentioned the dataset by Dit et al. Was the dataset by Moreno et al  treated
differently? Why?

Reading the description of the experiment, I was not able to understand whether
the authors simulated the use of GitHub. I mean, were all the applications and
the change sets in the used datasets in GitHub?

Last paragraph in section IV.E is not clear. I mean the place where the authors
justify why RQ2 has been studied only on one dataset.

In section IV.F, the authors discussed on the fact that the p-value was greater
than 0.05. In particular, they wrote: “This suggests that changeset topics are
just as accurate as snapshot topics at the method-level, especially since there
is a lack of statistical significance for any of the cases.”  Since the null
hypothesis has not been rejected, the authors can only discuss on descriptive
statistics. That it, it seems that the authors accept the null hypothesis and
this is definitively incorrect.

A statistical test (i.e., that chosen) verifies the presence of significant
difference between two groups (in your case), but it does not provide any
information about the magnitude of such a difference (if present). The
magnitude of such a difference could be computed using a (non-parametric)
effect size measure (e.g., Cliff’s d). You could also use the average
percentage improvement/reduction.

Why the authors did not analyze execution time?

In the threats to validity you should also consider biases related to the
statistical analysis performed (Conclusion validity). The readability could
improve organizing threats in: Internal, External, Conclusion, and Construct.


Typing and formatting minor issues:

At the end of section III.C, there is (between brackets) a strange symbol.

Figure 2 is not compressible if the paper is printed black and white.

Please remove orphans.

Section 4.B - it is not so good reading the description of the experimental
objects as the authors did.

## Reviewer 2 

This paper proposes a topic-modeling-based feature location technique in which
the text retrieval model (i.e., topic model) is built incrementally from source
code history. The technique uses an online learning algorithm to train topic
models based on change sets, and thus can maintain an up-to-date model without
incurring computational cost associated with retraining traditional
snapshot-based topic models. The proposed technique has been evaluated and the
results indicate that the accuracy of the technique is similar to that of a
snapshot-based feature location technique.

This paper reports an interesting exploration of applying incrementally built
topic models for feature location. It has the potential of improving current
IR-based feture location methods with lower computational cost on building text
retrieval models. But I think the paper still has a large space to improve.

First, the motivation of the paper is not clear and it is not well reflected in
the evaluation. It seems that the main benefit of the proposed technique is the
saving of computational cost associated with retraining traditional
snapshot-based topic models. However, there is no analysis about how much
computational cost can be saved. If the training of a snapshot-based topic
model only takes a short time (e.g., several minutes), it is acceptable that
the topic model is retrained for each release. Moreover, the saving of
computational cost is not evaluated in the experimental study.

Second, the proposed technique is not well described. In the section presenting
the technique (Section III), Section III-A and III-C respectively presents
terminology and explains the reason why change set is used. Section III-B
introduces the proposed technique, which is very short. Some important details
are missing, for example how change set corpus are combined with snapshot
corpus in training topic models? The process described in Figure 1 (B) does not
reflect the incremental manner of the proposed technique.


## Reviewer 3

The paper presents a topic-modeling-based Feature Location Technique (FLT)
where, to reduce the computational cost, the model is updated incrementally
from the changesets of commits from the project history instead of entire
snapshots. The approach is evaluated on 1,200 defects on publicly available
dataset (from 14 open-source Java projects) and is shown to exhibit accuracy
not lower than the accuracy of more traditional models built on entire
snapshots. The data and source code for the analysis are provided in an online
appendix.

The idea is novel and the approach has potential. Not much work has addressed
the issue of incremental model building in IR based feature location (the paper
misses some related work – see below). The motivation behind building a model
incrementally is to reduce the computational cost of rebuilding a model from
every snapshot. The approach presented in the paper is sensible and the results
indicate that it is a direction worth following. However, the paper also has
several points where it needs some improvement.

The original motivation suggests that the changesets will update the model
incrementally. My expectation was that every changeset will be considered
separately, i.e., the model will be updated using a changeset. However, neither
of the two research questions actually evaluates the approach in that setting.
In RQ1 the changeset-based model is built using all changesets at once. In RQ2,
the changesets are grouped into partitions based on the bug report that they
are linked to and the model is updated using a partition. The first question
here is why grouping changesets and why not updating the model after each
commit? And then if a grouping is to be made, why not approximate a more
realistic setting, i.e., update the model with every consecutive 10 commits,
for example. Consecutive commits will address different bugs and thus will
certainly have different topic distribution. My doubt here is to what extent
the grouping in RQ2 may have introduced a bias in the results? By the w! ay,
the part describing the historical simulation is somewhat confusing – at least
I had to read it twice to fully understand what exactly is being done.

When investigating the accuracy of the models built on the changesets the
thresholds are selected without justification and no tuning. For instance, for
the number topic models in all analyzed projects is fixed to 500. The paper
justifies the lack of parameter tuning with the fact that the "goal is to show
the performance of the changeset-based FLT against snapshot-based FLT under the
same conditions" and that "the measurements collected are fair and that the
results are not influenced by selective parameter tweaking". However, poor
selection of the parameters may lead to poor results and thus unrealistic
optimism that the proposed changeset-based FLT performs as good as traditional
snapshot-based FLTs. This doubt is somewhat confirmed by results shown in
Tables 1 and 2: The Mean Reciprocal Rank (MRR) is used to measure the
effectiveness of a FLTs for a set of queries; the higher the value the better
the result. The values for MRR shown in Tables 1 and 2 are quite low and this
is true for both models. For example, for the project Pig v0.8.0, the MRR is ~
0.011. This score of MRR would mean that the minimum rank for a relevant class
would be on average ~ 90 (out of 442 classes in this project). The MRR reported
by Moreno et al. varies depending on the settings and type of information that
is considered but stays between 0.18 and 0.26 for the same project. This
corresponds to ranks 6 and 4 (again out of 442). Thus, the doubt here is that
the results of the snapshot-based FLT using the selected parameters are poor
and the only thing that one can conclude is that the changeset-based FLT is not
making the poor results worse. Now whether the poor results are due to the
underlying techniques (i.e., LDA and-or LSI) or to the parameter selection only
is not clear but is probably worth investigating.

RQ1 should be rephrased maybe as a hypothesis “Changeset-based FLT is less
accurate than snapshot based FLT”. Then the data shows that this cannot be
proved.

Regarding RQ2, it is not clear how the accuracy's "fluctuation" of the CFL
technique is measured as a project evolves. I do not think the MRR metric by
itself measures such fluctuation, or at least this is not explained in the
paper. The MRR only measures accuracy. I would think that series analysis on
the MRRs across time would be the way to go or other analysis of this kind.
Now, it seems that the goal was onlu to compare the accuracy when changesets
are used to incrementally update the topic model, as opposed to update the
model at once with all the changesets. Unfortunately, it is not clear whether
what the goal really is. I suggest to clarify this issue and perhaps
reformulate RQ2. After all, the main goal of the paper is to test how the CFL
would perform in a realistic environment where the model is incrementally
updated with changes in commits.

The paper omits the LSI results “for brevity”. If they are omitted completely,
it is best not to even mention them. The best thing to do is to at least
mention how they compare wrt LDA.

Detailed comments:

p1:

- "By training an online learning algorithm using changesets, the FLT maintains
  an up-to-date model without incurring the non-trivial computational cost
  associated with retraining traditional FLTs.": As shown in Fig. 1 the
  snapshots are still used for indexing. Thus, the computational cost is saved
  in the process of building the topic model. What is exactly the saved
  computational cost? To better motivate the paper I would recommend to give a
  citation or an example of how long it takes to create a topic model for a
  large system such as eclipse using LDA. Also, it is a good idea to provide
  the cost saving of the Online LDA technique, compared to the standard LDA.
- "It follows from the first two observations (1: Like a class/method
  definition, a changeset has program text; 2: Unlike a class/method
  definition, a changeset is immutable.) that it is possible for an FLT
  following our methodology to satisfy all three of the criteria above. ": It
  is not clear how the first criterion is satisfied, i.e., "(1) accurate like a
  TM-based FLT"
- "We then used a subset of over 600 defects and features to conduct a
  historical simulation that demonstrates how the FLTs perform as a project
  evolves.": Why 600?
- The preprocessing often includes stemming, but stemming is not mentioned
  here. Later (p.6, Section IV Study) it becomes clear that no stemming is
  applied without justifying why.

p2:

- "Normalizing: replace each upper case letter with the corresponding lower
  case letter": Lawrie et al. use “normalization” for vocabulary normalization
  (i.e., the alignment of the vocabulary found in source code with that found
  in other software artifacts). See: D. Lawrie, D. Binkley, and C. Morrell.
  Normalizing source code vocabulary. In Proceedings of the Working Conference
  on Reverse Engineering (WCRE), pages 3-12, 2010
- "corpus is a set of documents (i.e., methods)": "i.e.," -> "e.g.,"

p5:

- Section IV.C. (Methodology) can be broken down into subsections based on the
  RQs.
- To answer RQ2 (Does the accuracy of a changeset-based FLT fluctuate as a
  project evolves?), the paper describes the so-called historical simulation
  where commits are related to each query (or issue) and partitions of
  mini-batches of changesets are created. The model is then updated using a
  mini-batch. An index of topic distributions with the snapshot corpus is then
  inferred. I don't understand why for the historical simulation, commits are
  grouped into partitions of mini-batches instead of updating the model after
  every commit.
- "on all documents extracted." -> extracted documents

p6:

- The paragraph starting with "After extracting tokens, we split ... " is not
  needed. The preprocessing, except the stemming, is already explained in
  Section II.A.
- Thresholds are missing justifications: K, the number of topics, is chosen to
  be 500; the two parameters that control how much influence a new mini-batch
  has on the model when training are 1024 and 0.9. No justification is given
  for the selected values. What are the values selected in related works?

p10:

- Ref. [2]: the publication date is 2013.
- The references should be consistent. For example, the venue of the references
  7, 17, 19 and 20 have the following form: "Software Engineering, IEEE
  Transactions on"; instead of "IEEE Transactions on Software Engineering".

Missing references to related work:

Hsin-yi Jiang, Tien N. Nguyen, Carl K. Chang, and Fei Dong, "Traceability Link
Evolution Management with Incremental Latent Semantic Indexing", in Proceedings
of the 31st IEEE International Computer Software and Applications Conference
(IEEE COMPSAC 2007), pages 309-316, July 24-27,2007

Hsin-yi Jiang, Tien N. Nguyen, Ing-Xiang Chen, Hojun Jaygarl, Carl K. Chang,
"Incremental Latent Semantic Indexing for Automatic Traceability Link Evolution
Management", in Proceedings of the 23rd ACM/IEEE International Conference on
Automated Software Engineering (ACM/IEEE ASE 2008), September 15-19, 2008

Ratanotayanon, Sukanya, Hye Jung Choi, and Susan Elliott Sim. "Using transitive
changesets to support feature location." Proceedings of the IEEE/ACM
International Conference on Automated Software Engineering, 2010
