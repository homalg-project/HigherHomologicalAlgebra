ReadPackage( "DerivedCategories", "examples/convolution/pre_functions.g" );

field := HomalgFieldOfRationals( );

# In the following we create three grids P**, Q**, R**
# and a morphism between alpha:P** --> Q** and beta: Q** --> R**
# Then we apply the convolution on alpha, beta and their composition.

l := 0;
r := 2;
b := 0;
a := 2;

input :=
  [
    # vertices labels
    [ "P", "Q", "R" ],
    
    # 0,1 diffs labels
    [ [ "dP" ], [ "dQ" ], [ "dR" ] ],
    
    # higher diffs labels
    [ [ "hdP" ], [ "hdQ" ], [ "hdR" ] ],
    
    # 0 morphisms
    [ [ "alpha" ], [ "beta" ] ],
    
    # higher morphisms
    [ [ "h_alpha" ], [ "h_beta" ] ],
    
    # homotopies
    [ ],
    
    # differentials relations
    [ [ "dP", "dQ", "dR" ], [ [ "hdP" ], [ "hdQ" ], [ "hdR" ] ] ],
    
    # morphisms relations
    [
      [ "dP", "hdP", "alpha", "h_alpha", "dQ", "hdQ" ],
      [ "dQ", "hdQ", "beta", "h_beta", "dR", "hdR" ]
    ],
    
    # homotopies relations
    [ ],
  ];
    
complexes := [ [ "dP", "P" ], [ "dQ", "Q" ], [ "dR", "R" ] ];
morphisms := [ [ "P", "Q", "alpha" ], [ "Q", "R", "beta" ] ];

AC := create_free_category( field, l, r, b, a, input, complexes, morphisms );

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

