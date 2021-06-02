#!/bin/bash

set -e

rm -rf build
mkdir -p build

sed -e "s|usetheme\[.*\]|usetheme\[bannertitle,blue\]|g" main.tex > build/build-bannertitle-blue.tex
sed -e "s|usetheme\[.*\]|usetheme\[bannertitle,red\]|g" main.tex  > build/build-bannertitle-red.tex
sed -e "s|usetheme\[.*\]|usetheme\[blue\]|g" main.tex             > build/build-blue.tex
sed -e "s|usetheme\[.*\]|usetheme\[red\]|g" main.tex              > build/build-red.tex

latexmk $@ -outdir=build build/build-*.tex
