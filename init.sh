#!/bin/sh

set -x

#python3 -m venv ~/pyenvs/music

source ~/pyenvs/music/bin/activate

#pip install -r requirements.txt

rm -f data/interim/*

sleep 5

python src/main.py &&

sleep 15 &

cp data/raw/*.txt data/interim/ &

wait