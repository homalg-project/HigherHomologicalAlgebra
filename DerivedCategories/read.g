# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Reading the implementation part of the package.
#
ReadPackage( "DerivedCategories", "gap/DerivedCategories.gi" );
ReadPackage( "DerivedCategories", "gap/Objects.gi" );
ReadPackage( "DerivedCategories", "gap/Morphisms.gi");
ReadPackage( "DerivedCategories", "gap/Functors.gi");

if IsPackageMarkedForLoading( "FunctorCategories", ">= 2022.09.23" ) then
  ReadPackage( "DerivedCategories", "gap/OnlyWithFunctorCategories.gi");
fi;
