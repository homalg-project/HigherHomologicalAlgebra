LoadPackage( "DerivedCategories" );

field := HomalgFieldOfRationals( );

quiver := RightQuiver( "q(3)[x0:1->2,x1:1->2,x2:1->2,y0:2->3,y1:2->3,y2:2->3]" );;

Qq := PathAlgebra( field, quiver );;

# 
# End( Ω^0(0) ⊕ Ω^1(1) ⊕ Ω^2(2) )

A :=
  QuotientOfPathAlgebra(
    Qq,
    [ 
      Qq.x0 * Qq.y0 ,
      Qq.x1 * Qq.y1 ,
      Qq.x2 * Qq.y2 ,
      Qq.x0 * Qq.y1 + Qq.x1 * Qq.y0,
      Qq.x0 * Qq.y2 + Qq.x2 * Qq.y0,
      Qq.x1 * Qq.y2 + Qq.x2 * Qq.y1,
    ]
);;

cat := CategoryOfQuiverRepresentations( A );

phi := RandomMorphism( cat, 10 );

epi := CokernelProjection( phi );
cok := CokernelObject( phi );
temp1 := RandomMorphismWithFixedRange( cok, 10 );
temp2 := EpimorphismFromSomeProjectiveObject( Source( temp1 ) );
alpha := PreCompose( temp2, temp1 );


emb := KernelEmbedding( phi );
k := KernelObject( phi );
temp1 := RandomMorphismWithFixedSource( k, 10 );
temp2 := MonomorphismIntoSomeInjectiveObject( Range( temp1 ) );
beta := PreCompose( temp1, temp2 );

quit;

l1 := Lift( alpha, epi );
l2 := ProjectiveLift( alpha, epi );
# with mySolutionMat, NullspaceMat, without homalg: 204327, 418,
# with mySolutionMat, NullspaceMat, singular, homalg:
# with mySolutionMat, NullspaceMat, magma, homalg: 263883, 1110



c1 := Colift( emb, beta );
c2 := InjectiveColift( emb, beta );
# with mySolutionMat, NullspaceMat, without homalg: 751948, 1476
# with mySolutionMat, NullspaceMat, singular, homalg:
# with mySolutionMat, NullspaceMat, magma, homalg: ?, 1120

