LoadPackage( "LinearAlgebra" );
LoadPackage( "ComplexesForCAP" );;
LoadPackage( "RingsForHom" );

Q := HomalgFieldOfRationals( );
cat := MatrixCategory( Q );
k1 := VectorSpaceObject( 1, Q );
k2 := VectorSpaceObject( 2, Q );
k4 := VectorSpaceObject( 4, Q );


f := VectorSpaceMorphism( k4, HomalgMatrix( "[ 2,3,4,5,6,7,1,0,2]", 4, 2, Q ), k2 );

#             0           1           2              3               4
#
#                   f          ker f
# C: <------  Q^2 <----- Q^4 <------ Q^2 <-------- 
#
C := ChainComplex( [ f, KernelEmbedding( f ) ], 1 );

g := VectorSpaceMorphism( k2, HomalgMatrix( "[ -3,1,0,0]", 2, 2, Q ), k2 );
t := VectorSpaceMorphism( k1, HomalgMatrix( "[ 0, 3 ]", 1, 2, Q ), k2 );

#                    g          t
# D: <------  Q^2 <----- Q^2 <------ Q^1 <--------
#
D := ChainComplex( [ g, t ], 1 );

# Let us compute the internal hom between C and D and use it to compute
# the dimension of external Hom( C, D ) as a vector space over Q.
#
# We know that External hom is isomorphism to Cycles of internal hom in index 0

internal_hom_C_D := InternalHomOnObjects( C, D );

cycle0 := CyclesAt( internal_hom_C_D, 0 );

external_hom := Source( cycle0 );


