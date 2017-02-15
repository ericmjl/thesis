# Convert PDF images to JPG.
cd figures
for file in *.pdf;
do
    convert -density 300 $file -quality 100 ${file%%.*}.jpg;
done
cd ..

# Commit to repository.
git add figures/*
git commit -m "auto commit figures"
git push
