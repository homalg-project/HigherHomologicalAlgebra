LoadPackage( "Bialgebroids");
LoadPackage( "DerivedCategories" );

##
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

field := HomalgFieldOfRationals( );

##
vertex_labels := [ "A_1", "A_0", "B_1", "B_0" ];
labels := [ "d_A", "d_B", "f_0", "f_1", "g_0", "g_1", "y", "z" ];
sources := [ 1, 3, 2, 1, 2, 1, 2, 2 ];
ranges  := [ 2, 4, 4, 3, 4, 3, 3, 3 ];
quiver := RightQuiver( "quiver", vertex_labels, labels, sources, ranges );

Qq := PathAlgebra( field, quiver );

relations := [
      Qq.d_A * Qq.f_0 - Qq.f_1 * Qq.d_B,
      Qq.d_A * Qq.g_0 - Qq.g_1 * Qq.d_B,
      Qq.f_1 - Qq.g_1- Qq.d_A * Qq.y,
      Qq.f_0 - Qq.g_0 - Qq.z * Qq.d_B 
    ];
    
A := Qq / relations;

C := Algebroid( A );;
AC := AdditiveClosure( C );
Ch_AC := ChainComplexCategory( AC );
Ho_AC := HomotopyCategory( AC );

AssignSetOfObjects( C );
AssignSetOfGeneratingMorphisms( C );

st_A := StandardExactTriangle( d_A / AC / Ch_AC / Ho_AC );
st_B := StandardExactTriangle( d_B / AC / Ch_AC / Ho_AC );

m := MorphismOfExactTriangles( st_A, f_1 / AC / Ch_AC / Ho_AC, f_0 / AC / Ch_AC / Ho_AC, st_B );
IsWellDefined( m );

g := HomotopyCategoryMorphism( st_A[ 2 ], st_B[ 2 ], [ g_0 / AC, g_1 / AC ], 0 );

n := MorphismOfExactTriangles( st_A, m[ 0 ], m[ 1 ], g, st_B );
IsWellDefined( n );

m = n;
# false
# I.e., there are different ways to complete the diagram to a morphism of standard triangles.
# Hence, Mapping Cone is not functorial

