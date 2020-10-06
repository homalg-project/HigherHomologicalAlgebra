# SPDX-License-Identifier: GPL-2.0-or-later
# BBGG: Beilinson monads and derived categories for coherent sheaves over P^n
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "BBGG", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "BBGG" );
true
gap> LoadPackage( "IO_ForHomalg" );
true
gap> LoadPackage( "FreydCategoriesForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
gap> HOMALG_IO.show_banners := false;;
