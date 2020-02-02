ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );

graded_lp := GradedLeftPresentations( S );

BB := BeilinsonFunctor3( S );

omegas := UnderlyingCategory( DefiningCategory( AsCapCategory( Range( BB ) ) ) );
collection := CreateExceptionalCollection( omegas : name_for_underlying_quiver := "quiver{Ω^2(2)-{3}->Ω^1(1)-{3}->Ω^0(0)}",
                                                    name_for_endomorphism_algebra := "End(⊕ {Ω^i(i)|i=0,1,2})"
                                                  );

algebroid := Algebroid( collection );
DeactivateCachingForCertainOperations( algebroid, operations_to_deactivate );

iso := IsomorphismIntoAlgebroid( collection );
iso := ExtendFunctorToAdditiveClosures( iso );
iso := ExtendFunctorToHomotopyCategories( iso );

BB := PreCompose( BB, iso );

o := TwistedGradedFreeModule( S, 0 );
L := List( [ -3, -2, -1 ], i -> ApplyFunctor( BB, o[ i ] ) );
name_for_quiver := "quiver{𝓞 (-3) -{3}-> 𝓞 (-2) -{3}-> 𝓞 (-1)}";
name_for_algebra := "End(⊕ {𝓞 (i)|i=-3,-2,-1})";
collection := CreateExceptionalCollection( L : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );

algebroid := Algebroid( collection );
DeactivateCachingForCertainOperations( algebroid, operations_to_deactivate );
iso := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
iso := ExtendFunctorToAdditiveClosures( iso );
iso := ExtendFunctorToHomotopyCategories( iso );
HA := HomFunctorOnAdditiveClosure( collection );
HH := ExtendFunctorToHomotopyCategories( HA );

D := AsCapCategory( Range( HA ) );

eq := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( D );
eq := ExtendFunctorToHomotopyCategories( eq );
Loc := PreCompose( LocalizationFunctorByProjectiveObjects( HomotopyCategory( D ) ), eq );

HH := PreCompose( [ HH, Loc, iso ] );

TT := IsomorphismFromAlgebroid( collection );
TT := PreCompose( TT, InclusionFunctor( DefiningFullSubcategory( collection ) ) );
TT := ExtendFunctorToAdditiveClosureOfSource( TT );
TT := ExtendFunctorToHomotopyCategories( TT );

# to embedd in some category with homologies

iso := IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra(
          Algebroid( ExceptionalCollection( omegas ) )
        );
inc := PreCompose( iso, InclusionFunctor( AsCapCategory( Range( iso ) ) ) );
inc := ExtendFunctorToAdditiveClosureOfSource( inc );
inc := ExtendFunctorToHomotopyCategories( inc );

quit;

a := "0,0,0,0,0,-2,-x0*x1-x1^2, 0,2,-x0-2*x2,-5,2*x0*x1,-3*x2,0,0, 2,0,3*x0,-2*x0^2-x0*x1,0,2,-x0-x1,-2,-x0^2, x0^2,1,-1,-x0,2,3*x0*x1,-x0,0,0,-1,0,x0";
a := HomalgMatrix( a, 6, 6, S );
a := AsGradedLeftPresentation( a, [ 0, 2, 2, 1, 2, 0 ] );

# or
# a := RandomObject( graded_lp, 8 );
# a := TwistedGradedFreeModule( S, -4 );

a := BB( a );
conv_a := Convolution( TT( HH( a ) ) );

a := inc( a );
conv_a := inc( conv_a );

