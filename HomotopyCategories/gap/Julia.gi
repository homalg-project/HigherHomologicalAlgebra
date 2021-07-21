# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
##

InstallMethod( HomotopyCategoryObject,
        [ IsHomotopyCategory, IsJuliaObject, IsInt ],
        
  function( homotopy_cat, diffs, N )
    
    return HomotopyCategoryObject( homotopy_cat, ConvertJuliaToGAP( diffs ), N );
    
end );

##
InstallMethod( HomotopyCategoryMorphism,
        [ IsHomotopyCategoryObject, IsJuliaObject, IsInt, IsHomotopyCategoryObject ],
        
  function( a, maps, N, b )
    
    return HomotopyCategoryMorphism( a, ConvertJuliaToGAP( maps ), N, b );
    
end );

##
InstallMethod( HomotopyCategoryMorphism,
        [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsJuliaObject, IsInt ],
        
  function( a, b, maps, N )
    
    return HomotopyCategoryMorphism( a, b, ConvertJuliaToGAP( maps ), N );
    
end );

##
InstallMethod( CreateDiagramInHomotopyCategory,
          [ IsJuliaObject, IsJuliaObject, IsJuliaObject, IsJuliaObject ],
  function( objects, morphisms, relations, bounds )
    
    return CreateDiagramInHomotopyCategory( ConvertJuliaToGAP( objects ), ConvertJuliaToGAP( morphisms ), ConvertJuliaToGAP( relations ), ConvertJuliaToGAP( bounds ) );
    
end );

