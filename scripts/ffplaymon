#!/bin/bash
until ./ffplay.sh; do
    echo "Stream crashed with exit code $?.  Respawning.." >&2
    
    
    sleep 2    
    
done
