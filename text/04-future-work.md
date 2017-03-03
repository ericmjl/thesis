# Remaining Challenges & Future Work

## Engineering

Algorithms developed in the academic world often require "just some engineering" to be made ready for deployment to the real-world. It remains on my personal wish-list to have turned this reassortment detection algorithm into a standalone software package, similar to BEAST [@Drummond:2012cs] or GiRaF [@Nagarajan:2011je]. It is also my desire to have a continually-updated monitoring system, similar to NextFlu [@Neher:2015jr], to continually detect newly-sequenced reassortant viruses as they show up. At the moment, the Influenza Research Database team, led by Prof. Richard Schuermann at the JCVI, is considering incorporating the reassortment detection code as part of their data platform.

### Automation

The code, as it stands right now, was designed for execution on a Sun Grid Engine compute cluster. This design enabled manual parallelism wherever the code was embarrassingly parallel, in a map-reduce paradigm. For example, one key step is the creation of a multiple sequence alignment for each influenza A virus segment. Because the the alignment of one segment is not dependent on the alignment of another segment, they could be aligned in parallel, with the alignment of longer segments taking longer than the alignment of shorter segments. However, a few steps after that, there is a "reduction" step that is dependent on having all 8 evolutionary distance matrices computed fully, and this was one example of a step that was not automated because of (1) a lack of expertise in parallel computation and (2) the nature of the SGE scheduling system not being accessible from an external API.

With the development of Python-based software schedulers (e.g. Dask [@Team:2016wk]) enabling automatic execution of complex, arbitrary computation graphs, a rework of the code could be performed to make it executable with a single command from the command line. Dask has the added advantage of being able to scale from single cores to cloud infrastructure, though at the moment SGE clusters are not supported.

## Scientific

### Homologous Reassortment

Detection of reassortment between genotypically similar (but non-identical) viruses, which we might want to call "homologous reassortment", remains an oft-cited challenge for reassortment detection. Reassortment frequency is high and fairly unbiased under neutral fitness conditions [@Marshall:2013kn] (i.e. there is no change in viral protein sequence, but only nucleotide sequence). However, this knowledge also raises the question about the utility of knowing how much homologous reassortment happens - if there are minimal (or no) fitness differences, then is homologous reassortment consequential for the evolution of a virus? My own answer, based on intuition, is that homologous reassortment likely has little impact on the evolution of a virus, and that the surveillance community would be better concerned with heterologous reassortment.

### Probabilistic Identification of Reassortant Viruses

The algorithm, as it stands right now, only provides a deterministic identification of the parental sources, based on the evolutionary distance computed by Clustal Omega [@Sievers:2011fn]. I define this as "deterministic" because only the viruses that (when taken together) give the highest summed PWI, will be chosen as parental viruses.

A logical next step would be to extend the algorithm 
