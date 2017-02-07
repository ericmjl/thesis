# Future Work

## Engineering work

The code, as it stands right now, was designed for execution on a Sun Grid Engine compute cluster. This design enabled manual parallelism wherever the code was embarrassingly parallel. For example, one key step is the creation of a multiple sequence alignment for each influenza A virus segment. Because the the alignment of one segment is not dependent on the alignment of another segment, they could be aligned in parallel, with the alignment of longer segments taking longer than the alignment of shorter segments. However, a few steps after that, there is a "reduction" step that is dependent on having all 8 evolutionary distance matrices computed fully, and this was one example of a step that was not automated because of (1) a lack of expertise in parallel computation and (2) the nature of the SGE scheduling system not being accessible from an external API.

With the development of Python-based software schedulers (e.g. Dask [@Team:2016wk]) enabling automatic execution of complex, arbitrary computation graphs, a rework of the code could be performed to make it executable with a single command from the command line. Dask has the added advantage of being able to scale from single cores to cloud infrastructure.

## Scientific questions

1. Can we experimentally validate this principle?
1.
