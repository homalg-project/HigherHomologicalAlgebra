# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################

########################
##
## Declarations
##
########################

##
InstallMethod( HomotopyCategoryByCochains,
          [ IsCapCategory ],
          
  function( cat )
    local name, homotopy_category;
    
    name := Concatenation( "Homotopy category by cochains( ", Name( cat ), " )" );
    
    homotopy_category := QuotientCategory(
                           rec( name := name,
                                nr_arguments_of_congruence_function := 1,
                                congruence_function := IsHomotopicToZeroMorphism,
                                underlying_category := ComplexesCategoryByCochains( cat ),
                                category_filter := IsHomotopyCategoryByCochains,
                                category_object_filter := IsHomotopyCategoryByCochainsObject,
                                category_morphism_filter := IsHomotopyCategoryByCochainsMorphism ) : FinalizeCategory := false );
    
    SetDefiningCategory( homotopy_category, cat );
    
    ADD_FUNCTIONS_OF_HOMOMORPHISM_STRUCTURE_TO_HOMOTOPY_CATEGORY_BY_COCHAINS( homotopy_category );
    ADD_FUNCTIONS_OF_TRIANGULATED_STRUCTURE_TO_HOMOTOPY_CATEGORY( homotopy_category );
    
    Finalize( homotopy_category );
    
    return homotopy_category;
    
end );
