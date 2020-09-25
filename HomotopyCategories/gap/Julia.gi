#
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
##
InstallMethod( HomotopyCategoryObject,
        [ IsJuliaObject, IsInt ],
        
  function( diffs, N )
    
    return HomotopyCategoryObject( ConvertJuliaToGAP( diffs ), N );
    
end );

##
InstallMethod( CreateDiagramInHomotopyCategory,
          [ IsJuliaObject, IsJuliaObject, IsJuliaObject, IsJuliaObject ],
  function( objects, morphisms, relations, bounds )
    
    return CreateDiagramInHomotopyCategory( ConvertJuliaToGAP( objects ), ConvertJuliaToGAP( morphisms ), ConvertJuliaToGAP( relations ), ConvertJuliaToGAP( bounds ) );
    
end );

