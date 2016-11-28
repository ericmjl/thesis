"""
Author: Eric J. Ma
Purpose: A script to concatenate my thesis chapters together into a single
         file. The key point here is that it adds a 'newline' character between
         documents, something that the bash `cat` command doesn't do.
"""

import os

os.chdir('./text/')

order = os.listdir()

thesis = ''
for text in order:
    with open(text, 'r+') as f:
        thesis += f.read()
        thesis += "\n"

with open('../thesis.md', 'w+') as f:
    f.write(thesis)
