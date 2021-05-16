# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#

BindGlobal( "SECTION_AND_RETRACTION_METHOD_RECORD", rec(

  Section := rec(
    installation_name := "Section",
    filter_list := [ "category", "morphism" ],
    cache_name := "Section",
    return_type := "morphism"
  ),
  
  Retraction := rec(
    installation_name := "Retraction",
    filter_list := [ "category", "morphism" ],
    cache_name := "Retraction",
    return_type := "morphism"
  )
) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( SECTION_AND_RETRACTION_METHOD_RECORD );
CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( SECTION_AND_RETRACTION_METHOD_RECORD );

AddDerivationToCAP( Section,
            [
              [ Lift, 1 ],
              [ IdentityMorphism, 1 ]
            ],
            
  {cat, alpha} -> Lift( IdentityMorphism( Range( alpha ) ), alpha )
  : Description:= "Section using Lift and IdentityMorphism"
);

AddDerivationToCAP( Retraction,
            [
              [ Colift, 1 ],
              [ IdentityMorphism, 1 ]
            ],
            
  {cat, alpha} -> Colift( alpha, IdentityMorphism( Source( alpha ) ) )
  : Description:= "Retraction using Colift and IdentityMorphism"
);


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
    
    if IsBound( IsStableCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsStableCategory" ) );
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

##
InstallMethod( SimplifySource,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return PreCompose( SimplifyObject_IsoToInputObject( Source( phi ), i ), phi );
    
end );

##
InstallMethod( SimplifySource_IsoFromInputObject,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return SimplifyObject_IsoFromInputObject( Source( phi ), i );
    
end );

##
InstallMethod( SimplifySource_IsoToInputObject,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return SimplifyObject_IsoToInputObject( Source( phi ), i );
    
end );

##
InstallMethod( SimplifyRange,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return PreCompose( phi, SimplifyObject_IsoFromInputObject( Range( phi ), i ) );
    
end );

##
InstallMethod( SimplifyRange_IsoFromInputObject,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return SimplifyObject_IsoFromInputObject( Range( phi ), i );
    
end );

##
InstallMethod( SimplifyRange_IsoToInputObject,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return SimplifyObject_IsoToInputObject( Range( phi ), i );
    
end );

##
InstallMethod( SimplifySourceAndRange,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return PreCompose(
              [
                SimplifyObject_IsoToInputObject( Source( phi ), i ),
                phi,
                SimplifyObject_IsoFromInputObject( Range( phi ), i )
              ]
            );
    
end );

##
InstallMethod( SimplifySourceAndRange_IsoFromInputSource,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return SimplifyObject_IsoFromInputObject( Source( phi ), i );
    
end );

##
InstallMethod( SimplifySourceAndRange_IsoToInputSource,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return SimplifyObject_IsoToInputObject( Source( phi ), i );
    
end );

##
InstallMethod( SimplifySourceAndRange_IsoFromInputRange,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return SimplifyObject_IsoFromInputObject( Range( phi ), i );
    
end );

##
InstallMethod( SimplifySourceAndRange_IsoToInputRange,
          [ IsCapCategoryMorphism, IsObject ], -1,
          
  function( phi, i )
    local category;
    
    category := CapCategory( phi );
    
    #if not ( CanCompute( category, "SimplifyObject" ) and 
    #          CanCompute( category, "SimplifyObject_IsoToInputObject" ) and
    #            CanCompute( category, "SimplifyObject_IsoFromInputObject" ) 
    #              ) then
    #              
    #  TryNextMethod( );
    #fi;
    
    return SimplifyObject_IsoToInputObject( Range( phi ), i );
    
end );
