#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################


##
InstallMethod( MappingCone,
          [ IsHomotopyCategoryMorphism ],
  function( phi )
    local homotopy_category, u_phi;
    
    homotopy_category := CapCategory( phi );
    
    u_phi := UnderlyingCell( phi );
    
    return MappingCone( u_phi ) / homotopy_category;
    
end );

##
InstallMethod( NaturalInjectionInMappingCone,
          [ IsHomotopyCategoryMorphism ],
  function( phi )
    local homotopy_category, u_phi, i;
    
    homotopy_category := CapCategory( phi );
    
    u_phi := UnderlyingCell( phi );
    
    i := NaturalInjectionInMappingCone( u_phi );
    
    return HomotopyCategoryMorphism( homotopy_category, i );
    
end );

##
InstallMethod( NaturalProjectionFromMappingCone,
          [ IsHomotopyCategoryMorphism ],
  function( phi )
    local homotopy_category, u_phi, p;
    
    homotopy_category := CapCategory( phi );
    
    u_phi := UnderlyingCell( phi );
    
    p := NaturalProjectionFromMappingCone( u_phi );
    
    return HomotopyCategoryMorphism( homotopy_category, p );
    
end );

InstallMethod( MappingConeColift,
          [ IsChainMorphism, IsChainMorphism ],
  function( phi, psi )
    local chains, H, maps;
    
    chains := CapCategory( phi );
        
    H := HomotopyMorphisms( PreCompose( phi, psi ) );
    
    maps := AsZFunction( n -> MorphismBetweenDirectSums( [ [ H[ n - 1 ] ], [ psi[ n ] ] ] ) );
    
    maps := ChainMorphism( MappingCone( phi ), Range( psi ), maps );
    
    return maps;
    
end );

#    A ----- phi ----> B ----------> Cone( phi )
#    |                 |
#    | alpha_0         | alpha_1
#    |                 |
#    v                 v
#    A' --- psi -----> B' ---------> Cone( psi )
#
InstallMethod( MappingConePseudoFunctorial,
          [ IsChainMorphism, IsChainMorphism, IsChainMorphism, IsChainMorphism ],
  function( phi, psi, alpha_0, alpha_1 )
    local cone_phi, cone_psi, s, maps;
    
    cone_phi := MappingCone( phi );
    
    cone_psi := MappingCone( psi );
    
    s := HomotopyMorphisms( PreCompose( phi, alpha_1 ) - PreCompose( alpha_0, psi ) );
    
    maps := AsZFunction(
            function( i )
              return MorphismBetweenDirectSums(
                [
                  [ alpha_0[ i - 1 ], s[ i - 1 ] ],
                  [ ZeroMorphism( Source( alpha_1 )[ i ], Range( alpha_0 )[ i - 1 ] ), alpha_1[ i ] ]
                ] );
                
            end );
            
    return ChainMorphism( cone_phi, cone_psi, maps );
    
end );

InstallMethod( MappingConeColift,
          [ IsCochainMorphism, IsCochainMorphism ],
  function( phi, psi )
    local cochains, H, maps;
    
    cochains := CapCategory( phi );
    
    H := HomotopyMorphisms( PreCompose( phi, psi ) );
    
    maps := AsZFunction( n -> MorphismBetweenDirectSums( [ [ H[ n + 1 ] ], [ psi[ n ] ] ] ) );
    
    return CochainMorphism( MappingCone( phi ), Range( psi ), maps );
    
end );

