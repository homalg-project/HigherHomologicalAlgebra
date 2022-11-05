# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Reading the declaration part of the package.
#

ReadPackage( "DerivedCategories", "gap/DerivedCategories.gd");
ReadPackage( "DerivedCategories", "gap/ExceptionalCollection.gd" );
ReadPackage( "DerivedCategories", "gap/Convenience.gd" );
ReadPackage( "DerivedCategories", "gap/Functors.gd" );
ReadPackage( "DerivedCategories", "gap/Hom.gd" );
ReadPackage( "DerivedCategories", "gap/Tensor.gd" );
ReadPackage( "DerivedCategories", "gap/NaturalTransformations.gd" );
ReadPackage( "DerivedCategories", "gap/ExceptionalReplacement.gd" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "DerivedCategories", "gap/Julia.gd" );
fi;
