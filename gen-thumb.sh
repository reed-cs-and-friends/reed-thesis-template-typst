#!/usr/bin/env sh

typst compile -f png --pages 1 --ppi 250 template/main.typ thumb.png
oxipng -o 4 --strip safe thumb.png
