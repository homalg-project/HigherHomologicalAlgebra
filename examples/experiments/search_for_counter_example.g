ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################

SetInfoLevel( InfoDerivedCategories, 1 );
SetInfoLevel( InfoHomotopyCategories, 1 );
SetInfoLevel( InfoComplexCategoriesForCAP, 1 );

# create graded polynomial ring
Q := HomalgFieldOfRationalsInSingular( );
S := CoxRingForProductOfProjectiveSpaces( Q, [ 1, 2 ] );

# create the Beilinson functor
U := BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows( S );
U := ExtendFunctorToHomotopyCategories( U );

twisted_omegas := FullSubcategoryGeneratedByBoxProductOfTwistedCotangentModules( S );

# Geometry
rows := CategoryOfGradedRows( S );
freyd := FreydCategory( rows );
fpres := GradedLeftPresentations( S );
coh_P1xP2 := CoherentSheavesOverProductOfProjectiveSpaces( S );
Sh := SheafificationFunctor( coh_P1xP2 );

# Algebra
A_1 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[1] );
A_2 := EndomorphismAlgebraOfCotangentBeilinsonCollection( S!.factor_rings[2] );
algebra := TensorProductOfAlgebras( A_1, A_2 );

algebroid := Algebroid( algebra );
qrows := QuiverRows( algebra );
qreps := CategoryOfQuiverRepresentations( algebra );

N := 1;
while true do
  
  Display( "Creating new objects" );
  a := RandomObject( HomotopyCategory( rows ), 1 );
  
  while true do
    b := RandomObject( HomotopyCategory( rows ), 1 );
    hom_a_b := BasisOfExternalHom(a,b);
    if not IsEmpty( hom_a_b ) then
      break;
    fi;
  od;
  
  while true do
    c := RandomObject( HomotopyCategory( rows ), 1 );
    hom_b_c := BasisOfExternalHom(b,c);
    if not IsEmpty( hom_b_c ) then
      break;
    fi;
  od;
 
  for alpha in hom_a_b do
    for beta in hom_b_c do
      Display( alpha );
      Display( beta );
      if IsCongruentForMorphisms( Convolution( PreCompose( U(alpha), U(beta) ) ), PreCompose( Convolution( U(alpha) ), Convolution( U(beta) ) ) ) then
        Print( "#########################################################################\n" );
        Display( N );
        Print( "Seems ok!\n" );
        Print( "#########################################################################\n" );        
      else
        Error( "Counter example found\n" );
      fi;
      N := N + 1;
    od;
  od;
  
od;

