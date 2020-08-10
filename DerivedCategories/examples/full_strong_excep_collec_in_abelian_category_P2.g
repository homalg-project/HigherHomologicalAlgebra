ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
#############################################################


quiver := RightQuiver( "quiver", 3, [ [ "x0", 1, 2 ], [ "x1", 1, 2 ], [ "x2", 1, 2 ],
                                  [ "y0", 2, 3 ], [ "y1", 2, 3 ], [ "y2", 2, 3 ] ] );;
# "quiver{Ω^0(0),Ω^1(1),Ω^2(2)}"

Qq := PathAlgebra( field, quiver );;

# 
# End(  )

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

C := CategoryOfQuiverRepresentations( A, homalg_field );

C_injs := FullSubcategoryGeneratedByInjectiveObjects( C );
DeactivateCachingOfCategory( C_injs );

chains_C := ChainComplexCategory( C );

homotopy_C := HomotopyCategory( C );

derived_C := DerivedCategory( C );

ii := IndecInjectiveObjects( C );


# O, O(1), O(2)
T := [ ];

mats :=
  [ [ [ 1, 0, 0 ] ], [ [ 0, 1, 0 ] ], [ [ 0, 0, 1 ] ], [ [ 0, 0, 0 ], [ -1, 0, 0 ], [ 0, -1, 0 ] ], [ [ 1, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, -1 ] ], 
    [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 0, 0 ] ] ];
  
mats := List( mats, m -> MatrixByRows( field, m ) );

Add( T, QuiverRepresentation( A, [ 1, 3, 3 ], mats ) );

mats :=
[ [ [ 0, 0, 0, -1, 0, 0, 0, -1 ], [ 0, 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0 ] ],
  [ [ 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 1, 0 ] ],
  [ [ 0, 1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 1 ] ],
  [ [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ],
      [ 0, 0, 0, -1, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ] ], [ [ 0, 0, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ],
      [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ] ],
  [ [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ],
      [ 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 0, 0 ] ] ];
      
mats := List( mats, m -> MatrixByRows( field, m ) );

Add( T, QuiverRepresentation( A, [ 3, 8, 6 ], mats ) );

mats :=
[ [ [ 0, 0, -1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, -1 ],
      [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 ] ],
  [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ] ],
  [ [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ] ],
  [ [ 0, 0, -1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ],
      [ 0, 0, 0, -1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, -1, 0, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, -1, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, -1, 0 ] ],
  [ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 0, -1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1, 0, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, -1 ] ],
  [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ] ];
      
mats := List( mats, m -> MatrixByRows( field, m ) );

Add( T, QuiverRepresentation( A, [ 6, 15, 10 ], mats ) );

name_for_quiver := "quiver{𝓞 -{3}-> 𝓞 (1) -{3}-> 𝓞 (2) }";
name_for_algebra := "End(⊕ {𝓞 (i)|i=0,1,2})";
collection := CreateExceptionalCollection( T : name_for_underlying_quiver := name_for_quiver,
                                                name_for_endomorphism_algebra := name_for_algebra );

H := HomFunctor( collection );
R_H := RightDerivedFunctor( H );
HI := HomFunctorOnInjectiveObjects( collection );
homotopy_H := PreCompose( LocalizationFunctorByInjectiveObjects( homotopy_C ), ExtendFunctorToHomotopyCategories( HI ) );

D := AsCapCategory( Range( H ) );

D_projs := FullSubcategoryGeneratedByProjectiveObjects( D );
DeactivateCachingOfCategory( D_projs );

chains_D := ChainComplexCategory( D );

homotopy_D := HomotopyCategory( D );

derived_D := DerivedCategory( D );


T := TensorFunctor( collection );
L_T := LeftDerivedFunctor( T );

TP := TensorFunctorOnProjectiveObjects( collection );
I := ExtendFunctorToAdditiveClosureOfSource( InclusionFunctor( DefiningFullSubcategory( collection ) ) );
T := PreCompose( TP, I );
homotopy_T := PreCompose( LocalizationFunctorByProjectiveObjects( homotopy_D ), ExtendFunctorToHomotopyCategories( T ) );

eta := CounitOfTensorHomAdjunction( collection );
lambda := UnitOfTensorHomAdjunction( collection );

pp := IndecProjectiveObjects( D );

# RandomObject( chains, [ lower_bound, upper_bound, complexity_of_each_differential ] );
a := RandomObject( chains_C, [ -1, 1, 2 ] )/homotopy_C/derived_C;

quit;

# Computing with homotopy_H & homotopy_T -- faster
# we use the homotopy category of the subcategory generated by injective & projective objects
homotopy_T_homotopy_H_a := homotopy_T( homotopy_H( UnderlyingCell( a ) ) );
ViewHomotopyCategoryObject( homotopy_T_homotopy_H_a );
HomologySupport( homotopy_T_homotopy_H_a );
HomologyAt(homotopy_T_homotopy_H_a, 0 );

# Computing with the right and left derived functors -- slow
# we use the derived category
lten_rhom_a := L_T( R_H( a ) );
HomologySupport( a );
HomologySupport( lten_rhom_a );
HomologyAt( a, 0 );
HomologyAt( lten_rhom_a, 0 );

# counit and unit of tensor-hom in the abelian category
alpha := RandomMorphism( C, 3 );
CheckNaturality( eta, alpha );
beta := RandomMorphism( D, 4 );
CheckNaturality( lambda, beta );

