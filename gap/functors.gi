
##
InstallMethod( HomologyFunctorAt, 
               [ IsHomotopyCategory, IsCapCategory, IsInt ],
function( homotopy_category, cat, n )
  local functor, complex_cat, name, Hn;

  if not IsIdenticalObj( UnderlyingCategory( UnderlyingCapCategory( homotopy_category ) ), cat ) then

    Error( "The first argument should be the homotopy category of complex category of the second argument" );

  fi;
     
  complex_cat := UnderlyingCapCategory( homotopy_category );

  Hn := HomologyFunctorAt( complex_cat, cat, n );

  name := Concatenation( String( n ), "-th homology functor from ", Name( homotopy_category ), " to ", Name( cat ) );
     
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
InstallMethod( ShiftFunctorAt, 
               [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local functor, complex_cat, name, T;
     
  complex_cat := UnderlyingCapCategory( homotopy_category ); 

  T := ShiftFunctor( complex_cat, n );

  name := Concatenation( "Shift by ", String( n ), " autoequivalence on ", Name( homotopy_category ) );
     
  functor := CapFunctor( name, homotopy_category, homotopy_category );

  AddObjectFunction( functor, 
  
    function( complex )
  
      return HomotopyCategoryObject( homotopy_category, ApplyFunctor( T, UnderlyingCell( complex ) ) );
  
  end );
     
  AddMorphismFunction( functor,

    function( new_source, map, new_range )

      return HomotopyCategoryMorphism( homotopy_category, ApplyFunctor( T, UnderlyingCell( map ) ) );

  end );

  return functor;
 
end );

##
InstallMethod( UnsignedShiftFunctorAt,
               [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local functor, complex_cat, name, T;
     
  complex_cat := UnderlyingCapCategory( homotopy_category ); 

  T := UnsignedShiftFunctor( complex_cat, n );

  name := Concatenation( "Unsigned Shift by ", String( n ), " autoequivalence on ", Name( homotopy_category ) );
     
  functor := CapFunctor( name, homotopy_category, homotopy_category );

  AddObjectFunction( functor, 
  
  function( complex )
  
    return HomotopyCategoryObject( homotopy_category, ApplyFunctor( T, UnderlyingCell( complex ) ) );
  
  end );
     
  AddMorphismFunction( functor,

    function( new_source, map, new_range )

      return HomotopyCategoryMorphism( homotopy_category, ApplyFunctor( T, UnderlyingCell( map ) ) );

  end );

  return functor;
 
end );

##
InstallMethod( ExtendFunctorToHomotopyCategoryFunctor,
               [ IsCapFunctor ],
function( F )
  local S, T, ChF, name, functor;

  S := HomotopyCategory( AsCapCategory( Source( F ) ) );

  T := HomotopyCategory( AsCapCategory(  Range( F ) ) );
  
  ChF := ExtendFunctorToChainComplexCategoryFunctor( F );
  
  name := Concatenation( "Extended version of ", Name( F ), " from ", Name( S ), " to ", Name( T ) );

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
InstallMethod( EmbeddingInHomotopyCategoryOfTheFullSubcategoryGeneratedByProjectiveObjects,
          [ IsCapCategory ],
  function( cat )
    local projs, homotopy_category, name, F;
    
    if not IsAbelianCategoryWithEnoughProjectives( cat ) then
      
      Error( "The input should be abelian with enough projectives!\n" );
      
    fi;
  
    projs := ValueGlobal( "FullSubcategoryGeneratedByProjectiveObjects" )( cat );
    
    homotopy_category := HomotopyCategory( projs );
    
    name := Random( List( [ 1 .. 6 ], i -> TextAttr.(i) ) );
    
    name := Concatenation( "Embedding functor ", name, "from\033[0m ", Name( cat ), name, " into\033[0m ", Name( homotopy_category ) );
   
    F := CapFunctor( name, cat, homotopy_category );
    
    ##
    AddObjectFunction( F,
      function( a )
        local p;
        
        p := AsChainComplex( ProjectiveResolution( a, true ) );
        
        p := AsComplexOverCapFullSubcategory( projs, p );
        
        return HomotopyCategoryObject( homotopy_category, p );
        
    end );
    
    ##
    AddMorphismFunction( F,
      function( s, phi, r )
        local psi;
        
        psi := MorphismBetweenProjectiveResolutions( phi, true );
        
        psi := AsChainMorphism( psi );
        
        psi := AsChainMorphismOverCapFullSubcategory( psi );
        
        return HomotopyCategoryMorphism( homotopy_category, psi );
        
    end );
    
    return F;
    
end );

##
InstallMethod( EmbeddingInHomotopyCategoryOfTheFullSubcategoryGeneratedByInjectiveObjects,
          [ IsCapCategory ],
  function( cat )
    local injs, homotopy_category, name, F;
    
    if not IsAbelianCategoryWithEnoughInjectives( cat ) then
      
      Error( "The input should be abelian with enough injectives!\n" );
      
    fi;
  
    injs := ValueGlobal( "FullSubcategoryGeneratedByInjectiveObjects" )( cat );
    
    homotopy_category := HomotopyCategory( injs );
    
    name := Random( List( [ 1 .. 6 ], i -> TextAttr.(i) ) );
     
    name := Concatenation( "Embedding functor ", name, "from\033[0m ", Name( cat ), name, " into\033[0m ", Name( homotopy_category ) );
   
    F := CapFunctor( name, cat, homotopy_category );
    
    ##
    AddObjectFunction( F,
      function( a )
        local p;
        
        p := AsChainComplex( InjectiveResolution( a, true ) );
        
        p := AsComplexOverCapFullSubcategory( injs, p );
        
        return HomotopyCategoryObject( homotopy_category, p );
        
    end );
    
    ##
    AddMorphismFunction( F,
      function( s, phi, r )
        local psi;
        
        psi := MorphismBetweenProjectiveResolutions( phi, true );
        
        psi := AsChainMorphism( psi );
        
        psi := AsChainMorphismOverCapFullSubcategory( psi );
        
        return HomotopyCategoryMorphism( homotopy_category, psi );
        
    end );
    
    return F;
    
end );
