

DeclareRepresentation( "IsHomotopyCategoryMorphismRep",
                       IsCapCategoryMorphismRep and IsHomotopyCategoryMorphism,
                       [ ] );

BindGlobal( "TheTypeOfHomotopyCategoryMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                 IsHomotopyCategoryMorphismRep ) );


##
InstallMethod( HomotopyCategoryMorphism,
            [ IsHomotopyCategory, IsCapCategoryMorphism ],
            
  function( homotopy_category, phi )
    local homotopy_phi;
    
    if not IsIdenticalObj( UnderlyingCapCategory( homotopy_category ), CapCategory( phi ) ) then
      
      Error( "The input is not compatible!\n" );
      
    fi;
    
    homotopy_phi := StableCategoryMorphism( homotopy_category, phi );
    
    SetFilterObj( homotopy_phi, IsHomotopyCategoryMorphism );
   
    SetUnderlyingChainMorphism( homotopy_phi, phi );
    
    return homotopy_phi;
  
end );

##
InstallMethod( UnderlyingChainMorphism, [ IsHomotopyCategoryMorphism ], UnderlyingCapCategoryMorphism );

##
InstallMethod( UnderlyingChainCell, [ IsHomotopyCategoryMorphism ], UnderlyingCapCategoryMorphism );

##
InstallMethod( MappingCone,
    [ IsHomotopyCategoryMorphism ],
  function( phi )
    local homotopy_category, u_phi, cone;
  
    homotopy_category := CapCategory( phi );
  
    u_phi := UnderlyingChainMorphism( phi );
  
    cone := MappingCone( u_phi );
  
    return HomotopyCategoryObject( homotopy_category, cone );
  
end );

##
InstallMethod( NaturalInjectionInMappingCone,
    [ IsHomotopyCategoryMorphism ],
  function( phi )
    local homotopy_category, u_phi, i;
  
    homotopy_category := CapCategory( phi );
  
    u_phi := UnderlyingChainMorphism( phi );
  
    i := NaturalInjectionInMappingCone( u_phi );
  
    return HomotopyCategoryMorphism( homotopy_category, i );
  
end );

##
InstallMethod( NaturalProjectionFromMappingCone,
    [ IsHomotopyCategoryMorphism ],
  function( phi )
    local homotopy_category, u_phi, p;
  
    homotopy_category := CapCategory( phi );
  
    u_phi := UnderlyingChainMorphism( phi );
  
    p := NaturalProjectionFromMappingCone( u_phi );
  
    return HomotopyCategoryMorphism( homotopy_category, p );
  
end );

InstallMethod( HomotopyMorphisms,
    [ IsHomotopyCategoryMorphism ],
  function( phi )
  
    return HomotopyMorphisms( UnderlyingChainMorphism( phi ) );
    
end );

InstallMethod( HomotopyMorphisms,
    [ IsChainComplex ],
  function( C )
    local chains, cat;
    
    chains := CapCategory( C );
    
    cat := UnderlyingCategory( chains );
    
    if IsHomotopyCategory( cat ) then
      
      return MapLazy( IntegersList, i -> HomotopyMorphisms( PreCompose( C^i, C^( i - 1 ) ) ), 1 );
      
    else
      
      Error( "The input should be a chain complex whose objects and morphisms live in a homotopy category" );
    
    fi;
    
end );



InstallMethod( MappingConeColift,
    [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ],
  function( phi, tau )
    local homotopy_category, l, with_infos;
    
    homotopy_category := CapCategory( phi );
    
    l := MappingConeColift( UnderlyingChainMorphism( phi ), UnderlyingChainMorphism( tau ) );
    
    with_infos := ValueOption( "WithInfos" );
    
    if with_infos = true then
      
      ColiftUniquenessInfos( NaturalInjectionInMappingCone( phi ), tau );
      
    fi;
    
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
    local homotopy_category, m;
    
    homotopy_category := CapCategory( phi );
    
    m := MappingConePseudoFunctorial(
          UnderlyingChainMorphism( phi ),
          UnderlyingChainMorphism( psi ),
          UnderlyingChainMorphism( alpha_0 ),
          UnderlyingChainMorphism( alpha_1 )
    );
    
    return HomotopyCategoryMorphism( homotopy_category, m );
    
end );

##
InstallMethod( Display,
            [ IsHomotopyCategoryMorphism ],
  function( a )
  
    Print( "A morphism in homotopy category defined by:\n\n" );

    Display( UnderlyingChainMorphism( a ) );

end );

InstallMethod( ViewObj,
            [ IsHomotopyCategoryMorphism ],
  function( a )
    
    Print( "<A morphism in homotopy category defined by: " );

    ViewObj( UnderlyingChainMorphism( a ) );
    
    Print(">" );

end );
 
