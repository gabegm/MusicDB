#!/bin/sh

set -x

source ~/pyenvs/music/bin/activate

rm -f data/interim/*

sleep 5

python src/main.py &&

sleep 15 &

cp data/raw/*.txt data/interim/ &

wait