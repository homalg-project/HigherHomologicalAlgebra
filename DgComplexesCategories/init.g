# SPDX-License-Identifier: GPL-2.0-or-later
#
# Reading the declaration part of the package.
#

ReadPackage( "DgComplexesCategories", "gap/Categories.gd" );
ReadPackage( "DgComplexesCategories", "gap/Complexes.gd" );
ReadPackage( "DgComplexesCategories", "gap/ChainMaps.gd" );
ReadPackage( "DgComplexesCategories", "gap/HomStructure.gd" );

if IsPackageMarkedForLoading( "Algebroids", ">= 2022.09.23" ) then
    ReadPackage( "DgComplexesCategories", "gap/DgComplexesOfAdditiveClosureOfAlgebroid.gd" );
fi;

