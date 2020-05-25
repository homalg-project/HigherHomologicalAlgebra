#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################


##
DeclareRepresentation( "IsHomotopyCategoryObjectRep",
                       IsCapCategoryObjectRep and IsHomotopyCategoryObject,
                       [ ] );

##
BindGlobal( "TheTypeOfHomotopyCategoryObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsHomotopyCategoryObjectRep ) );

##
InstallMethod( HomotopyCategoryObject,
            [ IsHomotopyCategory, IsChainOrCochainComplex ],
            
  function( homotopy_category, a )
    local homotopy_a;
    
    if not IsIdenticalObj( UnderlyingCategory( homotopy_category ), CapCategory( a ) ) then
      
      Error( "The input is not compatible!\n" );
      
    fi;
    
    homotopy_a := StableCategoryObject( homotopy_category, a );
    
    SetFilterObj( homotopy_a, IsHomotopyCategoryObject );
     
    return homotopy_a;
    
end );

##
InstallMethod( HomotopyCategoryObject,
          [ IsHomotopyCategory, IsList, IsInt ],
  function( homotopy_category, diffs, N )
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      return HomotopyCategoryObject( homotopy_category, ChainComplex( diffs, N ) );
      
    else
      
      return HomotopyCategoryObject( homotopy_category, CochainComplex( diffs, N ) );
      
    fi;
    
end );

##
InstallMethod( HomotopyCategoryObject,
          [ IsHomotopyCategory, IsZFunction ],
  function( homotopy_category, diffs )
    local C;
    
    C := DefiningCategory( homotopy_category );
    
    if IsChainComplexCategory( UnderlyingCategory( homotopy_category ) ) then
      
      return ChainComplex( C, diffs ) / homotopy_category;
      
    else
      
      return CochainComplex( C, diffs ) / homotopy_category;
      
    fi;
    
end );

##
InstallOtherMethod( HomotopyCategoryObject,
          [ IsList, IsInt ],
          
  function( diffs, N )
    
    return HomotopyCategoryObject( HomotopyCategory( CapCategory( diffs[1] ) ), diffs, N );
    
end );


##
InstallMethod( \[\],
  [ IsHomotopyCategoryObject, IsInt ],
    { a, i } -> UnderlyingCell( a )[ i ] );

##
InstallMethod( \^,
  [ IsHomotopyCategoryObject, IsInt ],
    { a, i } -> UnderlyingCell( a ) ^ i );

##
InstallMethod( \/,
          [ IsChainOrCochainComplex, IsHomotopyCategory ],
  { a, H } -> HomotopyCategoryObject( H, a )
);

##
InstallMethod( BoxProduct,
          [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsHomotopyCategory ],
  { a, b, homotopy_category } ->
      HomotopyCategoryObject(
          homotopy_category,
          BoxProduct( UnderlyingCell( a ), UnderlyingCell( b ), UnderlyingCategory( homotopy_category ) )
        )
);

##
InstallMethod( Display,
          [ IsHomotopyCategoryObject ],
  function( a )
    local l, u, r, s, i;
    
    l := ActiveLowerBound( a );
    
    u := ActiveUpperBound( a );
    
    DISPLAY_DATA_OF_CHAIN_OR_COCHAIN_COMPLEX( UnderlyingCell( a ), l, u );
     
    Print( "\nAn object in ", Name( CapCategory( a ) ), " given by the above data\n" );
    
    
end );

##
InstallMethod( ViewObj,
          [ IsHomotopyCategoryObject ],
  function( a )
    
    Print( "<An object in ", Name( CapCategory( a ) ) );
    
    if HasActiveLowerBound( a ) then
      Print( " with active lower bound ", ActiveLowerBound( a ) );
    fi;
    
    if HasActiveUpperBound( a ) then
      Print( " and active upper bound ", ActiveUpperBound( a ) );
    fi;
    
    Print(">" );

end );

##
InstallMethod( ViewHomotopyCategoryObject, 
          [ IsHomotopyCategoryObject ],
  function( a )
    local l, u, r, s, i;
    
    l := ActiveLowerBound( a );
    
    u := ActiveUpperBound( a );
    
    VIEW_DATA_OF_CHAIN_OR_COCHAIN_COMPLEX( UnderlyingCell( a ), l, u );
    
    Print( "\nAn object in ", Name( CapCategory( a ) ), " given by the above data\n" );
    
end );
