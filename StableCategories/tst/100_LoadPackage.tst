# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
#?gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "GradedModules", false );
true
gap> LoadPackage( "ModulePresentations", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> LoadPackage( "FinSetsForCAP", false );
true
gap> LoadPackage( "QPA", false );
true
gap> LoadPackage( "Algebroids", false );
true
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> LoadPackage( "FunctorCategories", false );
true
gap> LoadPackage( "StableCategories", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "GradedModules" );
true
gap> LoadPackage( "ModulePresentations" );
true
gap> LoadPackage( "IO_ForHomalg" );
true
gap> LoadPackage( "FinSetsForCAP" );
true
gap> LoadPackage( "QPA" );
true
gap> LoadPackage( "Algebroids" );
true
gap> LoadPackage( "FreydCategoriesForCAP" );
true
gap> LoadPackage( "FunctorCategories" );
true
gap> LoadPackage( "StableCategories" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
gap> HOMALG_IO.show_banners := false;;
