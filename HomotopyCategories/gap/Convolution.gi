#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

################################
#
# for chain complexes cells
#
################################

##
InstallMethod( ForwardPostnikovSystemAtOp,
          [ IsChainComplex, IsInt ],
  function( C, m )
    local l, u, alpha, beta, H, maps, d, diffs;
    
    l := ActiveLowerBound( C );
    
    u := ActiveUpperBound( C );
    
    if m + 1 > u then
      
      return C;
      
    elif m + 1 < u then
      
      return ForwardPostnikovSystemAt( ForwardPostnikovSystemAt( C, m + 1 ), m );
      
    elif u - l in [ 0, 1 ] then
      
      return StalkChainComplex( StandardConeObject( C ^ ( m + 1 ) ), m );
      
    else
      
      alpha := C ^ ( m + 1 );
      
      beta := C ^ m;
      
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
    
    C := ForwardPostnikovSystemAt( C, l );
    
    return Shift( C[ l ], l );
    
end );

##
InstallMethod( ForwardPostnikovSystemAtOp,
          [ IsChainMorphism, IsInt ],
  function( alpha, m )
    local l, u, map, maps, s, r;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    if m + 1 > u then
      
      return alpha;
      
    elif m + 1 < u then
      
      return ForwardPostnikovSystemAt( ForwardPostnikovSystemAt( alpha, m + 1 ), m );
      
    else
      
      map := MorphismBetweenStandardConeObjects(
                Source( alpha ) ^ ( m + 1 ),
                alpha[ m + 1 ],
                alpha[ m ],
                Range( alpha ) ^ ( m + 1 )
              );
              
      if l = u then
        
        return StalkChainMorphism( map, m );
        
      else
        
        maps := List( [ l .. u - 2 ], i -> alpha[ i ] );
        
        Add( maps, map );
        
        s := ForwardPostnikovSystemAt( Source( alpha ), m );
        
        r := ForwardPostnikovSystemAt( Range( alpha ), m );
        
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
    
    alpha := ForwardPostnikovSystemAt( alpha, l );
    
    return Shift( alpha[ l ], l );
    
end );

##
InstallMethod( BackwardPostnikovSystemAtOp,
          [ IsChainComplex, IsInt ],
  function( C, m )
    local l, u, alpha, beta, H, maps, d, diffs;
    
    l := ActiveLowerBound( C );
    
    u := ActiveUpperBound( C );
    
    if m - 1 < l then
      
      return C;
      
    elif m - 1 > l then
      
      return BackwardPostnikovSystemAt( BackwardPostnikovSystemAt( C, m - 1 ), m );
      
    elif u - l in [ 0, 1 ] then
      
      return StalkChainComplex( InverseShiftOnObject( StandardConeObject( C ^ m ) ), m );
      
    else
      
      alpha := C ^ ( m + 1 );
      
      beta := C ^ m;
      
      H := HomotopyMorphisms( PreCompose( alpha, beta ) );
      
      maps := AsZFunction( i -> MorphismBetweenDirectSums( [ [ -alpha[ i ], H[ i ] ] ] ) );
      
      d := HomotopyCategoryMorphism(
                  Source( alpha ),
                  InverseShiftOnObject( StandardConeObject( C ^ m ) ),
                  maps
                );
                
      diffs := List( [ l + 3 .. u ], i -> C ^ i );
      
      Add( diffs, d, 1 );
      
      return ChainComplex( diffs, m + 1 );
      
    fi;
    
end );

##
InstallMethod( BackwardConvolution,
          [ IsChainComplex ],
  function( C )
    local u;
    
    u := ActiveUpperBound( C );
    
    C := BackwardPostnikovSystemAt( C, u );
    
    return Shift( C[ u ], u );
    
end );

