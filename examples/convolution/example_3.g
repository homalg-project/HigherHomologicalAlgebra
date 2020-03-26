ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

field := HomalgFieldOfRationals( );

# In the following we create three grids P**, Q**, R**
# and a morphism between alpha:P** --> Q** and beta: Q** --> R**
# Then we apply the convolution on alpha, beta and their composition.

l := 0;
r := 4;
b := 0;
a := 4;

vertices_labels := create_labels_for_vertices( l, r, b, a, [ "P", "Q" ] );

01_diffs := create_labels_for_01_differentials( l, r, b, a, [ [ "dP" ], [ "dQ" ] ] );
higher_diffs := create_labels_for_higher_differentials( l, r, b, a, [ [ "fP" ], [ "fQ" ] ] );

0_morphisms := create_labels_for_0_morphisms( l, r, b, a, [ [ "alpha" ] ] );
higher_morphisms := create_labels_for_higher_morphisms( l, r, b, a, [ [ "y", "z" ] ] );

diffs := ListN( 01_diffs, higher_diffs, Concatenation );
morphisms := ListN( 0_morphisms, higher_morphisms, Concatenation );

arrows := ListN( diffs, morphisms, Concatenation );

quiver := RightQuiver( "q", vertices_labels, arrows[1], arrows[2], arrows[3] );

A := PathAlgebra( field, quiver );

d_relations := differentials_relations( A, l, r, b, a, [ "dP", "dQ" ], [ [ "fP" ], [ "fQ" ] ] );

m_relations := morphisms_relations( A, l, r, b, a,
        [
          [ "dP", "fP", "alpha", "y", "dQ", "fQ" ],
          [ "dP", "fP", "alpha", "z", "dQ", "fQ" ]
        ] );

relations := Concatenation( d_relations, m_relations );

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

