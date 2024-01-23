#!/bin/bash

set -e

# Bicomplexes
echo "Release Bicomplexes"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/Bicomplexes" --webdir "$PWD/gh-pages/Bicomplexes" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ComplexesCategories
echo "Release ComplexesCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ComplexesCategories" --webdir "$PWD/gh-pages/ComplexesCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# DerivedCategories
echo "Release DerivedCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/DerivedCategories" --webdir "$PWD/gh-pages/DerivedCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# HomotopyCategories
echo "Release HomotopyCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/HomotopyCategories" --webdir "$PWD/gh-pages/HomotopyCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# StableCategories
echo "Release StableCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/StableCategories" --webdir "$PWD/gh-pages/StableCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ToolsForHigherHomologicalAlgebra
echo "Release ToolsForHigherHomologicalAlgebra"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ToolsForHigherHomologicalAlgebra" --webdir "$PWD/gh-pages/ToolsForHigherHomologicalAlgebra" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# TriangulatedCategories
echo "Release TriangulatedCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/TriangulatedCategories" --webdir "$PWD/gh-pages/TriangulatedCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""
