# A Primer on the Influenza A Virus

## The Importance of Studying the Evolution and Ecology of the Influenza Virus

The influenza A virus has inflicted economic and social damage annually on the order of X billions of dollars (#factcheck, #cite). Being a pathogen with zoonotic origins [^zoonotic], it is imperative to study its circulation, evolution and pathogenesis not only in humans, but also in animals (domestic and wild). In this thesis, I outline joint efforts with my colleagues to map out and identify reassortant viruses at a global scale, and use this systematic, global identification to learn more about influenza, reticulate evolution, and ecology. (#TO BE CONTINUED...)

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
