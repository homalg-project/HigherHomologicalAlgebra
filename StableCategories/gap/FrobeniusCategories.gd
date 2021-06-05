#################################
##
##  Declarations
##
#################################

DeclareGlobalVariable( "CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "FROBENIUS_CATEGORIES_METHOD_NAME_RECORD" );

DeclareCategory( "IsCapCategoryShortSequence", IsCapCategoryObject );

DeclareCategory( "IsCapCategoryMorphismOfShortSequences", IsCapCategoryMorphism );

DeclareCategory( "IsCapCategoryShortExactSequence", IsCapCategoryShortSequence );

DeclareCategory( "IsCapCategoryConflation", IsCapCategoryShortExactSequence );

####################################
##
##  Methods Declarations in Records
##
####################################

 
DeclareAttribute( "IsInflation", IsCapCategoryMorphism );

DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsList ] );
DeclareAttribute( "IsDeflation", IsCapCategoryMorphism );

DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "IsConflationPair",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ExactCokernelObject", IsCapCategoryMorphism );

DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ExactCokernelProjection", IsCapCategoryMorphism );

DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactCokernelProjectionWithGivenExactCokernelObject",
    [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactCokernelColift",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ColiftAlongDeflation",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ExactKernelObject", IsCapCategoryMorphism );

DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ExactKernelEmbedding", IsCapCategoryMorphism );

DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactKernelEmbeddingWithGivenExactKernelObject",
  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactKernelLift",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "LiftAlongInflation",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra


#! @Subsection Exact Fiber Product
DeclareOperation( "ExactFiberProduct", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ProjectionInFirstFactorOfExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "ProjectionInSecondFactorOfExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "UniversalMorphismIntoExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "UniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra-fiber-product





DeclareOperation( "ExactPushout", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "InjectionOfFirstCofactorOfExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
DeclareOperation( "InjectionOfSecondCofactorOfExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "UniversalMorphismFromExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "UniversalMorphismFromExactPushoutWithGivenExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsList ] );

DeclareProperty( "IsExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactProjectiveLift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "SomeExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "DeflationFromSomeExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#!  an inflation $\iota_A:A \to I_A$ where $I_A$ is an $\EE$-injective object.


#! @Description
DeclareProperty( "IsExactInjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactInjectiveColift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "SomeExactInjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "InflationIntoSomeExactInjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

##
DeclareProperty( "IsLiftableAlongDeflationFromSomeExactProjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "LiftAlongDeflationFromSomeExactProjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareProperty( "IsColiftableAlongInflationIntoSomeExactInjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "ColiftAlongInflationIntoSomeExactInjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#################################
##
## Methods 
##
#################################

DeclareAttribute( "CategoryOfShortSequences", IsCapCategory );

DeclareOperation( "CreateShortSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CreateShortExactSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
           
DeclareOperation( "CreateConflation", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SchanuelsIsomorphism", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsString ] );

DeclareAttribute( "IsShortExactSequence_", IsCapCategoryShortSequence );
#################################
##
##  Attributes
##
#################################

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY", IsCapCategory );
DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_EXACT_CATEGORY", IsCapCategory );
        
#################################
##
## Properties
##
#################################

DeclareProperty( "IsExactCategory", IsCapCategory );
DeclareProperty( "IsExactCategoryWithEnoughExactProjectives", IsCapCategory );
DeclareProperty( "IsExactCategoryWithEnoughExactInjectives", IsCapCategory );
DeclareProperty( "IsFrobeniusCategory", IsCapCategory );

DeclareAttribute( "AsResidueClassOfInflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoFromRangeToRangeOfResidueClassOfInflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoToRangeFromRangeOfResidueClassOfInflation", IsStableCategoryMorphism );

DeclareAttribute( "AsResidueClassOfDeflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoFromSourceToSourceOfResidueClassOfDefflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoToSourceFromSourceOfResidueClassOfDeflation", IsStableCategoryMorphism );


KeyDependentOperation( "MorphismAt", IsCapCategoryShortSequence, IsInt, ReturnTrue );
DeclareOperation( "\^", [ IsCapCategoryShortSequence, IsInt ] );

KeyDependentOperation( "ObjectAt", IsCapCategoryShortSequence, IsInt, ReturnTrue );
DeclareOperation( "\[\]", [ IsCapCategoryShortSequence, IsInt ] );

