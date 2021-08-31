# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#

BindGlobal( "BASIS_OF_POST_AND_PRE_ANNIHILATORS_METHOD_RECORD", rec(
    
  BasisOfPostAnnihilatorsInLinearCategory := rec(
    filter_list := [ "category", "morphism", "object" ],
    io_type := [ [ "alpha", "C" ], [ "alpha_range", "C" ] ],
    dual_operation := "BasisOfPreAnnihilatorsInLinearCategory",
    return_type := "list_of_morphisms"
  ),
  
  BasisOfPreAnnihilatorsInLinearCategory := rec( 
    filter_list := [ "category", "morphism", "object" ],
    io_type := [ [ "alpha", "C" ], [ "C", "alpha_source" ] ],
    dual_operation := "BasisOfPostAnnihilatorsInLinearCategory",
    return_type := "list_of_morphisms"
  ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BASIS_OF_POST_AND_PRE_ANNIHILATORS_METHOD_RECORD );
CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BASIS_OF_POST_AND_PRE_ANNIHILATORS_METHOD_RECORD );

AddDerivationToCAP( BasisOfPostAnnihilatorsInLinearCategory,
            [
              [ IdentityMorphism, 1 ],
              [ BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory, 1 ]
            ],
  function( cat, alpha, C )
    
    return Concatenation(
        BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory(
              cat,
              [ [ alpha ] ],
              [ [ IdentityMorphism( C ) ] ]
            )
        );
    
  end : Description:= "BasisOfPostAnnihilators using BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory and IdentityMorphism"
);

AddDerivationToCAP( BasisOfPreAnnihilatorsInLinearCategory,
            [
              [ IdentityMorphism, 1 ],
              [ BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory, 1 ]
            ],
  function( cat, alpha, C )
    
    return Concatenation(
        BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory(
              cat,
              [ [ IdentityMorphism( C ) ] ],
              [ [ alpha ] ]
            )
        );
    
  end : Description:= "BasisOfPreAnnihilators using BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory and IdentityMorphism"
);

