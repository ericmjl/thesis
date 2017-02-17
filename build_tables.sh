# Convert all CSV tables to Markdown
cd tables
for file in *.csv;
do
    csvtomd $file > ${file%%.*}.md;
done
cd ..
