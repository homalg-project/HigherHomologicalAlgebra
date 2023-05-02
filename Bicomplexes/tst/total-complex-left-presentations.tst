gap> LoadPackage( "Bicomplexes" );
true
gap> LoadPackage( "ModulePresentations" );
true
gap> ZZ := HomalgRingOfIntegers( );;
gap> lp := LeftPresentations( ZZ );;
gap> bicomplexes_cat := BicomplexesCategoryByChains( lp );;
gap> modeling_category := ModelingCategory( bicomplexes_cat );;
gap> complexes_cat := UnderlyingCategory( modeling_category );;
gap> F1 := FreeLeftPresentation( 1, ZZ );;
gap> d7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 4 ] ]", 1, 1, ZZ ), F1 );;
gap> d6 := CokernelProjection( d7 );;
gap> C10 := CreateComplex( complexes_cat, [ d6, d7 ], 6 );;
gap> t7 := PresentationMorphism( F1, HomalgMatrix( "[ [ 2 ] ]", 1, 1, ZZ ), F1 );;
gap> t6 := CokernelProjection( t7 );;
gap> C9 := CreateComplex( complexes_cat, [ t6, t7 ], 6 );;
gap> phi5 := PresentationMorphism( C10[ 5 ], HomalgIdentityMatrix( 1, ZZ ),  C9[ 5 ] );;
gap> phi6 := PresentationMorphism( F1, HomalgIdentityMatrix( 1, ZZ ), F1 );;
gap> phi7 := PresentationMorphism( F1, 2 * HomalgIdentityMatrix( 1, ZZ ), F1 );;
gap> phi := CreateComplexMorphism( C10, [ phi5, phi6, phi7 ], 5, C9 );;
gap> o := CreateComplex( modeling_category, [ phi ], 10 );;
gap> bicomplex := ReinterpretationOfObject( bicomplexes_cat, o );;
gap> t := TotalComplex( bicomplex );;
gap> IsWellDefined( t ) and IsExact( t );
true
