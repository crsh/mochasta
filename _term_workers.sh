#!/bin/sh

for i in $(seq 62 65); do ssh computer@134.95.17.$i pkill R; done
