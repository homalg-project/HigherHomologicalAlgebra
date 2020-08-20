#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################


##
InstallMethod( ForwardConvolution,
          [ IsHomotopyCategoryObject ],
  C -> ForwardConvolution( UnderlyingCell( C ) )
);

##
InstallMethod( ForwardConvolution,
          [ IsHomotopyCategoryMorphism ],
  alpha -> ForwardConvolution( UnderlyingCell( alpha ) )
);

##
InstallOtherMethod( ForwardConvolution,
          [ IsHomotopyCategoryCell, IsInt ],
    ForwardConvolutionAtIndex 
);

##
InstallMethod( BackwardConvolution,
          [ IsHomotopyCategoryObject ],
  C -> BackwardConvolution( UnderlyingCell( C ) )
);

##
InstallMethod( BackwardConvolution,
          [ IsHomotopyCategoryMorphism ],
  alpha -> BackwardConvolution( UnderlyingCell( alpha ) )
);

##
InstallOtherMethod( BackwardConvolution,
          [ IsHomotopyCategoryCell, IsInt ],
    BackwardConvolutionAtIndex 
);

################################
#
# Forward convolution by chains
#
################################

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

################################
#
# Backward convolution by chains
#
################################

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
      
      maps := AsZFunction( i -> MorphismBetweenDirectSums( [ [ -alpha[ i ], H[ i ] ] ] ) );
      
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

##
InstallMethod( ShiftOfBackwardConvolution_into_BackwardConvolutionOfShiftOp,
          [ IsHomotopyCategoryObject, IsInt ],
  function( C, n )
    local diffs, D, z_func, alpha;
    
    if n mod 2 = 0 then
      
      return IdentityMorphism( Shift( BackwardConvolution( C ), n ) );
      
    fi;
    
    diffs := Differentials( C );
    
    diffs := ApplyMap( diffs, AdditiveInverse );
    
    D := HomotopyCategoryObject( CapCategory( C ), diffs );
    
    SetLowerBound( D, ActiveLowerBound( C ) );
    
    SetUpperBound( D, ActiveUpperBound( C ) );
    
    z_func := AsZFunction( i -> ( -1 ) ^ i * IdentityMorphism( C[ i ] ) );
    
    alpha := HomotopyCategoryMorphism( C, D, z_func );
    
    return Shift( BackwardConvolution( alpha ), n );

end );

##
InstallMethod( BackwardConvolutionOfShift_into_ShiftOfBackwardConvolutionOp,
          [ IsHomotopyCategoryObject, IsInt ],
  function( C, n )
    local m;
    
    m := ShiftOfBackwardConvolution_into_BackwardConvolutionOfShift( C, n );
    
    return HomotopyCategoryMorphism( Range( m ), Source( m ), Morphisms( m ) );

end );

###################################
#
# Forward Convolution by cochains
#
###################################

##
InstallMethod( ForwardConvolutionAtIndexOp,
          [ IsCochainComplex, IsInt ],

  function( C, m )
    local l, u, alpha, beta, H, maps, d, diffs;
     
    u := ActiveUpperBound( C );
    
    l := ActiveLowerBound( C );
    
    if m < l then
      
      return C;
      
    elif m > l then
      
      return ForwardConvolutionAtIndex( ForwardConvolutionAtIndex( C, m - 1 ), m );
      
    elif u - l in [ 0, 1 ] then
      
      return StalkCochainComplex( StandardConeObject( C ^ m ), m + 1 );
      
    else
      
      alpha := C ^ m;
      
      beta := C ^ ( m + 1 );
      
      H := HomotopyMorphisms( PreCompose( alpha, beta ) );
      
      maps := AsZFunction( i -> MorphismBetweenDirectSums( [ [ H[ i + 1 ] ], [ beta[ i ] ] ] ) );
      
      d := HomotopyCategoryMorphism( StandardConeObject( alpha ), Range( beta ), maps );
      
      diffs := List( [ l + 2 .. u - 1 ], i -> C ^ i );
      
      diffs := Concatenation( [ d ], diffs );
      
      return CochainComplex( diffs, l + 1 );
      
    fi;
    
end );

##
InstallOtherMethod( ForwardConvolutionAtIndex,
        [ IsHomotopyCategoryCell, IsInt ],
  { c, m } -> ForwardConvolutionAtIndex( UnderlyingCell( c ), m ) / CapCategory( c )
);

##
InstallMethod( ForwardConvolution,
          [ IsCochainComplex ],
  function( C )
    local u;
    
    u := ActiveUpperBound( C );
    
    C := ForwardConvolutionAtIndex( C, u - 1 );
    
    return Shift( C[ u ], -u );
    
end );

