SHELL = /bin/sh

FIGURES = ./figures

TABLES = ./tables

TEXT = ./text

all: figures/*.jpg tables/*md thesis.md index.html thesis.pdf

thesis.md: text/*.md concatenate.py Makefile
	python concatenate.py

index.html: thesis.md default.html styles.css pnas.csl header.html ../styles/pnas.csl ../references-master/papers-library.bib Makefile
	cp ../styles/pnas.csl .

	cp ../references-master/papers-library.bib .

	pandoc thesis.md \
	    -o index.html \
	    --template=default.html \
	    -c styles.css \
	    --csl pnas.csl \
	    --mathjax \
	    --filter pandoc-fignos \
		--filter pandoc-tablenos \
	    --filter pandoc-citeproc \
	    --filter include.py \
	    --bibliography papers-library.bib \
	    --toc \
	    -H header.html

$FIGURES/%.jpg: $FIGURES/%.pdf Makefile
	convert -density 300 $< -quality 100 $@

$TABLES/%.md: $TABLES/%.csv Makefile
	csvtomd $< > $@.md

thesis.pdf: thesis.md default.latex pnas.csl papers-library.bib Makefile
	pandoc thesis.md \
	    --template=default.latex \
	    --latex-engine=xelatex \
	    --filter pandoc-fignos \
		--filter pandoc-tablenos \
	    --csl pnas.csl \
	    --filter pandoc-citeproc \
	    --bibliography papers-library.bib \
	    --toc \
	    -o thesis.pdf
	scp thesis.pdf doroot:/var/www/html/cv/.


commit: index.html thesis.md
	git add .
	git commit -m "autocommit"
	git push
