#! /bin/bash
rsync -rv --exclude '.*' --exclude brewoahu --exclude 'user_*' --exclude sync.sh . paul@results2018.brewoahu.com:/usr/local/brewoahu
