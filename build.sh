# Convert all CSV tables to Markdown
cd tables
for file in *.csv;
do
    csvtomd $file > ${file%%.*}.md;
done
cd ..

# Script to compile thesis text files into a single PDF that is uploaded.
python concatenate.py

# Copy over PNAS stylesheet
cp ../styles/pnas.csl .

# Copy over references-master
cp ../references-master/papers-library.bib .

# pandoc thesis.md \
#     --template=default.latex \
#     -o thesis.pdf
#
# scp thesis.pdf doroot:/var/www/html/cv/.

# Convert PDF images to JPG.
cd figures
for file in *.pdf;
do
    convert -density 300 $file -quality 100 ${file%%.*}.jpg;
done
cd ..

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

# Commit to repository.
git add .
git commit
git push
