

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
 
