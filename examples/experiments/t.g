LoadPackage( "Bialgebroids");
LoadPackage( "DerivedCategories" );
ENABLE_COLORS := true;

##
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

field := HomalgFieldOfRationals( );

##
vertex_labels := [ "A_0", "A_1", "A_2", "A_3", "B_0", "B_1", "B_2", "B_3", "C_0", "C_1", "C_2", "C_3" ];
labels := [
            "d1_A", "d2_A", "d3_A", "d1_B", "d2_B", "d3_B", "d1_C", "d2_C", "d3_C",
            "f_0", "f_1", "f_2", "f_3", "g_0", "g_1", "g_2", "g_3"
          ];

sources := [ 2, 3, 4, 6, 7, 8, 10, 11, 12, 1, 2, 3, 4, 9, 10, 11, 12 ];
ranges  := [ 1, 2, 3, 5, 6, 7,  9, 10, 11, 5, 6, 7, 8, 5,  6, 7,   8 ]; 

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
      
      kQ.d1_C * kQ.g_0 - kQ.g_1 * kQ.d1_B,
      kQ.d2_C * kQ.g_1 - kQ.g_2 * kQ.d2_B,
      kQ.d3_C * kQ.g_2 - kQ.g_3 * kQ.d3_B,
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
g := ChainMorphism( C, B, [ g_0/AC, g_1/AC, g_2/AC, g_3/AC ], 0 )/Ho_AC;
A := A/Ho_AC;
B := B/Ho_AC;
C := C/Ho_AC;


Tr_f := CompleteMorphismToStandardExactTriangle( f );
rot_Tr_f := RotationOfStandardExactTriangle( Tr_f );
i := IsomorphismFromStandardExactTriangle( rot_Tr_f );

tau := MorphismIntoConeObject( f );
g_tau := PreCompose( g, tau );
Tr_g_tau := CompleteMorphismToStandardExactTriangle( g_tau );
Tr_tau := CompleteMorphismToStandardExactTriangle( tau );
j := CompleteToMorphismOfStandardExactTriangles( Tr_g_tau, Tr_tau, g, IdentityMorphism( ConeObject( f ) ) );
ji := PreCompose( j, i );

_f := AdditiveInverse( Shift( Tr_g_tau ^ 2, -1 ) );
_g := Shift( ji[ 2 ], -1 );

IsCongruentForMorphisms( PreCompose( _f, g ), PreCompose( _g, f ) );
# true
