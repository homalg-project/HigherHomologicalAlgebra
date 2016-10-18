#! @Chapter Examples and Tests

#! @Section Stable category of left presentations over an axterior algebra

LoadPackage( "StableCategoriesForCap" );

#! @Example

R := KoszulDualRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );
#! Q{e0,e1,e2}
cat := StableCategoryOfLeftPresentationsOverExteriorAlgebra( R );
#! the stable category of Category of left presentations of Q{e0,e1,e2}
H := HomalgMatrix( "[ [ e0,e1 ] ]", 1, 2, R );
#! <A 1 x 2 matrix over an external ring>
M := AsLeftPresentation( H );
#! <An object in Category of left presentations of Q{e0,e1,e2}>
MM := AsStableCategoryObject( cat, M );
#! <An object in the stable category of Category of left presentations of Q{e0,e1,e2}>
f := CoverByFreeModule( M );
#! <A morphism in Category of left presentations of Q{e0,e1,e2}>
ff := AsStableCategoryMorphism( cat, f );
#! <A morphism in the stable category of Category of left presentations of Q{e0,e1,e2}>
IsZero( ff );
#! true
IsZero( f );
#! false 
T := HomalgMatrix( [ [ 1,1,1,1 ] ], 2, 2, R );
#! <A 2 x 2 matrix over an external ring>
F := PresentationMorphismInStableCategory( MM, T, MM );
#! <A morphism in the stable category of Category of left presentations of Q{e0,e1,e2}>
IsSplitEpimorphism( F );
#! false
IsSplitMonomorphism( F );
#! false
#! @EndExample