# A Primer on the Influenza A Virus

## The Importance of Studying the Evolution and Ecology of the Influenza Virus

The influenza A virus has inflicted economic and social damage annually on the order of X billions of dollars (#factcheck, #cite). Being a pathogen with zoonotic origins [^zoonotic], it is imperative to study its circulation, evolution and pathogenesis not only in humans, but also in animals (domestic and wild). One major problem of interest pertains to influenza's ability to shuffle its genome with other influenza viruses, and its implication in the ability of the virus to jump between host species. To address this, in this thesis I outline efforts with my colleagues to map out and identify these shuffled viruses at a global scale, and use this systematic, global identification to learn more about influenza, reticulate evolution, and ecology.

[^zoonotic]: Being of zoonotic origin means that the virus' reservoir is in one or more animal hosts, but "spills over" into humans upon contact. As such, humans are the "spillover host".

## Genome Structure & Evolution

The influenza A virus is a negative strand RNA virus, comprised of 8 genomic RNA segments. Its negative strandedness means that it encodes the strand opposite the messenger RNA (mRNA), implying that it needs to first be copied into mRNA before translation can occur. Together, the RNA segments encode its polymerase (PB2, PB1, PA, NP), viral entry and release proteins (HA, NA), a matrix protein (M) and a non-structural protein (NS) +@fig:genome-structure-reassortment.

![](./figures/genome-structure-reassortment.jpg){#fig:genome-structure-reassortment}

Being an RNA virus that carries its own RNA-dependent RNA polymerase, the influenza A virus is prone to copying errors during replication inside a host cell (#cite). This 'sloppiness' allows the influenza virus to evolve rapidly, and can be thought of as an **evolutionary drift**.

Evolutionary drift coupled with selection contributes to the difference in evolutionary rates that are observed between the external and internal genes. The HA and NA genes are thought to be under immune selection, as they are the external proteins that are targeted by the immune system. The HA and NA proteins, therefore, evolve under dual constraints: they have to continue functioning for cellular entry and release, while also evolve novel epitopes that can successfully evade immune system detection. Evolutionary drift in the HA and NA genes contribute to **antigenic drift**, in which the antigenic characteristics of these two proteins slowly evolve over time. On the other hand, the internal proteins do not function under such selective pressures, and as such are much more highly conserved.

Evolutionary drift is not the only mechanism by which influenza evolves. Its segmented and independently assorting genome allows for **reassortment** as a complementary mode of genomic evolution. Reassortment is thought to be the process resulting from co-infection of two viruses infecting the same host at the same time. If, for example, a red virus and a blue virus were to co-infect the same host cell, the progeny virus would contain any one of 2<sup>8</sup> combinations of red and blue segments (inclusive of the original viruses themselves) (#figure). Reassortment, thus, can be viewed as a form of **evolutionary shift**[^evoshift] in the genomic structure of the virus.

[^evoshift]: Amongst influenza researchers, evolutionary shift almost always refers to the exchange of HA and NA genes to produce viruses with an immunologically novel HA/NA combination. However, in this thesis, evolutionary shift refers more broadly to the exchange of any of the genes resulting in a novel genotype combination.

## Phylogenies

The evolutionary history of the influenza virus can be visualized using phylogenies. Phylogenetic trees are a reconstruction of the life history of a virus, and is based on two core concepts in evolutionary biology: common ancestry and descent with modification. There have been three major advances in the history of inference of phylogenies using gene sequence data:

1. Maximum parsimony (non-statistical reconstruction)
2. Maximum likelihood (statistical point estimation of a tree)
3. Bayesian inference (statistical reconstruction of ensemble of trees)

Tree construction is done as follows: given a matrix of **character states** (columns) against **samples** (rows) that are assumed to be independently evolving, we want to find the tree representation of the distance matrix that best reconstructs the evolutionary history of the samples. Prior to the advent of molecular sequence information, the character states that were used were morphological features, such as wings span and bone sizes. With the advent of molecular sequence data, multiple sequence alignments are used as the input data, with the character states being the individual positions[^charevolve].

[^charevolve]: The assumption that character states evolve independently is still used in modern phylogenetic analyses, even though we know that this does not necessarily hold true, such as in the case of co-evolving sites due to epistatic interactions in a protein.

### Maximum Parsimony

Maximum parsimony methods for phylogenetic reconstruction follow the logic of "the more similar we look, the closer our common ancestor is". A toy example is shown below. (#figure) Consider the example where we have the following three samples with 3 binary character states recorded:

```{include.table=./tables/phylogenetics.md}
```

Using the principle of parsimony, we may compute a distance matrix as follows:

```{include.table=./tables/phylogenetics-distmat.md}
```

Of the three possible trees that can be reconstructed, there are two that fit the data best:

![Maximum parsimony-based reconstruction of the character states.](./figures/parsimony-tree.jpg){#fig:parsimony-tree}

### Maximum Likelihood

Molecular clock theory essentially states that the number of mutational events observed in a sequence is roughly linearly proportional with time. While in principle, this may seem to suggest that we can use the edit distance (maximum parsimony) to estimate the time of divergence between two sequences, there are problems with this logic.

One of the problems with maximum parsimony methods is that mutational reversions can occur. When a nucleotide changes from A to T, it can continue to mutate to a G or a C, or can revert back to an A. Many generations of replication forward, the edit distance (Hamming or Levenshtein) between the progeny and the original reaches a plateau (+@fig:hamming). When reversions occur, using maximum parsimony to infer evolutionary history masks these reversion events.

![Levenshtein distance of 100 simulated trajectories.](./figures/hamming.png){#fig:hamming}

Maximum likelihood methods were developed to deal with this problem. Under the assumption that each site evolves independently, we require three ingredients to compute the likelihood of a given phylogeny: the structure of the tree, an assumed internal node sequence, and a probability of mutation between any given pair of nucleotide states.

Purely for illustrative purposes, and without going into further detail, I show an example with concrete numbers below.

Given the following three samples with the following states:

```{include.table=./tables/max_likelihood_sequence.md}
```

and the following transition probabilities:

```{include.table=./tables/max_likelihood_transitions.md}
```

and two trees (out of many possible) for this given state:

![Two trees with internal node reconstructions on which likelihood calculations are performed.](./figures/max_likelihood_trees.jpg){#fig:mlt}

We may compute the following log likelihood for each of the trees: (#factcheck check these calculations!)

$$L_{tree1}(T) = P(A_4 \rightarrow A_1) \times P(A_4 \rightarrow A_2) \times P(A_5 \rightarrow A_4) \times P(A_5 \rightarrow C_3)$$

Taking a log transform to prevent underflow in computation:

$$log(L_{tree1}(T)) = logP(A_4 \rightarrow A_1) + logP(A_4 \rightarrow A_2) + logP(A_5 \rightarrow A_4) + logP(A_5 \rightarrow C_3)$$

And evaluating the result, we get:

$$log(L_{tree1}(T)) = 3log0.4 + log0.2 = -1.89$$

Doing an analogous computation for tree 2 yields a log likelihood score of -2.19.

In principle, this procedure has to be for every possible nucleotide in the internal nodes. The sum of all log likelihood scores gives the log likelihood of the tree, given the sequence at a position $i$ in a multiple sequence alignment. This computation is then repeated for every position in a sequence alignment. This makes maximum likelihood methods computationally more expensive than maximum parsimony methods.

Yet, we run into a problem: it is computationally infeasible to compute the likelihood for every single topology! Not only is the tree space large, according to Feltenstein (2004) [@Feltenstein:2004ws]

$$ \frac{(2n-3)!}{2^{n-2}(n-2)!} $$

the likelihood over every possible reconstructed ancestral sequence has to be computed as well.

Thus, in practice, trees are iteratively built using a greedy algorithm. For brevity, I do not detail the methods here, but they can be found in Feltenstein (2004) [@Feltenstein:2004ws].

### Bayesian Phylogenetic Inference

Bayesian phylogenetic reconstruction methods extend likelihood tree reconstruction methods by allowing us to infer a probability distribution over the tree topology and coalescent times, given the data. When paired with phylogeographic inference [@Lemey:2010eu], where geography is modelled as another character state in addition to nucleotide sequence, it is possible to trace reconstruct and trace the movement of viruses. As is the case with Bayesian inference in general, the exponential increase in computational power along with advances in tree-space MCMC have been greatly enabling. Bayesian phylogenetic inference has been used successfully to infer the time of emergence of outbreak viruses such as the Ebola virus [@Gire:2014fk; @Park:2015cw] and movement swine influenza viruses [@Nelson:2015dy].

## Interpreting Trees

A bifurcating phylogenetic tree is a directed acyclic graph comprised of leaf nodes (tips), internal nodes, and bifurcating branches at each **internal node** (+@fig:interpreting-trees). Branch lengths indicate evolutionary time elapsed from an internal node to another internal node or leaf.

As with any hierarchical clustering method, the leaves can be organized into **clades** (+@fig:interpreting-trees), which represent a cluster of isolates on the tree that are closely related. How a clade is defined is subjective, and visual observation is the most common way to define a clade.

A metric of evolutionary distance between any two given isolates is the **patristic distance** (+@fig:interpreting-trees) between them. The patristic distance is measured by the sum of branch lengths (in the units that the lengths are defined) from one isolate to another. As such, isolates that are more evolutionarily related will have a shorter patristic distance between them.

![Visual definition of internal nodes, clades, and patristic distances.](./figures/interpreting-trees.jpg){#fig:interpreting-trees}

## Inferring Reassortment


### Inferring Reassortment using Phylogeny-Dependent Methods.

#### Single Virus

Reassortment is clasically inferred on a single virus of interest. The logic is essentially presented in +@fig:reassortment.

![An illustration of how reassortment is inferred for a single virus. ](./figures/reassortment.jpg){#fig:reassortment}

Reassortment can be detected by looking for incongruence in the phylogenetic history of a virus. As a simple example, for the red flu of interest in +@fig:reassortment, two of its three genes share closer evolutionary history with avian flu, while one gene shares closer evolutionary history with human flu. As such, we would infer that this avian virus acquired a human virus' gene through some process of reassortment.

Is it possible to tell in which host a virus was isolated? Given the sparsity of sampling efforts, it is very difficult to tell whether this reassortment was more likely to have occurred inside a human host or an avian host or an intermediate host. The best that we can do is reconstruct the evolutionary history.

#### Tree Incongruence


#### Patristic Distances

Patristic distance can be used as a measure of finding reassortant viruses.

### Inferring Reassortment Using Phylogeny-Independent Methods

Phylogeny-independent methods do not require the construction of phylogenetic trees in order to identify reassortant viruses.

#### 3rd Codon Biases

3rd codon sequences are assumed to be under less selective pressure than 1st and 2nd codons in a sequence. If one considers two strains of virus $v_a$ and $v_b$, and their respective pairs of segments, $s_{ia}$ and $s_{ib}$, and $s_{ja}$ and $s_{jb}$, we may compute the difference between their segments as follows:

$$ d_{iab} = EditDistance(s_{ia}, s_{ib}) $$
$$ d_{jab} = EditDistance(s_{ja}, s_{jb}) $$

Plotting the distribution of $d_{iab}$ against $d_{jab}$ for all pairs of viruses $(v_a, v_b)$ yields the following plot:

![Toy distribution of all pairwise 3rd codon hamming distances between viral isolates. Blue dots: comparisons between viruses that yielded correlated 3rd codon hamming distances. Yellow dots: comparisons between viruses that yielded non-correlated 3rd codon hamming distances.](./figures/3rd-codon-distance.jpg){#fig:3rd-codon-distance .class max-height=200px}

As shown in +@fig:3rd-codon-distance (adpated from [@Rabadan:2008jm]), if no reassortment was present, the hamming distance between the 3rd codons should be correlated under the assumptions that (a) 3rd codons are under neutral selection, and (b) the segments drift at roughly the same rate under neutral conditions. This would result in only blue dots showing up. If reassortment was present, then the hamming distances between two viruses should be non-correlated, and the yellow dots will show up.

This is a computationally simple method, as it only requires the computation of all pairwise edit distances, and as such has the advantage of being scalable to large numbers of sequences.

#### Sequence Similarity Thresholding



## Genome Packaging

In the study of the process of reassortment, one cannot escape from the topic of "how viruses are packaged". This is because when two viruses co-infect the same host cell, the resulting mixed pool of genomic segments have to undergo packaging into another live virus. The level of abstraction required for understanding this thesis is at the host species level. As such, the details of packaging are not a central and necessary piece of knowledge for understanding influenza reassortment at a global scale. Thus, in lieu of a full description of the current state of knowledge, I have listed the major key points below as follows:

1. There are "packaging signals" located in the coding sequence (imposing a further evolutionary constraint) that determine whether a piece of RNA is selectively packaged into the viral genome. [@Goto:2013bc; @Hutchinson:2009hd; @Gog:2007ie] (+@fig:packaging)
1. Selective packaging is shown via electron microscopy, where the vast majority of viral particles have a distinct "7+1" arrangement of segments. Only a minority have extra segments. [@Gerber:2014hp]
1. Packaging signals have been exploited to generate influenza viruses that carry GFP rather than one of the genomic segments, allowing for tracking of viral replication [@Goto:2013bc]. This remains, to date, the strongest evidence in favour of the presence of packaging signals that are part of the coding sequence of each of the 8 genes. This provides the genetic basis for selective packaging, but biochemical mechanisms remain elusive.

![Summary of known results in influenza genome packaging. (a) Mutating the 3rd codon positions in the packaging regions reduces packaging efficiency, thus highlighting their importance. (b) Defective-interfering RNAs harbouring only the packaging signals can interfere with live virion production. (c) Foreign genes, such as GFP, have been packaged into the influenza virus by flanking them with packaging signals. (d) Packaging signals can be swapped between segments, but a packaging signal sequence must be present on each gene in order to rescue live virus.](./figures/packaging.jpg){#fig:packaging}

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
