ReadPackage( "DerivedCategories", "examples/pre_settings.g" );

k := HomalgFieldOfRationals();;
Q := RightQuiver( "q(4)[a:4->2,b:2->1,c:4->3,d:3->1]" );;
kQ := PathAlgebra( k, Q );;
rel := [ kQ.a*kQ.b - kQ.c*kQ.d ];;
A := kQ / rel;;
AA := QuiverRows( A );; # I suggest using QuiverRows
HA := HomotopyCategory( AA );;
P1 := HA.1;;
P2 := HA.2;;
P3 := HA.3;;
P4 := HomotopyCategoryObject( [ MorphismBetweenDirectSums( [ [ AA.a, AA.c ] ] ) ], 1 );;
collection := CreateExceptionalCollection( [ P1, P2, P3, P4 ] );;
B := EndomorphismAlgebra( collection );;
QuiverOfAlgebra( B );;
Conv := ConvolutionFunctor( collection );;
Rep := ReplacementFunctor( collection );;
for P in [ P1, P2, P3, P4 ] do
  h := BasisOfExternalHom( P, Conv( Rep( P ) ) );
  Display( Length(h)=1 and IsIsomorphism( h[1] ) );
od;
#I := IsomorphismOntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( Aoid );
#iota := EmbeddingFunctorIntoDerivedCategory( SourceOfFunctor( Conv ) );
# This exceptional collection comes form objects that lives in abelian category Hence, we
# can create it in the abelian category and then use RHom(T,-) and LTensor(T,-)

#iota := EmbeddingFunctorIntoDerivedCategory( HA );
#HomologySupport( iota( P4 ) );
#Q1 := HomologyAt( iota( P1 ), 0 );
#Q2 := HomologyAt( iota( P2 ), 0 );
#Q3 := HomologyAt( iota( P3 ), 0 );
#Q4 := HomologyAt( iota( P4 ), 0 );
# C := CreateExceptionalCollection( [ Q1, Q2, Q3, Q4 ], [ "1111", "0101", "0011", "0111" ] );
#End_C := EndomorphismAlgebra( C );
#Dimension( End_C );
#QuiverOfAlgebra( End_C );

#hom := HomFunctor( C );
#Rhom := RightDerivedFunctor( hom );
#
#ten := TensorFunctor( C );
#Lten := LeftDerivedFunctor( ten );
#
#Display( Rhom );
#Display( Lten );
#
#BasisOfExternalHom( iota( P1 ), Lten( Rhom( iota( P1 ) ) ) );
#BasisOfExternalHom( iota( P2 ), Lten( Rhom( iota( P2 ) ) ) );
#BasisOfExternalHom( iota( P3 ), Lten( Rhom( iota( P3 ) ) ) );
#BasisOfExternalHom( iota( P4 ), Lten( Rhom( iota( P4 ) ) ) );

