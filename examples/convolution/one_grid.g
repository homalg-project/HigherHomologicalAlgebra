ReadPackage( "DerivedCategories", "examples/convolution/clean_pre_functions.g" );

field := HomalgFieldOfRationals( );

l := 0;
r := 8;
b := 0;
a := 8;
names :=
  [
    # vertices labels, these are the labels of the grid's
    [ "P" ],
    
    # 0,1 diffs labels, these are the diffs of degree 0 and 1, they go left and down, in case of chains, and right, up in case of cochains
    [ [ "dP" ] ],
    
    # higher diffs labels, these are higher diffs, i.e., diffs of degree 2 and more, hence the letter "h"
    [ [ "xP", "yP" ] ],
    
    # 0 morphisms labels, these are the morphisms of degree 0 between two grids
    [ ],
    
    # higher morphisms labels, these are higher morphisms between two grids
    [ ],
    
    # homotopies that should exists between the two grids
    [ ],
    
    # differentials relations
    # this means dP will be extended by hdP and similarly for dQ
    [ [ "dP"], [ [ "xP", "yP" ] ] ],
    
    # morphisms relations
    [ ],
    
    # homotopies relations
    [ ],
  ];

complexes := [ [ "dP", "P" ] ];
morphisms := [ ];
extra_names := [ "dP", "xP", "yP", "hP" ];

