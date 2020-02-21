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

indec_C := UnderlyingCategory( DefiningCategory( AmbientCategory( collection ) ) );
DeactivateCachingForCertainOperations( indec_C, operations_to_deactivate );

D := CategoryOfQuiverRepresentationsOverOppositeAlgebra( collection );
Ch_D := ChainComplexCategory( D );
Ho_D := HomotopyCategory( D );

L := LocalizationFunctorByProjectiveObjects( HomotopyCategory( D ) );
T := ExtendFunctorToHomotopyCategories( TensorFunctorOnProjectiveObjects( collection ) );
Conv := ConvolutionFunctor( collection );

equivalence := PreCompose( [ L, T, Conv ] );

while true do
  
  while true do
    a := RANDOM_CHAIN_COMPLEX( Ch_D, -1, 2, 1 ) / Ho_D;
    if not IsZero( a ) then
      break;
    fi;
  od;
  
  while true do
    b := RANDOM_CHAIN_COMPLEX( Ch_D, -2, 1, 1 ) / Ho_D;
    hom_a_b := BasisOfExternalHom( a, b );
    if not IsEmpty( hom_a_b ) then
      break;
    fi;
  od;
  
  while true do
    c := RANDOM_CHAIN_COMPLEX( Ch_D, -2, 1, 1 ) / Ho_D;
    hom_b_c := BasisOfExternalHom( b, c );
    hom_a_c := BasisOfExternalHom( a, c );
    if not IsEmpty( hom_a_c ) and not IsEmpty( hom_b_c ) then
      break; 
    fi;
  od;
  
  for i in [ 1 .. 10 ] do
    alpha := List( [ 1 .. Size( hom_a_b ) ], i -> Random( [ -1, 0, 1 ] ) ) * hom_a_b;
    beta :=  List( [ 1 .. Size( hom_a_b ) ], i -> Random( [ -1, 0, 1 ] ) ) * hom_b_c;
    bool := CheckFunctoriality( equivalence, alpha, beta );
    if bool = false then
      Error( "Counter example has been found!" );
    else
      Print( "\n\n\n\nIT SEEMS FUNCTORIAL!!\n\n\n" );
    fi;
  od;
  
od;
