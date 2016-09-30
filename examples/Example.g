LoadPackage( "StableCategoriesForCap" );
LoadPackage( "LinearAlgebraForCap" );

Q := HomalgFieldOfRationals();
Mat := MatrixCategory( Q );
func := function( mor) return true;end;
# f is defined like that because all vector spaces are projective and injective, and hence all morphisms are zero since they factor through its coimage.
A := VectorSpaceObject( 2, Q );
B := VectorSpaceObject( 1, Q );
f := VectorSpaceMorphism( B, HomalgMatrix( [ [ 3,4 ] ], 1,2, Q ), A );
g := 4*f;
Stable_Mat := StableCategory( Mat, func, "func" );

A_ := AsStableCategoryObject( Stable_Mat, A );
B_ := AsStableCategoryObject( Stable_Mat, B );
f_ := AsStableCategoryMorphism( Stable_Mat, f );
g_ := AsStableCategoryMorphism( Stable_Mat, g );

