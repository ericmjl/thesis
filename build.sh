python build.py

pandoc thesis.md \
    --template=default.latex \
    -o thesis.pdf

open thesis.pdf
