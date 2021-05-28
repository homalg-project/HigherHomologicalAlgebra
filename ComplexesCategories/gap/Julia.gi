# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#

##
InstallOtherMethod( CochainComplex,
        [ IsJuliaObject, IsObject ],
        
  function( diffs, lower_bound )
    
    return CochainComplex( ConvertJuliaToGAP( diffs ), lower_bound );
    
end );

##
InstallOtherMethod( ChainComplex,
        [ IsJuliaObject, IsObject ],
        
  function( diffs, lower_bound )
    
    return ChainComplex( ConvertJuliaToGAP( diffs ), lower_bound );
    
end );
