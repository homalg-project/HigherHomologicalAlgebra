#!/bin/bash

set -e

# Bicomplexes
echo "Simulate release of Bicomplexes"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/Bicomplexes" --webdir "$PWD/gh-pages/Bicomplexes" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ComplexesCategories
echo "Simulate release of ComplexesCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/ComplexesCategories" --webdir "$PWD/gh-pages/ComplexesCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# DerivedCategories
echo "Simulate release of DerivedCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/DerivedCategories" --webdir "$PWD/gh-pages/DerivedCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# HomotopyCategories
echo "Simulate release of HomotopyCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/HomotopyCategories" --webdir "$PWD/gh-pages/HomotopyCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# StableCategories
echo "Simulate release of StableCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/StableCategories" --webdir "$PWD/gh-pages/StableCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ToolsForHigherHomologicalAlgebra
echo "Simulate release of ToolsForHigherHomologicalAlgebra"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/ToolsForHigherHomologicalAlgebra" --webdir "$PWD/gh-pages/ToolsForHigherHomologicalAlgebra" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# TriangulatedCategories
echo "Simulate release of TriangulatedCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --srcdir "$PWD/TriangulatedCategories" --webdir "$PWD/gh-pages/TriangulatedCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""