InstallMethod( MappingConePseudoFunctorial,
          [ IsCochainMorphism, IsCochainMorphism, IsCochainMorphism, IsCochainMorphism ],
  function( phi, psi, alpha_0, alpha_1 )
    local cone_phi, cone_psi, s, maps;
    
    cone_phi := MappingCone( phi );
    
    cone_psi := MappingCone( psi );
    
    s := HomotopyMorphisms( PreCompose( phi, alpha_1 ) - PreCompose( alpha_0, psi ) );
    
    maps := AsZFunction(
            function( i )
              return MorphismBetweenDirectSums(
                [
                  [ alpha_0[ i + 1 ], s[ i + 1 ] ],
                  [ ZeroMorphism( Source( alpha_1 )[ i ], Range( alpha_0 )[ i + 1 ] ), alpha_1[ i ] ]
                ] );
            end );
            
    return ChainMorphism( cone_phi, cone_psi, maps );
    
end );

##
InstallMethod( MappingConeColift,
          [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ],
  function( phi, tau )
    local homotopy_category, l, with_infos;
    
    homotopy_category := CapCategory( phi );
    
    l := MappingConeColift( UnderlyingCell( phi ), UnderlyingCell( tau ) );
    
    return HomotopyCategoryMorphism( homotopy_category, l );
    
end );


#    A ----- phi ----> B ----------> Cone( phi )
#    |                 |
#    | alpha_0         | alpha_1
#    |                 |
#    v                 v
#    A' --- psi -----> B' ---------> Cone( psi )
#
InstallMethod( MappingConePseudoFunctorial,
          [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism,
              IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ],
              
  function( phi, psi, alpha_0, alpha_1 )
    local homotopy_category, m, with_infos;
    
    homotopy_category := CapCategory( phi );
    
    m := MappingConePseudoFunctorial(
          UnderlyingCell( phi ),
          UnderlyingCell( psi ),
          UnderlyingCell( alpha_0 ),
          UnderlyingCell( alpha_1 )
    );
    
   return HomotopyCategoryMorphism( homotopy_category, m );
   
end );

#TODO Shift or UnsignedShift and why?
##
InstallMethod( ForwardConvolution,
          [ IsChainComplex ],
  function( C )
    local l, u, diffs, alpha, beta, H, maps, d_um1;
     
    l := ActiveLowerBound( C );
    
    u := ActiveUpperBound( C );
     
    if u - l in [ 0, 1 ] then
      
      return Shift( MappingCone( C ^ ( l + 1 ) ), l );
      
    else
      
      diffs := List( [ l + 1 .. u - 2 ], i -> C ^ i );
      
      alpha := C ^ u;
      
      beta := C ^ ( u - 1 );
      
      H := HomotopyMorphisms( PreCompose( alpha, beta ) );
    
      maps := AsZFunction( n -> MorphismBetweenDirectSums( [ [ H[ n - 1 ] ], [ beta[ n ] ] ] ) );
    
      d_um1 := HomotopyCategoryMorphism( MappingCone( alpha ), Range( beta ), maps );
      
      Add( diffs, d_um1 );
      
      return ForwardConvolution( ChainComplex( diffs, l + 1 ) );
      
    fi;
   
end );

##
InstallMethod( ForwardConvolution,
          [ IsHomotopyCategoryObject ],
  C -> ForwardConvolution( UnderlyingCell( C ) )
);

##
InstallMethod( ForwardConvolution,
          [ IsChainMorphism ],
  function( alpha )
    local chains_category, homotopy_category, C, D, l, u, m, tau_C, d_C, new_C, tau_D, d_D, new_D, L, new_alpha;
    
    chains_category := CapCategory( alpha );
    
    homotopy_category := UnderlyingCategory( chains_category );
    
    C := Source( alpha );
    
    D := Range( alpha );
    
    l := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
    
    u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
    
    if l = u then
      
      return ApplyFunctor( ShiftFunctor( homotopy_category, -l ), alpha[ u ] );
      
    elif l + 1 = u then
      
      m := MappingConePseudoFunctorial( C ^ u, D ^ u, alpha[ u ], alpha[ u - 1 ] );
      
      return ApplyFunctor( ShiftFunctor( homotopy_category, -l ), m );
      
    else
      
      tau_C := MappingConeColift( C ^ u, C ^ ( u - 1 ) );
      
      d_C := List( [ l + 1 .. u - 2 ], i -> C ^ i );
      
      Add( d_C, tau_C );
      
      new_C := ChainComplex( d_C, l + 1 );
      
      tau_D := MappingConeColift( D ^ u, D ^ ( u - 1 ) );
      
      d_D := List( [ l + 1 .. u - 2 ], i -> D ^ i );
      
      Add( d_D, tau_D );
      
      new_D := ChainComplex( d_D, l + 1 );
      
      L := List( [ l .. u - 2 ], i -> alpha[ i ] );
      
      m := MappingConePseudoFunctorial( C ^ u, D ^ u, alpha[ u ], alpha[ u - 1 ] );
      
      Add( L, m );
      
      new_alpha := ChainMorphism( new_C, new_D, L, l );
      
      return ForwardConvolution( new_alpha );
      
    fi;
  
end );

