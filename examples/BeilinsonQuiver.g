LoadPackage( "DerivedCategories" );

field := HomalgFieldOfRationals( );;
SET_GLOBAL_FIELD_FOR_QPA( field );;
ENABLE_COLORS := true;;
SWITCH_LOGIC_OFF := true;
DISABLE_ALL_SANITY_CHECKS := true;;
DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS :=
  [ IsMatrixCategory,
    IsChainComplexCategory,
    IsCochainComplexCategory,
    IsHomotopyCategory,
    IsAdditiveClosureCategory,
    IsQuiverRepresentationCategory,
    IsAlgebroid,
    IsQuiverRowsCategory
    # or some function
  ];

quiver := RightQuiver( "quiver", [ "O_0", "O_1", "O_2" ], [ "x0", "x1", "x2", "y0", "y1", "y2" ], [ 1, 1, 1, 2, 2, 2 ], [ 2, 2, 2, 3, 3, 3 ] );

Qq := PathAlgebra( field, quiver );;

# End( O(0) ⊕ O(1) ⊕ O(2) )
#
A := QuotientOfPathAlgebra(
  Qq,
  [ 
    Qq.x0 * Qq.y1 - Qq.x1 * Qq.y0,
    Qq.x0 * Qq.y2 - Qq.x2 * Qq.y0,
    Qq.x1 * Qq.y2 - Qq.x2 * Qq.y1,
  ]
);;

C := Algebroid( A );
AC := AdditiveClosure( C );
Ho_AC := HomotopyCategory( AC );
Tr := CategoryOfExactTriangles( Ho_AC );

I := EmbeddingFunctorIntoDerivedCategory( Ho_AC );

quit;

alpha := RandomMorphism( Ho_AC, [ [ -2, 2, 2 ], [ -2, 2, 2 ], [ 2 ] ] );
beta := RandomMorphismWithFixedSource( Range( alpha ), [ [ -2, 2, 2 ], [ 2 ] ] );

sigma := ShiftFunctor( Ho_AC );
sigma_m1 := InverseShiftFunctor( Ho_AC );

sigma_m1( sigma( alpha ) ) = alpha;

## Rotation functors that computes witness at each call on object

rot := RotationFunctor( Tr, true );
#! Rotation functor
rot_m1 := InverseRotationFunctorOp( Tr, true );
#! Inverse rotation functor

st_alpha := StandardExactTriangle( alpha );;
st_beta := StandardExactTriangle( beta );;

IsStandardExactTriangle( st_alpha );
# true
rot_st_alpha := rot( st_alpha );;
IsStandardExactTriangle( rot_st_alpha );
#! false
HasWitnessIsomorphismOntoStandardExactTriangle( rot_st_alpha );
#! true
w := WitnessIsomorphismOntoStandardExactTriangle( rot_st_alpha );;
IsWellDefined( w );
#! true
IsIsomorphism( w[ 0 ] );
#! true
IsIsomorphism( w[ 1 ] );
#! true
IsIsomorphism( w[ 2 ] );
#! true
### We can check whether a morphism is isomorphism by embedding it in some derived category
IsIsomorphism( I( w[ 2 ] ) );


o := ExactTriangleByOctahedralAxiom( alpha, beta );
o := ExactTriangleByOctahedralAxiom( st_alpha, st_beta );

### Let us create non-standard exact triangles
t_alpha := ExactTriangle( st_alpha ^ 0, ( 1/3 ) * st_alpha ^ 1, 3 * st_alpha ^ 2 );;
w := WitnessIsomorphismOntoStandardExactTriangle( t_alpha );;
Range( w ) = st_alpha;
#! true

t_beta := ExactTriangle( st_beta ^ 0, ( 1/2 ) * st_beta ^ 1, 2 * st_beta ^ 2 );;
w := WitnessIsomorphismOntoStandardExactTriangle( t_beta );;
Range( w ) = st_beta;
#! true

