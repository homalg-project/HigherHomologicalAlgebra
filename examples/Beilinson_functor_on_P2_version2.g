LoadPackage( "DerivedCategories" );


##########################################

list_of_operations := [
                        "PreCompose", "AdditionForMorphisms", "AdditiveInverse", "MultiplyWithElementOfCommutativeRingForMorphisms",
                        "IsZeroForObjects"
                      ];
                      
##########################################

field := GLOBAL_FIELD_FOR_QPA!.default_field;
#magma := HomalgFieldOfRationalsInMAGMA( );
magma := field;

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
DeactivateCachingOfCategory( C );
CapCategorySwitchLogicOff( C );

#################################

eq := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( C );
eq := ExtendFunctorToHomotopyCategories( eq );
Loc := PreCompose( LocalizationFunctorByProjectiveObjects( HomotopyCategory( C ) ), eq );

################ create the collection o(-3), o(-2), o(-1) #####################
L := List( [ -3, -2, -1 ], i -> ApplyFunctor( PreCompose( BB, Loc ), o[ i ] ) );
collection := CreateExceptionalCollection( L );
################################################################################


################# Hom #################################
HH := HomFunctorByExceptionalCollection( collection );
HP := RestrictionOfHomFunctorByExceptionalCollectionToAdditiveClosure( collection );
homotopy_HH := ExtendFunctorToHomotopyCategories( HP );
########################################################

Ho_C := AsCapCategory( Source( HH ) );
DisableSanityChecks( Ho_C );
DeactivateCachingOfCategory( Ho_C );
CapCategorySwitchLogicOff( Ho_C );

C := DefiningCategory( Ho_C ); # or AsCapCategory( Source( HP ) );
DisableSanityChecks( C );
DeactivateCachingOfCategory( C );
CapCategorySwitchLogicOff( C );

indec_C := UnderlyingCategory( C ); # caching for this is crisp
DeactivateCachingForCertainOperations( indec_C, list_of_operations );

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

################### Tensor ###############################
TT := TensorFunctorByExceptionalCollection( collection );
TP := RestrictionOfTensorFunctorByExceptionalCollectionToProjectiveObjects( collection );
homotopy_TT := PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_D ), ExtendFunctorToHomotopyCategories( TP ) );
##########################################################

quit;

b := RANDOM_CHAIN_COMPLEX( chains_C, -3, 3, 4 );
b := ApplyFunctor( Loc, b/homotopy_C );



