#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
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
InstallMethod( HomotopyCategoryMorphism,
          [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsList, IsInt ],
  function( a, b, maps, N )
    local homotopy_category;
    
    homotopy_category := CapCategory( a );
    
    return ChainMorphism( UnderlyingCell( a ), UnderlyingCell( b ), maps, N ) / homotopy_category;
    
end );

##
InstallMethod( HomotopyCategoryMorphism,
          [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsZFunction ],
  function( a, b, maps )
    local homotopy_category;
    
    homotopy_category := CapCategory( a );
    
    return ChainMorphism( UnderlyingCell( a ), UnderlyingCell( b ), maps ) / homotopy_category;
    
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
    
    r := RandomTextColor( "" );
    
    Print( "A morphism in ", Name( CapCategory( map ) ), " given by the data: \n" );
    
    Print( "\n" );
    
    for i in [ l .. u ] do
      
      s := Concatenation( "-- ", r[ 1 ], String( i ), r[ 2 ], " -----------------------" );
      Print( s );
      Print( "\n" ); 
      DisplayCapCategoryCell( map[ i ] );
      Print( "\n" );
      
    od;

end );

InstallMethod( ViewObj,
            [ IsHomotopyCategoryMorphism ],
  function( map )
    
    Print( "<A morphism in ", Name( CapCategory( map ) ) );
    Print( " with active lower bound ", ActiveLowerBound( map ) );
    Print( " and active upper bound ", ActiveUpperBound( map ) );
    Print(">" );

end );

##
InstallMethod( ViewHomotopyCategoryMorphism,
               [ IsHomotopyCategoryMorphism ],
  function( map )
    local l, u, r, s, i;
    
    l := ActiveLowerBound( map );
    
    u := ActiveUpperBound( map );
    
    r := RandomTextColor( "" );
     
    Print( "A morphism in ", Name( CapCategory( map ) ), " given by the data: \n" );
    Print( "\n" );
    
    for i in [ l .. u ] do
      
      s := Concatenation( "-- ", r[ 1 ], String( i ), r[ 2 ], " -----------------------" );
      Print( s );
      Print( "\n" ); 
      ViewCapCategoryCell( map[ i ] );
      Print( "\n" );
      
    od;

end );

