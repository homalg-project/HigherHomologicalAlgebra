#!/bin/bash

rsync -a --exclude=.git . saleh@plesken.mathematik.uni-siegen.de:/home/saleh/ssd-folder/local_gap_packages/pkg/Bicomplexes
