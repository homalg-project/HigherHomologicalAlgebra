# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> LoadPackage( "ToolsForHigherHomologicalAlgebra", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "FreydCategoriesForCAP" );
true
gap> LoadPackage( "ToolsForHigherHomologicalAlgebra" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
