#!/bin/bash

set -e

packages="BBGG Bicomplexes ComplexesCategories DerivedCategories HomotopyCategories QuotientCategories StableCategories ToolsForHigherHomologicalAlgebra TriangulatedCategories "

base_dir="$PWD"

for pkg in ${packages}; do
  ./release-gap-package --skip-existing-release --srcdir ${base_dir}/${pkg} --webdir ${base_dir}/gh-pages/${pkg} --update-file ${base_dir}/gh-pages/update.g $@
done
