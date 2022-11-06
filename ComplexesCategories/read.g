# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Reading the implementation part of the package.
#

ReadPackage( "ComplexesCategories", "gap/ZFunctions.gi" );
ReadPackage( "ComplexesCategories", "gap/HomStructure.gi" );
ReadPackage( "ComplexesCategories", "gap/Categories.gi" );
ReadPackage( "ComplexesCategories", "gap/Complexes.gi" );
ReadPackage( "ComplexesCategories", "gap/ComplexMorphisms.gi" );
ReadPackage( "ComplexesCategories", "gap/Functors.gi" );
ReadPackage( "ComplexesCategories", "gap/NaturalTransformations.gi" );
ReadPackage( "ComplexesCategories", "gap/Resolutions.gi" );
ReadPackage( "ComplexesCategories", "gap/Tools.gi" );

#if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
#    ReadPackage( "ComplexesCategories", "gap/Julia.gi" );
#fi;
