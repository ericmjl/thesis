# Script to compile thesis text files into a single PDF that is uploaded.

python concatenate.py

# Copy over PNAS stylesheet

cp ../styles/pnas.csl .

# pandoc thesis.md \
#     --template=default.latex \
#     -o thesis.pdf
#
# scp thesis.pdf doroot:/var/www/html/cv/.

convert -density 300 figures/packaging.pdf -quality 100 figures/packaging.jpg

pandoc thesis.md \
    -o index.html \
    --template=default.html \
    -c styles.css \
    --csl pnas.csl \
    --filter pandoc-fignos \
    --filter pandoc-citeproc \
    --filter include.py \
    --bibliography ../references-master/papers-library.bib \
    --toc \
    -H header.html

git add .
git commit
git push
