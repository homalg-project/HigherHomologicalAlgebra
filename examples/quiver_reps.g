LoadPackage( "DerivedCategories" );
LoadPackage( "LinearAlgebraForCAP" );

field := HomalgFieldOfRationals( );
SET_GLOBAL_FIELD_FOR_QPA( field );
SetInfoLevel( InfoDerivedCategories, 3 );

A := RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection( field, 4, 5, 2 );

C := CategoryOfQuiverRepresentations( A );
C_injs := FullSubcategoryGeneratedByInjectiveObjects( C );
chains_C := ChainComplexCategory( C );
homotopy_C := HomotopyCategory( C );
derived_C := DerivedCategory( C );

collection := CreateExceptionalCollection( IndecProjectiveObjects( C ) );

HH := HomFunctorByExceptionalCollection( collection );
HI := RestrictionOfHomFunctorByExceptionalCollectionToInjectiveObjects( collection );
homotopy_HH := PreCompose( LocalizationFunctorByInjectiveObjects( homotopy_C ), ExtendFunctorToHomotopyCategories( HI ) );


TT := TensorFunctorByExceptionalCollection( collection );

D := AsCapCategory( Source( TT ) );
D_projs := FullSubcategoryGeneratedByProjectiveObjects( D );
chains_D := ChainComplexCategory( D );
homotopy_D := HomotopyCategory( D );
derived_D := DerivedCategory( D );

TP := RestrictionOfTensorFunctorByExceptionalCollectionToProjectiveObjects( collection );
homotopy_TT := PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_D ), ExtendFunctorToHomotopyCategories( TP ) );

ii := IndecInjectiveObjects( C );
pp := IndecProjectiveObjects( D );

b := RANDOM_CHAIN_COMPLEX( chains_C, -3, 3, 2 );
ObjectsSupport( b );
homotopy_HH_b := ApplyFunctor( homotopy_HH, b / homotopy_C );
Display( homotopy_HH_b );
homotopy_TT_homotopy_HH_b := ApplyFunctor( homotopy_TT, homotopy_HH_b );
r := UnderlyingCell( homotopy_TT_homotopy_HH_b );
ViewComplex( r );
HomologyAt( b, 0 ); HomologyAt( r, 0 );
HomologyAt( b, -1 ); HomologyAt( r, -1 );
HomologyAt( b, -2 ); HomologyAt( r, -2 );
HomologyAt( b, 0 ); HomologyAt( r, 0 );
HomologyAt( b, 1 ); HomologyAt( r, 1 );
HomologyAt( b, 2 ); HomologyAt( r, 2 );