##
InstallMethod( ForwardConvolution,
          [ IsHomotopyCategoryMorphism ],
  alpha -> ForwardConvolution( UnderlyingCell( alpha ) )
);

##
InstallMethod( BackwardConvolutionOp,
          [ IsChainComplex, IsInt ],
  function( C, m )
    local l, u, alpha, beta, H, maps, d_mp2, diffs;
    
    l := ActiveLowerBound( C );
    
    u := ActiveUpperBound( C );
        
    if m < l then
      
      return C;
      
    elif m > l then
      
      return BackwardConvolution( BackwardConvolution( C, m - 1 ), m );
      
    elif u - l in [ 0, 1 ] then
      
      return StalkChainComplex( InverseShiftOnObject( StandardConeObject( C ^ ( m + 1 ) ) ), m + 1 );
      
    else
      
      alpha := C ^ ( m + 2 );
      
      beta := C ^ ( m + 1 );
      
      H := HomotopyMorphisms( PreCompose( alpha, beta ) );
      
      maps := AsZFunction( i -> MorphismBetweenDirectSums( [ [ alpha[ i ], -H[ i ] ] ] ) );
      
      d_mp2 := HomotopyCategoryMorphism(
                  Source( alpha ),
                  InverseShiftOnObject( StandardConeObject( C ^ ( m + 1 ) ) ),
                  maps
                );
      
      diffs := List( [ l + 3 .. u ], i -> C ^ i );
      
      Add( diffs, d_mp2, 1 );
      
      return ChainComplex( diffs, m + 2 );
      
    fi;
    
end );

##
InstallMethod( BackwardConvolution,
          [ IsChainComplex ],
  function( C )
    local u;
    
    u := ActiveUpperBound( C );
    
    C := BackwardConvolution( C, u - 1 );
    
    return Shift( C[ u ], u );
    
end );

##
InstallMethod( BackwardConvolutionOp,
          [ IsChainMorphism, IsInt ],
  function( alpha, m )
    local C, D, l, u, map, maps, s, r;
     
    C := Source( alpha );
    
    D := Range( alpha );
    
    l := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
    
    u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
    
    if m < l then
      
      return alpha;
      
    elif m > l then
      
      return BackwardConvolution( BackwardConvolution( alpha, m - 1 ), m );
      
    else
      
      map := MorphismBetweenStandardConeObjects(
                C ^ ( m + 1 ),
                alpha[ m + 1 ],
                alpha[ m ],
                D ^ ( m + 1 )
              );
      
      map := InverseShiftOnMorphism( map );
      
      if u - l in [ 0, 1 ] then
        
        return StalkChainMorphism( map, m + 1 );
    
      else
        
        maps := List( [ m + 2 .. u ], i -> alpha[ i ] );
        
        Add( maps, map, 1 );
        
        s := BackwardConvolution( Source( alpha ), m );
        
        r := BackwardConvolution( Range( alpha ), m );
        
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
    
    alpha := BackwardConvolution( alpha, u - 1 );
    
    return Shift( alpha[ u ], u );
    
end );

