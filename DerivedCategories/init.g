# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Reading the declaration part of the package.
#

ReadPackage( "DerivedCategories", "gap/DerivedCategories.gd" );
ReadPackage( "DerivedCategories", "gap/Objects.gd" );
ReadPackage( "DerivedCategories", "gap/Morphisms.gd");
ReadPackage( "DerivedCategories", "gap/Functors.gd");

if IsPackageMarkedForLoading( "FunctorCategories", ">= 2022.09.23" ) then
  ReadPackage( "DerivedCategories", "gap/OnlyWithFunctorCategories.gd");
fi;

