ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..1" );

BB := BeilinsonFunctor( S );

Ho_reps := AsCapCategory( Range( BB ) );

Ch_reps := UnderlyingCategory( Ho_reps );

reps := DefiningCategory( Ho_reps );

#################################

eq := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( reps );
eq := ExtendFunctorToHomotopyCategories( eq );
Loc := PreCompose( LocalizationFunctorByProjectiveObjects( HomotopyCategory( reps ) ), eq );

################ create the collection o(-3), o(-2) #####################
name_for_quiver := "quiver{𝓞 (2) -{2}-> 𝓞 (3)}";
name_for_algebra := "End(⊕ {𝓞 (i)|i=2,3})";
o := TwistedGradedFreeModule( S, 0 );
L := List( [ 2, 3 ], i -> ApplyFunctor( PreCompose( BB, Loc ), o[ i ] ) );
collection := CreateExceptionalCollection( L : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );

indec_C := UnderlyingCategory( DefiningCategory( AmbientCategory( collection ) ) );

inc := InclusionFunctor( indec_C );
inc := ExtendFunctorToAdditiveClosureOfSource( inc );
inc := ExtendFunctorToHomotopyCategories( inc : name_for_functor := "Extension the inclusion functor to homotopy categories" );
# embedd in a category where homology makes sence.


Rep := ReplacementFunctor( collection );
Conv := ConvolutionFunctor( collection );

b := Loc( RANDOM_CHAIN_COMPLEX( Ch_reps, -3, 3, 3 ) / Ho_reps );

quit;

b;
rep_b := Rep( b );
conv_b := Conv( rep_b );

inc_b := inc( b );
inc_conv_b := inc( conv_b );

HomologySupport( inc_b );
HomologySupport( inc_conv_b );
