# SPDX-License-Identifier: GPL-2.0-or-later
#
# Reading the implementation part of the package.
#

ReadPackage( "DgComplexesCategories", "gap/Categories.gi" );
ReadPackage( "DgComplexesCategories", "gap/Complexes.gi" );
ReadPackage( "DgComplexesCategories", "gap/ChainMaps.gi" );
ReadPackage( "DgComplexesCategories", "gap/HomStructure.gi" );

if IsPackageMarkedForLoading( "Algebroids", ">= 2022.09.23" ) then
    ReadPackage( "DgComplexesCategories", "gap/precompiled_categories/CategoryOfDgComplexesOfAdditiveClosureOfAlgebroidPrecompiled.gi" );
    ReadPackage( "DgComplexesCategories", "gap/DgComplexesOfAdditiveClosureOfAlgebroid.gi" );
    ReadPackage( "DgComplexesCategories", "gap/DesignDgComplexesCategory.gi" );
fi;
