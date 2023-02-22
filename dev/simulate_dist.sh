#!/bin/bash

set -e

# BBGG
echo "Simulate release of BBGG"
./dev/release-gap-package --srcdir "$PWD/BBGG" --webdir "$PWD/gh-pages/BBGG" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# Bicomplexes
echo "Simulate release of Bicomplexes"
./dev/release-gap-package --srcdir "$PWD/Bicomplexes" --webdir "$PWD/gh-pages/Bicomplexes" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ComplexesCategories
echo "Simulate release of ComplexesCategories"
./dev/release-gap-package --srcdir "$PWD/ComplexesCategories" --webdir "$PWD/gh-pages/ComplexesCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# DerivedCategories
echo "Simulate release of DerivedCategories"
./dev/release-gap-package --srcdir "$PWD/DerivedCategories" --webdir "$PWD/gh-pages/DerivedCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# HomotopyCategories
echo "Simulate release of HomotopyCategories"
./dev/release-gap-package --srcdir "$PWD/HomotopyCategories" --webdir "$PWD/gh-pages/HomotopyCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# QuotientCategories
echo "Simulate release of QuotientCategories"
./dev/release-gap-package --srcdir "$PWD/QuotientCategories" --webdir "$PWD/gh-pages/QuotientCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# StableCategories
echo "Simulate release of StableCategories"
./dev/release-gap-package --srcdir "$PWD/StableCategories" --webdir "$PWD/gh-pages/StableCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ToolsForHigherHomologicalAlgebra
echo "Simulate release of ToolsForHigherHomologicalAlgebra"
./dev/release-gap-package --srcdir "$PWD/ToolsForHigherHomologicalAlgebra" --webdir "$PWD/gh-pages/ToolsForHigherHomologicalAlgebra" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# TriangulatedCategories
echo "Simulate release of TriangulatedCategories"
./dev/release-gap-package --srcdir "$PWD/TriangulatedCategories" --webdir "$PWD/gh-pages/TriangulatedCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""
