
## These random method should be removed as long as the following PR has been merged to CAP
## https://github.com/homalg-project/CAP_project/pull/479
##
InstallMethod( RandomObjectByInteger,
          [ IsAdditiveClosureCategory, IsInt ],
  function( category, n )
    local underlying_category;
    
    if CanCompute( category, "RandomObjectByInteger" ) then
      
      TryNextMethod( );
      
    fi;
    
    underlying_category := UnderlyingCategory( category );
    
    if n = 0 then
      
      return ZeroObject( category );
      
    else
      
      return List( [ 1 .. AbsInt( n ) ],
              i -> RandomObjectByInteger( underlying_category, n )
               ) / category;
               
    fi;
    
end );

##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByInteger,
          [ IsAdditiveClosureObject, IsAdditiveClosureObject, IsInt ],
  function( source, range, n )
    local category, source_objects, range_objects, morphisms, current_row, s, r;
    
    category := CapCategory( source );
    
    if CanCompute( category, "RandomMorphismWithFixedSourceAndRangeByInteger" ) then
      
      TryNextMethod( );
      
    fi;
   
    source_objects := ObjectList( source );
    
    range_objects := ObjectList( range );
    
    if IsEmpty( source_objects ) or IsEmpty( range_objects ) then
      
      return ZeroMorphism( source, range );
      
    else
      
      morphisms := [ ];
      
      for s in source_objects do
        
        current_row := [ ];
        
        for r in range_objects do
          
          Add( current_row, RandomMorphismWithFixedSourceAndRange( s, r, n ) );
          
        od;
        
        Add( morphisms, current_row );
        
      od;
      
      return morphisms / category;
      
    fi;
    
end );

##
InstallMethod( RandomMorphismWithFixedSourceByInteger,
          [ IsAdditiveClosureObject, IsInt ],
  function( source, n )
    local category, range;
    
    category := CapCategory( source );
    
    if CanCompute( category, "RandomMorphismWithFixedSourceByInteger" ) then
      
      TryNextMethod( );
      
    fi;

    range := RandomObjectByInteger( category, n );
    
    return RandomMorphismWithFixedSourceAndRangeByInteger( source, range, n );
    
end );

##
InstallMethod( RandomMorphismWithFixedRangeByInteger,
          [ IsAdditiveClosureObject, IsInt ],
  function( range, n )
    local category, source;
    
    category := CapCategory( range );
    
    if CanCompute( category, "RandomMorphismWithFixedRangeByInteger" ) then
      
      TryNextMethod( );
      
    fi;

    source := RandomObjectByInteger( category, n );
    
    return RandomMorphismWithFixedSourceAndRangeByInteger( source, range, n );
    
end );

##
InstallMethod( RandomMorphismByInteger,
          [ IsAdditiveClosureCategory, IsInt ],
  function( category, n )
    local a;
    
    a := RandomObjectByInteger( category, n );
    
    return RandomMorphismWithFixedSourceByInteger( a, Random( [ AbsInt( n ) - 1 .. AbsInt( n ) + 1 ] ) );
    
end );

