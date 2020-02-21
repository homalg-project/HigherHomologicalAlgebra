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

Aoid := Algebroid( A );;
SetIsProjective( DistinguishedObjectOfHomomorphismStructure( Aoid ), true );;
add_Aoid := AdditiveClosure( Aoid );;
adelman := AdelmanCategory( add_Aoid );;
Ch_adelman := ChainComplexCategory( adelman );
Ho_adelman := HomotopyCategory( adelman );

##
ob := SetOfObjects( Aoid );
for o in ob do
  s := LabelAsString( UnderlyingVertex( o ) );
  BindGlobal( s, o/add_Aoid/adelman );
od;

##
gm := SetOfGeneratingMorphisms( Aoid );;
for m in gm do
  s := LabelAsString( Paths( Representative( UnderlyingQuiverAlgebraElement( m ) ) )[ 1 ] );
  BindGlobal( s, m/add_Aoid/adelman );
od;

st_A := CompleteMorphismToStandardExactTriangle( d_A/Ch_adelman/Ho_adelman );
st_B := CompleteMorphismToStandardExactTriangle( d_B/Ch_adelman/Ho_adelman );

m := CompleteToMorphismOfStandardExactTriangles( st_A, st_B, f_1/Ch_adelman/Ho_adelman, f_0/Ch_adelman/Ho_adelman );
IsWellDefined( m );

G := ChainMorphism( UnderlyingCell( st_A[2] ), UnderlyingCell( st_B[2] ), [ g_0, g_1 ], 0 )/Ho_adelman;

n := CreateTrianglesMorphism( st_A, st_B, m[0], m[1], G );
IsWellDefined( n );

m = n;
# false
# I.e., there are different ways to complete the diagram to a morphism of standard triangles.
# Hence, Mapping Cone is not functorial

