ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

field := HomalgFieldOfRationals( );

# In the following we create three grids P**, Q**
# and a morphism between alpha:P** --> Q**
# which has two different Convolutions that are homotopic in case we add higher homotopies

l := 0;
r := 4;
b := 0;
a := 4;
with_homotopies := false;

vertices_labels := create_labels_for_vertices( l, r, b, a, [ "P", "Q" ] );

01_diffs := create_labels_for_01_differentials( l, r, b, a, [ [ "dP" ], [ "dQ" ] ] );
higher_diffs := create_labels_for_higher_differentials( l, r, b, a, [ [ "hdP" ], [ "hdQ" ] ] );

0_morphisms := create_labels_for_0_morphisms( l, r, b, a, [ [ "alpha" ] ] );
higher_morphisms := create_labels_for_higher_morphisms( l, r, b, a, [ [ "y", "z" ] ] );

if with_homotopies then
  homotopies := create_labels_for_homotopies( l, r, b, a, [ [ "h" ] ] );
else
  homotopies := [ [], [], [] ];
fi;

diffs := ListN( 01_diffs, higher_diffs, homotopies, Concatenation );
morphisms := ListN( 0_morphisms, higher_morphisms, Concatenation );

arrows := ListN( diffs, morphisms, Concatenation );

quiver := RightQuiver( "q", vertices_labels, arrows[1], arrows[2], arrows[3] );

A := PathAlgebra( field, quiver );

d_relations := differentials_relations( A, l, r, b, a, [ "dP", "dQ" ], [ [ "hdP" ], [ "hdQ" ] ] );

m_relations := morphisms_relations( A, l, r, b, a,
        [
          [ "dP", "hdP", "alpha", "y", "dQ", "hdQ" ],
          [ "dP", "hdP", "alpha", "z", "dQ", "hdQ" ]
        ] );

if with_homotopies then
  h_relations := homotopies_relations( A, l, r, b, a,
        [
          [ "dP","hdP", [ "alpha", "alpha" ], [ "y", "z" ], "h", "dQ", "hdQ" ]
        ] );
else 
  h_relations := [ ];
fi;

relations := Concatenation( d_relations, m_relations, h_relations );

A := A / relations;

C := Algebroid( A );
C!.Name := "algebroid over quiver algebra";
AssignSetOfObjects( C );
AssignSetOfGeneratingMorphisms( C );

AC := AdditiveClosure( C );
Ho_AC := HomotopyCategory( AC );

create_complexes( AC, l, r, b, a, [ [ "dP", "P" ], [ "dQ", "Q" ] ] );
create_morphisms( AC, l, r, b, a, [ [ "P", "Q", "alpha" ] ] );

quit;

# Two higher morphisms "y" and "z" could have been used, but the convolution method chooses to use "y_?x?_?"
conv_y := Convolution( alpha );
conv_z := hack_morphism_in_homotopy_category( conv_y, "y", "z" );

IsZero( conv_y - conv_z  );

HomStructure( P[a], Shift( Q[a-1], -1 ) );
B := BasisOfExternalHom( P[a], Shift( Q[a-1], -1 ) );

