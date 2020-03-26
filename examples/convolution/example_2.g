ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

field := HomalgFieldOfRationals( );

# In the following we create three grids P**, Q**, R**
# and a morphism between alpha:P** --> Q** and beta: Q** --> R**
# Then we apply the convolution on alpha, beta and their composition.

l := 0;
r := 3;
b := 0;
a := 3;

vertices_labels := create_labels_for_vertices( l, r, b, a, [ "P", "Q", "R" ] );

01_diffs := create_labels_for_01_differentials( l, r, b, a, [ [ "dP" ], [ "dQ" ], [ "dR" ] ] );
higher_diffs := create_labels_for_higher_differentials( l, r, b, a, [ [ "fP" ], [ "fQ" ], [ "fR" ] ] );

0_morphisms := create_labels_for_0_morphisms( l, r, b, a, [ [ "alpha" ], [ "beta" ] ] );
higher_morphisms := create_labels_for_higher_morphisms( l, r, b, a, [ [ "h_alpha" ], [ "h_beta" ] ] );

diffs := ListN( 01_diffs, higher_diffs, Concatenation );
morphisms := ListN( 0_morphisms, higher_morphisms, Concatenation );

arrows := ListN( diffs, morphisms, Concatenation );

quiver := RightQuiver( "q", vertices_labels, arrows[1], arrows[2], arrows[3] );

A := PathAlgebra( field, quiver );

d_relations := differentials_relations( A, l, r, b, a, [ "dP", "dQ", "dR" ], [ [ "fP" ], [ "fQ" ], [ "fR" ] ] );

m_relations := morphisms_relations( A, l, r, b, a,
        [
          [ "dP", "fP", "alpha", "h_alpha", "dQ", "fQ" ],
          [ "dQ", "fQ", "beta", "h_beta", "dR", "fR" ]
        ] );

relations := Concatenation( d_relations, m_relations );

A := A / relations;

C := Algebroid( A );
C!.Name := "algebroid over quiver algebra";
AssignSetOfObjects( C );
AssignSetOfGeneratingMorphisms( C );

AC := AdditiveClosure( C );
Ho_AC := HomotopyCategory( AC );

create_complexes( AC, l, r, b, a, [ [ "dP", "P" ], [ "dQ", "Q" ], [ "dR", "R" ] ] );
create_morphisms( AC, l, r, b, a, [ [ "P", "Q", "alpha" ], [ "Q", "R", "beta" ] ] );

quit;

Display( P_0x1 / AC );
Display( P_1[ 0 ] );
Display( P_1 );
P;
P[1] = P_1;
P[2] = P_2;
Q;
Q[1] = Q_1;
Q[2] = Q_2;
alpha_1;
Source( alpha_1 ) = P_1;
Range( alpha_1 ) = Q_1;
alpha;

conv_P := Convolution( P );
conv_alpha := Convolution( alpha );
conv_beta := Convolution( beta );
conv_alpha_beta := Convolution( PreCompose( alpha, beta ) );

