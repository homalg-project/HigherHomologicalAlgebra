#! @Chapter Examples and Tests

#! @Section Homotopy Category of Left-Presentations Categories

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
A_O := AlgebroidFromDataTables( k_quotient_P_O );
#! Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms
Dimension( A_O );
#! 10
IsAdmissibleAlgebroid( A_O );
#! true
PSh := PreSheaves( A_O );
#! PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )
Y1 := YonedaEmbeddingOfSourceCategory( PSh );
#! Yoneda embedding functor
Display( Y1 );
#! Yoneda embedding functor:
#! 
#! Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms
#!   |
#!   V
#! PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )
ApplyFunctor( Y1, A_O.x );
#! <(A)->1x2, (B)->0x1, (C)->0x0>
Y2 := ExtendFunctorToAdditiveClosureOfSource( Y1 );
#! Extension of Yoneda embedding functor to a functor from the additive closure of the source
Display( Y2 );
#! Extension of Yoneda embedding functor to a functor from the additive closure of the source:
#! 
#! AdditiveClosure( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms )
#!   |
#!   V
#! PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )
add_A_O := SourceOfFunctor( Y2 );
#! AdditiveClosure( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms )
ApplyFunctor( Y2, add_A_O.x );
#! <(A)->1x2, (B)->0x1, (C)->0x0>
Y3 := ExtendFunctorToFreydCategory( Y2 );
#! Extension to FreydCategory( Source( Extension of Yoneda embedding functor to a functor from the additive closure of the source ) )
Display( Y3 );
#! Extension to FreydCategory( Source( Extension of Yoneda embedding functor to a functor from the additive closure of the source ) ):
#! 
#! Freyd( AdditiveClosure( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms ) )
#!   |
#!   V
#! PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )
Display( SourceOfFunctor( Y3 ) );
#! A CAP category with name Freyd( AdditiveClosure( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms ) ):
#! 
#! 48 primitive operations were used to derive 360 operations for this category which algorithmically
#! * IsCategoryWithDecidableColifts
#! * IsCategoryWithDecidableLifts
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
#! * IsAbelianCategoryWithEnoughProjectives
Display( RangeOfFunctor( Y3 ) );
#! A CAP category with name PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ):
#! 
#! 59 primitive operations were used to derive 363 operations for this category which algorithmically
#! * IsCategoryWithDecidableColifts
#! * IsCategoryWithDecidableLifts
#! * IsEquippedWithHomomorphismStructure
#! * IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
#! * IsAbelianCategoryWithEnoughInjectives
#! * IsAbelianCategoryWithEnoughProjectives
Y4 := ExtendFunctorToHomotopyCategoriesByCochains( Y3 );
#! Extension of ( Extension to FreydCategory( Source( Extension of Yoneda embedding functor to a functor from the additive closure of the source ) ) ) to homotopy categories by cochains
Display( Y4 );
#! Extension of ( Extension to FreydCategory( Source( Extension of Yoneda embedding functor to a functor from the additive closure of the source ) ) ) to homotopy categories by cochains:
#! 
#! Homotopy category by cochains( Freyd( AdditiveClosure( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms ) ) )
#!   |
#!   V
#! Homotopy category by cochains( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) )
repeat f := RandomMorphism( SourceOfFunctor( Y4 ), 3 );; until not IsZeroForMorphisms( f );
Y4_f := ApplyFunctor( Y4, f );
#! <A morphism in Homotopy category by cochains( PreSheaves( Q-algebroid( {A,B,C}[x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) ) supported on the interval [ -1 .. 2 ]>
r1 := RankOfObject( HomomorphismStructureOnObjects( Source( f ), Target( f ) ) );;
r2 := RankOfObject( HomomorphismStructureOnObjects( Source( Y4_f ), Target( Y4_f ) ) );;
r1 = r2;
#! true
# @drop_example_in_Julia
#! @EndExample
