cat \
    title.md \
    introduction.md \
    algorithm.md \
    applications.md \
    future-work.md \
    appendices.md \
> thesis.md

pandoc thesis.md \
    --template=default.latex \
    -o thesis.pdf
