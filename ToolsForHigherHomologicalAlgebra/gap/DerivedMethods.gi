# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#



##
AddDerivationToCAP( Lift,
            [ [ IdentityMorphism, 1 ],
              [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
              [ HomomorphismStructureOnMorphisms, 1 ],
              [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
              [ Lift, 1, RangeCategoryOfHomomorphismStructure ] ],
  function( cat, alpha, beta )
    local range_cat, a, b;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    a := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha );
    
    b := HomomorphismStructureOnMorphisms( cat, IdentityMorphism( Source( alpha ) ), beta );
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, Source( alpha ), Source( beta ), Lift( range_cat, a, b ) );
    
end : CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
      Description := "Derive Lift using the homomorphism structure and Lift in the range of the homomorphism structure" );

##
AddDerivationToCAP( Colift,
            [
              [ IdentityMorphism, 1 ],
              [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
              [ HomomorphismStructureOnMorphisms, 1 ],
              [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
              [ Lift, 1, RangeCategoryOfHomomorphismStructure ],
            ],
  function( cat, alpha, beta )
    local range_cat, b, a;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    b := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, beta );
    
    a := HomomorphismStructureOnMorphisms( cat, alpha, IdentityMorphism( Range( beta ) ) );
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, Range( alpha ), Range( beta ), Lift( range_cat, b, a ) );
    
end : CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
      Description := "Derive Colift using the homomorphism structure and Lift in the range of the homomorphism structure" );

