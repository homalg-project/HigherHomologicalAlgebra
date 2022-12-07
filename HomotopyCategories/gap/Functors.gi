






##
InstallMethod( ExtendFunctorToHomotopyCategoriesByCochains,
          [ IsCapFunctor ],
  
  function ( F )
    local homotopy_category_1, homotopy_category_2, name, G;
    
    homotopy_category_1 := HomotopyCategoryByCochains( SourceOfFunctor( F ) );
    homotopy_category_2 := HomotopyCategoryByCochains( RangeOfFunctor( F ) );
    
    name := Concatenation( "Extension of ( ", Name( F ), " ) to homotopy categories by cochains" );
    
    G := CapFunctor( name, homotopy_category_1, homotopy_category_2 );
    
    F := ExtendFunctorToComplexesCategoriesByCochains( F );
    
    AddObjectFunction( G, C -> ObjectConstructor( homotopy_category_2, ApplyFunctor( F, UnderlyingCell( C ) ) ) );
    
    AddMorphismFunction( G, { S, alpha, R } -> MorphismConstructor( S, ApplyFunctor( F, UnderlyingCell( alpha ) ), R ) );
    
    return G;
    
end );

##
InstallMethod( LocalizationFunctorByProjectiveObjects,
          [ IsHomotopyCategory ],
  
  function ( homotopy_category )
    local cat, projs, homotopy_category_projs, name, F;
    
    cat := DefiningCategory( homotopy_category );
    
    projs := ValueGlobal( "FullSubcategoryOfProjectiveObjects" )( cat );
    
    homotopy_category_projs := HomotopyCategoryByCochains( projs );
    
    name := "Localization functor via projective objects";
    
    F := CapFunctor( name, homotopy_category, homotopy_category_projs );
    
    ##
    AddObjectFunction( F,
      function( C )
        local PC, objs, diffs;
        
        PC := ProjectiveResolution( UnderlyingCell( C ), true );
        
        objs := AsZFunction( i -> AsSubcategoryCell( projs, PC[i] ) );
        diffs := AsZFunction( i -> AsSubcategoryCell( projs, PC^i ) );
        
        return CreateComplex( homotopy_category_projs, [ objs, diffs, LowerBound( PC ), UpperBound( PC ) ] );
        
    end );
    
    ##
    AddMorphismFunction( F,
      function( S, phi, R )
        local P_phi, morphisms;
        
        P_phi := MorphismBetweenProjectiveResolutions( UnderlyingCell( phi ), true );
        
        morphisms := AsZFunction( i -> AsSubcategoryCell( projs, P_phi[i] ) );
        
        return CreateComplexMorphism( homotopy_category_projs, S, morphisms, R );
        
    end );
    
    return F;
    
end );

##
InstallMethod( LocalizationFunctorByInjectiveObjects,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, projs, homotopy_category_projs, name, F;
    
    cat := DefiningCategory( homotopy_category );
    
    projs := ValueGlobal( "FullSubcategoryOfInjectiveObjects" )( cat );
    
    homotopy_category_projs := HomotopyCategoryByCochains( projs );
    
    name := "Localization functor via injective objects";
    
    F := CapFunctor( name, homotopy_category, homotopy_category_projs );
    
    ##
    AddObjectFunction( F,
      function( C )
        local PC, objs, diffs;
        
        PC := InjectiveResolution( UnderlyingCell( C ), true );
        
        objs := AsZFunction( i -> AsSubcategoryCell( projs, PC[i] ) );
        diffs := AsZFunction( i -> AsSubcategoryCell( projs, PC^i ) );
        
        return CreateComplex( homotopy_category_projs, [ objs, diffs, LowerBound( PC ), UpperBound( PC ) ] );
        
    end );
    
    ##
    AddMorphismFunction( F,
      function( S, phi, R )
        local P_phi, morphisms;
        
        P_phi := MorphismBetweenInjectiveResolutions( UnderlyingCell( phi ), true );
        
        morphisms := AsZFunction( i -> AsSubcategoryCell( projs, P_phi[i] ) );
        
        return CreateComplexMorphism( homotopy_category_projs, S, morphisms, R );
        
    end );
    
    return F;
    
end );

