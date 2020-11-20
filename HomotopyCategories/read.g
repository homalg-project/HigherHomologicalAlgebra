# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Reading the implementation part of the package.
#

ReadPackage( "HomotopyCategories", "gap/TriangulatedStructure.gi" );
ReadPackage( "HomotopyCategories", "gap/CAP_TOOLS.gi" );
ReadPackage( "HomotopyCategories", "gap/HomotopyCategories.gi" );
ReadPackage( "HomotopyCategories", "gap/HomStructure.gi" );
ReadPackage( "HomotopyCategories", "gap/Functors.gi" );
ReadPackage( "HomotopyCategories", "gap/HomotopyCategoryObjects.gi" );
ReadPackage( "HomotopyCategories", "gap/HomotopyCategoryMorphisms.gi" );
ReadPackage( "HomotopyCategories", "gap/DerivedMethods.gi" );
ReadPackage( "HomotopyCategories", "gap/Convolution.gi" );
ReadPackage( "HomotopyCategories", "gap/ImportedMethods.gi" );
ReadPackage( "HomotopyCategories", "gap/RandomMethods.gi" );

if IsPackageMarkedForLoading( "Algebroids", ">= 2020.04.25" ) then
    ReadPackage( "HomotopyCategories", "gap/Algebroids.gi" );
fi;

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "HomotopyCategories", "gap/Julia.gi" );
fi;
