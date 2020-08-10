ReadPackage( "DerivedCategories", "examples/convolution/clean_pre_functions.g" );

# 

field := HomalgFieldOfRationals( );

l := 0;
r := 4;
b := 0;
a := 4;

names :=
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
      [ "h" ]
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
      [ "dP","hdP", [ "alpha", "beta" ], [ "h_alpha", "h_beta" ], "h", "dQ", "hdQ" ]
    ],
  ];
  

extra_names := [ ];

complexes := [ [ "dP", "P" ], [ "dQ", "Q" ] ];
morphisms := [ [ "P", "Q", "alpha" ], [ "P", "Q", "beta" ] ];

AC := create_algebroid( field, l, r, b, a, names, extra_names, complexes, morphisms );

quit;
#   P :=
#
#
#   P_2:      P_0x2  <--- P_1x2 <--- P_2x2 <---
#    |          |           |          | 
#    |          |           |          | 
#    v          v           v          v 
#   P_1:      P_0x1  <--- P_1x1 <--- P_2x1 <---
#    |          |           |          | 
#    | dP_1     |           |          | 
#    v          v           v          v 
#   P_0:      P_0x0  <--- P_1x0 <--- P_2x0 <---
#
#
#               0           1          2
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

