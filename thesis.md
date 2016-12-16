---
title: Identification of Reassortant Influenza Viruses At Scale - Algorithm and Applications
author:
- name: Eric J. Ma
  affiliation: Department of Biological Engineering, MIT
numbersections: true
---

# A Primer on the Influenza A Virus

## The Importance of Studying the Evolution and Ecology of the Influenza Virus

The influenza A virus has inflicted economic and social damage annually on the order of X billions of dollars (#factcheck, #cite). Being a pathogen with zoonotic origins [^zoonotic], it is imperative to study its circulation, evolution and pathogenesis not only in humans, but also in animals (domestic and wild).

In this thesis, I outline joint efforts with my colleagues to map out and identify reassortant viruses at a global scale, and use this systematic, global identification to learn more about influenza, reticulate evolution, and ecology. (#TO BE CONTINUED...)

[^zoonotic]: Being of zoonotic origin means that the virus' reservoir is in one or more animal hosts, but "spills over" into humans upon contact. As such, humans are the "spillover host".

## Genome Structure & Evolution

The influenza A virus is a negative strand RNA virus, comprised of 8 genomic RNA segments. Its negative strandedness means that it encodes the strand opposite the messenger RNA (mRNA), implying that it needs to first be copied into mRNA before translation can occur. Together, the RNA segments encode its polymerase (PB2, PB1, PA, NP), viral entry and release proteins (HA, NA), a matrix protein (M) and a non-structural protein (NS) (#figure).

Being an RNA virus means that influenza is prone to copying errors during replication inside a host cell (#cite). This 'sloppiness' allows the influenza virus to evolve rapidly, and can be thought of as an **evolutionary drift**.

Evolutionary drift coupled with selection contributes to the difference in evolutionary rates that are observed between the external and internal genes. The HA and NA genes are thought to be under immune selection, as they are the external proteins that are targeted by the immune system. The HA and NA proteins, therefore, evolve under dual constraints: they have to continue functioning for cellular entry and release, fwhile also evolve novel epitopes that can successfully evade immune system detection. Evolutionary drift in the HA and NA genes contribute to **antigenic drift**, in which the antigenic characteristics of these two proteins slowly evolve over time; under the assumption that current immunity does not adapt, the current strains gradually become non-targetable by standing population immunity. On the other hand, the internal proteins do not function under such selective pressures, and as such are much more highly conserved.

Evolutionary drift is not the only mechanism by which influenza evolves. Its segmented and independently assorting genome allows for **reassortment** as a complementary mode of genomic evolution. Reassortment is thought to be the process resulting from co-infection of two viruses infecting the same host at the same time. If, for example, a red virus and a blue virus were to co-infect the same host cell, the progeny virus would contain any one of 2<sup>8</sup> combinations of red and blue segments (inclusive of the original viruses themselves) (#figure). Reassortment, thus, can be viewed as a form of **evolutionary shift** in the genomic structure of the virus.

## Phylogenies

*note to self: this section I'm quite weak on. Need to read more on history of phylogenies to make it stronger.*

The evolutionary history of the influenza virus can be visualized using phylogenies. Phylogenetic trees are a reconstruction of the life history of a virus, and is based on two core concepts in evolutionary biology: common ancestry and descent with modification. There have been three major advances in the history of inference of phylogenies using gene sequence data:

1. Maximum parsimony (non-statistical reconstruction)
2. Maximum likelihood (statistical point estimation of a tree)
3. Bayesian inference (statistical reconstruction of ensemble of trees)

### Maximum Parsimony

Maximum parsimony methods for phylogenetic reconstruction follow the logic of "the more similar we look, the closer our common ancestor is".

<!-- to be continued, lots of detail needs to go inside here that I need continuous time to read up on -->

### Maximum Likelihood

One of the problems with maximum parsimony methods is that mutational reversions can occur. When a nucleotide changes from A to T, it can continue to mutate to a G or a C, or can revert back to an A. Many generations of replication forward, the edit distance (Hamming or Levenshtein) between the progeny and the original plateaus (#figure). When reversions occur, using maximum parsimony to infer evolutionary history masks these reversion events.

Hence, maximum likelihood approaches were developed, in which the nucleotide substitution rate, including mutations and reversions, are factored in as a parameter for tree construction, thus allowing for a more accurate reconstruction. (#references needed)

### Bayesian Inference

- molecular clock
- Alexi Drummond's key paper in 2001

## Inferring Reassortment

Reassortment is classically inferred by **tree incongruence**. Tree incongruence can be visualized as in Figure X (#figure). Let us consider the example in Figure X as a

## Genome Packaging

In the study of the process of reassortment, one cannot escape from the topic of "how viruses are packaged". I have detailed the current best knowledge in the field in the appendix, as it is not a central and necessary piece of knowledge for understanding influenza reassortment at a global scale. However, for the uninitiated, the major key points are as follows:

1. There are "packaging signals" located in the coding sequence (imposing a further evolutionary constraint) that determine whether a piece of RNA is selectively packaged into the viral genome.
2. Selective packaging is shown via electron microscopy, where the vast majority of viral particles have a distinct "7+1" arrangement of segments.
3. Packaging signals have been exploited to generate influenza viruses that carry GFP rather than one of the genomic segments, allowing for tracking of viral replication.


----

1. Current best knowledge on reassortment mechanism at the cellular level.
    1. Summarize at a higher level of abstraction that the “host” level is what is necessary for understanding the problem.
1. Phylogenetic trees: inference, structure, interpretation.
    1. Concepts to cover: patristic distance (branch length from isolate to isolate), very important for understanding algorithm claim 1.
    1. Inference of branching, meaning of “time of most recent common ancestor”, how it’s inferred - evolutionary rate models.
1. Reticulate evolution & reassortment: inference by tree discordance.
    1. Current software available for doing so, and a brief summary of their logic.
        1. GiRaF
        1. Reassortment Networks
        1. 3rd codon biases
1. Importance of reassortant viruses: pandemics, immune evasion.
    1. Measures of fitness - “what is a “fit” virus?” relative to others? Quasispecies concept.
    1. What barriers to replication and infection do the host provide that the virus needs to overcome?
1. Influenza geographical distribution & host range - provides necessary background knowledge for Application 2.
    1. Reservoir hosts - wild animals
    1. Spillover hosts - humans
    1. Intermediate hosts - farm animals
1. Problem description:
    1. Can we identify reassortant viruses at scale?
    1. What can we learn from the detection of reassortant viruses at scale?

# Algorithm

At a high level, the reassortment detection algorithm works as such. Given a set of sequences, we wish to identify, using the rule of maximal similarity on some given metric, the most likely source of each segment in a virus. Sources, by definition, have to occur prior in time to the virus under consideration. We try to maximize the source similarity score of a virus while minimizing the number of sources needed to explain its existence.

We adapted the SeqTrack algorithm [@Jombart:2011iu] to perform graph construction. Sequences were aligned using Clustal Omega 1.2.1 [@Sievers:2011fn], and the resultant distance matrix was converted into a similarity matrix by taking 1 - distance. Affinity propagation [@Frey:2007hs] clustering was performed on each segment’s similarity matrix to determine a threshold cutoff similarity value, defined as the minimum (across all clusters for that segment) of minimum in-cluster pairwise identities, below which we deemed it implausible for an evolutionary descent (clonal or reassortment) to have occurred (#figure). Because the affinity propagation algorithm does not scale well with sample size, we treated the threshold computation as an estimation problem, and the final threshold was computed as the median threshold of 50 random subsamples of 500 isolates.

We then thresholded each segment’s similarity matrix on the basis of its segment’s threshold value, summed all eight thresholded similarity matrices, and then for each isolate, we identified the most similar isolate that occurred before it in time. This yielded the initial “full complement” graph without reassortant viruses. Each edge in this graph has an attached pair- wise identity (PWI), which is the sum of PWIs across all eight segments. Within this graph, there are isolates for which no “full complement” of segments could be identified, which are candidate reassortant viruses. In addition, among the isolates for which a full complement of segments could be found from another source, we identified those whose in-edges were weighted at the bottom 10% of all edges present in the graph, which we also identified as candidate reassortant viruses (1,357 of 1,368 such viruses were eventually identified as reassortant; the other 11 were considered to be clonally descended). For these viruses, we performed source pair searches, where we identified sources for a part of the genome from one virus and sources for the complementary part of the genome from another virus. If the summed PWI across the segments for the two viruses was greater than the single-source search, we accepted the source pair as the candidate reassortant.

The algorithm is also expressed in the following three-part pseudocode.

```
# Part 1: Compute pairwise identities between all viral isolates' segments.
for each segment in all_segments:
    compute all pairwise identities (PWIs) between each pair of viral isolates
    cluster all isolates based on segment's similarity scores
    compute threshold score as the minimum of all minimum in-cluster PWI
    set to NULL all scores below threshold

initialize empty graph

for each isolate in all_isolates:
    get other isolates that occurred prior in time to this isolate
    filter isolates such that there are no NULL PWI values
    sum up PWI values
    find maximally similar isolate(s) and add edge between isolate(s)

# re-check isolates
for each edge in graph:
    if edge PWI less than 10th percentile of all PWI scores:
        get other isolates that occurred prior in time to this isolate
        filter isolates such that there are no NULL PWI values
        find pair of isolates whose complementary segments maximizes PWI
        if new max PWI score > existing edge PWI score:
            replace single-source edge(s) with two-source edge(s)
```

Pairwise identities were computed using Clustal Omega (version 1.2.1) [@Sievers:2011fn]. The algorithm is implemented in the Python programming language (version 3.5); main packages used included NetworkX, `numpy`, `pandas`, and `matplotlib` for visualization. The source code is archived on Zenodo (DOI: 10.5281/zenodo.33421).

# Simulation Studies

To check whether the algorithm was capable of correctly identifying reassortant viruses, simulation studies were conducted. To simplify the problem, we considered the case of a two-segment virus, with each of the two segments having a different nucleotide substitution rate, mirroring the different substitution rates on each of the influenza genome segments. Each simulation run was initialized with anywhere between one and five viruses. At each time step, one virus was chosen at random to replicate (with 0.75 probability) or reassort with another virus (with 0.25 probability). Simulations were run for 50 time steps.

Regardless of replication or reassortment, the progeny virus was subjected to mutations, with the number of mutations in each segment being drawn from a binomial distribution with probability equal to the segment's substitution rate, and the exact positions drawn uniformly across the segment. This process is outlined in figure X (#figure).

The number of unique starting genotypes and total number of viral isolates being considered was much smaller than the real-world data. Therefore, our graph reconstruction procedure captured the essential parts of the method used in the global analysis, but differed in the details. Here, “full complements” involve only two segments. We did not perform affinity propagation clustering, as we started with completely randomly generated sequences of equal length. Our “null model” graph is where source isolates are chosen uniformly at random from the set of nodes occurring before the sink isolates.

To assess the accuracy of our reconstruction, we defined the path accuracy and reassortant path identification accuracy metrics (#figure). Edge accuracy, which is not used for evaluation here, is whether a particular reconstruction transmission between two isolates exists in the simulation. Path accuracy is a generalization of edge accuracy, where a path existing between the source and sink nodes (without considering the direction of edges) in the reconstruction is sufficient for being considered accurate. Reassortant path identification accuracy measures how accurately we identified the reassortant paths, analogous to the regular path accuracy.

Source code for the simulation studies is availble on Zenodo (DOI: 10.5281/zenodo.33427).

# Applications

## Application 1: Global reticulate evolution study.

Reticulate evolutionary processes, such as horizontal gene transfer and genomic reassortment, have been proposed as a major mechanism for microbial evolution (#cite), aiding in the diversification into new ecological niches (#cite). In contrast to clonal adaptation through genetic drift over time, reticulate evolutionary processes allow an organism to acquire independently evolved genetic material that can confer new fitness-enhancing traits. Examples include the acquisition of cell surface receptor adaptations (point mutations) in viruses (#cite) and antibiotic resistance (single genes) (#cite) and pathogenicity islands (or gene clusters) in bacteria (#cite).

Host switching, defined as a pathogen moving from one host species into another, represents a fitness barrier to microbial pathogens. The acquisition of adaptations through reticulate processes either before or after transmission from one species to another may serve to aid successful pathogen host switches by improving fitness and the likelihood of continued transmission (#cite). In this sense, reticulate evolution may be viewed as an ecological strategy for switching between ecological niches (such as different host species), complementing but also standing in contrast to the clonal adaptation of a microbial pathogen by genetic drift under selection. To test this idea and its importance in host switch events, which are critical for (re)-emerging infectious disease, we provide a quantitative assessment of the relative importance of reticulate processes versus clonal adaptation in aiding the ecological niche switch of a viral pathogen.

Data yielded from influenza genome sequencing projects provide a unique opportunity for quantitatively testing this concept and are suitable for the following reasons. First, the influenza A virus (IAV) has a broad host tropism (#cite) and is capable of infecting organisms spanning millennia of divergence on the tree of life. With different host-specific restriction factors forming an adaptive barrier, each host species may then be viewed as a unique ecological niche for the virus (#cite). Second, IAV is capable of and frequently undergoes reassortment, which is a well-documented reticulate evolutionary process (#cite). Reassortment has also been implicated as an adaptive evolutionary mechanism in host switching (#cite), although this is most prevalently observed for pandemic viruses of public health interest for which sequences are available (#cite). Finally, as a result of surveillance efforts during the last 2 decades, whole-genome sequences have been intensively sampled during a long time frame, with corresponding host species metadata, available in an easily accessible and structured format (#cite). Because reassortant viruses are the product of two or more genetically distinct viruses coinfecting the same host, a more complex process than clonal trans- mission and adaptation, they are expected to occur less frequently. Hence, the global IAV dataset, which stretches over time and space with large sample numbers, provides the necessary scope to detect reassortant viruses at a scale required to quantitatively assess the relative importance of reticulate events in viral host switching.

- Research question: is reassortment favoured when crossing between viral hosts?
- Results are in PNAS paper, so I will import them over with minimal modifications.
    - Main figure
- Need to describe statistical test, as this is required for a reader to understand how the statistical inference happened.

## Application 2: Viral persistence.

- Research question: is reassortment a favoured strategy for viral gene persistence across wintering seasons?
    - Lead author: Nichola Hill (post-doc in lab).
- Results: reassortment is over-represented for persistence through winter, relative to random chance. Describe statistical test.

Caveats common to both applications: always will have sampling issues with the current sequence database.

# Future Work

# Appendices

## Influenza Packaging

<!-- insert here our current best knowledge on influenza packaging -->

# References

