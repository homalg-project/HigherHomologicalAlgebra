#! @Chapter Examples and Tests

#! @Section Homotopy Category of Presheaves categories (Quiver Representations)

#! @Example
LoadPackage( "FunctorCategories", false );
#! true
LoadPackage( "HomotopyCategories", false );
#! true
q_O := FinQuiver( "q_O(A,B,C)[x:A->B,y:A->B,z:B->C,w:B->C]" );
#! FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" )
P_O := PathCategory( q_O );
#! PathCategory( FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" ) )
rho_O := [ [ P_O.xz, P_O.yw ] ];
#! [ [ x⋅z:(A) → (C), y⋅w:(A) → (C) ] ]
quotient_P_O := QuotientCategory( P_O, rho_O );
#! PathCategory( FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" ) ) / [ x⋅z = y⋅w ]
QQ := HomalgFieldOfRationals( );
#! Q
k := QQ;
#! Q
k_quotient_P_O := k[quotient_P_O];
#! Q-LinearClosure( PathCategory( FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" ) ) / [ x⋅z = y⋅w ] )
IsAdmissibleAlgebroid( k_quotient_P_O );
#! true
A_O := AlgebroidFromDataTables( k_quotient_P_O );
#! Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms
Dimension( A_O );
#! 10
HasIsAdmissibleAlgebroid( A_O ) and IsAdmissibleAlgebroid( A_O );
#! true
phi := 2 * A_O.x + 3 * A_O.y;
#! <2*x + 3*y:(A) → (B)>
PSh := PreSheavesOfFpEnrichedCategory( A_O );
#! PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )
Display( PSh );
#! A CAP category with name PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ):
#! 
#! 59 primitive operations were used to derive 363 operations for this category which algorithmically
#! * IsCategoryWithDecidableColifts
#! * IsCategoryWithDecidableLifts
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
#! * IsAbelianCategoryWithEnoughInjectives
#! * IsAbelianCategoryWithEnoughProjectives
indec_projs := IndecomposableProjectiveObjects( PSh );
#! [ <(A)->1, (B)->0, (C)->0; (x)->0x1, (y)->0x1, (z)->0x0, (w)->0x0>, <(A)->2, (B)->1, (C)->0; (x)->1x2, (y)->1x2, (z)->0x1, (w)->0x1>, 
#!   <(A)->3, (B)->2, (C)->1; (x)->2x3, (y)->2x3, (z)->1x2, (w)->1x2> ]
indec_injs := IndecomposableInjectiveObjects( PSh );
#! [ <(A)->1, (B)->2, (C)->3; (x)->2x1, (y)->2x1, (z)->3x2, (w)->3x2>, <(A)->0, (B)->1, (C)->2; (x)->1x0, (y)->1x0, (z)->2x1, (w)->2x1>, 
#!   <(A)->0, (B)->0, (C)->1; (x)->0x0, (y)->0x0, (z)->1x0, (w)->1x0> ]
C_PSh := ComplexesCategoryByCochains( PSh );
#! Complexes category by cochains( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) )
K_PSh := HomotopyCategoryByCochains( PSh );
#! Homotopy category by cochains( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) )
Display( K_PSh );
#! A CAP category with name Homotopy category by cochains( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) ):
#! 
#! 50 primitive operations were used to derive 218 operations for this category which algorithmically
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
#! * IsAdditiveCategory
L_proj := LocalizationFunctorByProjectiveObjects( K_PSh );
#! Localization functor via projective objects
Display( L_proj );
#! Localization functor via projective objects:
#! 
#! Homotopy category by cochains( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) )
#!   |
#!   V
#! Homotopy category by cochains( FullSubcategoryOfProjectiveObjects( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) ) )
f := BasisOfExternalHom( indec_projs[1], indec_projs[2] )[1];
#! <(A)->1x2, (B)->0x1, (C)->0x0>
IsEpimorphism( f );
#! false
R := CokernelObject( f );
#! <(A)->1, (B)->1, (C)->0; (x)->1x1, (y)->1x1, (z)->0x1, (w)->0x1>
R := CreateComplex( K_PSh, [ UniversalMorphismIntoZeroObject( R ) ], 0 );
#! <An object in Homotopy category by cochains( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) ) supported on the interval [ 0 .. 1 ]>
iota_R := QuasiIsomorphismIntoInjectiveResolution( R, true );
#! <A morphism in Homotopy category by cochains( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) ) supported on the interval [ 0 .. 1 ]>
IsWellDefined( iota_R );
#! true
IsQuasiIsomorphism( iota_R );
#! true
CohomologySupport( Source( iota_R ) );
#! [ 0 ]
CohomologySupport( Target( iota_R ) );
#! [ 0 ]
L_proj_iota_R := ApplyFunctor( L_proj, iota_R );
#! <A morphism in Homotopy category by cochains( FullSubcategoryOfProjectiveObjects( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) ) ) supported on the interval [ -1 .. 1 ]>
IsIsomorphism( L_proj_iota_R );
#! true
inv_L_proj_iota_R := InverseForMorphisms( L_proj_iota_R );
#! <A morphism in Homotopy category by cochains( FullSubcategoryOfProjectiveObjects( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) ) ) supported on the interval [ -1 .. 1 ]>
u := PreCompose( L_proj_iota_R, inv_L_proj_iota_R );;
id := IdentityMorphism( Source( L_proj_iota_R ) );;
IsZeroForMorphisms( u - id );
#! true
w := WitnessForBeingHomotopicToZeroMorphism( u - id );
#! <ZFunction>
w[0];
#! A morphism in full subcategory given by: <(A)->2x1, (B)->1x0, (C)->0x0>
# @drop_example_in_Julia (was manually added there)
#! @EndExample
