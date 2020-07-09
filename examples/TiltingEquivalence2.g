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