##
InstallMethod( BackwardPostnikovSystemAtOp,
          [ IsChainMorphism, IsInt ],
  function( alpha, m )
    local C, D, l, u, map, maps, s, r;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    if m - 1 < l then
      
      return alpha;
      
    elif m - 1 > l then
      
      return BackwardPostnikovSystemAt( BackwardPostnikovSystemAt( alpha, m - 1 ), m );
      
    else
      
      map := MorphismBetweenStandardConeObjects(
                Source( alpha ) ^ ( m ),
                alpha[ m ],
                alpha[ m - 1 ],
                Range( alpha ) ^ ( m )
              );
              
      map := InverseShiftOnMorphism( map );
      
      if u - l in [ 0, 1 ] then
        
        return StalkChainMorphism( map, m );
        
      else
        
        maps := List( [ m + 1 .. u ], i -> alpha[ i ] );
        
        Add( maps, map, 1 );
        
        s := BackwardPostnikovSystemAt( Source( alpha ), m );
        
        r := BackwardPostnikovSystemAt( Range( alpha ), m );
        
        return ChainMorphism( s, r, maps, m );
        
      fi;
      
    fi;
    
end );

##
InstallMethod( BackwardConvolution,
          [ IsChainMorphism ],
  function( alpha )
    local u;
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    alpha := BackwardPostnikovSystemAt( alpha, u );
    
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

#####################################
#
# For cochains categories cells
#
#####################################

##
InstallMethod( ForwardPostnikovSystemAtOp,
          [ IsCochainComplex, IsInt ],

  function( C, m )
    local l, u, alpha, beta, H, maps, d, diffs;
     
    u := ActiveUpperBound( C );
    
    l := ActiveLowerBound( C );
    
    if m - 1 < l then
      
      return C;
      
    elif m - 1 > l then
      
      return ForwardPostnikovSystemAt( ForwardPostnikovSystemAt( C, m - 1 ), m );
      
    elif u - l in [ 0, 1 ] then
      
      return StalkCochainComplex( StandardConeObject( C ^ ( m - 1 ) ), m );
      
    else
      
      alpha := C ^ ( m - 1 );
      
      beta := C ^ m;
      
      H := HomotopyMorphisms( PreCompose( alpha, beta ) );
      
      maps := AsZFunction( i -> MorphismBetweenDirectSums( [ [ H[ i + 1 ] ], [ beta[ i ] ] ] ) );
      
      d := HomotopyCategoryMorphism( StandardConeObject( alpha ), Range( beta ), maps );
      
      diffs := List( [ l + 2 .. u - 1 ], i -> C ^ i );
      
      diffs := Concatenation( [ d ], diffs );
      
      return CochainComplex( diffs, l + 1 );
      
    fi;
    
end );

##
InstallMethod( ForwardConvolution,
          [ IsCochainComplex ],
  function( C )
    local u;
    
    u := ActiveUpperBound( C );
    
    C := ForwardPostnikovSystemAt( C, u );
    
    return Shift( C[ u ], -u );
    
end );

##
InstallMethod( ForwardPostnikovSystemAtOp,
          [ IsCochainMorphism, IsInt ],
  function( alpha, m )
    local l, u, map, maps, s, r;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    if m - 1 < l then
      
      return alpha;
      
    elif m - 1 > l then
      
      return ForwardPostnikovSystemAt( ForwardPostnikovSystemAt( alpha, m - 1 ), m );
      
    else
      
      map := MorphismBetweenStandardConeObjects(
                Source( alpha ) ^ ( m - 1 ),
                alpha[ m - 1 ],
                alpha[ m ],
                Range( alpha ) ^ ( m - 1 )
              );
              
      if l = u then
        
        return StalkCochainMorphism( map, m );
        
      else
        
        maps := List( [ l + 2 .. u ], i -> alpha[ i ] );
        
        maps := Concatenation( [ map ], maps );
        
        s := ForwardPostnikovSystemAt( Source( alpha ), m );
        
        r := ForwardPostnikovSystemAt( Range( alpha ), m );
        
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
    
    alpha := ForwardPostnikovSystemAt( alpha, u );
    
    return Shift( alpha[ u ], -u );
    
end );

##
InstallMethod( BackwardPostnikovSystemAtOp,
          [ IsCochainComplex, IsInt ],
  function( C, m )
    local l, u, alpha, beta, H, maps, d, diffs;
    
    l := ActiveLowerBound( C );
    
    u := ActiveUpperBound( C );
    
    if m + 1 > u then
      
      return C;
      
    elif m + 1 < u then
      
      return BackwardPostnikovSystemAt( BackwardPostnikovSystemAt( C, m + 1 ), m );
      
    elif u - l in [ 0, 1 ] then
      
      return StalkCochainComplex( InverseShiftOnObject( StandardConeObject( C ^ m ) ), m );
      
    else
      
      alpha := C ^ ( m - 1 );
      
      beta := C ^ m;
      
      H := HomotopyMorphisms( PreCompose( alpha, beta ) );
      
      maps := AsZFunction( i -> MorphismBetweenDirectSums( [ [ -alpha[ i ], H[ i ] ] ] ) );
      
      d := HomotopyCategoryMorphism(
                  Source( alpha ),
                  InverseShiftOnObject( StandardConeObject( C ^ m ) ),
                  maps
                );
                
      diffs := List( [ l .. u - 3 ], i -> C ^ i );
      
      Add( diffs, d );
      
      return CochainComplex( diffs, l );
      
    fi;
    
end );

##
InstallMethod( BackwardConvolution,
          [ IsCochainComplex ],
  function( C )
    local l;
    
    l := ActiveLowerBound( C );
    
    C := BackwardPostnikovSystemAt( C, l );
    
    return Shift( C[ l ], -l );
    
end );

##
InstallMethod( BackwardPostnikovSystemAtOp,
          [ IsCochainMorphism, IsInt ],
  function( alpha, m )
    local C, D, l, u, map, maps, s, r;
    
    l := ActiveLowerBoundForSourceAndRange( alpha );
    
    u := ActiveUpperBoundForSourceAndRange( alpha );
    
    if m + 1 > u then
      
      return alpha;
      
    elif m + 1 < u then
      
      return BackwardPostnikovSystemAt( BackwardPostnikovSystemAt( alpha, m + 1 ), m );
      
    else
      
      map := MorphismBetweenStandardConeObjects(
                Source( alpha ) ^ m,
                alpha[ m ],
                alpha[ m + 1 ],
                Range( alpha ) ^ m
              );
              
      map := InverseShiftOnMorphism( map );
      
      if u - l in [ 0, 1 ] then
        
        return StalkCochainMorphism( map, m );
        
      else
        
        maps := List( [ l .. u - 2 ], i -> alpha[ i ] );
        
        Add( maps, map );
        
        s := BackwardPostnikovSystemAt( Source( alpha ), m );
        
        r := BackwardPostnikovSystemAt( Range( alpha ), m );
        
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
    
    alpha := BackwardPostnikovSystemAt( alpha, l );
    
    return Shift( alpha[ l ], -l );
    
end );

#####################################
#
# For homotopy category cells
#
#####################################

##
InstallOtherMethod( ForwardPostnikovSystemAt,
        [ IsHomotopyCategoryCell, IsInt ],
  { c, m } -> ForwardPostnikovSystemAt( UnderlyingCell( c ), m ) / CapCategory( c )
);

##
InstallOtherMethod( BackwardPostnikovSystemAt,
        [ IsHomotopyCategoryCell, IsInt ],
  { c, m } -> BackwardPostnikovSystemAt( UnderlyingCell( c ), m ) / CapCategory( c )
);

##
InstallMethod( ForwardConvolution,
          [ IsHomotopyCategoryCell ],
  c -> ForwardConvolution( UnderlyingCell( c ) )
);

##
InstallMethod( BackwardConvolution,
          [ IsHomotopyCategoryCell ],
  c -> BackwardConvolution( UnderlyingCell( c ) )
);
