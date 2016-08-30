#!/bin/bash

cd /opt/trinitycore/data
time ../bin/mapextractor || exit 1
time ../bin/vmap4extractor || exit 1
mkdir vmaps
time ../bin/vmap4assembler Buildings vmaps || exit 1
mkdir mmaps
time ../bin/mmaps_generator --threads `nproc`

