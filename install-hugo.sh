#!/bin/bash

HUGO_VERSION="0.146.0"

# Download and extract Hugo
curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz

# Move Hugo binary to a folder we can reference
mkdir -p .bin
mv hugo .bin/hugo
