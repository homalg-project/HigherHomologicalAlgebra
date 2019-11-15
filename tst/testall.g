#
# CddInterface: Gap interface to Cdd package
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "ComplexesForCAP" );
LoadPackage( "LinearAlgebraForCAP" );
LoadPackage( "ModulePresentations" );
LoadPackage( "RingsForHomalg" );
LoadPackage( "GaussForHomalg" );

R := HomalgFieldOfRationalsInSingular( )* "x,y,z";;

dirs := DirectoriesPackageLibrary( "ComplexesForCAP", "tst" );
TestDirectory( dirs, rec( exitGAP := true, testOptions:= rec(compareFunction:="uptowhitespace" )) );
FORCE_QUIT_GAP(1);
