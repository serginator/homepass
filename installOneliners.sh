#!/bin/bash
cp .3ds-oneliners ~
echo "
if [ -f ~/.3ds-oneliners ]; then
    . .3ds-oneliners
fi" | tee --append ~/.bashrc >/dev/null
. .3ds-oneliners
