







InstallMethod( EmbeddingIntoDerivedCategory,
          [ IsHomotopyCategory ],
  
  function( homotopy_cat )
    local add_closure, B, PSh, overhead, Y;
    
    if not IsAdditiveClosureCategory( DefiningCategory( homotopy_cat ) ) then
        TryNextMethod( );
    fi;
    
    add_closure := DefiningCategory( homotopy_cat );
    
    if not IsAlgebroid( UnderlyingCategory( add_closure ) ) then
        TryNextMethod( );
    fi;
    
    B := UnderlyingCategory( add_closure );
    
    PSh := PreSheaves( B : overhead := false );
    
    Y := IsomorphismFromSourceIntoImageOfYonedaEmbeddingOfSource( PSh );
    
    Y := PreCompose( Y, InclusionFunctor( RangeOfFunctor( Y ) ) );
    
    Y := ExtendFunctorToAdditiveClosureOfSource( Y );
    
    Y := ExtendFunctorToHomotopyCategoriesByCochains( Y );
    
    Y := PreCompose( Y, LocalizationFunctor( RangeOfFunctor( Y ) ) );
    
    Y!.Name := "Embedding functor into derived category of presheaves";
    
    return Y;
    
end );


InstallMethod( EquivalenceOntoDerivedCategory,
          [ IsHomotopyCategory ],
  
  function( homotopy_cat )
    local Y;
    
    Y := EmbeddingIntoDerivedCategory( homotopy_cat );
    
    Y!.Name := "Equivalence functor onto derived category of presheaves";
    
    return Y;
    
end );

