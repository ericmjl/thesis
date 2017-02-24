# Future Work

## Engineering work

### Automation

The code, as it stands right now, was designed for execution on a Sun Grid Engine compute cluster. This design enabled manual parallelism wherever the code was embarrassingly parallel, in a map-reduce paradigm. For example, one key step is the creation of a multiple sequence alignment for each influenza A virus segment. Because the the alignment of one segment is not dependent on the alignment of another segment, they could be aligned in parallel, with the alignment of longer segments taking longer than the alignment of shorter segments. However, a few steps after that, there is a "reduction" step that is dependent on having all 8 evolutionary distance matrices computed fully, and this was one example of a step that was not automated because of (1) a lack of expertise in parallel computation and (2) the nature of the SGE scheduling system not being accessible from an external API.

With the development of Python-based software schedulers (e.g. Dask [@Team:2016wk]) enabling automatic execution of complex, arbitrary computation graphs, a rework of the code could be performed to make it executable with a single command from the command line. Dask has the added advantage of being able to scale from single cores to cloud infrastructure, though at the moment SGE clusters are not supported.

## Scientific questions

### Experimental Validation

The principle that genome shuffling can confer advantages in crossing between niches that are quantitatively different is a broad and difficult question to answer, partly because it is a broad idea that requires well-defined boundaries to answer, and partly because the genetics of influenza itself, such as packaging signals [@Steel:2014ef], may confound the ecological study of reassortment.

Influenza genetics also complicate the matter. With 8 genomic segments, if there are two viruses being experimentally reassorted, there are $2^8$ possible unique viruses that could be individually tested for replication fitness in a new host. Factor in the number of possible viruses that could be reassorted, and the number of possible model host cell lines available, and it can become an intractable problem to test every single combination.

Finally, we run into the issue of "gain-of-function" (GOF) studies. GOF studies are tricky because of the risk of creating a laboratory virus strain that (a) has the potential for human-to-human transmission, and (b) has the potential for lethality if a human is infected.

A simpler experimental approach may be as follows. We may opt to test the effect of avian genes on the replication of human viruses in avian cell lines (rather than the other way around, to circumvent GOF issues).
