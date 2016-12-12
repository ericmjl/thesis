# Script to compile thesis text files into a single PDF that is uploaded.

python build.py

pandoc thesis.md \
    --template=default.latex \
    -o thesis.pdf

pandoc thesis.md \
    -o index.html \
    --template=default.html \
    -H styles.css

scp thesis.pdf doroot:/var/www/html/cv/.
