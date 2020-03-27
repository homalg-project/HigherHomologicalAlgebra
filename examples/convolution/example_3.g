ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

# 

field := HomalgFieldOfRationals( );

l := 0;
r := 4;
b := 0;
a := 4;
alpha_and_beta_are_higher_homotopic := true;


vertices_labels := create_labels_for_vertices( l, r, b, a, [ "P", "Q" ] );

01_diffs := create_labels_for_01_differentials( l, r, b, a, [ [ "dP" ], [ "dQ" ] ] );
higher_diffs := create_labels_for_higher_differentials( l, r, b, a, [ [ "hdP" ], [ "hdQ" ] ] );

0_morphisms := create_labels_for_0_morphisms( l, r, b, a, [ [ "alpha", "beta" ] ] );
higher_morphisms := create_labels_for_higher_morphisms( l, r, b, a, [ [ "h_alpha", "h_beta" ] ] );

diffs := ListN( 01_diffs, higher_diffs, Concatenation );
morphisms := ListN( 0_morphisms, higher_morphisms, Concatenation );

if alpha_and_beta_are_higher_homotopic then
  homotopies := create_labels_for_homotopies( l, r, b, a, [ [ "h" ] ] );
else
  homotopies := [ [], [], [] ];
fi;

arrows := ListN( diffs, morphisms, homotopies, Concatenation );

quiver := RightQuiver( "q", vertices_labels, arrows[1], arrows[2], arrows[3] );

A := PathAlgebra( field, quiver );

d_relations := differentials_relations( A, l, r, b, a, [ "dP", "dQ" ], [ [ "hdP" ], [ "hdQ" ] ] );

m_relations := morphisms_relations( A, l, r, b, a,
        [
          [ "dP", "hdP", "alpha", "h_alpha", "dQ", "hdQ" ],
          [ "dP", "hdP", "beta",  "h_beta",  "dQ", "hdQ" ],
        ] );

if alpha_and_beta_are_higher_homotopic then
  h_relations := homotopies_relations( A, l, r, b, a,
        [
          [ "dP","hdP", [ "alpha", "beta" ], [ "h_alpha", "h_beta" ], "h", "dQ", "hdQ" ]
        ] );
else 
  h_relations := [ ];
fi;

relations := Concatenation( d_relations, m_relations, h_relations );

A := A / relations;
C := Algebroid( A );
C!.Name := "algebroid of some algebra";
AssignSetOfObjects( C );
AssignSetOfGeneratingMorphisms( C );
AC := AdditiveClosure( C );

create_complexes( AC, l, r, b, a, [ [ "dP", "P" ], [ "dQ", "Q" ] ] );
create_morphisms( AC, l, r, b, a, [ [ "P", "Q", "alpha" ], [ "P", "Q", "beta" ] ] );

quit;
P;
Q;
alpha;
beta;
conv_alpha := Convolution( alpha );
conv_beta := Convolution( beta );
conv_alpha + conv_beta = Convolution( alpha + beta );

IsZero( conv_alpha - conv_beta );
# true in case alpha and beta are higher homotopic
# false in case alpha and beta are not higher homotopic

# in case alpha and beta are higher homotopic
H := HomotopyMorphisms( conv_alpha - conv_beta );

