ReadPackage( "DerivedCategories", "examples/pre_settings.g" );

k := HomalgFieldOfRationals();;
Q := RightQuiver( "q(4)[a:4->2,b:2->1,c:4->3,d:3->1]" );;
kQ := PathAlgebra( k, Q );;
rel := [ kQ.a*kQ.b - kQ.c*kQ.d ];;
A := kQ / rel;;
Aoid := Algebroid( A );;
AA := AdditiveClosure( Aoid );; # I suggest using QuiverRows
HA := HomotopyCategory( AA );;
P1 := HA.1;;
P2 := HA.2;;
P3 := HA.3;;
P4 := HomotopyCategoryObject( [ MorphismBetweenDirectSums( [ [ Aoid.a/AA, Aoid.c/AA ] ] ) ], 1 );;
c := CreateExceptionalCollection( [ P1, P2, P3, P4 ] );;
B := EndomorphismAlgebra(c);;
QuiverOfAlgebra( B );;
Conv := ConvolutionFunctorFromHomotopyCategoryOfAdditiveClosureOfAlgebroid( c );;
Rep := ReplacementFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid( c );;
for P in [ P1, P2, P3, P4 ] do
  h := BasisOfExternalHom( P, Conv( Rep( P ) ) );
  Display( Length(h)=1 and IsIsomorphism( h[1] ) );
od;
#I := IsomorphismOntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( Aoid );
#iota := EmbeddingFunctorIntoDerivedCategory( SourceOfFunctor( Conv ) );
# This exceptional collection comes form objects that lives in abelian category Hence, we
# can create it in the abelian category and then use RHom(T,-) and LTensor(T,-)

iota := EmbeddingFunctorIntoDerivedCategory( HA );
HomologySupport( iota( P4 ) );
Q1 := HomologyAt( iota( P1 ), 0 );
Q2 := HomologyAt( iota( P2 ), 0 );
Q3 := HomologyAt( iota( P3 ), 0 );
Q4 := HomologyAt( iota( P4 ), 0 );
C := CreateExceptionalCollection( [ Q1, Q2, Q3, Q4 ], [ "1111", "0101", "0011", "0111" ] );

hom := HomFunctor(C);
Rhom := RightDerivedFunctor( hom );

ten := TensorFunctor(C);
Lten := LeftDerivedFunctor( ten );

Display( Rhom );
Display( Lten );

BasisOfExternalHom( iota( P1 ), LTen( Rhom( iota( P1 ) ) ) );
BasisOfExternalHom( iota( P2 ), LTen( Rhom( iota( P2 ) ) ) );
BasisOfExternalHom( iota( P3 ), LTen( Rhom( iota( P3 ) ) ) );
BasisOfExternalHom( iota( P4 ), LTen( Rhom( iota( P4 ) ) ) );

