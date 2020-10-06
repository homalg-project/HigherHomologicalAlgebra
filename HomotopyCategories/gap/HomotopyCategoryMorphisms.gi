#
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################


DeclareRepresentation( "IsHomotopyCategoryMorphismRep",
                       IsCapCategoryMorphismRep and IsHomotopyCategoryMorphism,
                       [ ] );

BindGlobal( "TheTypeOfHomotopyCategoryMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                 IsHomotopyCategoryMorphismRep ) );

##
InstallMethod( HomotopyCategoryMorphism,
            [ IsHomotopyCategory, IsChainOrCochainMorphism ],
            
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
InstallMethod( HomotopyCategoryMorphism,
          [ IsHomotopyCategoryObject, IsList, IsInt, IsHomotopyCategoryObject ],
  { a, maps, N, b } -> HomotopyCategoryMorphism( a, b, maps, N )
);

##
InstallMethod( HomotopyCategoryMorphism,
          [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsList, IsInt ],

  function( a, b, maps, N )
    local homotopy_category, alpha;
    
    homotopy_category := CapCategory( a );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      alpha := ChainMorphism( UnderlyingCell( a ), UnderlyingCell( b ), maps, N );
       
    else
      
      alpha := CochainMorphism( UnderlyingCell( a ), UnderlyingCell( b ), maps, N );
       
    fi;
    
    return HomotopyCategoryMorphism( homotopy_category, alpha  );
    
end );

##
InstallMethod( HomotopyCategoryMorphism,
          [ IsHomotopyCategoryObject, IsZFunction, IsHomotopyCategoryObject ],
  { a, maps, b } -> HomotopyCategoryMorphism( a, b, maps )
);

##
InstallMethod( HomotopyCategoryMorphism,
          [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsZFunction ],
  function( a, b, maps )
    local homotopy_category, alpha;
    
    homotopy_category := CapCategory( a );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      alpha := ChainMorphism( UnderlyingCell( a ), UnderlyingCell( b ), maps );
      
    else
      
      alpha := CochainMorphism( UnderlyingCell( a ), UnderlyingCell( b ), maps );
        
    fi;
    
    return HomotopyCategoryMorphism( homotopy_category, alpha  );
    
end );

##
InstallMethod( \[\],
  [ IsHomotopyCategoryMorphism, IsInt ],
    { a, i } -> UnderlyingCell( a )[ i ] );

##
InstallMethod( \/,
          [ IsChainOrCochainMorphism, IsHomotopyCategory ],
  { a, H } -> HomotopyCategoryMorphism( H, a )
);

##
InstallOtherMethod( \/,
          [ IsCapCategoryMorphism, IsHomotopyCategory ],
  function( a, H )
    
    if IsIdenticalObj( CapCategory( a ), DefiningCategory( H ) ) then
      return a/UnderlyingCategory( H )/H;
    fi;
    
    TryNextMethod( );
    
end );


##
InstallMethod( AsChainMorphism,
              [ IsHomotopyCategoryMorphism ],
  function( alpha )
    local homotopy_cat, output;
    
    homotopy_cat := CapCategory( alpha );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_cat ) ) then
      
      return alpha;
      
    else
      
      output := AsChainMorphism( UnderlyingCell( alpha ) ) / HomotopyCategory( DefiningCategory( homotopy_cat ), false );
      
      SetAsCochainMorphism( output, alpha );
      
      return output;
      
    fi;
    
end );

##
InstallMethod( AsCochainMorphism,
              [ IsHomotopyCategoryMorphism ],
  function( alpha )
    local homotopy_cat, output;
    
    homotopy_cat := CapCategory( alpha );
    
    if IsCochainComplexCategory( UnderlyingCategory( homotopy_cat ) ) then
      
      return alpha;
      
    else
      
      output := AsCochainMorphism( UnderlyingCell( alpha ) ) / HomotopyCategory( DefiningCategory( homotopy_cat ), true );
      
      SetAsChainMorphism( output, alpha );
      
      return output;
      
    fi;
    
end );


InstallMethod( HomotopyMorphisms,
    [ IsHomotopyCategoryMorphism ],
  function( phi )
  
    return HomotopyMorphisms( UnderlyingCell( phi ) );
    
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
      
      diffs := ApplyMap( diffs, UnderlyingCell );
      
      complex := ChainComplex( cat, diffs );
      
      SetLowerBound( complex, ActiveLowerBound( C ) );
      
      SetUpperBound( complex, ActiveUpperBound( C ) );
      
      return ValueGlobal( "HomologicalBicomplex" )( complex );
      
    else
      
      Error( "The input should be a chain complex whose objects and morphisms live in a homotopy category" );
    
    fi;

end );

##
InstallMethod( BoxProduct,
          [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism, IsHomotopyCategory ],
  { a, b, homotopy_category } -> HomotopyCategoryMorphism(
                                        homotopy_category,
                                        BoxProduct( UnderlyingCell( a ), UnderlyingCell( b ), UnderlyingCategory( homotopy_category ) )
                                      )
);

##
InstallMethod( Display,
            [ IsHomotopyCategoryMorphism ],
  function( map )
    local l, u, r, s, i;
    
    l := ActiveLowerBound( map );
    
    u := ActiveUpperBound( map );
    
    DISPLAY_DATA_OF_CHAIN_OR_COCHAIN_COMPLEX_MORPHISM( UnderlyingCell( map ), l, u );
    
    Print( "\nA morphism in ", Name( CapCategory( map ) ), " given by the above data\n" );
    
end );

InstallMethod( ViewObj,
            [ IsHomotopyCategoryMorphism ],
  function( map )
    local m, l, u, w, a, string;
    
    m := Concatenation( "A morphism in ", Name( CapCategory( map ) ) );
    
    if HasActiveLowerBound( map ) then
      
      l := Concatenation( "active lower bound ", String( ActiveLowerBound( map ) ) );
      
    else
      
      l := "";
      
    fi;
    
    if HasActiveUpperBound( map ) then
      
      u := Concatenation( "active upper bound ", String( ActiveUpperBound( map ) ) );
      
    else
      
      u := "";
      
    fi;
    
    if l <> "" or u <> "" then
      
      w := " with ";
      
    else
      
      w := "";
      
    fi;
   
    if l <> "" and u <> "" then
      
      a := " and ";
      
    else
      
      a := "";
      
    fi;
    
    string := Concatenation( "<", m, w, l, a, u, ">" );
    
    Print( string );

end );

##
InstallMethod( ViewHomotopyCategoryMorphism,
               [ IsHomotopyCategoryMorphism ],
  function( map )
    local l, u, r, s, i;
    
    l := ActiveLowerBound( map );
    
    u := ActiveUpperBound( map );
    
    VIEW_DATA_OF_CHAIN_OR_COCHAIN_COMPLEX_MORPHISM( UnderlyingCell( map ), l, u );
    
    Print( "\nA morphism in ", Name( CapCategory( map ) ), " given by the above data\n" );

end );

##
InstallMethod( LaTeXStringOp,
          [ IsHomotopyCategoryCell ],
  c -> LaTeXStringOp( UnderlyingCell( c ) )
);

##
InstallOtherMethod( LaTeXStringOp,
          [ IsHomotopyCategoryCell, IsInt, IsInt ],
  { c, l, u } -> LaTeXStringOp( UnderlyingCell( c, l, u ) )
);

##
## MakeShowable( [ "text/latex", "application/x-latex" ], IsHomotopyCategoryCell );

