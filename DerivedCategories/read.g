# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Reading the implementation part of the package.
#
ReadPackage( "DerivedCategories", "gap/DerivedCategories.gi");
ReadPackage( "DerivedCategories", "gap/ExceptionalCollection.gi" );
ReadPackage( "DerivedCategories", "gap/QPA.gi" );
ReadPackage( "DerivedCategories", "gap/OtherQPATweaks.gi" );
ReadPackage( "DerivedCategories", "gap/Decomposition.gi" );
ReadPackage( "DerivedCategories", "gap/Convenience.gi" );
ReadPackage( "DerivedCategories", "gap/Functors.gi" );
ReadPackage( "DerivedCategories", "gap/Hom.gi" );
ReadPackage( "DerivedCategories", "gap/Tensor.gi" );
ReadPackage( "DerivedCategories", "gap/NaturalTransformations.gi" );
ReadPackage( "DerivedCategories", "gap/BoxProduct.gi" );
ReadPackage( "DerivedCategories", "gap/ImportedMethods.gi" );
ReadPackage( "DerivedCategories", "gap/TempMethods.gi" );
ReadPackage( "DerivedCategories", "gap/ExceptionalReplacement.gi" );
ReadPackage( "DerivedCategories", "gap/CohrerntScheavesOverProjectiveSpace.gi" );
ReadPackage( "DerivedCategories", "gap/ProductOfProjectiveSpaces.gi" );
ReadPackage( "DerivedCategories", "gap/ToolsForHomalg.gi" );
ReadPackage( "DerivedCategories", "gap/ToolsForFreydCategories.gi" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "DerivedCategories", "gap/Julia.gi" );
fi;
