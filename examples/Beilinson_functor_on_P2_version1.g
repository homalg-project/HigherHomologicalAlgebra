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

DISABLE_ALL_SANITY_CHECKS_AND_LOGIC[ 1 ] := true;
DISABLE_ALL_SANITY_CHECKS_AND_LOGIC[ 2 ] := true;
SET_GLOBAL_FIELD_FOR_QPA( magma );
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
o := TwistedGradedFreeModule( S, 0 );

BB := BeilinsonFunctor( S );

homotopy_C := AsCapCategory( Range( BB ) );
DeactivateCachingOfCategory( homotopy_C );

chains_C := UnderlyingCapCategory( homotopy_C );
DeactivateCachingOfCategory( chains_C );

C := DefiningCategory( homotopy_C );
DeactivateCachingOfCategory( C );

indec_proj_C := FullSubcategoryGeneratedByIndecProjectiveObjects( C );
DeactivateCachingForCertainOperations( indec_proj_C, list_of_operations );


L := List( [ -2, -1, 0 ], i -> ApplyFunctor( BB, o[ i ] ) );
collection := CreateExceptionalCollection( L );

HH := HomFunctorByExceptionalCollection( collection );
HP := RestrictionOfHomFunctorByExceptionalCollectionToProjectiveObjects( collection );
homotopy_HH := PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_C ), ExtendFunctorToHomotopyCategories( HP ) );

D := AsCapCategory( Range( HH ) );
DeactivateCachingOfCategory( D );

homotopy_D := HomotopyCategory( D );
DeactivateCachingOfCategory( homotopy_D );

chains_D := UnderlyingCapCategory( homotopy_D );
DeactivateCachingOfCategory( chains_D );


TT := TensorFunctorByExceptionalCollection( collection );
TP := RestrictionOfTensorFunctorByExceptionalCollectionToProjectiveObjects( collection );
homotopy_TT := PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_D ), ExtendFunctorToHomotopyCategories( TP ) );

cell_func := cell -> Convolution( UnderlyingCell( PreCompose( homotopy_HH, homotopy_TT )( cell ) ) );

b := RANDOM_CHAIN_COMPLEX( chains_C, -2, 1, 3 ) / homotopy_C;

quit;

b;
conv_b := cell_func( b );

