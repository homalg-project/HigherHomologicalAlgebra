LoadPackage( "DerivedCategories" );
LoadPackage( "BBGG" );

##########################################

list_of_operations := [
                        #"PreCompose",
                        "AdditionForMorphisms",
                        "AdditiveInverse",
                        "MultiplyWithElementOfCommutativeRingForMorphisms",
                        "IsZeroForObjects"
                      ];
                      
########################### global options ###############################
#
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );
#
DISABLE_ALL_SANITY_CHECKS := true;
SWITCH_LOGIC_OFF := true;
ENABLE_COLORS := true;
DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS :=
  [ IsChainComplexCategory,
    IsCochainComplexCategory,
    IsHomotopyCategory,
    IsAdditiveClosureCategory,
    IsQuiverRepresentationCategory,
    # or some function
  ];

#
field := GLOBAL_FIELD_FOR_QPA!.default_field;
#homalg_field := HomalgFieldOfRationalsInSingular( );
#homalg_field := HomalgFieldOfRationalsInMAGMA( );
homalg_field := field;
SET_GLOBAL_FIELD_FOR_QPA( homalg_field );
#
########################################################################


S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );

BB := BeilinsonFunctor( S );

Ho_C := AsCapCategory( Range( BB ) );
Ch_C := UnderlyingCategory( Ho_C );
C := DefiningCategory( Ho_C );

indec_C := FullSubcategoryGeneratedByIndecProjectiveObjects( C );
DeactivateCachingForCertainOperations( indec_C, list_of_operations );


o := TwistedGradedFreeModule( S, 0 );
L := List( [ -2, -1, 0 ], i -> ApplyFunctor( BB, o[ i ] ) );
name_for_quiver := "quiver{𝓞 (-2) -{3}-> 𝓞 (-1) -{3}-> 𝓞 }";
name_for_algebra := "End(⊕ {𝓞 (i)|i=-2,-1,0})";
collection := CreateExceptionalCollection( L : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );

HH := HomFunctor( collection );
HP := HomFunctorOnProjectiveObjects( collection );
homotopy_HH := PreCompose( LocalizationFunctorByProjectiveObjects( Ho_C ), ExtendFunctorToHomotopyCategories( HP ) );

D := AsCapCategory( Range( HH ) );
Ho_D := HomotopyCategory( D );
Ch_D := UnderlyingCategory( Ho_D );

TP := TensorFunctorOnProjectiveObjects( collection );
homotopy_TT := PreCompose( 
                  LocalizationFunctorByProjectiveObjects( Ho_D ), 
                  ExtendFunctorToHomotopyCategories( TP : name_for_functor := "Extension of - ⊗_{End T} T to homotopy categories" )
                  );

Inc := InclusionFunctorOfHomotopyCategory( collection );

#################################

cell_func := cell -> Convolution( UnderlyingCell( PreCompose( [ homotopy_HH, homotopy_TT, Inc ] )( cell ) ) );

b := RANDOM_CHAIN_COMPLEX( Ch_C, -2, 1, 3 ) / Ho_C;

quit;

b;
conv_b := cell_func( b );

HomologySupport( b );
HomologySupport( conv_b );

