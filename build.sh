# Script to compile thesis text files into a single PDF that is uploaded.

python build.py

pandoc thesis.md \
    --template=default.latex \
    -o thesis.pdf

scp thesis.pdf doroot:/var/www/html/cv/.
