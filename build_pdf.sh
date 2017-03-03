pandoc thesis.md \
    --template=default.latex \
    --latex-engine=xelatex \
    --filter pandoc-fignos \
    --csl pnas.csl \
    --filter pandoc-citeproc \
    --bibliography papers-library.bib \
    --toc \
    -o thesis.pdf
#
scp thesis.pdf doroot:/var/www/html/cv/.


