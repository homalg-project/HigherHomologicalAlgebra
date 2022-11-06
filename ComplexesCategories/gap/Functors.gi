





##
BindGlobal( "_complexes_ExtendFunctorToComplexesCategories",
  
  function( S, F, T )
    local name, ch_F;
    
    if ForAll( [ S, T ], IsCochainComplexCategory ) then
        name := "co";
    else
        name := "";
    fi;
    
    ch_F := CapFunctor( Concatenation( "Extension of ( ", Name( F ), " ) to ", name, "chain complexes" ), S, T );
    
    AddObjectFunction( ch_F, C ->
          CreateComplex(
                T,
                ApplyMap( Objects( C ), o -> ApplyFunctor( F, o ) ),
                ApplyMap( Differentials( C ), delta -> ApplyFunctor( F, delta ) ),
                LowerBound( C ),
                UpperBound( C ) ) );
    
    AddMorphismFunction( ch_F,
      { source, phi, range } ->
          CreateComplexMorphism(
                T,
                source,
                range,
                ApplyMap( Morphisms( phi ), m -> ApplyFunctor( F, m ) ),
                LowerBound( phi ),
                UpperBound( phi ) ) );
    
    return ch_F;
    
end );

##
InstallMethod( ExtendFunctorToComplexesCategoriesByChains,
          [ IsCapFunctor ],
  F -> _complexes_ExtendFunctorToComplexesCategories(
              ComplexesCategoryByChains( SourceOfFunctor( F ) ),
              F,
              ComplexesCategoryByChains( RangeOfFunctor( F ) ) ) );

##
InstallMethod( ExtendFunctorToComplexesCategoriesByCochains,
          [ IsCapFunctor ],
  F -> _complexes_ExtendFunctorToComplexesCategories(
              ComplexesCategoryByCochains( SourceOfFunctor( F ) ),
              F,
              ComplexesCategoryByCochains( RangeOfFunctor( F ) ) ) );
 
