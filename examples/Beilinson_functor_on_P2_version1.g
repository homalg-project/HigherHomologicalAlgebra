LoadPackage( "DerivedCategories" );

field := GLOBAL_FIELD_FOR_QPA!.default_field;
#magma := HomalgFieldOfRationalsInMAGMA( );
magma := field;

list_of_operations := [
                        #"PreCompose",
                        "AdditionForMorphisms",
                        "AdditiveInverse",
                        "MultiplyWithElementOfCommutativeRingForMorphisms",
                        "IsZeroForObjects"
                      ];

SET_GLOBAL_FIELD_FOR_QPA( magma );
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
o := TwistedGradedFreeModule( S, 0 );

BB := BeilinsonFunctor( S );

homotopy_C := AsCapCategory( Range( BB ) );
DisableSanityChecks( homotopy_C );
DeactivateCachingOfCategory( homotopy_C );
CapCategorySwitchLogicOff( homotopy_C );

chains_C := UnderlyingCapCategory( homotopy_C );
DisableSanityChecks( chains_C );
DeactivateCachingOfCategory( chains_C );
CapCategorySwitchLogicOff( chains_C );

C := DefiningCategory( homotopy_C );
DisableSanityChecks( C );
#DeactivateCachingOfCategory( C );
CapCategorySwitchLogicOff( C );

indec_proj_C := FullSubcategoryGeneratedByIndecProjectiveObjects( C );
DeactivateCachingForCertainOperations( indec_proj_C, list_of_operations );


L := List( [ -3, -2, -1 ], i -> ApplyFunctor( BB, o[ i ] ) );
collection := CreateExceptionalCollection( L );

HH := HomFunctorByExceptionalCollection( collection );
HP := RestrictionOfHomFunctorByExceptionalCollectionToProjectiveObjects( collection );
homotopy_HH := PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_C ), ExtendFunctorToHomotopyCategories( HP ) );

D := AsCapCategory( Range( HH ) );
DisableSanityChecks( D );
DeactivateCachingOfCategory( D );
CapCategorySwitchLogicOff( D );

homotopy_D := HomotopyCategory( D );
DisableSanityChecks( homotopy_D );
DeactivateCachingOfCategory( homotopy_D );
CapCategorySwitchLogicOff( homotopy_D );

chains_D := UnderlyingCapCategory( homotopy_D );
DisableSanityChecks( chains_D );
DeactivateCachingOfCategory( chains_D );
CapCategorySwitchLogicOff( chains_D );


TT := TensorFunctorByExceptionalCollection( collection );
TP := RestrictionOfTensorFunctorByExceptionalCollectionToProjectiveObjects( collection );
homotopy_TT := PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_D ), ExtendFunctorToHomotopyCategories( TP ) );

b := RANDOM_CHAIN_COMPLEX( chains_C, -3, 3, 4 ) / homotopy_C;

