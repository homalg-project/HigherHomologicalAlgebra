ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

# In the following we create a grid P** with differntials of degrees 0 & 1 with labels dP_0, dP_1
# and two different higher differentials, which both can be used to compute a convolution

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
quit;

conv_fP := Convolution( P );
IsWellDefined( conv_fP );

conv_gP := hack_object_in_homotopy_category( conv_fP, "fP", "gP" );
IsWellDefined( conv_gP );

HomStructure( conv_fP, conv_gP );
#! <A vector space object over Q of dimension 0>

