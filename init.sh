#!/bin/sh

source ~/pyenvs/music/bin/activate

rm data/interim/*

python src/main.py &&

sleep 15 &

cp data/raw/*.txt data/interim/

wait