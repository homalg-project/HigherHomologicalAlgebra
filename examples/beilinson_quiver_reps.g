LoadPackage( "HomotopyCategoriesForCAP" );
LoadPackage( "QPA" );
LoadPackage( "LinearAlgebraForCAP" );
LoadPackage( "DerivedCategories" );

#field := Rationals;;
field := HomalgFieldOfRationals( );

quiver := RightQuiver( "q(4)[x0:1->2,x1:1->2,x2:1->2,x3:1->2,y0:2->3,y1:2->3,y2:2->3,y3:2->3,z0:3->4,z1:3->4,z2:3->4,z3:3->4]" );;
Qq := PathAlgebra( field, quiver );;

# End( O(0) ⊕ O(1) ⊕ O(2) ⊕ O(3) )
#
# A :=
  QuotientOfPathAlgebra(
    Qq,
    [ Qq.x0 * Qq.y1 - Qq.x1 * Qq.y0,
      Qq.x0 * Qq.y2 - Qq.x2 * Qq.y0,
      Qq.x0 * Qq.y3 - Qq.x3 * Qq.y0,
      Qq.x1 * Qq.y2 - Qq.x2 * Qq.y1,
      Qq.x1 * Qq.y3 - Qq.x3 * Qq.y1,
      Qq.x2 * Qq.y3 - Qq.x3 * Qq.y2,
      Qq.y0 * Qq.z1 - Qq.y1 * Qq.z0,
      Qq.y0 * Qq.z2 - Qq.y2 * Qq.z0,
      Qq.y0 * Qq.z3 - Qq.y3 * Qq.z0,
      Qq.y1 * Qq.z2 - Qq.y2 * Qq.z1,
      Qq.y1 * Qq.z3 - Qq.y3 * Qq.z1,
      Qq.y2 * Qq.z3 - Qq.y3 * Qq.z2
    ]
);;

# 
# End( Ω^0(0) ⊕ Ω^1(1) ⊕ Ω^2(2) ⊕ Ω^3(3) )

A :=
  QuotientOfPathAlgebra(
    Qq,
    [ 
      Qq.x0 * Qq.y0 , Qq.y0 * Qq.z0,
      Qq.x1 * Qq.y1 , Qq.y1 * Qq.z1,
      Qq.x2 * Qq.y2 , Qq.y2 * Qq.z2,
      Qq.x3 * Qq.y3 , Qq.y3 * Qq.z3,
      Qq.x0 * Qq.y1 + Qq.x1 * Qq.y0,
      Qq.x0 * Qq.y2 + Qq.x2 * Qq.y0,
      Qq.x0 * Qq.y3 + Qq.x3 * Qq.y0,
      Qq.x1 * Qq.y2 + Qq.x2 * Qq.y1,
      Qq.x1 * Qq.y3 + Qq.x3 * Qq.y1,
      Qq.x2 * Qq.y3 + Qq.x3 * Qq.y2,
      Qq.y0 * Qq.z1 + Qq.y1 * Qq.z0,
      Qq.y0 * Qq.z2 + Qq.y2 * Qq.z0,
      Qq.y0 * Qq.z3 + Qq.y3 * Qq.z0,
      Qq.y1 * Qq.z2 + Qq.y2 * Qq.z1,
      Qq.y1 * Qq.z3 + Qq.y3 * Qq.z1,
      Qq.y2 * Qq.z3 + Qq.y3 * Qq.z2
    ]
);;

SetIsAdmissibleQuiverAlgebra( A, true );

cat := CategoryOfQuiverRepresentations( A : FinalizeCategory := false );;
cat!.compute_basis_of_hom_using_homalg := [ true, 1, field ]; 
SetIsLinearCategoryOverCommutativeRing( cat, true );;
SetCommutativeRingOfLinearCategory( cat, field );;
Finalize( cat );;


full := FullSubcategoryGeneratedByListOfObjects( IndecProjRepresentations( A ) );
collection := CreateExceptionalCollection( full );
B := EndomorphismAlgebraOfExceptionalCollection( collection );
algebroid := Algebroid( B );


F := IsomorphismIntoAlgebroid( collection );
G := IsomorphismFromAlgebroid( collection );

add_F := ExtendFunctorToAdditiveClosures( F );
Ho_add_F := ExtendFunctorToHomotopyCategoryFunctor( add_F );

additive_full := AsCapCategory( Source( add_F ) );
additive_alg := AsCapCategory( Range( add_F ) );

a := AdditiveClosureObject( [ collection[1], collection[2] ], additive_full );
add_F_a := ApplyFunctor( add_F, IdentityMorphism( a ) );

I := IsomorphismIntoFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );
J := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( algebroid );

