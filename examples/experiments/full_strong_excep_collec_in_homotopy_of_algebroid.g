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
################## start ##################################

o := TwistedGradedFreeModule( S, 0 );
L := List( [ -1, 0, 1 ], i -> ApplyFunctor( BB, o[ i ] ) );
name_for_quiver := "quiver{𝓞 (-2) -{3}-> 𝓞 (-1) -{3}-> 𝓞 (0)}";
name_for_algebra := "End(⊕ {𝓞 (i)|i=-2,-1,0})";
collection := CreateExceptionalCollection( L : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );


algebroid := Algebroid( collection );
add_algebroid := AdditiveClosure( algebroid );
ch_add_algebroid := ChainComplexCategory( add_algebroid );
ho_add_algebroid := HomotopyCategory( add_algebroid );

I := ExtendFunctorToHomotopyCategories(
        ExtendFunctorToAdditiveClosures(
            IsomorphismFromAlgebroid( collection )
              ) );
Conv := ConvolutionFunctor( collection );
F := PreCompose( I, Conv );

quit;

l := -1;
u := 1;
i := 1;
N := 1;

while true do
  
  while true do
    a := RandomChainComplex( ch_add_algebroid, l, u, i ) / ho_add_algebroid;
    if not IsZero( a ) then
      Display( "a = " );
      Display( a );
      break;
    fi;
  od;
  
  while true do
    b := RandomChainComplex( ch_add_algebroid, l, u, i ) / ho_add_algebroid;
    hom_a_b := BasisOfExternalHom( a, b );
    if not IsEmpty( hom_a_b ) then
      Display( "b = " );
      Display( b );
      break;
    fi;
  od;
  
  while true do
    c := RandomChainComplex( ch_add_algebroid, l, u, i ) / ho_add_algebroid;
    hom_b_c := BasisOfExternalHom( b, c );
    hom_a_c := BasisOfExternalHom( a, c );
    if not IsEmpty( hom_a_c ) and not IsEmpty( hom_b_c ) then
      Display( "c = " );
      Display( c );
      break; 
    fi;
  od;
  
  for i in [ 1 .. 10 ] do
    alpha := List( [ 1 .. Size( hom_a_b ) ], i -> Random( [ -1, 0, 1 ] ) ) * hom_a_b;
    beta :=  List( [ 1 .. Size( hom_a_b ) ], i -> Random( [ -1, 0, 1 ] ) ) * hom_b_c;
    bool := CheckFunctoriality( F, alpha, beta );
    if bool = false then
      Error( "Counter example has been found!" );
    else
      Print( "N = ", N );
      Print( "\nIT STILL SEEMS FUNCTORIAL!!\n" );
      N := N + 1;
    fi;
    
  od;
  
od;
