LoadPackage( "ModulePresentations" );
LoadPackage( "Gauss" );
LoadPackage( "GaussForHomalg" );
LoadPackage( "LinearAlgebraForCap" );
LoadPackage( "ComplexesForCAP" );

AUTODOC_file_scan_list := [ "../PackageInfo.g" ];
LoadPackage( "GAPDoc" );

example_tree := ExtractExamples( Directory("./doc/"), "ComplexesForCAP.xml", AUTODOC_file_scan_list, 500 );

RunExamples( example_tree, rec( compareFunction := "uptowhitespace" ) );

QUIT;
