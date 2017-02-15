watchmedo shell-command --patterns="*.pdf" \
    --command="bash build_figures.sh" \
    figures/. &

watchmedo shell-command --patterns="*.md" \
    --command="bash build_text.sh" \
    text/. &

watchmedo shell-command --patterns="*.csv" \
    --command="bash build_tables.sh" \
    tables/. &
