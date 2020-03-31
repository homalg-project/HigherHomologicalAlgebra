ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

field := HomalgFieldOfRationals( );

# In the following we create two grids P**, Q**
# and a morphism between alpha:P** --> Q**
# which has two different Convolutions that are homotopic in case we add higher homotopies

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
    [ [ "alpha" ] ],
    
    # higher morphisms
    [ [ "y", "z" ] ],
    
    # homotopies
    [
      #[ "h" ]
    ],
    
    # differentials relations
    [ [ "dP", "dQ" ], [ [ "hdP" ], [ "hdQ" ] ] ],
    
    # morphisms relations
    [
      [ "dP", "hdP", "alpha", "y", "dQ", "hdQ" ],
      [ "dP", "hdP", "alpha", "z", "dQ", "hdQ" ]
    ],
    
    # homotopies relations
    [
      #[ "dP","hdP", [ "alpha", "alpha" ], [ "y", "z" ], "h", "dQ", "hdQ" ]
    ],
  ];
  
complexes := [ [ "dP", "P" ], [ "dQ", "Q" ] ];
morphisms := [ [ "P", "Q", "alpha" ] ];

AC := create_free_category( field, l, r, b, a, input, complexes, morphisms );
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
# Two higher morphisms "y" and "z" could have been used, but the convolution method chooses to use "y_?x?_?"
conv_y := Convolution( alpha );
conv_z := hack_morphism_in_homotopy_category( conv_y, "y", "z" );

IsZero( conv_y - conv_z  );

HomStructure( P[a], Shift( Q[a-1], -1 ) );
B := BasisOfExternalHom( P[a], Shift( Q[a-1], -1 ) );

# now enable homotopies