##
InstallMethod( ForwardConvolutionAtIndexOp,
          [ IsCochainMorphism, IsInt ],
  function( alpha, m )
    local l, u, map, maps, s, r;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    if m < l then
      
      return alpha;
      
    elif m > l then
      
      return ForwardConvolutionAtIndex( ForwardConvolutionAtIndex( alpha, m - 1 ), m );
      
    else
      
      map := MorphismBetweenStandardConeObjects(
                Source( alpha ) ^ m,
                alpha[ m ],
                alpha[ m + 1 ],
                Range( alpha ) ^ m
              );
              
      if l = u then
        
        return StalkCochainMorphism( map, m + 1 );
        
      else
        
        maps := List( [ l + 2 .. u ], i -> alpha[ i ] );
        
        maps := Concatenation( [ map ], maps );
        
        s := ForwardConvolutionAtIndex( Source( alpha ), m );
        
        r := ForwardConvolutionAtIndex( Range( alpha ), m );
        
        return CochainMorphism( s, r, maps, l + 1 );
        
      fi;
      
    fi;
    
end );

##
InstallMethod( ForwardConvolution,
          [ IsCochainMorphism ],
  function( alpha )
    local u;
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    alpha := ForwardConvolutionAtIndex( alpha, u - 1 );
    
    return Shift( alpha[ u ], -u );
    
end );

#########################
#
# Backward Convolution by cochains
#
#########################

##
InstallMethod( BackwardConvolutionAtIndexOp,
          [ IsCochainComplex, IsInt ],
  function( C, m )
    local l, u, alpha, beta, H, maps, d, diffs;
    
    l := ActiveLowerBound( C );
    
    u := ActiveUpperBound( C );
    
    if m > u then
      
      return C;
      
    elif m < u then
      
      return BackwardConvolutionAtIndex( BackwardConvolutionAtIndex( C, m + 1 ), m );
      
    elif u - l in [ 0, 1 ] then
      
      return StalkCochainComplex( InverseShiftOnObject( StandardConeObject( C ^ ( m - 1 ) ) ), m - 1 );
      
    else
      
      alpha := C ^ ( m - 2 );
      
      beta := C ^ ( m - 1 );
      
      H := HomotopyMorphisms( PreCompose( alpha, beta ) );
      
      maps := AsZFunction( i -> MorphismBetweenDirectSums( [ [ -alpha[ i ], H[ i ] ] ] ) );
      
      d := HomotopyCategoryMorphism(
                  Source( alpha ),
                  InverseShiftOnObject( StandardConeObject( C ^ ( m - 1 ) ) ),
                  maps
                );
                
      diffs := List( [ l .. u - 3 ], i -> C ^ i );
      
      Add( diffs, d );
      
      return CochainComplex( diffs, l );
      
    fi;
    
end );

##
InstallOtherMethod( BackwardConvolutionAtIndex,
        [ IsHomotopyCategoryCell, IsInt ],
  { c, m } -> BackwardConvolutionAtIndex( UnderlyingCell( c ), m ) / CapCategory( c )
);

##
InstallMethod( BackwardConvolution,
          [ IsCochainComplex ],
  function( C )
    local l;
    
    l := ActiveLowerBound( C );
    
    C := BackwardConvolutionAtIndex( C, l + 1 );
    
    return Shift( C[ l ], -l );
    
end );

##
InstallMethod( BackwardConvolutionAtIndexOp,
          [ IsCochainMorphism, IsInt ],
  function( alpha, m )
    local C, D, l, u, map, maps, s, r;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    if m > u then
      
      return alpha;
      
    elif m < u then
      
      return BackwardConvolutionAtIndex( BackwardConvolutionAtIndex( alpha, m + 1 ), m );
      
    else
      
      map := MorphismBetweenStandardConeObjects(
                Source( alpha ) ^ ( m - 1 ),
                alpha[ m - 1 ],
                alpha[ m ],
                Range( alpha ) ^ ( m - 1 )
              );
              
      map := InverseShiftOnMorphism( map );
      
      if u - l in [ 0, 1 ] then
        
        return StalkCochainMorphism( map, m - 1 );
        
      else
        
        maps := List( [ l .. u - 2 ], i -> alpha[ i ] );
        
        Add( maps, map );
        
        s := BackwardConvolutionAtIndex( Source( alpha ), m );
        
        r := BackwardConvolutionAtIndex( Range( alpha ), m );
        
        return CochainMorphism( s, r, maps, l );
        
      fi;
      
    fi;
    
end );

##
InstallMethod( BackwardConvolution,
          [ IsCochainMorphism ],
  function( alpha )
    local l;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    alpha := BackwardConvolutionAtIndex( alpha, l + 1 );
    
    return Shift( alpha[ l ], -l );
    
end );
