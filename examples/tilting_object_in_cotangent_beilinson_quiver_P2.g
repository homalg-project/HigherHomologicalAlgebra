LoadPackage( "DerivedCategories" );

field := GLOBAL_FIELD_FOR_QPA!.default_field;
#magma := HomalgFieldOfRationalsInMAGMA( );
magma := field;

SET_GLOBAL_FIELD_FOR_QPA( magma );
SetInfoLevel( InfoDerivedCategories, 3 );

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

cat := CategoryOfQuiverRepresentations( A, magma );
chains_cat := ChainComplexCategory( cat );
homotopy_cat := HomotopyCategory( cat );
derived_cat := DerivedCategory( cat );

pp := IndecProjRepresentations( A );

ii := IndecInjRepresentations( A );

matrix_cat := RangeCategoryOfHomomorphismStructure( cat );

cat_projs := FullSubcategoryGeneratedByProjectiveObjects( cat );
cat_indec_projs := FullSubcategoryGeneratedByIndecProjectiveObjects( cat );
add_cat_indec_projs := AdditiveClosure( cat_indec_projs );

cat_injs := FullSubcategoryGeneratedByInjectiveObjects( cat );
cat_indec_injs := FullSubcategoryGeneratedByIndecInjectiveObjects( cat );
add_cat_indec_injs := AdditiveClosure( cat_indec_injs );

# decomposition functor: cat_projs ---> add_cat_indec_projs
dec_proj_func := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( cat );

# decomposition functor: cat_injs ---> add_cat_indec_injs
dec_inj_func := EquivalenceFromFullSubcategoryGeneratedByInjectiveObjectsIntoAdditiveClosureOfIndecInjectiveObjects( cat );


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


collection := CreateExceptionalCollection( T );

# right A-representations -> right End(T)-representations
# i.e., cat ---> right End(T)-representations
F := HomFunctorByExceptionalCollection( collection );

# if we want to apply F only on injective objects we can compute the restriction to injective objects
# i.e., cat_injs -> right End(T)-representations

F_on_injs_1 := RestrictFunctorToFullSubcategoryOfSource( F, cat_injs );

# to compute faster, we can restrict the functor to cat_indec_injs
# i.e., cat_indec_injs ---> right End(T)-representations
r_F := RestrictFunctorToFullSubcategoryOfSource( F_on_injs_1, cat_indec_injs );

# and then extend to the additive closure of the source
# i.e., add_cat_indec_injs ---> right End(T)-representations
add_r_F := ExtendFunctorToAdditiveClosureOfSource( r_F );

# now we precompose with dec_inj_func

F_on_injs_2 := PreCompose( dec_inj_func, add_r_F );

G := RestrictionOfHomFunctorByExceptionalCollectionToIndecInjectiveObjects( collection );
add_G := ExtendFunctorToAdditiveClosureOfSource( G );

F_on_injs_3 := PreCompose( dec_inj_func, add_G );

# none, weak or crisp
list_for_caches :=
  [
    [ cat, "weak" ],
    [ matrix_cat, "none" ],
    [ cat_projs, "none" ],
    [ cat_injs, "none" ],
    [ cat_indec_projs, "weak" ],
    [ cat_indec_injs, "weak" ],
    [ add_cat_indec_projs, "weak" ],
    [ add_cat_indec_injs, "weak" ],
  ];

Apply( list_for_caches,
  function( l ) 
    SetCachingOfCategory( l[1], l[2] );
    return true;
end );

quit;

L := List( [ 1 .. 15 ], i -> Random( ii ) );
a := DirectSum( L );

b1 := ApplyFunctor( F_on_injs_1, a/cat_injs );time;

b2 := ApplyFunctor( F_on_injs_2, a/cat_injs );time;

b3 := ApplyFunctor( F_on_injs_3, a/cat_injs );time;

