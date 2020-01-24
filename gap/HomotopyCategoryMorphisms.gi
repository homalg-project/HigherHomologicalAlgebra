

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
    
    if not IsIdenticalObj( UnderlyingCategory( homotopy_category ), CapCategory( phi ) ) then
      
      Error( "The input is not compatible!\n" );
      
    fi;
    
    homotopy_phi := StableCategoryMorphism( homotopy_category, phi );
    
    SetFilterObj( homotopy_phi, IsHomotopyCategoryMorphism );
   
    SetUnderlyingCell( homotopy_phi, phi );
    
    return homotopy_phi;
  
end );

##
InstallMethod( \[\],
  [ IsHomotopyCategoryMorphism, IsInt ],
    { a, i } -> UnderlyingCell( a )[ i ] );

##
InstallMethod( \/,
          [ IsCapCategoryMorphism, IsHomotopyCategory ],
  {a,H} -> HomotopyCategoryMorphism( H, a )
);

InstallMethod( HomotopyMorphisms,
    [ IsHomotopyCategoryMorphism ],
  function( phi )
  
    return HomotopyMorphisms( UnderlyingCell( phi ) );
    
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

##
InstallMethod( IsQuasiIsomorphism,
          [ IsHomotopyCategoryMorphism ],
  alpha -> IsQuasiIsomorphism( UnderlyingCell( alpha ) )
);

# THIS IS DRAFT
BindGlobal( "AsPseudoHomologicalBicomplex",
     #[ IsChainComplex ],
  function( C )
    local chains, homotopy_category, cat, diffs, complex;
    
    chains := CapCategory( C );
    
    homotopy_category := UnderlyingCategory( chains );
    
    cat := UnderlyingCategory( homotopy_category );
    
    if IsHomotopyCategory( homotopy_category ) then
      
      diffs := Differentials( C );
      
      diffs := MapLazy( diffs, UnderlyingCell, 1 );
      
      complex := ChainComplex( cat, diffs );
      
      SetLowerBound( complex, ActiveLowerBound( C ) );
      
      SetUpperBound( complex, ActiveUpperBound( C ) );
      
      return ValueGlobal( "HomologicalBicomplex" )( complex );
      
    else
      
      Error( "The input should be a chain complex whose objects and morphisms live in a homotopy category" );
    
    fi;

end );

##
InstallMethod( Display,
            [ IsHomotopyCategoryMorphism ],
  function( a )
  
    Print( "A morphism in homotopy category defined by:\n\n" );

    Display( UnderlyingCell( a ) );

end );

InstallMethod( ViewObj,
            [ IsHomotopyCategoryMorphism ],
  function( a )
    local c;
    
    c := UnderlyingCell( a );
    
    Print( "<A morphism in ", Name( CapCategory( a ) ) );
    
    if HasActiveLowerBound( c ) then
      Print( " with active lower bound ", ActiveLowerBound( c ) );
    fi;
    
    if HasActiveUpperBound( c ) then
      Print( " and active upper bound ", ActiveUpperBound( c ) );
    fi;
    
    Print(">" );

end );
 
