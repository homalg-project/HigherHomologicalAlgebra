LoadPackage( "DerivedCategories" );
LoadPackage( "ExamplesForModelCategories" );

field := GLOBAL_FIELD_FOR_QPA!.default_field;
#magma := HomalgFieldOfRationalsInMAGMA( );
magma := field;

SET_GLOBAL_FIELD_FOR_QPA( magma );
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 1 );

A := CotangentBeilinsonQuiverAlgebra( field, 2 );
S := UnderlyingHomalgGradedPolynomialRing( A );

C := CategoryOfQuiverRepresentations( A );

o := TwistedStructureSheaf( S, 0 );

BB := _CotangentBeilinsonFunctor( A );

