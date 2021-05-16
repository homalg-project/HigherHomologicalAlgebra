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

DeclareCategory( "IsCapCategoryInflation", IsCapCategoryMorphism );

DeclareCategory( "IsCapCategoryDeflation", IsCapCategoryMorphism );

####################################
##
##  Methods Declarations in Records
##
####################################

 
DeclareOperation( "IsConflationPair", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsList ] );


DeclareAttribute( "CompleteInflationToConflation", IsCapCategoryMorphism );

DeclareOperation( "AddCompleteInflationToConflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCompleteInflationToConflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCompleteInflationToConflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCompleteInflationToConflation",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "CompleteDeflationToConflation", IsCapCategoryMorphism );

DeclareOperation( "AddCompleteDeflationToConflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCompleteDeflationToConflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCompleteDeflationToConflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCompleteDeflationToConflation",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactFiberProduct", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ProjectionInFactorOfExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsInt ] );

DeclareOperation( "ProjectionInFactorOfExactFiberProduct", [ IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddProjectionInFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddProjectionInFactorOfExactFiberProduct",
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

DeclareOperation( "LiftAlongInflation", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "ColiftAlongDeflation", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactPushout", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "InjectionOfCofactorOfExactPushout", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInjectionOfCofactorOfExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInjectionOfCofactorOfExactPushout",
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

DeclareProperty( "IsExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareProperty( "IsExactInjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "SomeExactProjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "DeflationFromSomeExactProjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
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

DeclareOperation( "ExactProjectiveLift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
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

##
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
DeclareAttribute( "LiftAlongDeflationFromSomeExactProjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
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

DeclareAttribute( "SetFilterOnInflations", IsCapCategoryMorphism );

DeclareAttribute( "SetFilterOnDeflations", IsCapCategoryMorphism );
DeclareAttribute( "SetFilterOnConflations", IsCapCategoryShortSequence );
        
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

