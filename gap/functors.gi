
##
InstallMethod( HomologyFunctorOp, 
               [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local cat, complex_cat, Hn, r, name, functor;
  
  cat := DefiningCategory( homotopy_category );
  
  complex_cat := ChainComplexCategory( cat );
  
  Hn := HomologyFunctor( complex_cat, n );
  
  r := RANDOM_TEXT_ATTR();
  
  name := Concatenation( String( n ), "-th homology functor ", r[ 1 ], "from", r[ 2 ], " ",
            Name( homotopy_category ), " ", r[ 1 ], "to", r[ 2 ], " ", Name( cat ) );
  
  functor := CapFunctor( name, homotopy_category, cat );
  
  AddObjectFunction( functor, 
    
    function( complex )
      
      return ApplyFunctor( Hn, UnderlyingCell( complex ) );
      
  end );
  
  AddMorphismFunction( functor,
    
    function( new_source, map, new_range )
      
      return ApplyFunctor( Hn, UnderlyingCell( map ) );
      
  end );
  
  return functor;
  
end );

##
InstallMethod( ShiftFunctorOp, 
          [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local cat, complex_cat, T, name, functor;
  
  cat := DefiningCategory( homotopy_category );
  
  complex_cat := ChainComplexCategory( cat );
  
  T := ShiftFunctor( complex_cat, n );
  
  name := Concatenation( "Shift by ", String( n ), " autoequivalence on ", Name( homotopy_category ) );
  
  functor := CapFunctor( name, homotopy_category, homotopy_category );
  
  AddObjectFunction( functor,
    
    function( complex )
      
      return ApplyFunctor( T, UnderlyingCell( complex ) ) / homotopy_category;
      
  end );
  
  AddMorphismFunction( functor,
    
    function( new_source, map, new_range )
      
      return ApplyFunctor( T, UnderlyingCell( map ) ) / homotopy_category;
      
  end );
  
  return functor;
  
end );

##
InstallMethod( UnsignedShiftFunctorOp,
          [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local cat, complex_cat, T, name, functor;
  
  cat := DefiningCategory( homotopy_category );
  
  complex_cat := ChainComplexCategory( cat );
  
  T := UnsignedShiftFunctor( complex_cat, n );
  
  name := Concatenation( "Unsigned Shift by ", String( n ), " autoequivalence on ", Name( homotopy_category ) );
  
  functor := CapFunctor( name, homotopy_category, homotopy_category );
  
  AddObjectFunction( functor, 
  
  function( complex )
    
    return ApplyFunctor( T, UnderlyingCell( complex ) ) / homotopy_category;
    
  end );
  
  AddMorphismFunction( functor,
    
    function( new_source, map, new_range )
      
      return ApplyFunctor( T, UnderlyingCell( map ) ) / homotopy_category;
      
  end );
  
  return functor;
  
end );

##
InstallMethod( ExtendFunctorToHomotopyCategoryFunctor,
               [ IsCapFunctor ],
  function( F )
    local S, T, ChF, name, functor, r;
    
    S := HomotopyCategory( AsCapCategory( Source( F ) ) );
    
    T := HomotopyCategory( AsCapCategory(  Range( F ) ) );
    
    ChF := ExtendFunctorToChainComplexCategoryFunctor( F );
    
    r := RANDOM_TEXT_ATTR();
    
    name := Concatenation( r[ 1 ], "The extension functor of ", r[ 2 ], Name( F ), r[ 1 ], " to homotopy categories.", r[ 2 ] );
    
    functor := CapFunctor( name, S, T );
    
    AddObjectFunction( functor,
      function( C )
        
        return ApplyFunctor( ChF, UnderlyingCell( C ) ) / T;
        
      end );
    
    AddMorphismFunction( functor,
      function( new_source, phi, new_range ) 
        
        return ApplyFunctor( ChF, UnderlyingCell( phi ) ) / T;
        
      end );
      
    return functor;
    
end );

##
InstallMethod( LocalizationFunctorByProjectiveObjects,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, projs, homotopy_category_projs, r, name, F;
    
    cat := DefiningCategory( homotopy_category );
    
    if not IsAbelianCategoryWithEnoughProjectives( cat ) then
      
      Error( "The input should be abelian with enough projective objects!\n" );
      
    fi;
    
    projs := ValueGlobal( "FullSubcategoryGeneratedByProjectiveObjects" )( cat );
    
    homotopy_category_projs := HomotopyCategory( projs );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Localization functor ", r[ 1 ], "from", r[ 2 ], 
                 " ", Name( homotopy_category ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( homotopy_category_projs ) );
    
    F := CapFunctor( name, homotopy_category, homotopy_category_projs );
    
    ##
    AddObjectFunction( F,
      function( a )
        local p;
        
        p := ProjectiveResolution( UnderlyingCell( a ), true );
        
        p := AsComplexOverCapFullSubcategory( projs, p );
        
        return p / homotopy_category_projs;
        
    end );
    
    ##
    AddMorphismFunction( F,
      function( s, phi, r )
        local psi;
        
        psi := MorphismBetweenProjectiveResolutions( UnderlyingCell( phi ), true );
        
        psi := AsChainMorphismOverCapFullSubcategory( UnderlyingCell( s ), psi, UnderlyingCell( r ) );
        
        return psi / homotopy_category_projs;
        
    end );
    
    return F;
    
end );

##
InstallMethod( LocalizationFunctorByInjectiveObjects,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, injs, homotopy_category_injs, r, name, F;
    
    cat := DefiningCategory( homotopy_category );
    
    if not IsAbelianCategoryWithEnoughInjectives( cat ) then
      
      Error( "The input should be abelian with enough injective objects!\n" );
      
    fi;
    
    injs := ValueGlobal( "FullSubcategoryGeneratedByInjectiveObjects" )( cat );
    
    homotopy_category_injs := HomotopyCategory( injs );
    
    r := RANDOM_TEXT_ATTR( );
    
    name := Concatenation( "Localization functor ", r[ 1 ], "from", r[ 2 ], 
                 " ", Name( homotopy_category ), " ", r[ 1 ], "into", r[ 2 ], " ", Name( homotopy_category_injs ) );
    
    F := CapFunctor( name, homotopy_category, homotopy_category_injs );
    
    ##
    AddObjectFunction( F,
      function( a )
        local p;
        
        p := InjectiveResolution( UnderlyingCell( a ), true );
        
        p := AsComplexOverCapFullSubcategory( injs, p );
        
        return p / homotopy_category_injs;
        
    end );
    
    ##
    AddMorphismFunction( F,
      function( s, phi, r )
        local psi;
        
        psi := MorphismBetweenInjectiveResolutions( UnderlyingCell( phi ), true );
        
        psi := AsChainMorphismOverCapFullSubcategory( UnderlyingCell( s ), psi, UnderlyingCell( r ) );
        
        return psi / homotopy_category_injs;
        
    end );
    
    return F;
    
end );

