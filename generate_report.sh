#!/bin/bash

### Basic if statement (if this is true then do this and if not true dont do that)
if [ "$#" -ne 2 ]; then ### if there is no input then print in line 2...
	echo "usage: $0 <input.md> <output.pdf>" ### prints out input for md filename and pdf filename.
	exit
fi 

# if this machine does not have the template in place, put it there!
if [ ! -e /usr/share/pandoc/data/templates/eisvogel.latex ]
then
	sudo cp eisvogel.latex /usr/share/pandoc/data/templates/
fi

pandoc $1 -o $2 \
--from markdown+yaml_metadata_block+raw_html \
--template eisvogel \
--table-of-contents \
--toc-depth 6 \
--number-sections \
--top-level-division=chapter \
--highlight-style tango

if [ $? -eq 0 ]
then
	evince $2
fi
