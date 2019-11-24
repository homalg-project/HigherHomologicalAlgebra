LoadPackage( "HomotopyCategories" );
LoadPackage( "QPA" );
LoadPackage( "LinearAlgebra" );
ReadPackage( "HomotopyCategories", "/examples/temp_dir/random_methods_for_categories_of_quiver_reps.g" );

field := Rationals;;

quiver := RightQuiver( "q(4)[x0:1->2,x1:1->2,x2:1->2,x3:1->2,y0:2->3,y1:2->3,y2:2->3,y3:2->3,z0:3->4,z1:3->4,z2:3->4,z3:3->4]" );;
Qq := PathAlgebra( field, quiver );;

# End( O(0) ⊕ O(1) ⊕ O(2) ⊕ O(3) )
#
A := QuotientOfPathAlgebra(
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

B := QuotientOfPathAlgebra(
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

cat := CategoryOfQuiverRepresentations( B : FinalizeCategory := false );;
cat!.compute_basis_of_hom_using_homalg := [ true, 1, HomalgFieldOfRationals() ]; 
# cat!.compute_basis_of_hom_using_homalg := [ true, 2, HomalgFieldOfRationals() ]; to hid [[#I  Using homalg to compute BasisOfHom(-,-)]]
SetIsLinearCategoryOverCommutativeRing( cat, true );;
SetCommutativeRingOfLinearCategory( cat, HomalgFieldOfRationals( ) );;
AddMultiplyWithElementOfCommutativeRingForMorphisms( cat, \* );;
AddRandomMethodsToQuiverRepresentations( cat );;
Finalize( cat );;

homotopy_of_quiver_reps := HomotopyCategory( cat );;

#                      α1  
# a:   0 <------ a0 <-------- a1 <------- 0
#                  \                     
#                     \
#                        \ f
#                           \   
#                             V
# b:   0 <------ b0 <-------- b1 <------- 0
#                      β1

a_0 := RandomObject( cat, 3 );;

alpha_1 := RandomMorphismWithFixedRange( a_0, 3 );;
a := ChainComplex( [ alpha_1 ], 1 );;

f := RandomMorphismWithFixedSource( a_0, 3 );;
b_1 := Range( f );;

beta_1 := RandomMorphismWithFixedSource( b_1, 3 );;

b := ChainComplex( [ beta_1 ], 1 );;

phi := ChainMorphism( a, b, [ PreCompose( f, b^1 ), PreCompose( a^1, f ) ], 0 );; # b^1 := beta_1, a^1 := alpha_1

homotopy_phi := HomotopyCategoryMorphism( homotopy_of_quiver_reps, phi );;

IsZero( homotopy_phi );;
# true

IsNullHomotopic( phi );;
H := HomotopyMorphisms( phi );;  # H[ i ] : Source( phi )[ i ] ----> Range( phi )[ i + 1 ]
H[1];

