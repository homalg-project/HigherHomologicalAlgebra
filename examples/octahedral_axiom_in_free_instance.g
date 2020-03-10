LoadPackage( "Bialgebroids");
LoadPackage( "DerivedCategories" );
ENABLE_COLORS := true;

##
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

field := HomalgFieldOfRationals( );

##
vertex_labels := [ "A_0", "A_1", "A_2", "A_3", "C_0", "C_1", "C_2", "C_3", "B_0", "B_1", "B_2", "B_3" ];
labels := [
            "d1_A", "d2_A", "d3_A", "d1_C", "d2_C", "d3_C", "d1_B", "d2_B", "d3_B",
            "f_0", "f_1", "f_2", "f_3", "g_0", "g_1", "g_2", "g_3"
          ];

sources := [ 2, 3, 4, 6, 7, 8, 10, 11, 12, 1, 2, 3, 4, 9, 10, 11, 12 ];
ranges  := [ 1, 2, 3, 5, 6, 7,  9, 10, 11, 9, 10, 11, 12, 5,  6, 7,   8 ]; 

quiver := RightQuiver( "quiver", vertex_labels, labels, sources, ranges );

kQ := PathAlgebra( field, quiver );

relations :=
    [
      kQ.d2_A * kQ.d1_A, kQ.d3_A * kQ.d2_A,
      kQ.d2_B * kQ.d1_B, kQ.d3_B * kQ.d2_B,
      kQ.d2_C * kQ.d1_C, kQ.d3_C * kQ.d2_C,
      
      kQ.d1_A * kQ.f_0 - kQ.f_1 * kQ.d1_B,
      kQ.d2_A * kQ.f_1 - kQ.f_2 * kQ.d2_B,
      kQ.d3_A * kQ.f_2 - kQ.f_3 * kQ.d3_B,
      
      kQ.d1_B * kQ.g_0 - kQ.g_1 * kQ.d1_C,
      kQ.d2_B * kQ.g_1 - kQ.g_2 * kQ.d2_C,
      kQ.d3_B * kQ.g_2 - kQ.g_3 * kQ.d3_C,
    ];

algebra := kQ / relations;

algebroid := Algebroid( algebra );
AssignSetOfObjects( algebroid );
AssignSetOfGeneratingMorphisms( algebroid );

AC := AdditiveClosure( algebroid );
Ho_AC := HomotopyCategory( AC );
#################
A := ChainComplex( [ d1_A/AC, d2_A/AC, d3_A/AC ], 1 );
B := ChainComplex( [ d1_B/AC, d2_B/AC, d3_B/AC ], 1 );
C := ChainComplex( [ d1_C/AC, d2_C/AC, d3_C/AC ], 1 );

f := ChainMorphism( A, B, [ f_0/AC, f_1/AC, f_2/AC, f_3/AC ], 0 )/Ho_AC;
g := ChainMorphism( B, C, [ g_0/AC, g_1/AC, g_2/AC, g_3/AC ], 0 )/Ho_AC;
A := A/Ho_AC;
B := B/Ho_AC;
C := C/Ho_AC;

g_o_f := PreCompose( f, g );

Tr_f := CompleteMorphismToStandardExactTriangle( f );
Tr_g := CompleteMorphismToStandardExactTriangle( g );
Tr_g_o_f := CompleteMorphismToStandardExactTriangle( g_o_f );

U := CompleteToMorphismOfStandardExactTriangles( Tr_f, Tr_g_o_f, IdentityMorphism( A ), g );

u := U[ 2 ];
v := LiftColift( PreCompose( MorphismFromConeObject(g_o_f), Shift( f, 1 ) ),
                    MorphismFromConeObject( g ),
                      MorphismIntoConeObject( g_o_f ),
                        MorphismIntoConeObject( g )
                      );
w := PreCompose( MorphismFromConeObject(g), Shift( MorphismIntoConeObject(f), 1 ) );

T := CreateExactTriangle( u, v, w );
i := IsomorphismIntoStandardExactTriangle( T );
i := i[2];
j := Inverse( i );


