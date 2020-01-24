
##
InstallMethod( HomologyFunctorOp, 
               [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local cat, complex_cat, Hn, r, name, functor;
  
  cat := DefiningCategory( homotopy_category );
  
  complex_cat := ChainComplexCategory( cat );
  
  Hn := HomologyFunctor( complex_cat, n );
  
  r := RandomTextColor();
  
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
InstallMethod( ExtendFunctorToHomotopyCategories,
               [ IsCapFunctor ],
  function( F )
    local S, T, ChF, r1, r2, name, functor;
    
    S := HomotopyCategory( AsCapCategory( Source( F ) ) );
    
    T := HomotopyCategory( AsCapCategory(  Range( F ) ) );
    
    ChF := ExtendFunctorToChainComplexCategories( F );
    
    r1 := RandomBoldTextColor( );
    
    r2 := RandomTextColor( );
    
    name := Concatenation( r2[ 1 ], "Extention of functor ( ", r2[ 2 ], Name( F ), " ", r2[ 1 ], ") to homotopy categories",
              r1[ 1 ], ":", r1[ 2 ], "\n\n", Name( S ), "\n", r1[ 1 ], "  |\n  |\n  V", r1[ 2 ], "\n", Name( T ) );
    
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
InstallMethod( ExtendNaturalTransformationToHomotopyCategories,
          [ IsCapNaturalTransformation ],
  function( eta )
    local F, G, homotopy_cat, HF, HG, C_eta, r1, r2, name, H_eta;
    
    F := Source( eta );
    
    G := Range( eta );
    
    homotopy_cat := HomotopyCategory( AsCapCategory( Range( G ) ) );
    
    HF := ExtendFunctorToHomotopyCategories( F );
    
    HG := ExtendFunctorToHomotopyCategories( G );
    
    C_eta := ExtendNaturalTransformationToChainComplexCategories( eta );
    
    r1 := RandomBoldTextColor( );
    
    r2 := RandomTextColor( );
    
    name := Concatenation( r2[ 1 ], "Extention of natural transformation ( ", r2[ 2 ], Name( eta ), " ", r2[ 1 ], ") ",
              r1[ 1 ], ":", r1[ 2 ], " ", Name( HF ), " ", r1[ 1 ], "===>", r1[ 2 ], " ", Name( HG ) );

    H_eta := NaturalTransformation( name, HF, HG );
    
    AddNaturalTransformationFunction( H_eta,
      function( HF_a, a, HG_a )
        
        return ApplyNaturalTransformation( C_eta, UnderlyingCell( a ) ) / homotopy_cat;
      
    end );
    
    return H_eta;
    
end );

##
InstallMethod( LocalizationFunctorByProjectiveObjects,
          [ IsHomotopyCategory ],
  function( homotopy_category )
    local cat, projs, homotopy_category_projs, r, name, F;
    
    cat := DefiningCategory( homotopy_category );
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( cat ) then
      
      Error( "The input should be abelian with computable enough projective objects!\n" );
      
    fi;
    
    projs := ValueGlobal( "FullSubcategoryGeneratedByProjectiveObjects" )( cat );
    
    homotopy_category_projs := HomotopyCategory( projs );
    
    r := RandomBoldTextColor( );
   
    name := Concatenation( "Localization functor by projectives",
              r[ 1 ],  ":", r[ 2 ], "\n\n", Name( homotopy_category ), "\n", r[ 1 ], "  |\n  |\n  V", r[ 2 ], "\n", Name( homotopy_category_projs ) );
    
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
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( cat ) then
      
      Error( "The input should be abelian with computable enough injective objects!\n" );
      
    fi;
    
    injs := ValueGlobal( "FullSubcategoryGeneratedByInjectiveObjects" )( cat );
    
    homotopy_category_injs := HomotopyCategory( injs );
    
    r := RandomBoldTextColor( );
    
    name := Concatenation( "Localization functor by injectives",
              r[ 1 ],  ":", r[ 2 ], "\n\n", Name( homotopy_category ), "\n", r[ 1 ], "  |\n  |\n  V", r[ 2 ], "\n", Name( homotopy_category_injs ) );
    
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

