# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Reading the declaration part of the package.
#

ReadPackage( "HomotopyCategories", "gap/Categories.gd");
ReadPackage( "HomotopyCategories", "gap/Objects.gd");
ReadPackage( "HomotopyCategories", "gap/Morphisms.gd");
ReadPackage( "HomotopyCategories", "gap/HomStructure.gd");
ReadPackage( "HomotopyCategories", "gap/TriangulatedStructure.gd" );
ReadPackage( "HomotopyCategories", "gap/Convolution.gd" );
ReadPackage( "HomotopyCategories", "gap/StrongExceptionalSequences.gd" );
ReadPackage( "HomotopyCategories", "gap/Functors.gd" );
ReadPackage( "HomotopyCategories", "gap/NaturalTransformations.gd" );

if IsPackageMarkedForLoading( "Algebroids", ">= 2022.11-10" ) then
    ReadPackage( "HomotopyCategories", "gap/OnlyWithAlgebroids.gd" );
fi;

if IsPackageMarkedForLoading( "FunctorCategories", ">= 2022.11-07" ) then
    ReadPackage( "HomotopyCategories", "gap/OnlyWithFunctorCategories.gd" );
fi;
