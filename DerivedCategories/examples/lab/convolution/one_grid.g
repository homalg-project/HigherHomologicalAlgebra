ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

field := HomalgFieldOfRationals( );

l := 0;
r := 5;
b := 0;
a := 5;
names :=
  [
    # vertices labels, these are the labels of the grid's
    [ "P" ],
    
    # 0,1 diffs labels, these are the diffs of degree 0 and 1, they go left and down, in case of chains, and right, up in case of cochains
    [ [ "dP" ] ],
    
    # higher diffs labels, these are higher diffs, i.e., diffs of degree 2 and more, hence the letter "h"
    [ [ "xP" ] ],
    
    # 0 morphisms labels, these are the morphisms of degree 0 between two grids
    [ ],
    
    # higher morphisms labels, these are higher morphisms between two grids
    [ ],
    
    # homotopies that should exists between the two grids
    [ ],
    
    # differentials relations
    # this means dP will be extended by hdP and similarly for dQ
    [ [ "dP"], [ [ "xP" ] ] ],
    
    # morphisms relations
    [ ],
    
    # homotopies relations
    [ ],
  ];

complexes := [ [ "dP", "P" ] ];
morphisms := [ ];
extra_names := [ ];

quit;

algebroid := create_algebroid( field, l, r, b, a, names, extra_names, complexes, morphisms );
alpha := create_totalization_complex_morphism( algebroid, l, r, b, a, [ "P", "dP", [ "xP", "yP" ], "hP" ] );
P;
conv_xP := Convolution( P );
conv_yP := hack_object_in_homotopy_category( conv_xP, "xP", "yP" );
BasisOfExternalHom( conv_xP, conv_yP );
BasisOfExternalHom( Source( alpha ), conv_xP );

