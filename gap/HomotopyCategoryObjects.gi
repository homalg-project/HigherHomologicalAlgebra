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
            [ IsHomotopyCategory, IsCapCategoryObject ],
            
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
          [ IsList, IsInt ],
  function( diffs, N )
    local category, homotopy_category;
    
    category := CapCategory( diffs[ 1 ] );
    
    homotopy_category := HomotopyCategory( category );
    
    return ChainComplex( diffs, N ) / homotopy_category;
    
end );

##
InstallMethod( HomotopyCategoryObject,
          [ IsHomotopyCategory, IsZFunction ],
  function( homotopy_category, diffs )
    local C;
    
    C := DefiningCategory( homotopy_category );
    
    return ChainComplex( C, diffs ) / homotopy_category;
    
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
          [ IsCapCategoryObject, IsHomotopyCategory ],
  {a,H} -> HomotopyCategoryObject( H, a )
);

##
InstallMethod( BoxProduct,
          [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsHomotopyCategory ],
  { a, b, homotopy_category } -> HomotopyCategoryObject(
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
    
    r := RandomTextColor( "" );
    
    Print( "An object in ", Name( CapCategory( a ) ), " given by the data: \n\n" );
    
    for i in [ l .. u ] do
      if i <> l then
        Print( "  ", r[ 1 ], " Λ", r[ 2 ], "\n" );
        Print( "  ", r[ 1 ], " |", r[ 2 ], "\n" );
        DisplayCapCategoryCell( a ^ i );
        Print( "\n" );
        Print( "  ", r[ 1 ], " |", r[ 2 ], "\n\n" );
      fi;
      s := Concatenation( "-- ", r[ 1 ], String( i ), r[ 2 ], " -----------------------" );
      Print( s );
      Print( "\n" );
      DisplayCapCategoryCell( a[ i ] );
      Print( "\n" );
      Print( Concatenation(
        ListWithIdenticalEntries(
          Size( s ) - Size( r[ 1 ] ) - Size( r[ 2 ] ), "-" ) )
        );
      Print( "\n\n" );
      
    od;
    
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
   
    r := RandomTextColor( "" );
    
    Print( "An object in ", Name( CapCategory( a ) ), " given by the data: \n\n" );
    
    for i in [ l .. u ] do
      
      if i <> l then
        Print( "  ", r[ 1 ], " Λ", r[ 2 ], "\n" );
        Print( "  ", r[ 1 ], " |", r[ 2 ], "\n" );
        ViewCapCategoryCell( a ^ i );
        Print( "\n" );
        Print( "  ", r[ 1 ], " |", r[ 2 ], "\n\n" );
      fi;
      s := Concatenation( "-- ", r[ 1 ], String( i ), r[ 2 ], " -----------------------" );
      Print( s );
      Print( "\n" );
      ViewCapCategoryCell( a[ i ] );
      Print( "\n" );
      Print( Concatenation(
        ListWithIdenticalEntries(
          Size( s ) - Size( r[ 1 ] ) - Size( r[ 2 ] ) , "-" ) )
        );
      Print( "\n\n" );
      
    od;

end );
