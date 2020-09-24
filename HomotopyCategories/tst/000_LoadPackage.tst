#
# HomotopyCategories: Homotopy categories of additive categories
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "HomotopyCategories", false );
true
gap> LoadPackage( "ModulePresentations", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "HomotopyCategories" );
true
gap> LoadPackage( "ModulePresentations" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
