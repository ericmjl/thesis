# Copy over PNAS stylesheet
cp ../styles/pnas.csl .

# Copy over references-master
cp ../references-master/papers-library.bib .

# Build tables
bash build_tables.sh

# Build text
bash build_text.sh

# Convert Markdown to HTML
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

# # Commit to repository.
# git add .
# git commit
# git push
