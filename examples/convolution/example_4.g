ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

# To be completed!

field := HomalgFieldOfRationals( );

l := 0;
r := 4;
b := 0;
a := 4;

vertices_labels := create_labels_for_vertices( l, r, b, a, [ "P", "Q" ] );

01_diffs := create_labels_for_01_differentials( l, r, b, a, [ [ "dP" ], [ "dQ" ] ] );
higher_diffs := create_labels_for_higher_differentials( l, r, b, a, [ [ "fP" ], [ "fQ" ] ] );

0_morphisms := create_labels_for_0_morphisms( l, r, b, a, [ [ "alpha" ] ] );
higher_morphisms := create_labels_for_higher_morphisms( l, r, b, a, [ [ "alpha" ] ] );

diffs := ListN( 01_diffs, higher_diffs, Concatenation );
morphisms := ListN( 0_morphisms, higher_morphisms, Concatenation );

homotopies := create_labels_for_homotopies( l, r, b, a, [ [ "h" ] ] );
arrows := ListN( diffs, morphisms, homotopies, Concatenation );

quiver := RightQuiver( "q", vertices_labels, arrows[1], arrows[2], arrows[3] );

A := PathAlgebra( field, quiver );

d_relations := differentials_relations( A, l, r, b, a, [ "dP", "dQ" ], [ [ "fP" ], [ "fQ" ] ] );

m_relations := morphisms_relations( A, l, r, b, a,
        [
          [ "dP", "fP", "alpha", "alpha", "dQ", "fQ" ]
        ] );
h_relations := homotopies_relations( A, l, r, b, a,
        [
          [ "dP","fP", "alpha", "alpha", "h", "dQ", "fQ" ]
        ] );

relations := Concatenation( d_relations, m_relations, h_relations );

A := A / relations;
C := Algebroid( A );
C!.Name := "algebroid of some algebra";
AssignSetOfObjects( C );
AssignSetOfGeneratingMorphisms( C );
AC := AdditiveClosure( C );

create_complexes( AC, l, r, b, a, [ [ "dP", "P" ], [ "dQ", "Q" ] ] );
create_morphisms( AC, l, r, b, a, [ [ "P", "Q", "alpha" ] ] );

quit;
P;
Q;
alpha;
conv_alpha := Convolution( alpha );
IsZero( conv_alpha );
H := HomotopyMorphisms( conv_alpha );

