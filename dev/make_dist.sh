#!/bin/bash

set -e

# BBGG
echo "Release BBGG"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/BBGG" --webdir "$PWD/gh-pages/BBGG" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# Bicomplexes
echo "Release Bicomplexes"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/Bicomplexes" --webdir "$PWD/gh-pages/Bicomplexes" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ComplexesCategories
echo "Release ComplexesCategories"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ComplexesCategories" --webdir "$PWD/gh-pages/ComplexesCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# DerivedCategories
echo "Release DerivedCategories"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/DerivedCategories" --webdir "$PWD/gh-pages/DerivedCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# HomotopyCategories
echo "Release HomotopyCategories"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/HomotopyCategories" --webdir "$PWD/gh-pages/HomotopyCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# QuotientCategories
echo "Release QuotientCategories"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/QuotientCategories" --webdir "$PWD/gh-pages/QuotientCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# StableCategories
echo "Release StableCategories"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/StableCategories" --webdir "$PWD/gh-pages/StableCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ToolsForHigherHomologicalAlgebra
echo "Release ToolsForHigherHomologicalAlgebra"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ToolsForHigherHomologicalAlgebra" --webdir "$PWD/gh-pages/ToolsForHigherHomologicalAlgebra" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# TriangulatedCategories
echo "Release TriangulatedCategories"
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/TriangulatedCategories" --webdir "$PWD/gh-pages/TriangulatedCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""
