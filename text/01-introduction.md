\newpage

# A Primer on the Influenza A Virus

## The Importance of Studying Influenza Evolution & Ecology

The influenza A virus has inflicted economic damage annually on the order of billions of dollars [@Molinari:2007en]. Being a pathogen with zoonotic origins [^zoonotic], it is imperative to study its circulation, evolution and pathogenesis not only in humans, but also in animals (domestic and wild). One major problem of interest pertains to influenza's ability to shuffle its genome with other influenza viruses, and its implication in the ability of the virus to jump between host species. To address this, in this thesis I outline efforts with my colleagues to map out and identify these shuffled viruses at a global scale, and use this systematic, global identification study influenza, reticulate evolution, and ecology.

[^zoonotic]: Being of zoonotic origin means that the virus' reservoir is in one or more animal hosts, but "spills over" into humans upon contact. As such, humans are the "spillover host".

## Genome Structure & Evolution

The influenza A virus is a negative strand RNA virus, comprised of 8 genomic RNA segments. Its negative strandedness means that it encodes the strand opposite the messenger RNA (mRNA), implying that it needs to first be copied into mRNA before translation can occur. Together, the RNA segments encode its polymerase (PB2, PB1, PA, NP), viral entry and release proteins (HA, NA), a matrix protein (M) and a non-structural protein (NS) (+@fig:genome-structure-reassortment).

