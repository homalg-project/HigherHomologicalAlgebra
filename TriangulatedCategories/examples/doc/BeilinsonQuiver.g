#! @Chunk BeilinsonQuiver

LoadPackage( "DerivedCategories" );

#! @Example
field := HomalgFieldOfRationals( );;
quiver := RightQuiver(
>             "quiver",
>             [ "O_0", "O_1", "O_2" ],
>             [ "x0", "x1", "x2", "y0",
>             "y1", "y2" ],
>             [ 1, 1, 1, 2, 2, 2 ],
>             [ 2, 2, 2, 3, 3, 3 ]
>           );;
Qq := PathAlgebra( field, quiver );;
A := QuotientOfPathAlgebra(
>   Qq,
>   [
>     Qq.x0 * Qq.y1 - Qq.x1 * Qq.y0,
>     Qq.x0 * Qq.y2 - Qq.x2 * Qq.y0,
>     Qq.x1 * Qq.y2 - Qq.x2 * Qq.y1,
>   ]
> );;
C := Algebroid( A );
#! Algebroid( (Q * quiver) / [ -1*(x1*y0) + 1*(x0*y1), -1*(x2*y0) + 1*(x0*y2), -1*(x2*y1) + 1*(x1*y2) ] )
AC := AdditiveClosure( C );
#! Additive closure( Algebroid( (Q * quiver) / [ -1*(x1*y0) + 1*(x0*y1), -1*(x2*y0) + 1*(x0*y2), -1*(x2*y1) + 1*(x1*y2) ] ) )
Ho_AC := HomotopyCategory( AC );
#! Homotopy category( Additive closure( Algebroid( (Q * quiver) / [ -1*(x1*y0) + 1*(x0*y1),
#! -1*(x2*y0) + 1*(x0*y2), -1*(x2*y1) + 1*(x1*y2) ] ) ) )
Tr := CategoryOfExactTriangles( Ho_AC );
#! Category of exact triangles( Homotopy category( Additive closure( Algebroid( 
#! (Q * quiver) / [ -1*(x1*y0) + 1*(x0*y1), -1*(x2*y0) + 1*(x0*y2), -1*(x2*y1) + 1*(x1*y2) ] ) ) ) )
I := EmbeddingFunctorIntoDerivedCategory( Ho_AC );
#! Equivalence functor from homotopy category into derived category
#! @EndExample
quit;

alpha := RandomMorphism( Ho_AC, [ [ -2, 2, 2 ], [ -2, 2, 2 ], [ 2 ] ] );
beta := RandomMorphismWithFixedSource( Range( alpha ), [ [ -2, 2, 2 ], [ 2 ] ] );
sigma := ShiftFunctor( Ho_AC );
sigma_m1 := InverseShiftFunctor( Ho_AC );
sigma_m1( sigma( alpha ) ) = alpha;
rot := RotationFunctor( Tr, true );
rot_m1 := InverseRotationFunctorOp( Tr, true );
st_alpha := StandardExactTriangle( alpha );;
st_beta := StandardExactTriangle( beta );;
IsStandardExactTriangle( st_alpha );
rot_st_alpha := rot( st_alpha );;
IsStandardExactTriangle( rot_st_alpha );
HasWitnessIsomorphismOntoStandardExactTriangle( rot_st_alpha );
w := WitnessIsomorphismOntoStandardExactTriangle( rot_st_alpha );;
IsWellDefined( w );
IsIsomorphism( w[ 0 ] );
IsIsomorphism( w[ 1 ] );
IsIsomorphism( w[ 2 ] );
IsIsomorphism( I( w[ 2 ] ) );
o := ExactTriangleByOctahedralAxiom( alpha, beta );
o := ExactTriangleByOctahedralAxiom( st_alpha, st_beta );
t_alpha := ExactTriangle( st_alpha ^ 0, ( 1/3 ) * st_alpha ^ 1, 3 * st_alpha ^ 2 );;
w := WitnessIsomorphismOntoStandardExactTriangle( t_alpha );;
Range( w ) = st_alpha;
t_beta := ExactTriangle( st_beta ^ 0, ( 1/2 ) * st_beta ^ 1, 2 * st_beta ^ 2 );;
w := WitnessIsomorphismOntoStandardExactTriangle( t_beta );;
Range( w ) = st_beta;
