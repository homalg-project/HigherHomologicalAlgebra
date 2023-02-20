# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "ModulePresentations", false );
true
gap> LoadPackage( "Bicomplexes", false );
true
gap> LoadPackage( "Algebroids", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "ModulePresentations" );
true
gap> LoadPackage( "Bicomplexes" );
true
gap> LoadPackage( "Algebroids" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
