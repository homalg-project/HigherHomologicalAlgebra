ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );

BB := BeilinsonFunctor( S );

Ho_C := AsCapCategory( Range( BB ) );
Ch_C := UnderlyingCategory( Ho_C );
C := DefiningCategory( Ho_C );

indec_C := FullSubcategoryGeneratedByIndecProjectiveObjects( C );
DeactivateCachingForCertainOperations( indec_C, operations_to_deactivate );


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

Conv := ConvolutionFunctor( collection );

#################################

cell_func := cell -> PreCompose( [ homotopy_HH, homotopy_TT, Conv ] )( cell );

b := RANDOM_CHAIN_COMPLEX( Ch_C, -2, 1, 3 ) / Ho_C;

quit;

b;
conv_b := cell_func( b );

HomologySupport( b );
HomologySupport( conv_b );

