# Algorithm

At a high level, the reassortment detection algorithm works as such. Given a set of sequences, we wish to identify, using the rule of maximal similarity on some given metric, the most likely source of each segment in a virus. Sources, by definition, have to occur prior in time to the virus under consideration. We try to maximize the source similarity score of a virus while minimizing the number of sources needed to explain its existence.

The algorithm is described in more detail using the 3-part pseudocode below.

```
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

We implemented this using a combination of graph objects in `NetworkX` (#cite) and matrix summation in Python 3.5. The source code is available online (#cite Zenodo). To take advantage of vectorization, I used a combination of `numpy` and `pandas` to accomplish the matrix summation steps.
