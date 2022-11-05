# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#

##
MakeReadWriteGlobal( "DISABLE_ALL_SANITY_CHECKS" );
MakeReadWriteGlobal( "SWITCH_LOGIC_OFF" );
MakeReadWriteGlobal( "DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS" );

##
DISABLE_ALL_SANITY_CHECKS := false;
SWITCH_LOGIC_OFF := false;
DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS := [ ];
DISABLE_CACHING_FOR_CELLS_CONSTRUCTORS_FOR_CATEGORIES_WITH_THESE_FILTERS := [ ];

##
BindGlobal( "SetSpecialSettings",
  function( )
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
