
##
AddFinalDerivation( MorphismIntoColiftingObject,
                    [ ],
                    [ MorphismIntoColiftingObject ],
  function( a )
    
    return NaturalInjectionInMappingCone( IdentityMorphism( a ) );
  
end: CategoryFilter := IsChainOrCochainComplexCategory,
      Description:= "MorphismIntoColiftingObject by NaturalInjectionInMappingCone"
      );

##
AddFinalDerivation( IsColiftableThroughColiftingObject,
                    [ 
                      [ IsColiftable, 1 ]
                    ],
                    
                    [ 
                      IsColiftableThroughColiftingObject,
                      MorphismIntoColiftingObject  
                    ],
  function( alpha )
    local a, I_a;
    
    a := Source( alpha );

    I_a := NaturalInjectionInMappingCone( IdentityMorphism( a ) );

    return IsColiftable( I_a, alpha );
  
end: CategoryFilter := IsChainOrCochainComplexCategory,
      Description:= "IsColiftableThroughColiftingObject by IsColiftable"
      );

