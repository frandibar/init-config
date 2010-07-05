#!/bin/bash

# Use this script to fix seeking avi files recorded from canon cameras.
# Requires avidemux.
# i.e.
# MVI_0001.AVI
# $ fix-avi.sh 0001
# Converts MVI_0001.AVI to MVI_0001f.AVI where the 'f' stands for fixed
# and deletes the former file..

set -x
avidemux MVI_"$1".AVI --save MVI_"$1"f.AVI 1>/dev/null 2>/dev/null
del MVI_"$1".AVI
