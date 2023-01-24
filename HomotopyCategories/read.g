# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Reading the implementation part of the package.
#

ReadPackage( "HomotopyCategories", "gap/Categories.gi" );
ReadPackage( "HomotopyCategories", "gap/Objects.gi" );
ReadPackage( "HomotopyCategories", "gap/Morphisms.gi" );
ReadPackage( "HomotopyCategories", "gap/HomStructure.gi" );
ReadPackage( "HomotopyCategories", "gap/TriangulatedStructure.gi" );
ReadPackage( "HomotopyCategories", "gap/Convolution.gi" );
ReadPackage( "HomotopyCategories", "gap/StrongExceptionalSequences.gi" );
ReadPackage( "HomotopyCategories", "gap/Functors.gi" );
ReadPackage( "HomotopyCategories", "gap/NaturalTransformations.gi" );

if IsPackageMarkedForLoading( "Algebroids", ">= 2022.11-10" ) then
    ReadPackage( "HomotopyCategories", "gap/OnlyWithAlgebroids.gi" );
fi;

if IsPackageMarkedForLoading( "FunctorCategories", ">= 2022.11-07" ) then
    ReadPackage( "HomotopyCategories", "gap/OnlyWithFunctorCategories.gi" );
fi;

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "HomotopyCategories", "gap/Julia.gi" );
fi;
