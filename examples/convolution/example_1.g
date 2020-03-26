ReadPackage( "DerivedCategories", "examples/convolution/convolution.g" );

field := HomalgFieldOfRationals( );

l := 0;
r := 5;
b := 0;
a := 5;

vertices_labels := create_labels_for_vertices( l, r, b, a, [ "P" ] );

01_diffs := create_labels_for_01_differentials( l, r, b, a, [ [ "dP" ] ] );
higher_diffs := create_labels_for_higher_differentials( l, r, b, a, [ [ "fP", "gP" ] ] );

arrows := ListN( 01_diffs, higher_diffs, Concatenation );

quiver := RightQuiver( "q", vertices_labels, arrows[1], arrows[2], arrows[3] );

A := PathAlgebra( field, quiver );

relations := differentials_relations( A, l, r, b, a, [ "dP" ], [ [ "fP", "gP" ] ] );

A := A / relations;

C := Algebroid( A );
C!.Name := "algebroid over quiver algebra";
AssignSetOfObjects( C );
AssignSetOfGeneratingMorphisms( C );

AC := AdditiveClosure( C );
Ho_AC := HomotopyCategory( AC );

create_complexes( AC, l, r, b, a, [ [ "dP", "P" ] ] );
