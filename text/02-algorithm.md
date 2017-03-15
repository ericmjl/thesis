# Algorithm

## Description

At a high level, the reassortment detection algorithm works as such. Given a set of sequences, we wish to identify, using the rule of maximal similarity on some given metric, the most likely source of each segment in a virus. Sources, by definition, have to occur prior in time to the virus under consideration. We try to maximize the source similarity score of a virus while minimizing the number of sources needed to explain its existence.

We adapted the SeqTrack algorithm [@Jombart:2011iu] to perform graph construction. Sequences were aligned using Clustal Omega 1.2.1 [@Sievers:2011fn], and the resultant distance matrix was converted into a similarity matrix by taking 1 - distance. Affinity propagation [@Frey:2007hs] clustering was performed on each segment’s similarity matrix to determine a threshold cutoff similarity value, defined as the minimum (across all clusters for that segment) of minimum in-cluster pairwise identities, below which we deemed it implausible for an evolutionary descent (clonal or reassortment) to have occurred (+@fig:fig-s7). Because the affinity propagation algorithm does not scale well with sample size, we treated the threshold computation as an estimation problem, and the final threshold was computed as the median threshold of 50 random subsamples of 500 isolates.

![Schematic illustration of for the determination of thresholds. The minimum in-cluster PWI (min PWI) is shown within each cluster’s bounding box. The minimum of min PWIs is highlighted in red. Exact threshold values used for the global influenza evolution study, rounded to 2 decimal places, are shown on the right.](./figures/pnas-fig-s6.jpg){#fig:fig-s7}

We then thresholded each segment’s similarity matrix on the basis of its segment’s threshold value, summed all eight thresholded similarity matrices, and then for each isolate, we identified the most similar isolate that occurred before it in time. This yielded the initial “full complement” graph without reassortant viruses. Each edge in this graph has an attached pair- wise identity (PWI), which is the sum of PWIs across all eight segments. Within this graph, there are isolates for which no “full complement” of segments could be identified, which are candidate reassortant viruses. In addition, among the isolates for which a full complement of segments could be found from another source, we identified those whose in-edges were weighted at the bottom 10% of all edges present in the graph, which we also identified as candidate reassortant viruses (1,357 of 1,368 such viruses were eventually identified as reassortant; the other 11 were considered to be clonally descended). For these viruses, we performed source pair searches, where we identified sources for a part of the genome from one virus and sources for the complementary part of the genome from another virus. If the summed PWI across the segments for the two viruses was greater than the single-source search, we accepted the source pair as the candidate reassortant.

Pairwise identities were computed using Clustal Omega (version 1.2.1) [@Sievers:2011fn]. The algorithm is implemented in the Python programming language (version 3.5); main packages used included NetworkX, `numpy`, `pandas`, and `matplotlib` for visualization. The source code is archived on Zenodo (DOI: 10.5281/zenodo.33421).

## Simulation Studies

To check whether the algorithm was capable of correctly identifying reassortant viruses, simulation studies were conducted. To simplify the problem, we considered the case of a two-segment virus, with each of the two segments having a different nucleotide substitution rate, mirroring the different substitution rates on each of the influenza genome segments. Each simulation run was initialized with anywhere between one and five viruses. At each time step, one virus was chosen at random to replicate (with 0.75 probability) or reassort with another virus (with 0.25 probability). Simulations were run for 50 time steps.

Regardless of replication or reassortment, the progeny virus was subjected to mutations, with the number of mutations in each segment being drawn from a binomial distribution with probability equal to the segment's substitution rate, and the exact positions drawn uniformly across the segment. This process is outlined in +@fig:fig-s4-simulation in the Applications section.

![Viral simulation results. (a) Schematic of simulation studies conducted on a model two-segment virus with one segment capable of hypermutating in a short region of it. (b) In the null model, genomic information is ignored and a source virus is picked at random from isolates prior to it in time. Reassortants remain identified as reassortants, but sources are changed. In the proper reconstruction, sources are chosen to minimize genetic distance across two segments. (c) Distribution of proportion of reassortant viruses accurately identified under a proper reconstruction (blue bars) as opposed to a null model (green bars).](./figures/pnas-fig-s4.jpg){#fig:fig-s4-simulation}

The number of unique starting genotypes and total number of viral isolates being considered was much smaller than the real-world data. Therefore, our graph reconstruction procedure captured the essential parts of the method used in the global analysis, but differed in the details. Here, “full complements” involve only two segments. We did not perform affinity propagation clustering, as we started with completely randomly generated sequences of equal length. Our “null model” graph is where source isolates are chosen uniformly at random from the set of nodes occurring before the sink isolates.

To assess the accuracy of our reconstruction, we defined the path accuracy and reassortant path identification accuracy metrics (+@fig:accuracy-metrics). Edge accuracy, which is not used for evaluation here, is whether a particular reconstruction transmission between two isolates exists in the simulation. Path accuracy is a generalization of edge accuracy, where a path existing between the source and sink nodes (without considering the direction of edges) in the reconstruction is sufficient for being considered accurate. Reassortant path identification accuracy measures how accurately we identified the reassortant paths, analogous to the regular path accuracy.

![Accuracy scores for simulation studies. Simulations were conducted under (a) complete sampling and (b) incomplete sampling scenarios. Top row: Reconstruction using the algorithm described (blue background) and under a null reconstruction (green background). Middle row: Distribution of edge accuracy metrics (fraction incorrect vs. fraction correct) under null reconstruction (green scatter points) and algorithm reconstruction (blue scatter points). Bottom row: Distribution of path accuracy under a null reconstruction (green) and algorithm reconstruction (blue). The algorithm reconstruction has a consistently higher accuracy in identifying reassortant viruses. ](./figures/accuracy-metrics.jpg){#fig:accuracy-metrics}

Source code for the simulation studies is available on Zenodo (DOI: 10.5281/zenodo.33427).

## Comparative Analysis of Time Complexity

### Tree Reconstruction Complexity

According to Felsenstein [@Felsenstein:2004ws], given a set of $n$ labelled sequences, the number of possible rooted, bifurcating trees (which are used for inferring tree inconrguence) is

$$ \frac{(2n-3)!}{2^{n-2}(n-2)!} $$

This can be expanded to:

$$\frac{(2n-3)(2n-4)(2n-5)...(n)(n-1)(n-2)(n-3)(n-4)...(1)}{2^{n-2}(n-2)(n-3)(n-4)...(1)}$$

Cancelling the common terms in the numerator and denominator, we get:

$$\frac{(2n-3)(2n-4)(2n-5)...(2n-n)(2n-(n+1))}{2^{n-2}}$$

If we consider only the largest polynomial terms of n, we see that in the numerator, $2n$ is multiplied $k-2$ times, where $k$ is the term subtracted from $2n$. Therefore, the major term (ignoring the smaller polynomials) simplifies to:

$$\frac{(2n)^{n-1}}{2^{n-2}} = \frac{2^{n-1}n^{n-1}}{2^{n-2}} = 2n^{n-1}$$

Under the assumption that a Bayesian reconstruction is only looking for the most optimal tree topology and is not estimating times of divergence for internal nodes, then the worst case scenario is that the MCMC sampling algorithm has to search $O(n^{n})$ trees in order to find the best topology.

### Network Reconstruction Complexity

For each of the major steps in the algorithm developed in this thesis, the time complexity is outlined below:

- Pairwise distance matrix computations is of $O(n^2)$ complexity.
- Finding maximal edges again requires $n^2$ comparisons to be made.
- In the 2nd search for source pairs, given $s$ segments and $n$ isolates, in the worst case scenario, we have to check all isolates for the source pairs. Thus, we require ${s}\choose{2}$ $n^2$ comparisons in the worst-case scenario.

Given this analysis, and ignoring the $s$ term (which is the number of segments for a given virus), the worst-case time complexity of the SeqTrack-based algorithm described here should be $O(n^2)$.
