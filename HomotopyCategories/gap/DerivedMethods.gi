# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
##
AddFinalDerivation( MorphismToColiftingObject,
                    [ ],
                    [ MorphismToColiftingObject ],
  function( cat, a )
    
    return NaturalInjectionInMappingCone( IdentityMorphism( a ) );
  
end: CategoryFilter := IsChainOrCochainComplexCategory,
      Description:= "MorphismToColiftingObject by NaturalInjectionInMappingCone"
      );

##
AddFinalDerivation( IsColiftableAlongMorphismToColiftingObject,
                    [ 
                      [ IsColiftable, 1 ]
                    ],
                    
                    [ 
                      IsColiftableAlongMorphismToColiftingObject,
                      MorphismToColiftingObject  
                    ],
  function( cat, alpha )
    local a, I_a;
     
    a := Source( alpha );

    I_a := NaturalInjectionInMappingCone( IdentityMorphism( a ) );

    return IsColiftable( I_a, alpha );
  
end: CategoryFilter := IsChainOrCochainComplexCategory,
      Description:= "IsColiftableAlongMorphismToColiftingObject by IsColiftable"
      );

##
AddFinalDerivation( IsColiftableAlongMorphismToColiftingObject,
                    [ 
                      [ Colift, 1 ]
                    ],
                    
                    [ 
                      IsColiftableAlongMorphismToColiftingObject,
                      MorphismToColiftingObject  
                    ],
  function( cat, alpha )
    local a, I_a;
    
    a := Source( alpha );

    I_a := NaturalInjectionInMappingCone( IdentityMorphism( a ) );

    return Colift( I_a, alpha ) <> fail;
  
end: CategoryFilter := IsChainOrCochainComplexCategory,
      Description:= "IsColiftableAlongMorphismToColiftingObject by Colift"
      );

##
AddFinalDerivation( IsColiftableAlongMorphismToColiftingObject,
                    [ 
                      [ IsNullHomotopic, 1 ]
                    ],
                    
                    [ 
                      IsColiftableAlongMorphismToColiftingObject,
                      MorphismToColiftingObject  
                    ],
  { cat, alpha } -> IsNullHomotopic( alpha ) : CategoryFilter := IsChainOrCochainComplexCategory,
      Description:= "IsColiftableAlongMorphismToColiftingObject by IsNullHomotopic"
      );

