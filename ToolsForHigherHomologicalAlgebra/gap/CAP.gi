




##
MakeReadWriteGlobal( "DISABLE_ALL_SANITY_CHECKS" );
MakeReadWriteGlobal( "SWITCH_LOGIC_OFF" );
MakeReadWriteGlobal( "DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS" );

##
DISABLE_ALL_SANITY_CHECKS := false;
SWITCH_LOGIC_OFF := false;
DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS := [ ];

##
InstallMethod( Finalize,
          [ IsCapCategory ],
  function( category )
    local o;
    
    o := ValueOption( "ToolsForHigherHomologicalAlgebra_Finalize" );
    
    if o = false then
      TryNextMethod( );
    fi;
    
    Finalize( category: ToolsForHigherHomologicalAlgebra_Finalize := false );
    
    if DISABLE_ALL_SANITY_CHECKS then
      DisableSanityChecks( category );
    fi;
    
    if SWITCH_LOGIC_OFF then
      CapCategorySwitchLogicOff( category );
    fi;
    
    if ForAny( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, func -> func( category ) ) then
      DeactivateCachingOfCategory( category );
    fi;
    
end, 5000 );

##
InstallGlobalFunction( DeactivateCachingForCertainOperations,
  function( category, list_of_operations )
    local current_name;
    
    for current_name in list_of_operations do
      
      SetCaching( category, current_name, "none" );
      
    od;
    
end );

##
InstallGlobalFunction( ActivateCachingForCertainOperations,
  function( category, list_of_operations )
    local equality_operations, current_name;
    
    equality_operations := [
                  "IsEqualForMorphisms",
                  "IsEqualForObjects",
                  "IsEqualForMorphismsOnMor",
                  "IsEqualForCacheForMorphisms",
                  "IsEqualForCacheForObjects"
                  ];
                  
    list_of_operations := Concatenation( equality_operations, list_of_operations );
    
    for current_name in RecNames( category!.caches ) do
      
      if current_name in list_of_operations then
        
        continue;
        
      fi;
      
      SetCaching( category, current_name, "none" );
      
    od;
    
end );

##
InstallGlobalFunction( CurrentCaching,
  function( cat )
  
    return cat!.default_cache_type;
    
end );

##
BindGlobal( "SetSpecialSettings",
  function( )
    
    ENABLE_COLORS := true;
    
    DISABLE_ALL_SANITY_CHECKS := true;
    
    SWITCH_LOGIC_OFF := true;
    
    if IsBound( IsChainComplexCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsChainComplexCategory" ) );
    fi;
    
    if IsBound( IsCochainComplexCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsCochainComplexCategory" ) );
    fi;
  
    if IsBound( IsMatrixCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsMatrixCategory" ) );
    fi;
    
    if IsBound( IsHomotopyCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal(  "IsHomotopyCategory" ) );
    fi;
    
    if IsBound( IsAdditiveClosureCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsAdditiveClosureCategory" ) );
    fi;
    
    if IsBound( IsQuiverRowsCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsQuiverRepresentationCategory" ) );
    fi;
    
    if IsBound( IsAlgebroid ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsAlgebroid" ) );
    fi;
    
    if IsBound( IsQuiverRowsCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsQuiverRowsCategory" ) );
    fi;
    
    if IsBound( IsCapProductCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsCapProductCategory" ) );
    fi;
    
    if IsBound( IsCategoryOfGradedRows ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsCategoryOfGradedRows" ) );
    fi;
    
    if IsBound( IsFreydCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsFreydCategory" ) );
    fi; 
       
end );

##
InstallMethod( ViewCapCategoryCell,
          [ IsCapCategoryCell ],
          
  function( c )
    ViewObj( c );
end );

##
InstallMethod( DisplayCapCategoryCell,
          [ IsCapCategoryCell ],
          
  function( c )
    Display( c );
end );

##
InstallMethod( _WeakKernelEmbedding,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local cat;
    
    cat := CapCategory( alpha );
    
    if CanCompute( cat, "KernelEmbedding" ) then
      return KernelEmbedding( alpha );
    else
      TryNextMethod( );
    fi;
  
end, 5000 );
