# Algorithm

## Description

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

## Simulation Studies

To check whether the algorithm was capable of correctly identifying reassortant viruses, simulation studies were conducted. To simplify the problem, we considered the case of a two-segment virus, with each of the two segments having a different nucleotide substitution rate, mirroring the different substitution rates on each of the influenza genome segments. Each simulation run was initialized with anywhere between one and five viruses. At each time step, one virus was chosen at random to replicate (with 0.75 probability) or reassort with another virus (with 0.25 probability). Simulations were run for 50 time steps.

Regardless of replication or reassortment, the progeny virus was subjected to mutations, with the number of mutations in each segment being drawn from a binomial distribution with probability equal to the segment's substitution rate, and the exact positions drawn uniformly across the segment. This process is outlined in figure X (#figure).

The number of unique starting genotypes and total number of viral isolates being considered was much smaller than the real-world data. Therefore, our graph reconstruction procedure captured the essential parts of the method used in the global analysis, but differed in the details. Here, “full complements” involve only two segments. We did not perform affinity propagation clustering, as we started with completely randomly generated sequences of equal length. Our “null model” graph is where source isolates are chosen uniformly at random from the set of nodes occurring before the sink isolates.

To assess the accuracy of our reconstruction, we defined the path accuracy and reassortant path identification accuracy metrics (#figure). Edge accuracy, which is not used for evaluation here, is whether a particular reconstruction transmission between two isolates exists in the simulation. Path accuracy is a generalization of edge accuracy, where a path existing between the source and sink nodes (without considering the direction of edges) in the reconstruction is sufficient for being considered accurate. Reassortant path identification accuracy measures how accurately we identified the reassortant paths, analogous to the regular path accuracy.

Source code for the simulation studies is availble on Zenodo (DOI: 10.5281/zenodo.33427).

## Complexity Analysis

According to Feltenstein [@Feltenstein:2004ws], given a set of `n` labelled sequences, the number of possible rooted, bifurcating trees (which are used for inferring tree inconrguence) is

$$ \frac{(2n-3)!}{2^{n-2}(n-2)!} $$

Under the assumption that a Bayesian reconstruction is only looking for the most optimal tree topologies and is not estimating times of divergence, then the worst case scenario is that the MCMC sampling algorithm has to search $2^n$ trees in order to find the best topology.

The algorithm I have developed requires the computation of pairwise distance matrices, which requires $n^2$ comparisons.
