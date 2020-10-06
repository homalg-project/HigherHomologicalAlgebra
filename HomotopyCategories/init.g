# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Reading the declaration part of the package.
#

ReadPackage( "HomotopyCategories", "gap/HomotopyCategories.gd");
ReadPackage( "HomotopyCategories", "gap/HomotopyCategoryObjects.gd");
ReadPackage( "HomotopyCategories", "gap/HomotopyCategoryMorphisms.gd");
ReadPackage( "HomotopyCategories", "gap/Functors.gd" );
ReadPackage( "HomotopyCategories", "gap/Convolution.gd" );
ReadPackage( "HomotopyCategories", "gap/ImportedMethods.gd" );


if IsPackageMarkedForLoading( "Algebroids", ">= 2020.04.25" ) then
    ReadPackage( "HomotopyCategories", "gap/Algebroids.gd" );
fi;

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "HomotopyCategories", "gap/Julia.gd" );
fi;
