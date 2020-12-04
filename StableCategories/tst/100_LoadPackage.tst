# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "StableCategories", false );
true
gap> LoadPackage( "ModulePresentations", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "StableCategories" );
true
gap> LoadPackage( "ModulePresentations" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
