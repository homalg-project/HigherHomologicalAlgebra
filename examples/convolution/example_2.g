ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

# 

field := HomalgFieldOfRationals( );

l := 0;
r := 4;
b := 0;
a := 4;

input :=
  [
    # vertices labels
    [ "P", "Q" ],
    
    # 0,1 diffs labels
    [ [ "dP" ], [ "dQ" ] ],
    
    # higher diffs labels
    [ [ "hdP" ], [ "hdQ" ] ],
    
    # 0 morphisms
    [ [ "alpha", "beta" ] ],
    
    # higher morphisms
    [ [ "h_alpha", "h_beta" ] ],
    
    # homotopies
    [
      #[ "h" ]
    ],
    
    # differentials relations
    [ [ "dP", "dQ" ], [ [ "hdP" ], [ "hdQ" ] ] ],
    
    # morphisms relations
    [
      [ "dP", "hdP", "alpha", "h_alpha", "dQ", "hdQ" ],
      [ "dP", "hdP", "beta",  "h_beta",  "dQ", "hdQ" ]
    ],
    
    # homotopies relations
    [
      #[ "dP","hdP", [ "alpha", "beta" ], [ "h_alpha", "h_beta" ], "h", "dQ", "hdQ" ]
    ],
  ];
  
complexes := [ [ "dP", "P" ], [ "dQ", "Q" ] ];
morphisms := [ [ "P", "Q", "alpha" ], [ "P", "Q", "beta" ] ];

AC := create_free_category( field, l, r, b, a, input, complexes, morphisms );

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

