#!/usr/bin/env bash
#
# Generate a graphical representation of the current repository's history graph
# in .dot and .png formats.
#
# Usage:
#   cd ./merge
#   ../generate-graph.sh
#   <open graph.png in your image viewer of choice>
#
# Adapted from https://gist.github.com/brwyatt/ea54cd0310e24785e898
#

echo 'digraph "git" {' > graph.dot
git log --pretty='format: %h [label="%h\n%s" shape=box]' | perl -p -e 's/([0-9a-f]{7})/"\1"/' >> graph.dot
git log --pretty='format: %h -> { %p }' | perl -p -e 's/([0-9a-f]{7})/"\1"/g' >> graph.dot
echo '}' >> graph.dot
dot -Tpng graph.dot -o graph.png
