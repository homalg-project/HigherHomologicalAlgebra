#############################################################################
##
##  ComplexesForCAP.gi             ComplexesForCAP package
##
##  Copyright 2018,                Kamal Saleh, Siegen University, Germany
##
#############################################################################

################################################
##
## Derived Methods for chain complexes categories
##
################################################

AddDerivationToCAP( IsNullHomotopic,
                [
                    [ Colift, 1 ],
                    [ IsZeroForMorphisms, 1 ]
                ],
    function( phi )
    return  IsZeroForMorphisms( phi ) or
            Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi ) <> fail;
    end: CategoryFilter := IsChainOrCochainComplexCategory, 
         Description := "compute if a morphism is homotopic to zero using colifts" );

AddDerivationToCAP( HomotopyMorphisms,
                [
                    [ IsNullHomotopic, 1 ],
                    [ Colift, 1 ]
                ],
    function( phi )
    local C, D, colift;
    if not IsNullHomotopic( phi ) then
        return fail;
    fi;
    C := Source( phi );
    D := Range( phi );
    colift := Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi );
    if colift = fail then 
      return fail;
    else
      return MapLazy( IntegersList, 
      		n -> PreCompose( 
		MorphismBetweenDirectSums( [ [ IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], C[ n + 1 ] ) ] ] ),
		colift[ n + 1 ] ), 1 );
    fi;
end: CategoryFilter := IsChainComplexCategory,
         Description := "compute the homotopy morphisms of a null-homotopic morphisms" );

AddDerivationToCAP( HomotopyMorphisms,
                [
                    [ IsNullHomotopic, 1 ],
                    [ Colift, 1 ]
                ],
    function( phi )
    local C, D, colift;
    if not IsNullHomotopic( phi ) then
        return fail;
    fi;
    C := Source( phi );
    D := Range( phi );
    colift := Colift( NaturalInjectionInMappingCone( IdentityMorphism( Source( phi ) ) ), phi );
    if colift = fail then 
      return fail;
    else
      return MapLazy( IntegersList, 
      		n -> PreCompose( 
		MorphismBetweenDirectSums( [ [ IdentityMorphism( C[ n ] ), ZeroMorphism( C[ n ], C[ n - 1 ] ) ] ] ),
		colift[ n - 1 ] ), 1 );
    fi;
end: CategoryFilter := IsCochainComplexCategory,
         Description := "compute the homotopy morphisms of a null-homotopic morphisms" );
