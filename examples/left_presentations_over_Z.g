LoadPackage( "ModulePresentations" );;
LoadPackage( "StableCategoriesForCAP" );;

ZZ := HomalgRingOfIntegers( );
#! Z
cat := LeftPresentations( ZZ : FinalizeCategory := false );
#! Category of left presentations of Z

AddMorphismFromLiftingObject( cat,
  function( b )
    return EpimorphismFromSomeProjectiveObject( b );
end );;

Finalize( cat );
#! true
stable_cat := StableCategoryByLiftingStructure( cat );
#! The stable category of Category of left presentations of Z by a congruency test function
stable_functor := CanonicalProjectionFunctor( stable_cat );
#! Canonical projection functor from Category of left presentations of Z in
#! The stable category of Category of left presentations of Z by a congruency test function
a := AsLeftPresentation( HomalgMatrix( "[ [ 0, 0 ], [ 0, 2 ], [ 0, 3 ] ]", 3, 2, ZZ ) );
#! <An object in Category of left presentations of Z>
stable_a := ApplyFunctor( stable_functor, a );
#! <An object in The stable category of Category of left presentations of Z by a congruency test function>
IsZero( a );
#! false
IsZero( stable_a );
#! true

