# Script to compile thesis text files into a single PDF that is uploaded.

python concatenate.py

# pandoc thesis.md \
#     --template=default.latex \
#     -o thesis.pdf
#
# scp thesis.pdf doroot:/var/www/html/cv/.

pandoc thesis.md \
    -o index.html \
    --template=default.html \
    -c styles.css \
    --filter pandoc-fignos \
    --filter pandoc-citeproc \
    --bibliography ../references-master/papers-library.bib \
    -H header.html

git add .
git commit
git push
