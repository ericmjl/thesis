SHELL = /bin/sh

FIGURES = ./figures

all: index.html thesis.md thesis.pdf commit

thesis.md: text/*.md concatenate.py
	python concatenate.py

index.html: thesis.md default.html styles.css pnas.csl header.html
	pandoc thesis.md \
	    -o index.html \
	    --template=default.html \
	    -c styles.css \
	    --csl pnas.csl \
	    --mathjax \
	    --filter pandoc-fignos \
	    --filter pandoc-citeproc \
	    --filter include.py \
	    --bibliography papers-library.bib \
	    --toc \
	    -H header.html

$FIGURES/%.jpg: $FIGURES/%.pdf
	convert -density 300 $< -quality 100 $@

thesis.pdf: thesis.md default.latex pnas.csl papers-library.bib
	pandoc thesis.md \
	    --template=default.latex \
	    --latex-engine=xelatex \
	    --filter pandoc-fignos \
	    --csl pnas.csl \
	    --filter pandoc-citeproc \
	    --bibliography papers-library.bib \
	    --toc \
	    -o thesis.pdf

commit: index.html thesis.md
	git add .
	git commit -m "autocommit"
	git push
