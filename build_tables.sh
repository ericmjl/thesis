# Convert all CSV tables to Markdown
cd tables
for file in *.csv;
do
    csvtomd $file > ${file%%.*}.md;
done
cd ..

# Commit to repository.
git add .
git commit -m "auto commit raw tables"
git push
