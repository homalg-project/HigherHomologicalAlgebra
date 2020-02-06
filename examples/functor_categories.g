LoadPackage( "DerivedCategories" );
LoadPackage( "FunctorCategories" );


field := HomalgFieldOfRationals( );

A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 3, 3, 3 );
algebroid := Algebroid( A );

C := Hom( algebroid, MatrixCategory( field ) );
chains_C := ChainComplexCategory( C );
homotopy_C := HomotopyCategory( C );
derived_C := DerivedCategory( C );

indec_projs := IndecProjectiveObjects( C );
indec_injs := IndecInjectiveObjects( C );

collection := CreateExceptionalCollection( indec_projs );

H := HomFunctor( collection );
T := TensorFunctor( collection );

R_H := RightDerivedFunctor( H );
L_T := LeftDerivedFunctor( T );

s := DirectSum( List( [ 1 .. 8 ], i -> Random( Concatenation( indec_projs, indec_injs ) ) ) );
r := DirectSum( List( [ 1 .. 8 ], i -> Random( Concatenation( indec_projs, indec_injs ) ) ) );
a := CokernelObject( Random( BasisOfExternalHom( s, r ) ) )/chains_C/homotopy_C/derived_C;
L_T_R_H_a := L_T( R_H( a ) );
