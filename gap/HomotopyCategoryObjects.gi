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
InstallMethod( Display,
            [ IsHomotopyCategoryObject ],
  function( a )
  
    Print( "An object in homotopy category defined by:\n\n" );

    Display( UnderlyingCell( a ) );

end );

InstallMethod( ViewObj,
            [ IsHomotopyCategoryObject ],
  function( a )
    local c;
    
    c := UnderlyingCell( a );
    
    Print( "<An object in ", Name( CapCategory( a ) ) );
    
    if HasActiveLowerBound( c ) then
      Print( " with active lower bound ", ActiveLowerBound( c ) );
    fi;
    
    if HasActiveUpperBound( c ) then
      Print( " and active upper bound ", ActiveUpperBound( c ) );
    fi;
    
    Print(">" );

end );
 
