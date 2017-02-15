watchmedo shell-command --patterns="*.pdf" \
    --command="bash build_figs.sh" \
    figures/.


# watchmedo log \
#     --patterns="*.pdf" \
#     # --command="echo changed"\
#     figures/
