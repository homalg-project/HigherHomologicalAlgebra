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


