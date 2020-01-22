LoadPackage( "DerivedCategories" );


##########################################

list_of_operations := [
                        #"PreCompose",
                        "AdditionForMorphisms",
                        "AdditiveInverse",
                        "MultiplyWithElementOfCommutativeRingForMorphisms",
                        "IsZeroForObjects"
                      ];
                      
##########################################

field := GLOBAL_FIELD_FOR_QPA!.default_field;
#magma := HomalgFieldOfRationalsInMAGMA( );
magma := field;

DISABLE_ALL_SANITY_CHECKS_AND_LOGIC[ 1 ] := true;
DISABLE_ALL_SANITY_CHECKS_AND_LOGIC[ 2 ] := true;
SET_GLOBAL_FIELD_FOR_QPA( magma );
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
o := TwistedGradedFreeModule( S, 0 );

BB := BeilinsonFunctor3( S );

homotopy_C := AsCapCategory( Range( BB ) );
DeactivateCachingOfCategory( homotopy_C );

chains_C := UnderlyingCapCategory( homotopy_C );
DeactivateCachingOfCategory( chains_C );

C := DefiningCategory( homotopy_C );
DeactivateCachingOfCategory( C );

L := List( [ -2, -1, 0 ], i -> ApplyFunctor( BB, o[ i ] ) );
collection := CreateExceptionalCollection( L );

HH_additive := RestrictionOfHomFunctorByExceptionalCollectionToAdditiveClosure( collection );
homotopy_HH := ExtendFunctorToHomotopyCategories( HH_additive );

D := AsCapCategory( Range( HH_additive ) );
DeactivateCachingOfCategory( D );

homotopy_D := HomotopyCategory( D );
DeactivateCachingOfCategory( homotopy_D );

chains_D := UnderlyingCapCategory( homotopy_D );
DeactivateCachingOfCategory( chains_D );

TP := RestrictionOfTensorFunctorByExceptionalCollectionToProjectiveObjects( collection );
homotopy_TT := PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_D ), ExtendFunctorToHomotopyCategories( TP ) );

