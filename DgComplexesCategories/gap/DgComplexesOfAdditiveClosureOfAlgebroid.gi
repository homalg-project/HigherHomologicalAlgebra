# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#

InstallOtherMethod( DgComplexesOfAdditiveClosureOfAlgebroid,
        "for an algebroid",
        [ IsAlgebroid ],
        
  function( A )
    local M, DG;
    
    M := AdditiveClosure( A : FinalizeCategory := true );
    
    DG := DgCochainComplexCategory( M : FinalizeCategory := false );
    
    Finalize( RangeCategoryOfHomomorphismStructure( DG ) : FinalizeCategory := true );
    
    SetDefiningPairOfUnderlyingQuiver( DG, DefiningPairOfAQuiver( UnderlyingQuiver( A ) ) );
    
    DG!.compiler_hints.category_attribute_names :=
      [ "UnderlyingCategory",
        "DefiningPairOfUnderlyingQuiver",
        ];
    
    if ValueOption( "no_precompiled_code" ) <> true then
        ADD_FUNCTIONS_FOR_CategoryOfDgComplexesOfAdditiveClosureOfAlgebroidPrecompiled( DG );
    fi;
    
    Finalize( DG );
    
    return DG;
    
end );
