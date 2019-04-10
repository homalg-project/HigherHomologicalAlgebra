############################################################################
#                                     GAP package
#
#  Copyright 2015,       Kamal Saleh  RWTH Aachen University
#
#! @Chapter StableCategoriesForCap
##
#############################################################################

DeclareCategory( "IsStableCategory",
                 IsQuotientCategory );
                 
DeclareCategory( "IsStableCategoryObject",
                 IsQuotientCategoryObject );

DeclareCategory( "IsStableCategoryMorphism",
                 IsQuotientCategoryMorphism );

##
## Stable colifting structure

DeclareOperation( "ColiftingObject",
                  [ IsCapCategoryObject ] );

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
DeclareOperation( "MorphismIntoColiftingObject",
                  [ IsCapCategoryObject ] );

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

DeclareOperation( "ColiftingMorphism",
                  [ IsCapCategoryMorphism ] );

DeclareOperation( "AddColiftingMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftingMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddColiftingMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddColiftingMorphism",
                  [ IsCapCategory, IsList ] );


## Stable lifting structure

DeclareOperation( "LiftingObject",
                  [ IsCapCategoryObject ] );

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
DeclareOperation( "MorphismFromLiftingObject",
                  [ IsCapCategoryObject ] );

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

DeclareOperation( "LiftingMorphism",
                  [ IsCapCategoryMorphism ] );

DeclareOperation( "AddLiftingMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftingMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLiftingMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLiftingMorphism",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "StableCategory",
            [ IsCapCategory, IsFunction ] );

# These methods call AsQuotientCategory(Object/Morphism)
DeclareOperation( "AsStableCategoryObject",
            [ IsStableCategory, IsCapCategoryObject ] );

DeclareOperation( "AsStableCategoryMorphism",
            [ IsStableCategory, IsCapCategoryMorphism ] );

DeclareAttribute( "StableCategoryByColiftingStructure", IsCapCategory );

DeclareAttribute( "StableCategoryByLiftingStructure", IsCapCategory );

DeclareAttribute( "CongruencyTestFunctionForStableCategory", IsStableCategory );

DeclareAttribute( "CanonicalProjectionFunctor", IsStableCategory );

DeclareGlobalFunction( "ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE" );

DeclareGlobalVariable( "CAP_INTERNAL_STABLE_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "STABLE_CATEGORIES_METHOD_NAME_RECORD" );

