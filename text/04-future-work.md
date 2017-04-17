\newpage

# Remaining Challenges & Future Work

## Scientific

### Quantification of Ecological Niche Differences

Ecological niches are defined as being the set of activities that help an organism survive and reproduce, and is influenced by abiotic (e.g. temperature, sunlight) and biotic factors (presence or absence of predators). Biotic factors are traditionally described in qualitative or categorical terms: predation (X eats Y) and symbiosis (A helps B which also helps A) being the two most common categories, in addition to parasitism, neutral interactions, and more. As a global population, the influenza A virus lives essentially in a parasitic relationship with its hosts (as far as we can observe), and one idea put forth in the global reticulate evolutionary study was the idea of quantitative niche differences, as quantified by host evolutionary distance.

I recognize that cytochrome oxidase I sequence is a crude approximation of virus host differences; mechanistically speaking, it is more likely that quantitative differences in the immune system repertoire between each hosts would play a greater functional role in viral fitness. As an example, one might opt to sequence the B-cell receptor (BCR) repertoire of two viral hosts, and pass their sequences through a dimensionality reduction algorithm (e.g. multi-dimensional scaling, variational autoencoders), and use that lower-dimension representation as a way of quantifying differences in the immune system of a variety of hosts.

### Observation of Viral Subtypes

With 16 canonical hemagglutinin and 9 neuraminidase subtypes identified, there are theoretically 144 possible influenza subtypes that can form. Of them, we have observed (in the sequence dataset) about only $\frac{2}{3}$ of them (+@fig:circos). One may wonder, then, why we have not observed all 144 of them yet? Can we forecast which subtypes (or reassortant viruses) could be detected next?

![Circos panel depicting the connectivity of a particular HA & NA subtype combination with other subtypes. Within each circos plot, subtypes are ordered from the 12 o’clock position in increasing connectivity, starting with the lowest-ranked at 12 o’clock and increasing clockwise.  The highest-connected subtype, H3N8, is found just before the 12 o’clock position. Mx: “mixed subtype”.](./figures/circos.jpg){#fig:circos width=75% height=75%}

A naive statistical model of new subtype emergence would assume that reassortment between subtypes happens only by chance, and that us not having observed all subtypes would merely be a function of time. This would assume that new subtype emergence is essentially unpredictable.

Another more sophisticated statistical model of new subtype emergence would take greater advantage of the observation that certain subtypes of virus are more heavily associated with particular viral hosts. Because viruses have a very strong reliance on hosts for movement, it would make sense that where hosts overlap geographically, and even interact at a "host ecological niche" level, there would be a greater probability of viral subtypes associated with those host pairs to reassort, and hence produce new viral subtypes.

### Denser Sampling

As things stand right now, we do not detect whether a reassortment event happens prior to or after the host switch event. This caveat was addressed in Application 1, where we argued that it did not matter whether reassortment was helpful prior to or after host switching, as . In theory, denser sampling is required to be able to identify whether a reassortment event happened prior to or after a host switch event. Single viral particle sequencing from a viral host would be a very enabling technology here, and if paired with denser sampling, would open the doors to quantifying the relative viral load in a mixed infection, including reassortant viruses that emerge from the coinfection.

### Homologous Reassortment

Detection of reassortment between genotypically similar (but non-identical) viruses, which we might want to call "homologous reassortment", remains an oft-cited challenge for reassortment detection. Reassortment frequency is high and fairly unbiased under neutral fitness conditions [@Marshall:2013kn] (i.e. there is no change in viral protein sequence, but only nucleotide sequence). However, this knowledge also raises the question about the utility of knowing how much homologous reassortment happens - if there are minimal (or no) fitness differences, then is homologous reassortment consequential for the evolution of a virus? My own answer, based on intuition, is that homologous reassortment likely has little impact on the evolution of a virus, and that the surveillance community would be better concerned with heterologous reassortment.

### Probabilistic Identification of Reassortant Viruses

The algorithm, as it stands right now, only provides a deterministic identification of the parental sources, based on the evolutionary distance computed by Clustal Omega [@Sievers:2011fn]. I define this as "deterministic" because only the viruses that (when taken together) give the highest summed PWI, will be chosen as parental viruses.

A logical next step would be to extend the algorithm to identify not merely the parental sources that are of highest PWI, but to also assign a likelihood score to the parental source, given the evolutionary distance. The simplest thing that could be attempted is to use the summed PWI as a probability metric itself, as follows:

$$ \frac{\sum\limits_{k=1}^S p_{k}}{S} $$

where $p$ is the PWI for any given segment, and $S$ is the number of segments. To retrieve a probability score for any given PWI, one would then apply a 'softmax' normalization across all valid parental combinations, thus normalizing the probability scores to sum to 1. No doubt this still requires the assumption of the algorithm being a phylogenetic heuristic, rather than an attempt at ground truth reconstruction.

## Engineering

### Deployment

Algorithms developed in the academic world often require "just some engineering" to be made ready for deployment to the real-world. It remains on my personal wish-list to have turned this reassortment detection algorithm into a standalone software package, similar to BEAST [@Drummond:2012cs] or GiRaF [@Nagarajan:2011je]. It is also my desire to have a continually-updated monitoring system, similar to NextFlu [@Neher:2015jr], to continually detect newly-sequenced reassortant viruses as they show up. These goals were hampered by my personal lack of software engineering training, and as such I never got around to doing a proper refactoring of the code into reusable modules. Thankfully, at the moment, the Influenza Research Database team, led by Prof. Richard Schuermann at the JCVI, is considering incorporating the reassortment detection code as part of their data platform, and I would like to thank them for their interest.

### Automation

The code, as it stands right now, was designed for execution on a Sun Grid Engine (SGE) compute cluster. This design enabled manual parallelism wherever the code was embarrassingly parallel, in a map-reduce paradigm. For example, one key step is the creation of a multiple sequence alignment for each influenza A virus segment. Because the the alignment of one segment is not dependent on the alignment of another segment, they could be aligned in parallel, with the alignment of longer segments taking longer than the alignment of shorter segments. However, a few steps after that, there is a "reduction" step that is dependent on having all 8 evolutionary distance matrices computed fully, and this was one example of a step that was not automated because of (1) a lack of expertise in parallel computation and (2) the nature of the SGE scheduling system not being accessible from an external API.

With the development of Python-based software schedulers (e.g. Dask [@Team:2016wk]) enabling automatic execution of complex, arbitrary computation graphs, a rework of the code could be performed to make it executable with a single command from the command line. Dask has the added advantage of being able to scale from single cores to cloud infrastructure, though at the moment SGE clusters are not supported.
