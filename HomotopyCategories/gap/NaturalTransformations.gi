




##
BindGlobal( "_homotopy_ExtendNaturalTransformationToHomotopyCategories",
  
  function( kF, eta, kG )
    local name, k_eta;
    
    if IsHomotopyCategoryByChains( SourceOfFunctor( kF ) ) then
      name := "";
    else
      name := "co";
    fi;
    
    name := Concatenation( "Extention of (", Name( eta ), ") to homotopy categories by ", name, "chains" );
    
    k_eta := NaturalTransformation( name, kF, kG );
    
    AddNaturalTransformationFunction( k_eta,
      { kF_C, C, kG_C } -> CreateComplexMorphism(
                                      RangeOfFunctor( kF ),
                                      kF_C,
                                      ApplyMap( Objects( C ), o -> ApplyNaturalTransformation( eta, o ) ),
                                      kG_C ) );
    
    return k_eta;
    
end );

##
InstallMethod( ExtendNaturalTransformationToHomotopyCategoriesByChains,
          [ IsCapNaturalTransformation ],
  
  eta -> _homotopy_ExtendNaturalTransformationToHomotopyCategories(
                      ExtendFunctorToHomotopyCategoriesByChains( Source( eta ) ),
                      eta,
                      ExtendFunctorToHomotopyCategoriesByChains( Range( eta ) ) )
);

##
InstallMethod( ExtendNaturalTransformationToHomotopyCategoriesByCochains,
          [ IsCapNaturalTransformation ],
  
  eta -> _homotopy_ExtendNaturalTransformationToHomotopyCategories(
                      ExtendFunctorToHomotopyCategoriesByCochains( Source( eta ) ),
                      eta,
                      ExtendFunctorToHomotopyCategoriesByCochains( Range( eta ) ) )
);

