# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#

##
InstallMethod( CreateStrongExceptionalCollection,
        [ IsObject, IsJuliaObject ],
        
  function( full, vertices_labels )
    
    return CreateStrongExceptionalCollection( full, ConvertJuliaToGAP( vertices_labels ) );
    
end );

##
InstallMethod( CreateStrongExceptionalCollection,
        [ IsJuliaObject, IsJuliaObject ],
        
  function( full, vertices_labels )
    
    return CreateStrongExceptionalCollection( ConvertJuliaToGAP( full ), ConvertJuliaToGAP( vertices_labels ) );
    
end );
