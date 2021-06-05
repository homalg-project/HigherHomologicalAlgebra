# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# Declarations
#

#! @Chapter StableCategoriesForCap

#! @InsertChunk stable_cat_by_projectives

DeclareCategory( "IsStableCategory",
                 IsQuotientCategory );

DeclareProperty( "IsLiftingObject", IsCapCategoryObject );

DeclareOperation( "AddIsLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsLiftingObject",
                  [ IsCapCategory, IsList ] );
DeclareAttribute( "LiftingObject", IsCapCategoryObject );

DeclareOperation( "AddLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "MorphismFromLiftingObject", IsCapCategoryObject );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "MorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsList ] );
DeclareOperation( "SectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
    [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "SectionOfMorphismFromLiftingObject", IsCapCategoryObject );

DeclareOperation( "AddSectionOfMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "LiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "LiftingMorphism", IsCapCategoryMorphism );

DeclareProperty( "IsLiftableAlongMorphismFromLiftingObject",
                  IsCapCategoryMorphism );

DeclareOperation( "AddIsLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "WitnessForBeingLiftableAlongMorphismFromLiftingObject", IsCapCategoryMorphism );

DeclareOperation( "AddWitnessForBeingLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessForBeingLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWitnessForBeingLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWitnessForBeingLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsList ] );



DeclareProperty( "IsColiftingObject", IsCapCategoryObject );

DeclareOperation( "AddIsColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsColiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ColiftingObject", IsCapCategoryObject );

DeclareOperation( "AddColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddColiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "MorphismToColiftingObject", IsCapCategoryObject );

DeclareOperation( "AddMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToColiftingObject",
                  [ IsCapCategory, IsList ] );
DeclareOperation( "MorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList ] );
DeclareOperation( "RetractionOfMorphismToColiftingObjectWithGivenColiftingObject", 
    [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "RetractionOfMorphismToColiftingObject", IsCapCategoryObject );

DeclareOperation( "AddRetractionOfMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ColiftingMorphism", IsCapCategoryMorphism );

DeclareProperty( "IsColiftableAlongMorphismToColiftingObject",
                  IsCapCategoryMorphism );

DeclareOperation( "AddIsColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "WitnessForBeingColiftableAlongMorphismToColiftingObject", IsCapCategoryMorphism );

DeclareOperation( "AddWitnessForBeingColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessForBeingColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWitnessForBeingColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWitnessForBeingColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "StableCategory",
            [ IsCapCategory, IsFunction ] );

DeclareAttribute( "CongruencyTestFunction", IsStableCategory );
DeclareOperation( "StableCategoryObject",
            [ IsStableCategory, IsCapCategoryObject ] );

DeclareOperation( "StableCategoryMorphism",
            [ IsStableCategoryObject, IsCapCategoryMorphism, IsStableCategoryObject ] );


DeclareOperation( "StableCategoryMorphism",
            [ IsStableCategory, IsCapCategoryMorphism ] );

DeclareAttribute( "StableCategoryBySystemOfColiftingObjects", IsCapCategory );

DeclareAttribute( "StableCategoryBySystemOfLiftingObjects", IsCapCategory );

DeclareAttribute( "CongruencyTestFunctionForStableCategory", IsStableCategory );

DeclareAttribute( "ProjectionFunctor", IsStableCategory );

DeclareGlobalFunction( "ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT" );

DeclareGlobalFunction( "ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_LIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT" );

DeclareGlobalFunction( "ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE" );

DeclareGlobalFunction( "ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_LIFTING_STRUCTURE" );

DeclareGlobalVariable( "CAP_INTERNAL_STABLE_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "STABLE_CATEGORIES_METHOD_NAME_RECORD" );

DeclareOperation( "HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS", [ IsStableCategoryObject, IsStableCategoryObject ] );

DeclareOperation( "HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS", [ IsStableCategoryObject, IsStableCategoryObject ] );
