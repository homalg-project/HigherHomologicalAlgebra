#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

###########################
#
# Backward convolution
#
###########################

##
InstallMethod( ForwardConvolutionAtIndexOp,
          [ IsChainComplex, IsInt ],
  function( C, m )
    local l, u, alpha, beta, H, maps, d, diffs;
    
    l := ActiveLowerBound( C );
    
    u := ActiveUpperBound( C );
    
    if m > u then
      
      return C;
      
    elif m < u then
      
      return ForwardConvolutionAtIndex( ForwardConvolutionAtIndex( C, m + 1 ), m );
      
    elif u - l in [ 0, 1 ] then
      
      return StalkChainComplex( StandardConeObject( C ^ m ), m - 1 );
      
    else
      
      alpha := C ^ m;
      
      beta := C ^ ( m - 1 );
      
      H := HomotopyMorphisms( PreCompose( alpha, beta ) );
      
      maps := AsZFunction( i -> MorphismBetweenDirectSums( [ [ H[ i - 1 ] ], [ beta[ i ] ] ] ) );
      
      d := HomotopyCategoryMorphism( StandardConeObject( alpha ), Range( beta ), maps );
      
      diffs := List( [ l + 1 .. u - 2 ], i -> C ^ i );
      
      Add( diffs, d );
      
      return ChainComplex( diffs, l + 1 );
      
    fi;
    
end );

##
InstallMethod( ForwardConvolution,
          [ IsChainComplex ],
  function( C )
    local l;
    
    l := ActiveLowerBound( C );
    
    C := ForwardConvolutionAtIndex( C, l + 1 );
    
    return Shift( C[ l ], l );
    
end );

##
InstallMethod( ForwardConvolution,
          [ IsHomotopyCategoryObject ],
  C -> ForwardConvolution( UnderlyingCell( C ) )
);

##
InstallMethod( ForwardConvolutionAtIndexOp,
          [ IsChainMorphism, IsInt ],
  function( alpha, m )
    local l, u, map, maps, s, r;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    if m > u then
      
      return alpha;
      
    elif m < u then
      
      return ForwardConvolutionAtIndex( ForwardConvolutionAtIndex( alpha, m + 1 ), m );
      
    else
      
      map := MorphismBetweenStandardConeObjects(
                Source( alpha ) ^ m,
                alpha[ m ],
                alpha[ m - 1 ],
                Range( alpha ) ^ m
              );
              
      if l = u then
        
        return StalkChainMorphism( map, m - 1 );
        
      else
        
        maps := List( [ l .. u - 2 ], i -> alpha[ i ] );
        
        Add( maps, map );
        
        s := ForwardConvolutionAtIndex( Source( alpha ), m );
        
        r := ForwardConvolutionAtIndex( Range( alpha ), m );
        
        return ChainMorphism( s, r, maps, l );
        
      fi;
      
    fi;
    
end );

##
InstallMethod( ForwardConvolution,
          [ IsChainMorphism ],
  function( alpha )
    local l;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    alpha := ForwardConvolutionAtIndex( alpha, l + 1 );
    
    return Shift( alpha[ l ], l );
    
end );

##
InstallMethod( ForwardConvolution,
          [ IsHomotopyCategoryMorphism ],
  alpha -> ForwardConvolution( UnderlyingCell( alpha ) )
);

###########################
#
# Backward convolution
#
###########################

##
InstallMethod( BackwardConvolutionAtIndexOp,
          [ IsChainComplex, IsInt ],
  function( C, m )
    local l, u, alpha, beta, H, maps, d, diffs;
    
    l := ActiveLowerBound( C );
    
    u := ActiveUpperBound( C );
    
    if m < l then
      
      return C;
      
    elif m > l then
      
      return BackwardConvolutionAtIndex( BackwardConvolutionAtIndex( C, m - 1 ), m );
      
    elif u - l in [ 0, 1 ] then
      
      return StalkChainComplex( InverseShiftOnObject( StandardConeObject( C ^ ( m + 1 ) ) ), m + 1 );
      
    else
      
      alpha := C ^ ( m + 2 );
      
      beta := C ^ ( m + 1 );
      
      H := HomotopyMorphisms( PreCompose( alpha, beta ) );
      
      maps := AsZFunction( i -> MorphismBetweenDirectSums( [ [ alpha[ i ], -H[ i ] ] ] ) );
      
      d := HomotopyCategoryMorphism(
                  Source( alpha ),
                  InverseShiftOnObject( StandardConeObject( C ^ ( m + 1 ) ) ),
                  maps
                );
                
      diffs := List( [ l + 3 .. u ], i -> C ^ i );
      
      Add( diffs, d, 1 );
      
      return ChainComplex( diffs, m + 2 );
      
    fi;
    
end );

##
InstallMethod( BackwardConvolution,
          [ IsChainComplex ],
  function( C )
    local u;
    
    u := ActiveUpperBound( C );
    
    C := BackwardConvolutionAtIndex( C, u - 1 );
    
    return Shift( C[ u ], u );
    
end );

##
InstallMethod( BackwardConvolutionAtIndexOp,
          [ IsChainMorphism, IsInt ],
  function( alpha, m )
    local C, D, l, u, map, maps, s, r;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    if m < l then
      
      return alpha;
      
    elif m > l then
      
      return BackwardConvolutionAtIndex( BackwardConvolutionAtIndex( alpha, m - 1 ), m );
      
    else
      
      map := MorphismBetweenStandardConeObjects(
                Source( alpha ) ^ ( m + 1 ),
                alpha[ m + 1 ],
                alpha[ m ],
                Range( alpha ) ^ ( m + 1 )
              );
              
      map := InverseShiftOnMorphism( map );
      
      if u - l in [ 0, 1 ] then
        
        return StalkChainMorphism( map, m + 1 );
        
      else
        
        maps := List( [ m + 2 .. u ], i -> alpha[ i ] );
        
        Add( maps, map, 1 );
        
        s := BackwardConvolutionAtIndex( Source( alpha ), m );
        
        r := BackwardConvolutionAtIndex( Range( alpha ), m );
        
        return ChainMorphism( s, r, maps, m + 1 );
        
      fi;
      
    fi;
    
end );

##
InstallMethod( BackwardConvolution,
          [ IsChainMorphism ],
  function( alpha )
    local u;
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    alpha := BackwardConvolutionAtIndex( alpha, u - 1 );
    
    return Shift( alpha[ u ], u );
    
end );

