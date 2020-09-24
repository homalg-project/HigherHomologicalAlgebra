#
# StableCategories: Stable categories of additive categories
#
# Declarations
#

#! @Chapter StableCategoriesForCap

#! @InsertChunk stable_cat_by_projectives

DeclareCategory( "IsStableCategory",
                 IsQuotientCategory );

DeclareCategory( "IsStableCategoryCell",
                 IsQuotientCategoryCell );

DeclareCategory( "IsStableCategoryObject",
                 IsStableCategoryCell and IsQuotientCategoryObject );

DeclareCategory( "IsStableCategoryMorphism",
                 IsStableCategoryCell and IsQuotientCategoryMorphism );
##
## Stable colifting structure

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


###
DeclareOperation( "MorphismIntoColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismIntoColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismIntoColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismIntoColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismIntoColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "MorphismIntoColiftingObject", IsCapCategoryObject );

DeclareOperation( "AddMorphismIntoColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismIntoColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismIntoColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismIntoColiftingObject",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "ColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategoryMorphism, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ColiftingMorphism", IsCapCategoryMorphism );

DeclareProperty( "IsColiftableThroughColiftingObject",
                  IsCapCategoryMorphism );

DeclareOperation( "AddIsColiftableThroughColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftableThroughColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsColiftableThroughColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsColiftableThroughColiftingObject",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "WitnessForBeingColiftableThroughColiftingObject", IsCapCategoryMorphism );

DeclareOperation( "AddWitnessForBeingColiftableThroughColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessForBeingColiftableThroughColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWitnessForBeingColiftableThroughColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWitnessForBeingColiftableThroughColiftingObject",
                  [ IsCapCategory, IsList ] );

## Stable lifting structure

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

###
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
##
DeclareAttribute( "MorphismFromLiftingObject", IsCapCategoryObject );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "LiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategoryMorphism, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "LiftingMorphism", IsCapCategoryMorphism );

DeclareProperty( "IsLiftableThroughLiftingObject",
                  IsCapCategoryMorphism );

DeclareOperation( "AddIsLiftableThroughLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftableThroughLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsLiftableThroughLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsLiftableThroughLiftingObject",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "WitnessForBeingLiftableThroughLiftingObject", IsCapCategoryMorphism );

DeclareOperation( "AddWitnessForBeingLiftableThroughLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessForBeingLiftableThroughLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWitnessForBeingLiftableThroughLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWitnessForBeingLiftableThroughLiftingObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "StableCategory",
            [ IsCapCategory, IsFunction ] );

DeclareOperation( "StableCategoryObject",
            [ IsStableCategory, IsCapCategoryObject ] );

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
