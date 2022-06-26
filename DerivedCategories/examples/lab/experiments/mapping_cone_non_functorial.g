LoadPackage( "Algebroids");
LoadPackage( "DerivedCategories" );

##
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexesCategories, 3 );

field := HomalgFieldOfRationals( );

##
vertices_labels := [ "A", "C", "B", "D" ];
arrows_labels := [ "r", "s", "f_0", "f_1", "g_0", "g_1", "u", "v" ];
sources := [ 1, 3, 1, 2, 1, 2, 2, 2 ];
ranges  := [ 2, 4, 3, 4, 3, 4, 3, 3 ];
quiver := RightQuiver( "quiver", vertices_labels, arrows_labels, sources, ranges );

Qq := PathAlgebra( field, quiver );

relations := [
      Qq.r * Qq.f_1 - Qq.f_0 * Qq.s,
      Qq.r * Qq.g_1 - Qq.g_0 * Qq.s,
      Qq.f_1 - Qq.g_1- Qq.v * Qq.s,
      Qq.f_0 - Qq.g_0 - Qq.r * Qq.u
    ];
    
gamma := Qq / relations;

gamma_oid := Algebroid( gamma );;
AssignSetOfObjects( gamma_oid );
AssignSetOfGeneratingMorphisms( gamma_oid );

gamma_oid_oplus := AdditiveClosure( gamma_oid );
Co_gamma_oid_oplus := CochainComplexCategory( gamma_oid_oplus );
Ho_gamma_oid_oplus := HomotopyCategory( gamma_oid_oplus, true );

st_r := StandardExactTriangle( r / gamma_oid_oplus / Co_gamma_oid_oplus / Ho_gamma_oid_oplus );
st_s := StandardExactTriangle( s / gamma_oid_oplus / Co_gamma_oid_oplus / Ho_gamma_oid_oplus );

m := MorphismOfExactTriangles(
        st_r,
        f_0 / gamma_oid_oplus / Co_gamma_oid_oplus / Ho_gamma_oid_oplus,
        f_1 / gamma_oid_oplus / Co_gamma_oid_oplus / Ho_gamma_oid_oplus,
        st_s
      );

IsWellDefined( m );

g := HomotopyCategoryMorphism( st_r[ 2 ], st_s[ 2 ], [ g_0 / gamma_oid_oplus, g_1 / gamma_oid_oplus ], 0 );

n := MorphismOfExactTriangles( st_r, m[ 0 ], m[ 1 ], g, st_s );
IsWellDefined( n );

m = n;
# false
# I.e., there are different ways to complete the diagram to a morphism of standard triangles.
# Hence, Mapping Cone is not functorial