![(a) Influenza A virus genome structure. The influenza virus is comprised of 8 RNA segments. (b) Reassortment. Reassortment is the process by which two viruses co-infect the same host cell and produce progeny virus that contain segments from both parental viruses.](./figures/genome-structure-reassortment.jpg){#fig:genome-structure-reassortment}

Being an RNA virus that carries its own RNA-dependent RNA polymerase, the influenza A virus is prone to copying errors during replication inside a host cell [@Holmes:2003wl]. This 'sloppiness' allows the influenza virus to evolve rapidly under neutral conditions, resulting in **evolutionary drift**.

Evolutionary drift coupled with selection contributes to the difference in evolutionary rates that are observed between the external and internal genes. The HA and NA genes are thought to be under immune selection, as they are the external proteins that are targeted by the immune system. The HA and NA proteins, therefore, evolve under dual constraints: they have to continue functioning for cellular entry and release, while also evolving novel epitopes that can successfully evade immune system detection. Evolutionary drift in the HA and NA genes contribute to **antigenic drift**, in which the antigenic characteristics of these two proteins continually evolve under selection. By contrast, the internal proteins do not function under such selective pressures, and as such are much more highly conserved.

Evolutionary drift is not the only mechanism by which influenza evolves. Its segmented and independently assorting genome allows for **reassortment** as a complementary mode of genomic evolution. Reassortment is thought to be the process resulting from co-infection of two viruses infecting the same host at the same time. If, for example, a red virus and a blue virus were to co-infect the same host cell, the progeny virus would contain any one of $2^8$ combinations of red and blue segments (inclusive of the original viruses themselves) (+@fig:genome-structure-reassortment). Reassortment, thus, can be viewed as a form of **evolutionary shift**[^evoshift] in the genomic structure of the virus.

[^evoshift]: Amongst influenza researchers, evolutionary shift almost always refers to the exchange of HA and NA genes to produce viruses with an immunologically novel HA/NA combination. However, in this thesis, evolutionary shift refers more broadly to the exchange of any of the genes resulting in a novel genotype combination.

## Subtype Classification

Influenza A viruses are classically known by their subtypes, e.g. H1N1, H5N1, H3N2. The "H" represents the hemagglutinin subtype, for which there are 16 canonically known ones (H1-H16). The "N" stands for the neuraminidase subtype, for which there are 9 canonically known ones (N1-N9). H17N10 and H18N11, two new subtypes that expand our canonical view of the number of viral subtypes, have been isolated from bats [@Wu:2014by].

The hemagglutinin and neuraminidase are proteins expressed on the surface of the viral particle, and as such they are thought to be subject to immune selection and thus evolutionary pressure. This is the best current explanation as to why there is such great diversity in the HA and NA genes, and less diversity in the internal genes (e.g. polymerase genes)

## Phylogenies

The evolutionary history of the influenza virus can be visualized using phylogenies. Phylogenetic trees are a reconstruction of the life history of a virus, and is based on two core concepts in evolutionary biology: common ancestry and descent with modification. There have been three major advances in the history of inference of phylogenies using gene sequence data:

1. Maximum parsimony (non-statistical reconstruction)
2. Maximum likelihood (statistical point estimation of a tree)
3. Bayesian inference (statistical reconstruction of ensemble of trees)

Tree construction is done as follows: given a matrix of **character states** (columns) against **samples** (rows) that are assumed to be independently evolving, we want to find the tree representation of the distance matrix that best reconstructs the evolutionary history of the samples. Prior to the advent of molecular sequence information, the character states that were used were morphological features, such as wings span and bone sizes. With the advent of molecular sequence data, multiple sequence alignments are used as the input data, with the character states being the individual positions[^charevolve].

[^charevolve]: The assumption that character states evolve independently is still used in modern phylogenetic analyses, even though we know that this does not necessarily hold true, such as in the case of co-evolving sites due to epistatic interactions in a protein.

### Maximum Parsimony

Maximum parsimony methods for phylogenetic reconstruction follow the logic of "the more similar we look, the closer our common ancestor is". A toy example is shown below. Consider the example where we have the following three samples with 3 binary character states recorded:

sample  |  char1  |  char2  |  char3
--------|---------|---------|-------
A       |  1      |  1      |  1
B       |  1      |  1      |  0
C       |  1      |  0      |  0

Table: Toy example of binary character states. {#tbl:distmat}

Using the principle of parsimony, we may compute a distance matrix as follows:

sample  |  A  |  B  |  C
--------|-----|-----|---
A       |  0  |  1  |  2
B       |  1  |  0  |  1
C       |  2  |  1  |  0

Table: Distance matrix computed from character states. {#tbl:distmat}


Of the three possible trees that can be reconstructed, there are two that fit the data best:

![Maximum parsimony-based reconstruction of the character states. The non-parsimonious tree (Tree 3) is greyed out.](./figures/parsimony-tree.jpg){#fig:parsimony-tree}

### Maximum Likelihood

Molecular clock theory essentially states that the number of mutational events observed in a sequence is roughly linearly proportional with time. While in principle, this may seem to suggest that we can use the edit distance (maximum parsimony) to estimate the time of divergence between two sequences, there are problems with this logic.

One of the problems with maximum parsimony methods is that mutational reversions can occur. When a nucleotide changes from A to T, it can continue to mutate to a G or a C, or can revert back to an A. Many generations of replication forward, the edit distance (Hamming or Levenshtein) between the progeny and the original reaches a plateau (+@fig:hamming). When reversions occur, using maximum parsimony to infer evolutionary history masks these reversion events.

![Levenshtein distance of 100 simulated trajectories.](./figures/hamming.png){#fig:hamming}

Maximum likelihood methods help deal with this problem, by allowing us to calculate the likelihood that a given tree topology fits the sequence data, under an assumed model of sequence evolution that explicitly takes into account mutational reversion.

To illustrate how the likelihood calculations are performed, I show a toy example below on how tree likelihoods are computed.

Given the following three samples with the sequence states at a given position $j$.

Sample  |  $seq_{j}$
--------|------------
1       |  A
2       |  A
3       |  C

Table: Toy example of sequence states at a position in a multiple sequence alignment. {#tbl:seq-stats}

We may assume a model of evolution that follows the following sequence mutation (transition) probabilities:

letter  |  A     |  T     |  G     |  C
--------|--------|--------|--------|------
A       |  4/10  |  2/10  |  2/10  |  2/10
T       |  2/10  |  4/10  |  2/10  |  2/10
G       |  2/10  |  2/10  |  4/10  |  2/10
C       |  2/10  |  2/10  |  2/10  |  4/10

Table: Toy example of transition probabilities. {#tbl:transition-probabilities}

Finally, let us consider the following tree topology with two internal node reconstructions, as shown in +@fig:mlt.

![Two trees with internal node reconstructions on which likelihood calculations are performed.](./figures/max_likelihood_trees.jpg){#fig:mlt}

We may compute the following log likelihood for the left tree:

$$L_{tree1}(T) = P(A_4 \rightarrow A_1) \times P(A_4 \rightarrow A_2) \times P(A_5 \rightarrow A_4) \times P(A_5 \rightarrow C_3)$$

Taking a log transform to prevent underflow in computation yields:

$$log(L_{tree1}(T)) = logP(A_4 \rightarrow A_1) + logP(A_4 \rightarrow A_2) + logP(A_5 \rightarrow A_4) + logP(A_5 \rightarrow C_3)$$

Finally, evaluating the result, we get:

$$log(L_{tree1}(T)) = 3log0.4 + log0.2 = -1.89$$

Doing an analogous computation for the right tree yields a log likelihood score of -2.19. The same computation is performed over all possible nucleotide identities at the internal nodes, given the tree topology, and the log likelihoods are summed up. Tree topologies are compared with respect to their likelihood scores, and the one with the highest score is returned as the "maximum likelihood" tree.

Yet, we run into a problem: it is computationally infeasible to compute the likelihood for every single topology! Not only is the tree space large, according to Felsenstein [@Felsenstein:2004ws]:

$$ \frac{(2n-3)!}{2^{n-2}(n-2)!} $$

the likelihood over every possible reconstructed ancestral sequence has to be computed as well.

Thus, in practice, tree space is searched iteratively using a greedy algorithm, which is detailed in Felsenstein's book, Inferring Phylogenies [@Felsenstein:2004ws].

### Bayesian Phylogenetic Inference

Bayesian phylogenetic reconstruction methods extend likelihood tree reconstruction methods by allowing us to infer a probability distribution over the tree topology, given the data and an assumed evolutionary model. This yields an ensemble of trees. When paired with phylogeographic inference [@Lemey:2010eu], where geography is modelled as another character state in addition to nucleotide sequence, it is possible to reconstruct an inferred movement of viruses.

As is the case with Bayesian inference in general, the exponential increase in computational power along with advances in tree-space MCMC have been greatly enabling. Bayesian phylogenetic inference has been used successfully to infer the time of emergence of outbreak viruses such as the Ebola virus [@Gire:2014fk; @Park:2015cw] and movement swine influenza viruses [@Nelson:2015dy]. Nonetheless, while it is the state-of-the-art method, Bayesian phylogenetic tree construction remains computationally expensive; typical real-world runtimes for tree reconstruction, given single core, GPU-enabled compute power, are on the order of weeks for hundreds of taxa and months for thousands of taxa.

## Interpreting Trees

In order to understand how reassortment is detected, we need to first begin with some basic definitions of phylogenetic tree structure.

A bifurcating phylogenetic tree is a directed acyclic graph comprised of leaf nodes (tips), internal nodes, and bifurcating branches at each **internal node** (+@fig:interpreting-trees). Branch lengths indicate evolutionary time elapsed from an internal node to another internal node or leaf.

As with any hierarchical clustering method, the leaves can be organized into **clades** (+@fig:interpreting-trees), which represent a cluster of isolates on the tree that are closely related. How a clade is defined is often subjective; visual observation is the most common heuristic employed.

A metric of evolutionary distance between any two given isolates is the **patristic distance** (+@fig:interpreting-trees) between them. The patristic distance is measured by the sum of branch lengths (in the units that the lengths are defined, or else arbitrary distance) from one isolate to another. As such, isolates that are more evolutionarily related will have a shorter patristic distance between them.

![Visual definition of internal nodes, clades, and patristic distances.](./figures/interpreting-trees.jpg){#fig:interpreting-trees}

## Inferring Reassortment

Now that the basics of phylogenetic tree construction and interpretation have been covered, we will move on to discuss the current methods available for finding reassortant viruses, and their core logic.

### Single Virus

![An illustration of how reassortment is inferred for a single virus. ](./figures/reassortment.jpg){#fig:reassortment}

Reassortment is classically inferred on a single virus of interest. Reassortment can be detected by looking for incongruence in the phylogenetic history of a virus. As a simple example, for the red virus of interest in +@fig:reassortment, two of its three genes share closer evolutionary history with avian-isolated viruses, while one gene shares closer evolutionary history with human-isolated viruses. As such, we would infer that this avian virus acquired a human virus' gene through some process of reassortment.

### Tree Incongruence

Tree incongruence is another way of identifying reassortant influenza A viruses. Because a bifurcating phylogenetic tree can be defined as a set of splits partitioning the taxa into two sets, "incompatible splits" in the tree can be identified by looking at the partitioned sets and identifying partition sets that have non-null intersections.

Let us look at +@fig:tree-splits for an elementary example. Suppose we had two trees with the same set of taxa, $\{t_1, t_2, t_3, t_4\}$. We observe the following splits:

![Tree incongruence. Splits are denoted as red or yellow circles on the trees on the left; they are also denoted as nodes in the split incompatibility graph on the right. If two splits are incompatibe, as given by the definition below, then they are joined by an edge in the graph. ](./figures/tree-splits.jpg){#fig:tree-splits}

- The tree with a red split defines a partition of the four taxa into two splits, $A = \{t_1, t_2\}$ and $B = \{t_3, t_4\}$.
- The tree with a yellow split defines a partition of the four taxa into two splits, $X = \{t_1, t_3\}$ and $B = \{t_2, t_4\}$.

If these two trees are incompatible, then all of the following criteria are true:

- $A \cap X \ne \varnothing$, (i.e. intersection of sets A and X, or set of common items, is not an empty set)
- $A \cap Y \ne \varnothing$,
- $B \cap X \ne \varnothing$, and
- $B \cap Y \ne \varnothing$.

In the case of this pair of trees:

- $A \cap X = \{t_1\} \ne \varnothing$,
- $A \cap Y = \{t_2\} \ne \varnothing$,
- $B \cap X = \{t_3\} \ne \varnothing$, and
- $B \cap Y = \{t_4\} \ne \varnothing$.

Hence, these trees are incompatible, and thus there is evidence that reassortment has happened.

Tree incongruence is a generalization of the logic used to find individual reassortant viruses, and is implemented in the software, GiRaF [@Nagarajan:2011je]. GiRaF relies on the ensemble of trees returned from Bayesian phylogenetic tree reconstructions; hence, in practice the majority of time spent detecting reassortant viruses is actually spent on tree reconstruction. On the other hand, a nice statistical outcome of sampling tree space is that splits are only counted if they appear in more than 95% of sampled trees, leading to a natural "95% confidence" for any given reassortment event detected.

### 3rd Codon Biases

3rd codon sequences are assumed to be under less selective pressure than 1st and 2nd codons in a sequence. If one considers two strains of virus $v_a$ and $v_b$, and their respective pairs of segments, $s_{i,a}$ and $s_{i,b}$, and $s_{j,a}$ and $s_{j,b}$, we may compute the difference between their segments as follows:

$$ d_{i,(a,b)} = EditDistance(s_{i,a}, s_{i,b}) $$
$$ d_{j,(a,b)} = EditDistance(s_{j,a}, s_{j,b}) $$

Plotting the distribution of $d_{i,(a,b)}$ against $d_{j,(a,b)}$ for all pairs of viruses $(v_a, v_b)$ yields +@fig:3rd-codon-distance.

![Toy distribution of all pairwise 3rd codon hamming distances between viral isolates. Blue dots: comparisons between viruses that yielded correlated 3rd codon hamming distances. Yellow dots: comparisons between viruses that yielded non-correlated 3rd codon hamming distances.](./figures/3rd-codon-distance.jpg){#fig:3rd-codon-distance .class max-height=200px}

As shown in +@fig:3rd-codon-distance (adpated from [@Rabadan:2008jm]), if no reassortment was present, the hamming distance between the 3rd codons should be correlated under the assumptions that (a) 3rd codons are under neutral selection, and (b) the segments drift at roughly the same rate under neutral conditions. This would result in only blue dots showing up. If reassortment was present, then the hamming distances between two viruses should be non-correlated, and the yellow dots will show up.

This is a computationally simple method, as it only requires the computation of all pairwise edit distances, and as such has the advantage of being scalable to large numbers of sequences. However, it ignores the evolutionary history of the virus, making no inference about the source of segments, unless paired with time-stamped data.

## Influenza Biology

### Genome Packaging

In the study of the process of reassortment, one cannot escape from the topic of "how viruses are packaged". This is because when two viruses co-infect the same host cell, the resulting mixed pool of genomic segments have to undergo packaging into another live virus. However, the level of abstraction required for understanding this thesis is at the host species level. As such, the details of packaging are not a central and necessary piece of knowledge for understanding influenza reassortment at a global scale. Thus, in lieu of a full description of the current state of knowledge, I have listed the major key points below as follows:

1. There are "packaging signals" located in the coding sequence (imposing a further evolutionary constraint) that determine whether a piece of RNA is selectively packaged into the viral genome. [@Goto:2013bc; @Hutchinson:2009hd; @Gog:2007ie] (+@fig:packaging)
1. Selective packaging is shown via electron microscopy, where the vast majority of viral particles have a distinct "7+1" arrangement of segments. Only a minority have extra segments. [@Gerber:2014hp]
1. Packaging signals have been exploited to generate influenza viruses that carry GFP rather than one of the genomic segments, allowing for tracking of viral replication [@Goto:2013bc]. This remains, to date, the strongest evidence in favour of the presence of packaging signals that are part of the coding sequence of each of the 8 genes. This provides the genetic basis for selective packaging, but biochemical mechanisms remain elusive.

![Summary of known results in influenza genome packaging. (a) Mutating the 3rd codon positions in the packaging regions reduces packaging efficiency, thus highlighting their importance. (b) Defective-interfering RNAs harbouring only the packaging signals can interfere with live virion production. (c) Foreign genes, such as GFP, have been packaged into the influenza virus by flanking them with packaging signals. (d) Packaging signals can be swapped between segments, but a packaging signal sequence must be present on each gene in order to rescue live virus.](./figures/packaging.jpg){#fig:packaging}

### Host Distribution of Influenza A Virus

In order to understand reassortment in ecological contexts, we need to know the known host range and movement patterns of the influenza A virus.

The influenza A virus has a broad geographic and trophic range. Viral flow is canonically thought to start in the influenza A virus' reservoir hosts, wild ducks [@Webster:1992wl]. Viruses can occasionally **spillover** from wild birds into domestic animals, such as pigs and chickens. Because of the close proximity of humans to domestic animals, these viruses can also jump from domestic animals into humans, thus leading to pandemics [@Webster:1992wl].

Though ducks, pigs, chickens and humans are the canonical places we think of flu, influenza is neither solely restricted to these hosts, nor is the flow of virus uni-directional.

Influenza viruses have been isolated in large and small mammals, including cows, horses, dogs, cats [@Kuiken:2004cs], seals [@Hussein:2016cj; @Anthony:2012dda; @Lang:1981tj; @Fereidouni:2014df], penguins [@Wallensten:2006kl] and more. The newest influenza viral subtypes, H17N10 and H18N11, have been isolated from bats [@Wu:2014by].

Additionally, cases of **reverse zoonosis** [^rev_zoonosis] have been reported, where viruses jump back into swine hosts from humans [@Nelson:2015cg]. Humans, therefore, are not a "dead-end" host for the virus, as was once thought.

[^rev_zoonosis]: Zoonotic viruses typically have animal reservoir hosts, and humans are the "spillover" host. Reverse zoonosis occurs when these viruses jump from humans back into animal hosts.

A little detail on influenza biology is necessary to understand reverse zoonosis. Based on studies of the glycans [^glycans] that decorate the surface of cell membranes, human hosts generally have $\alpha$-(2,3) glycans, while avian hosts generally have $\alpha$-(2,6) glycans [@Gagneux:2003fs; @Matrosovich:1999ux]. The hemagglutinin attaches to the glycans in the first step of viral infection, thus mediating viral entry.

Pigs have been shown to have both glycans distributed on their cells [@Ito:1998tm]. As such, viruses that are capable of infecting birds can also infect pigs, where they may acquire mutations that allow them to enter human cells; additionally, human viruses are also thus capable of replicating in swine hosts. As such, this knowledge has led to the conclusion that swine hosts may play the role of "mixing vessels" [@Ito:1998tm], allowing influenza A viruses to reassort in pigs.

[^glycans]: Glycans are branched chains of sugar molecules that have been identified on cell surface membranes. Glycans are also post-translationally added to proteins through glycosylating enzymes.

### Viral and Host Movement

Viruses are obligate parasites, in the sense that they cannot reproduce without the presence of a host to infect. As such, it should also be evident that their mobility is determined by their host's movement range. This has implications for detecting and forecasting reassortment: reassortment between two viruses cannot happen unless their host ranges overlap, or their host geographic ranges overlap.

### Evolutionary Consequences of Reassortment

Reassortment can result in novel genotype combinations. An epidemiologically-relevant reassortment is one that occurs between viruses of different subtypes. This is because the HA and NA proteins elicit host immune responses. Thus, novel HA/NA combinations, or the introduction of an antigenically distinct HA or NA of the same subtype, can result in a new virus with the ability to evade immune detection. This would, in turn, help the virus circumvent existing host (and population) immunity.

In theory, it is also possible for other 'enhancements' to the influenza A virus to be acquired via reassortment. For example, polymorphisms correlated with enhanced polymerase replication capacity in human cells are found in viruses isolated in wild birds, raising the possibility that these mutations can occur naturally and, if reassorted with an immunologically-novel viral subtype, can confer enhanced replication capacity, leading to a much riskier virus.

## Research Questions

Given what we currently know about the ecology of influenza, a key gap in our knowledge is the role that reassortment plays in flu movement and survival. Grounded on this theme, I set out with colleagues to tackle the following questions:

1. Are reticulate evolutionary processes, such as reassortment, important for host switches? If so, can we quantify the importance? Is the principle generalizable?
1. Is reassortment an evolutionary strategy that influenza genes can employ to persist against barriers to transmission?
