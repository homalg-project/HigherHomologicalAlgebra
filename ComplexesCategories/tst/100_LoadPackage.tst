# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "ComplexesCategories", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> LoadPackage( "ModulePresentations", false );
true
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> LoadPackage( "LinearAlgebraForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "ComplexesCategories" );
true
gap> LoadPackage( "IO_ForHomalg" );
true
gap> LoadPackage( "ModulePresentations" );
true
gap> LoadPackage( "FreydCategoriesForCAP" );
true
gap> LoadPackage( "LinearAlgebraForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
gap> HOMALG_IO.show_banners := false;;
