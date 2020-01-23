

##
InstallMethod( MappingCone,
          [ IsHomotopyCategoryMorphism ],
  function( phi )
    local homotopy_category, u_phi, cone;
    
    homotopy_category := CapCategory( phi );
    
    u_phi := UnderlyingCell( phi );
    
    cone := MappingCone( u_phi );
    
    return HomotopyCategoryObject( homotopy_category, cone );
    
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

InstallMethodWithCache( MappingConeColift,
          [ IsChainMorphism, IsChainMorphism ],
  function( phi, psi )
    local chains, H, maps;
    
    chains := CapCategory( phi );
        
    H := HomotopyMorphisms( PreCompose( phi, psi ) );
    
    maps := MapLazy( IntegersList, n -> MorphismBetweenDirectSums( [ [ H[ n - 1 ] ], [ psi[ n ] ] ] ), 1 );
    
    return ChainMorphism( MappingCone( phi ), Range( psi ), maps );
    
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
    
    maps := MapLazy( IntegersList,  
            function( i )
              return MorphismBetweenDirectSums(
                [
                  [ alpha_0[ i - 1 ], s[ i - 1 ] ],
                  [ ZeroMorphism( Source( alpha_1 )[ i ], Range( alpha_0 )[ i - 1 ] ), alpha_1[ i ] ]
                ] );
                
            end, 1 );
            
    return ChainMorphism( cone_phi, cone_psi, maps );
    
end );

InstallMethodWithCache( MappingConeColift,
          [ IsCochainMorphism, IsCochainMorphism ],
  function( phi, psi )
    local cochains, H, maps;
    
    cochains := CapCategory( phi );
        
    H := HomotopyMorphisms( PreCompose( phi, psi ) );
    
    maps := MapLazy( IntegersList, n -> MorphismBetweenDirectSums( [ [ H[ n + 1 ] ], [ psi[ n ] ] ] ), 1 );
    
    return CochainMorphism( MappingCone( phi ), Range( psi ), maps );
    
end );

InstallMethod( MappingConePseudoFunctorial,
          [ IsCochainMorphism, IsCochainMorphism, IsCochainMorphism, IsCochainMorphism ],
  function( phi, psi, alpha_0, alpha_1 )
    local cone_phi, cone_psi, s, maps;
    
    cone_phi := MappingCone( phi );
    
    cone_psi := MappingCone( psi );
    
    s := HomotopyMorphisms( PreCompose( phi, alpha_1 ) - PreCompose( alpha_0, psi ) );
    
    maps := MapLazy( IntegersList,  
            function( i )
              return MorphismBetweenDirectSums(
                [
                  [ alpha_0[ i + 1 ], s[ i + 1 ] ],
                  [ ZeroMorphism( Source( alpha_1 )[ i ], Range( alpha_0 )[ i + 1 ] ), alpha_1[ i ] ]
                ] );
            end, 1 );
    
    #Error( ColiftInfos( NaturalInjectionInMappingCone( phi ), PreCompose( alpha_1, NaturalInjectionInMappingCone( psi ) ) ) );
    
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
InstallMethod( Convolution,
          [ IsChainComplex ],
  function( C )
    local chains_category, homotopy_category, l, u, d, tau;
    
    chains_category := CapCategory( C );
    
    homotopy_category := UnderlyingCategory( chains_category );
    
    l := ActiveLowerBound( C ) + 1;
    
    u := ActiveUpperBound( C ) - 1;
    
    if l = u then
      
      return ApplyFunctor( ShiftFunctor( homotopy_category, -l ), C[ u ] );
      
    elif l + 1 = u then
      
      return ApplyFunctor( ShiftFunctor( homotopy_category, -l ), MappingCone( C ^ u ) );
      
    else
      
      d := List( [ l + 1 .. u - 2 ], i -> C ^ i );
      
      tau := MappingConeColift( C ^ u, C ^ ( u - 1 ) );
      
      Add( d, tau );
      
      return Convolution( ChainComplex( d, l + 1 ) );
      
    fi;
   
end );

##
InstallMethod( Convolution,
          [ IsChainMorphism ],
  function( alpha )
    local chains_category, homotopy_category, C, D, l, u, m, tau_C, d_C, new_C, tau_D, d_D, new_D, L, new_alpha;
    
    chains_category := CapCategory( alpha );
    
    homotopy_category := UnderlyingCategory( chains_category );
    
    C := Source( alpha );
    
    D := Range( alpha );
    
    l := Minimum( ActiveLowerBound( C ) + 1, ActiveLowerBound( D ) + 1 );
    
    u := Maximum( ActiveUpperBound( C ) - 1, ActiveUpperBound( D ) - 1 );
    
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
       
      return Convolution( new_alpha );
      
    fi;
  
end );
