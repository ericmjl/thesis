# Script to compile thesis text files into a single PDF that is uploaded.
python concatenate.py

# Commit to repository.
git add text/*
git commit -m "auto commit raw text"
git push
