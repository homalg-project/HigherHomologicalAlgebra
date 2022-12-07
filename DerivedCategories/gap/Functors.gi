



##
InstallMethod( LocalizationFunctor,
              [ IsHomotopyCategory ],
  function( homotopy_cat )
    local cat, derived_cat, name, L;
    
    cat := DefiningCategory( homotopy_cat );
    
    derived_cat := DerivedCategoryByCochains( cat );
    
    name := "Localization functor from homotopy category into derived category";
    
    L := CapFunctor( name, homotopy_cat, derived_cat );
    
    AddObjectFunction( L, C -> ObjectConstructor( derived_cat, C ) );
    
    AddMorphismFunction( L, { S, alpha, R } -> MorphismConstructor( S, [ IdentityMorphism( homotopy_cat, Source( alpha ) ), alpha ], R ) );
    
    return L;
    
end );

##
InstallMethod( UniversalFunctorFromDerivedCategory,
          [ IsCapFunctor ],
  
  function( F )
    local homotopy_cat, localization_cat, cat, derived_cat, name, U;
    
    homotopy_cat := SourceOfFunctor( F );
    
    localization_cat := RangeOfFunctor( F );
    
    if not IsHomotopyCategory( homotopy_cat ) then
      
      Error( "the argument must be a functor from a homotopy category of an abelian category!\n" );
      
    fi;
    
    cat := DefiningCategory( homotopy_cat );
    
    derived_cat := DerivedCategoryByCochains( cat );
    
    name := "Universal functor from derived category";
    
    U := CapFunctor( name, derived_cat, localization_cat );
    
    AddObjectFunction( U,
      function ( C )
        
        return ApplyFunctor( F, UnderlyingCell( C ) );
        
    end );
    
    AddMorphismFunction( U,
      function ( S, alpha, R )
        local pair;
        
        pair := DefiningPairOfMorphisms( alpha );
        
        return PreCompose( localization_cat, InverseForMorphisms( localization_cat, ApplyFunctor( F, pair[1] ) ), ApplyFunctor( F, pair[2] ) );
        
    end );
    
    return U;
    
end );

