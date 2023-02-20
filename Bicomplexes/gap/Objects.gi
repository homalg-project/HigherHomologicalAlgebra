





##
InstallMethod( CreateBicomplex,
          [ IsBicomplexesCategory, IsList ],

ObjectConstructor );

##
InstallOtherMethod( CreateBicomplex,
          [ IsBicomplexesCategory, IsChainOrCochainComplex ],
  
  { bicomplexes_cat, o } -> ModeledObject( bicomplexes_cat, o )
);

##
BindGlobal( "CREATE_BICOMPLEX_FROM_BICOMPLEX",
   
  { bicomplexes_cat, o } -> ObjectConstructor( bicomplexes_cat,
                                [ {i,j} -> ObjectFunction( o )( -i, -j ),
                                  {i,j} -> HorizontalDifferentialFunction( o )( -i, -j ),
                                  {i,j} -> VerticalDifferentialFunction( o )( -i, -j ),
                                  -RightBound( o ), -LeftBound( o ),
                                  -AboveBound( o ), -BelowBound( o ) ] )
);

##
InstallOtherMethod( CreateBicomplex,
          [ IsBicomplexesCategoryByCochains, IsChainBicomplex ],
  
  CREATE_BICOMPLEX_FROM_BICOMPLEX );

##
InstallOtherMethod( CreateBicomplex,
          [ IsBicomplexesCategoryByChains, IsCochainBicomplex ],
  
  CREATE_BICOMPLEX_FROM_BICOMPLEX );

##
InstallOtherMethod( ObjectAt,
               [ IsChainOrCochainBicomplex, IsInt, IsInt ],
  
  { obj, i, j } -> ModelingObject( CapCategory( obj ), obj )[i][j]
    # or { obj, i, j } -> ObjectFunction( obj )( i, j ) (not cached)
);

##
InstallMethod( HorizontalDifferentialAt,
               [ IsChainOrCochainBicomplex, IsInt, IsInt ],
  
  { obj, i, j } -> (ModelingObject( CapCategory( obj ), obj )^i)[j]
  # or { obj, i, j } -> HorizontalDifferentialFunction( obj )( i, j ) (not cached)
);

##
InstallMethod( VerticalDifferentialAt,
               [ IsChainOrCochainBicomplex, IsInt, IsInt ],
  
  { obj, i, j } -> (-1)^i * ModelingObject( CapCategory( obj ), obj )[i]^j
  # or { obj, i, j } -> VerticalDifferentialFunction( obj )( i, j ) (not cached)
);


##
InstallMethod( ViewObj,
          [ IsChainOrCochainBicomplex ],
    
    _bicomplexes_ViewObj
);

##
InstallMethod( Display,
          [ IsChainOrCochainBicomplex ],
  
  function ( obj )
    local i, j;
    
    for i in [ LeftBound( obj ) .. RightBound( obj ) ] do
      for j in [ BelowBound( obj ) .. AboveBound( obj ) ] do
        
        Print( "\n-------------------------------------------\n" );
        Print( "At Indices ", [i, j], ":" );
        Print( "\n-------------------------------------------\n" );
        
        Print( "\nObject:\n" );
        Display( ObjectFunction( obj )(i, j) );
        
        Print( "\nHorizontal Differential:\n" );
        Display( HorizontalDifferentialFunction( obj )(i, j) );
        
        Print( "\nVertical Differential:\n" );
        Display( VerticalDifferentialFunction( obj )(i, j) );
        
      od;
    od;
    
    Print( "\nAn object in ", Name( CapCategory( obj ) ), " defined by the above data\n" );
    
end );

