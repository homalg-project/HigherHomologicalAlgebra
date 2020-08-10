#
# DerivedCategories: Gap package to create derived categories
#
# Reading the declaration part of the package.
#

ReadPackage( "DerivedCategories", "gap/DerivedCategories.gd");
ReadPackage( "DerivedCategories", "gap/ExceptionalCollection.gd" );
ReadPackage( "DerivedCategories", "gap/QPA.gd" );
ReadPackage( "DerivedCategories", "gap/Decomposition.gd" );
ReadPackage( "DerivedCategories", "gap/Convenience.gd" );
ReadPackage( "DerivedCategories", "gap/Functors.gd" );
ReadPackage( "DerivedCategories", "gap/Hom.gd" );
ReadPackage( "DerivedCategories", "gap/Tensor.gd" );
ReadPackage( "DerivedCategories", "gap/NaturalTransformations.gd" );
ReadPackage( "DerivedCategories", "gap/BoxProduct.gd" );
ReadPackage( "DerivedCategories", "gap/ExceptionalReplacement.gd" );
ReadPackage( "DerivedCategories", "gap/CohrerntScheavesOverProjectiveSpace.gd" );
ReadPackage( "DerivedCategories", "gap/ProductOfProjectiveSpaces.gd" );
ReadPackage( "DerivedCategories", "gap/ToolsForHomalg.gd" );
ReadPackage( "DerivedCategories", "gap/ToolsForFreydCategories.gd" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "DerivedCategories", "gap/Julia.gd" );
fi;
