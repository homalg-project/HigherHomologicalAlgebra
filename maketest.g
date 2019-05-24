LoadPackage( "ModulePresentations" );
LoadPackage( "Gauss" );
LoadPackage( "GaussForHomalg" );
LoadPackage( "LinearAlgebraForCap" );
LoadPackage( "ComplexesForCAP" );
a := 1;
AUTODOC_file_scan_list := [ "../PackageInfo.g" ];
LoadPackage( "GAPDoc" );

example_tree := ExtractExamples( Directory("./doc/"), "ComplexesForCAP.xml", AUTODOC_file_scan_list, 500 );

RunExamples( example_tree,
              rec( 
              compareFunction :=
                function( s1, s2 )
                  local new_s2, text_attr, attr;

                  new_s2 := s2;
  
                  text_attr := RecNames( TextAttr );
  
                  for attr in text_attr do
    
                    new_s2 := ReplacedString( new_s2, TextAttr.(attr), "" );

                  od;
  
                  return TEST.compareFunctions.uptowhitespace( s1, new_s2 );
  
                end )
           );

QUIT;
