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
DISABLE_COLORS[ 1 ] := false;
SET_GLOBAL_FIELD_FOR_QPA( magma );
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 1 );
SetInfoLevel( InfoComplexCategoriesForCAP, 1 );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0,x1" );
o := TwistedGradedFreeModule( S, 0 );

BB := BeilinsonFunctor( S );

homotopy_C := AsCapCategory( Range( BB ) );
DeactivateCachingOfCategory( homotopy_C );

chains_C := UnderlyingCategory( homotopy_C );
DeactivateCachingOfCategory( chains_C );

C := DefiningCategory( homotopy_C );
DeactivateCachingOfCategory( C );

#################################

eq := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( C );
eq := ExtendFunctorToHomotopyCategories( eq );
Loc := PreCompose( LocalizationFunctorByProjectiveObjects( HomotopyCategory( C ) ), eq );

################ create the collection o(-2), o(-1), o(0) #####################
name := "quiver{𝓞 (-2),𝓞 (-1)}";
L := List( [ -2, -1 ], i -> ApplyFunctor( PreCompose( BB, Loc ), o[ i ] ) );
collection := CreateExceptionalCollection( L : name_for_underlying_quiver := name );
################################################################################


################# Hom #################################
HH := HomFunctor( collection );
HP := HomFunctorOnAdditiveClosure( collection );
homotopy_HH := ExtendFunctorToHomotopyCategories( HP );
########################################################

Ho_C := AsCapCategory( Source( HH ) );
DeactivateCachingOfCategory( Ho_C );

C := DefiningCategory( Ho_C ); # or AsCapCategory( Source( HP ) );
DeactivateCachingOfCategory( C );

indec_C := UnderlyingCategory( C ); # caching for this is crisp
DeactivateCachingForCertainOperations( indec_C, list_of_operations );

D := AsCapCategory( Range( HH ) );
DeactivateCachingOfCategory( D );

homotopy_D := HomotopyCategory( D );
DeactivateCachingOfCategory( homotopy_D );

chains_D := UnderlyingCategory( homotopy_D );
DeactivateCachingOfCategory( chains_D );

##########################################################
inc := PreCompose( InclusionFunctor( indec_C ), InclusionFunctor( AsCapCategory( Range( InclusionFunctor( indec_C ) ) ) ) );
inc := ExtendFunctorToAdditiveClosureOfSource( inc );
inc := ExtendFunctorToHomotopyCategories( inc );
##########################################################

################### Tensor ###############################
TP := TensorFunctorOnProjectiveObjects( collection );
homotopy_TT := PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_D ), ExtendFunctorToHomotopyCategories( TP ) );
##########################################################

# this can be applied on objects and morphisms
cell_func := cell -> Convolution( UnderlyingCell( PreCompose( homotopy_HH, homotopy_TT )( cell ) ) );


b := RANDOM_CHAIN_COMPLEX( chains_C, -4, 4, 3 );
b := ApplyFunctor( Loc, b/homotopy_C );

quit;

b;
conv_b := cell_func( b );

inc_b := inc( b );
inc_conv_b := inc( conv_b );

HomologySupport( inc_conv_b );
HomologySupport( inc_b );

