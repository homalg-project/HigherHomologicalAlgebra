#
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#

##
InstallMethod( CreateExceptionalCollection,
        [ IsObject, IsJuliaObject ],
        
  function( full, vertices_labels )
    
    return CreateExceptionalCollection( full, ConvertJuliaToGAP( vertices_labels ) );
    
end );

##
InstallMethod( CreateExceptionalCollection,
        [ IsJuliaObject, IsJuliaObject ],
        
  function( full, vertices_labels )
    
    return CreateExceptionalCollection( ConvertJuliaToGAP( full ), ConvertJuliaToGAP( vertices_labels ) );
    
end );
