#
# HomotopyCategories: Package to create homotopy categories of an additive category
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "HomotopyCategories" );
LoadPackage( "ModulePresentations" );

TestDirectory(DirectoriesPackageLibrary( "HomotopyCategories", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
