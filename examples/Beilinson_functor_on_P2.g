ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );

BB := BeilinsonFunctor( S );

Ho_reps := AsCapCategory( Range( BB ) );

Ch_reps := UnderlyingCategory( Ho_reps );

reps := DefiningCategory( Ho_reps );

#################################

eq := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( reps );
eq := ExtendFunctorToHomotopyCategories( eq );
Loc := PreCompose( LocalizationFunctorByProjectiveObjects( HomotopyCategory( reps ) ), eq );

################ create the collection o(-2), o(-1), o(0) #####################
name_for_quiver := "quiver{𝓞 (-3) -{3}-> 𝓞 (-2) -{3}-> 𝓞 (-1)}";
name_for_algebra := "End(⊕ {𝓞 (i)|i=-3,-2,-1})";
o := TwistedGradedFreeModule( S, 0 );
L := List( [ -3, -2, -1 ], i -> ApplyFunctor( PreCompose( BB, Loc ), o[ i ] ) );
collection := CreateExceptionalCollection( L : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );
################################################################################


################# Hom #################################
H := HomFunctorOnDefiningCategory( collection );
H := ExtendFunctorToHomotopyCategories( H : name_for_functor := "Extension of Hom(T,-) to homotopy categories" );
########################################################

Ho_C := AsCapCategory( Source( H ) );
Ch_C := UnderlyingCategory( Ho_C );
C := DefiningCategory( Ho_C ); # or AsCapCategory( Source( HP ) );

indec_C := UnderlyingCategory( C ); # caching for this is crisp
DeactivateCachingForCertainOperations( indec_C, operations_to_deactivate );
#ActivateCachingForCertainOperations( indec_C, operations_to_activate );

##########################################################
inc := InclusionFunctor( indec_C );
inc := ExtendFunctorToAdditiveClosureOfSource( inc );
inc := ExtendFunctorToHomotopyCategories( inc : name_for_functor := "Extension the inclusion functor to homotopy categories" );
# embedd in a category where homology makes sence.

##########################################################


################### Tensor ###############################

T := TensorFunctor( collection );
Conv := ConvolutionFunctor( collection );

##########################################################

# to compute replacement in terms of the collection
Rep := PreCompose( [ H, T, Conv ] );

b := Loc( RANDOM_CHAIN_COMPLEX( Ch_reps, -1, 2, 2 ) / Ho_reps );

quit;

b;
rep_b := Rep( b );

inc_b := inc( b );
inc_rep_b := inc( rep_b );

HomologySupport( inc_b );
HomologySupport( inc_rep_b );
