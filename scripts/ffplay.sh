#!/bin/bash

ffplay -loglevel repeat+level+verbose -i 'srt://localhost:3000?mode=listener' -fflags nobuffer 

echo "Waiting for SRT stream on localhost:3000..."

