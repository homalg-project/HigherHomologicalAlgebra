gap> LoadPackage( "DerivedCategories", false );
true
gap> HOMALG_IO.show_banners := false;;
gap> S := HomalgFieldOfRationalsInSingular( ) * "x,y,z,t";;
gap> rows := CategoryOfRows( S );;
gap> freyd := FreydCategory( rows );;
gap> chains := ChainComplexCategory( freyd );;
gap> homotopy := HomotopyCategory( freyd );;
gap> derived := DerivedCategory( freyd );;
gap> a := CategoryOfRowsObject( 4, rows );;
gap> b := CategoryOfRowsObject( 1, rows );;
gap> m1 := CategoryOfRowsMorphism( a, HomalgMatrix( "x,y,z,t", 4, 1, S ), b );;
gap> m2 := CategoryOfRowsMorphism( a, HomalgMatrix( "x-y,y+t,z+x,t^2", 4, 1, S ), b );;;
gap> m1 := FreydCategoryObject( m1 );;
gap> m2 := FreydCategoryObject( m2 );;
gap> hom_m1_m2 := HomStructure( m1, m2 );;
gap> u := DistinguishedObjectOfHomomorphismStructure( freyd );;
gap> alpha_1 := CategoryOfRowsMorphism( b, HomalgMatrix( "[[1,1,0,0]]", 1, 4, S ), a );;
gap> alpha_2 := CategoryOfRowsMorphism( b, HomalgMatrix( "[[1,0,1,1]]", 1, 4, S ), a );;
gap> alpha_1 := FreydCategoryMorphism( u, alpha_1, hom_m1_m2 );;
gap> alpha_2 := FreydCategoryMorphism( u, alpha_2, hom_m1_m2 );;
gap> alpha_1 := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( m1, m2, alpha_1 );;
gap> alpha_2 := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( m1, m2, alpha_2 );;
gap> alpha_1 := alpha_1/chains/homotopy;;
gap> alpha_2 := alpha_2/chains/homotopy;;
gap> Lp := LocalizationFunctorByProjectiveObjects( homotopy );;
gap> IsCongruentForMorphisms( ApplyFunctor( Lp, alpha_1 ) + ApplyFunctor( Lp, alpha_2 ), ApplyFunctor( Lp, alpha_1 + alpha_2 ) );
true
