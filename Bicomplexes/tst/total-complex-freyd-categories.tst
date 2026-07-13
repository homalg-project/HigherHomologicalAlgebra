gap> START_TEST("total-complex-left-presentations.tst");

gap> LoadPackage( "Bicomplexes", false );
true
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> zz := HomalgRingOfIntegers( );;
gap> rows_zz := CategoryOfRows( zz );;
gap> lp := FreydCategory( rows_zz );;
gap> bicomplexes_cat := BicomplexesCategoryByChains( lp );;
gap> modeling_category := ModelingCategory( bicomplexes_cat );;
gap> complexes_cat := UnderlyingCategory( modeling_category );;
gap> F1 := AsFreydCategoryObject( CategoryOfRowsObject( 1, rows_zz ) );;
gap> d7 := FreydCategoryMorphism( F1, AsCategoryOfRowsMorphism( HomalgMatrix( [ [ 4 ] ], 1, 1, zz ), rows_zz ), F1 );;
gap> d6 := CokernelProjection( d7 );;
gap> C10 := CreateComplex( complexes_cat, [ d6, d7 ], 6 );;
gap> t7 := FreydCategoryMorphism( F1, AsCategoryOfRowsMorphism( HomalgMatrix( [ [ 2 ] ], 1, 1, zz ), rows_zz ), F1 );;
gap> t6 := CokernelProjection( t7 );;
gap> C9 := CreateComplex( complexes_cat, [ t6, t7 ], 6 );;
gap> phi5 := FreydCategoryMorphism( C10[ 5 ], AsCategoryOfRowsMorphism( HomalgIdentityMatrix( 1, zz ), rows_zz ), C9[ 5 ] );;
gap> phi6 := FreydCategoryMorphism( F1, AsCategoryOfRowsMorphism( HomalgIdentityMatrix( 1, zz ), rows_zz ), F1 );;
gap> phi7 := FreydCategoryMorphism( F1, AsCategoryOfRowsMorphism( 2 * HomalgIdentityMatrix( 1, zz ), rows_zz ), F1 );;
gap> phi := CreateComplexMorphism( C10, [ phi5, phi6, phi7 ], 5, C9 );;
gap> o := CreateComplex( modeling_category, [ phi ], 10 );;
gap> bicomplex := ReinterpretationOfObject( bicomplexes_cat, o );;
gap> t := TotalComplex( bicomplex );;
gap> Assert( 0, IsWellDefined( t ) and IsExact( t ) );

#
gap> STOP_TEST("total-complex-left-presentations.tst", 1 );

