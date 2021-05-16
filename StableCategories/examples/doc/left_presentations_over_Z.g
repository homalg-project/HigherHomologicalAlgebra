#! @Chunk stable_cat_by_projectives

LoadPackage( "ModulePresentations" );;
LoadPackage( "RingsForHomalg" );;
LoadPackage( "StableCategories" );;

#! @Example
ZZ := HomalgRingOfIntegers( );
#! Z
cat := LeftPresentations( ZZ : FinalizeCategory := false );
#! Category of left presentations of Z
AddMorphismFromLiftingObject( cat, EpimorphismFromSomeProjectiveObject );;
Finalize( cat );
#! true
stable_cat := StableCategoryBySystemOfLiftingObjects( cat );;
stable_functor := ProjectionFunctor( stable_cat );;
a := AsLeftPresentation( HomalgMatrix( "[[0,0],[0,2],[0,3]]", 3, 2, ZZ ) );
#! <An object in Category of left presentations of Z>
stable_a := ApplyFunctor( stable_functor, a );
#! <An object in Stable category( Category of left presentations of Z ) defined by
#! IsLiftableAlongMorphismFromLiftingObject>
IsZero( a );
#! false
IsZero( stable_a );
#! true
#! @EndExample
