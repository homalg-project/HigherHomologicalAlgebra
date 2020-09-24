#
# StableCategoriesForCap: Gap packge for constructing stable category of a given Cap category
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "StableCategories" );
LoadPackage( "ModulePresentations" );
LoadPackage( "RingsForHomalg" );

TestDirectory( DirectoriesPackageLibrary( "StableCategories", "tst" ),
  rec(exitGAP := true, testOptions := rec(compareFunction := "uptowhitespace") )
);

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
