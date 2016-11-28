# Algorithm

At a high level, the reassortment detection algorithm works as such. Given a set of sequences, we wish to identify, using the rule of maximal similarity on some given metric, the most likely source of each segment in a virus. Sources, by definition, have to occur prior in time to the virus under consideration. We try to maximize the source similarity score of a virus while minimizing the number of sources needed to explain its existence.

The algorithm is described in more detail using the 3-part pseudocode below.

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

Pairwise identities were computed using Clustal Omega (version 1.2.1)(#cite). I implemented the algorithm in the Python programming language (version 3.5); main packages used included NetworkX, `numpy`, `pandas`, and `matplotlib` for visualization. The source code is available online (#cite Zenodo).

# Simulation Studies

I conducted simulation studies to check whether the algorithm was capable of correctly identifying reassortant viruses. To simplify the problem, I considered the case of a two-segment virus, with each of the two segments having a different nucleotide substitution rate, mirroring the different substitution rates on each of the influenza genome segments. Each simulation run was initialized with anywhere between one and five viruses. At each time step, one virus was chosen at random to replicate (with 0.75 probability) or reassort with another virus (with 0.25 probability). Simulations were run for 50 time steps.

Regardless of replication or reassortment, the progeny virus was subjected to mutations, with the number of mutations in each segment being drawn from a binomial distribution with probability equal to the segment's substitution rate, and the exact positions drawn uniformly across the segment. This process is outlined in figure X (#figure).
