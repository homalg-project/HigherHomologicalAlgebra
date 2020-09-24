#
# Bicomplexes: Bicomplexes for Abelian categories
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "Bicomplexes" );
LoadPackage( "ModulePresentations" );

options := rec(
    exitGAP := true,
    testOptions := rec(
    
    compareFunction := function( s1, s2 )
                         local new_s2, text_attr, attr;
                         
                         new_s2 := s2;
                         
                         text_attr := RecNames( TextAttr );
                         
                         for attr in text_attr do
                           
                           new_s2 := ReplacedString( new_s2, TextAttr.(attr), "" );
                  
                         od;
                         
                         return TEST.compareFunctions.uptowhitespace( s1, new_s2 );
                         
                        end,
    ),
);
TestDirectory( DirectoriesPackageLibrary( "Bicomplexes", "tst" ), options );

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
