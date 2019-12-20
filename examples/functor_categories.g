LoadPackage( "DerivedCategories" );
LoadPackage( "FunctorCategories" );


field := HomalgFieldOfRationals( );

A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 3, 3, 3 );

algebroid := Algebroid( A );

C := Hom( algebroid, MatrixCategory( field ) );

indec_projs := IndecProjectiveObjects( C );

collection := CreateExceptionalCollection( indec_projs );

HH := HomFunctorByExceptionalCollection( collection );

TT := TensorFunctorByExceptionalCollection( collection );

D := AsCapCategory( Source( TT ) );

r := RandomObject( D, 10 );

ht_r := ApplyFunctor( PreCompose( TT, HH ), r );

