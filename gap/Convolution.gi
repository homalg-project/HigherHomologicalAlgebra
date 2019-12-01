

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
InstallMethodWithCrispCache( MappingConePseudoFunctorial,
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
    
    with_infos := ValueOption( "WithInfos" );
    
    if with_infos = true then
      
      LiftColiftUniquenessInfos( 
                          NaturalInjectionInMappingCone( phi ),      
                          PreCompose( alpha_1, NaturalInjectionInMappingCone( psi ) ),
                          PreCompose( NaturalProjectionFromMappingCone( phi ), ShiftOfMorphism( alpha_0 ) ),
                          NaturalProjectionFromMappingCone( psi ) );
      
    fi;
    
    return HomotopyCategoryMorphism( homotopy_category, m );
    
end );

##
InstallMethod( Convolution,
  [ IsChainComplex ],
  function( C )
    local chains_category, homotopy_category, l, u, tau, L;
    
    chains_category := CapCategory( C );
    
    homotopy_category := UnderlyingCategory( chains_category );
    
    l := ActiveLowerBound( C ) + 1;
    
    u := ActiveUpperBound( C ) - 1;
    
    if l = u then
      
      return ApplyFunctor( UnsignedShiftFunctor( homotopy_category, -l ), C[ u ] );
      
    elif l + 1 = u then

      return ApplyFunctor( UnsignedShiftFunctor( homotopy_category, -l ), MappingCone( C ^ u ) );

    else
      
      tau := MappingConeColift( C ^ u, C ^ ( u - 1 ) );
      
      L := List( [ l + 1 .. u - 2 ], i -> C^i );
      
      Add( L, tau );
      
      return Convolution( ChainComplex( L, l + 1 ) );
      
    fi;

  
end );


