#
# StableCategoriesForCap: Gap packge for constructing stable category of a given Cap category
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "StableCategoriesForCap" );

TestDirectory(DirectoriesPackageLibrary( "StableCategoriesForCap", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
