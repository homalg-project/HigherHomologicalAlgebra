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
InstallMethod( HomotopyCategoryByChains,
          [ IsCapCategory ],
          
  function( cat )
    local coch_homotopy_cat, ch_cat, object_constructor, object_datum, morphism_constructor, morphism_datum,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          ch_homotopy_cat;
    
    coch_homotopy_cat := HomotopyCategoryByCochains( cat );
    ch_cat := ComplexesCategoryByChains( cat );
    
    ##
    object_constructor := { ch_homotopy_cat, datum } ->
        CreateCapCategoryObjectWithAttributes( ch_homotopy_cat, UnderlyingCell, datum );
    
    ##
    object_datum := { ch_homotopy_cat, obj } -> UnderlyingCell( obj );
    
    ##
    morphism_constructor := { ch_homotopy_cat, S, datum, R } ->
        CreateCapCategoryMorphismWithAttributes( ch_homotopy_cat, S, R, UnderlyingCell, datum );
    
    ##
    morphism_datum := { ch_homotopy_cat, mor } -> UnderlyingCell( mor );
    
    ## from the raw object datum (a chain complex) to the object in the modeling category
    modeling_tower_object_constructor :=
      function( ch_homotopy_cat, datum )
        local coch_homotopy_cat, coch_cat;
        
        coch_homotopy_cat := ModelingCategory( ch_homotopy_cat );
        coch_cat := AmbientCategory( coch_homotopy_cat );
        
        return ObjectConstructor( coch_homotopy_cat,
                   CreateComplex( coch_cat,
                       Reflection( Objects( datum ) ),
                       Reflection( Differentials( datum ) ),
                       -UpperBound( datum ),
                       -LowerBound( datum ) ) );
        
    end;
    
    ## from the object in the modeling category to the raw object datum
    modeling_tower_object_datum :=
      function( ch_homotopy_cat, obj )
        local coch_complex;
        
        coch_complex := ObjectDatum( ModelingCategory( ch_homotopy_cat ), obj );
        
        return CreateComplex( ch_cat,
                   Reflection( Objects( coch_complex ) ),
                   Reflection( Differentials( coch_complex ) ),
                   -UpperBound( coch_complex ),
                   -LowerBound( coch_complex ) );
        
    end;
    
    ## from the raw morphism datum (a chain morphism) to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( ch_homotopy_cat, source, datum, range )
        local coch_homotopy_cat, coch_cat;
        
        coch_homotopy_cat := ModelingCategory( ch_homotopy_cat );
        coch_cat := AmbientCategory( coch_homotopy_cat );
        
        return MorphismConstructor( coch_homotopy_cat, source,
                   CreateComplexMorphism( coch_cat,
                       ObjectDatum( coch_homotopy_cat, source ),
                       Reflection( Morphisms( datum ) ),
                       ObjectDatum( coch_homotopy_cat, range ) ),
                   range );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism datum
    modeling_tower_morphism_datum :=
      function( ch_homotopy_cat, mor )
        local coch_homotopy_cat, coch_morphism;
        
        coch_homotopy_cat := ModelingCategory( ch_homotopy_cat );
        coch_morphism := MorphismDatum( coch_homotopy_cat, mor );
        
        return CreateComplexMorphism( ch_cat,
                   modeling_tower_object_datum( ch_homotopy_cat, Source( mor ) ),
                   Reflection( Morphisms( coch_morphism ) ),
                   modeling_tower_object_datum( ch_homotopy_cat, Range( mor ) ) );
        
    end;
    
    ##
    ch_homotopy_cat :=
      ReinterpretationOfCategory( coch_homotopy_cat,
              rec( name := Concatenation( "Homotopy category by chains( ", Name( cat ), " )" ),
                   category_filter := IsHomotopyCategoryByChains,
                   category_object_filter := IsHomotopyCategoryByChainsObject,
                   category_morphism_filter := IsHomotopyCategoryByChainsMorphism,
                   object_constructor := object_constructor,
                   object_datum := object_datum,
                   morphism_constructor := morphism_constructor,
                   morphism_datum := morphism_datum,
                   modeling_tower_object_constructor := modeling_tower_object_constructor,
                   modeling_tower_object_datum := modeling_tower_object_datum,
                   modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum := modeling_tower_morphism_datum,
                   only_primitive_operations := true ) : FinalizeCategory := false );
    
    SetDefiningCategory( ch_homotopy_cat, cat );
    
    SetAmbientCategory( ch_homotopy_cat, ch_cat );
    
    Finalize( ch_homotopy_cat );
    
    return ch_homotopy_cat;
    
end );

##
InstallMethod( HomotopyCategoryByCochains,
          [ IsCapCategory ],
          
  function( cat )
    local name, homotopy_category;
    
    name := Concatenation( "Homotopy category by cochains( ", Name( cat ), " )" );
    
    homotopy_category := QuotientCategory(
                           rec( name := name,
                                nr_arguments_of_congruence_func := 1,
                                congruence_func := IsHomotopicToZeroMorphism,
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
