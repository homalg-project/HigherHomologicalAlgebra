###############################################
##
##              CAP package
##
##              Kamal Saleh 2016
##
###############################################

#########################################
#
# Categories and filters
#
#########################################

##
DeclareCategory( "IsChainOrCochainComplex", IsCapCategoryObject );

DeclareCategory( "IsChainComplex", IsChainOrCochainComplex );

DeclareCategory( "IsCochainComplex", IsChainOrCochainComplex );

##
DeclareCategory( "IsBoundedBelowChainOrCochainComplex", IsChainOrCochainComplex );

DeclareCategory( "IsBoundedAboveChainOrCochainComplex", IsChainOrCochainComplex );

DeclareCategory( "IsBoundedChainOrCochainComplex", IsBoundedBelowChainOrCochainComplex and IsBoundedAboveChainOrCochainComplex );

##
DeclareCategory( "IsBoundedBelowChainComplex", IsBoundedBelowChainOrCochainComplex and IsChainComplex ); 

DeclareCategory( "IsBoundedBelowCochainComplex", IsBoundedBelowChainOrCochainComplex and IsCochainComplex ); 

##
DeclareCategory( "IsBoundedAboveChainComplex", IsBoundedAboveChainOrCochainComplex and IsChainComplex ); 

DeclareCategory( "IsBoundedAboveCochainComplex", IsBoundedAboveChainOrCochainComplex and IsCochainComplex ); 

##
DeclareCategory( "IsBoundedChainComplex", IsBoundedChainOrCochainComplex and IsChainComplex ); 

DeclareCategory( "IsBoundedCochainComplex", IsBoundedChainOrCochainComplex and IsCochainComplex ); 

#########################################
#
#  Constructors of (Co)chain complexes 
#
#########################################

DeclareOperation( "ChainComplex", [ IsCapCategory, IsZList, IsBool ] );

DeclareOperation( "ChainComplex", [ IsCapCategory, IsZList ] );

DeclareOperation( "CochainComplex", [ IsCapCategory, IsZList, IsBool ] );

DeclareOperation( "CochainComplex", [ IsCapCategory, IsZList ] );

DeclareOperation( "ChainComplex", [ IsDenseList, IsInt ] );

DeclareOperation( "ChainComplex", [ IsDenseList ] );

DeclareOperation( "CochainComplex", [ IsDenseList, IsInt ] );

DeclareOperation( "CochainComplex", [ IsDenseList ] );

DeclareOperation( "StalkChainComplex", [ IsCapCategoryObject, IsInt ] );

DeclareOperation( "StalkCochainComplex", [ IsCapCategoryObject, IsInt ] );

DeclareOperation( "ChainComplexWithInductiveSides", [ IsCapCategoryMorphism, IsFunction, IsFunction ] );

DeclareOperation( "CochainComplexWithInductiveSides", [ IsCapCategoryMorphism, IsFunction, IsFunction ] );

DeclareOperation( "ChainComplexWithInductiveNegativeSide", [ IsCapCategoryMorphism, IsFunction ] );

DeclareOperation( "ChainComplexWithInductivePositiveSide", [ IsCapCategoryMorphism, IsFunction ] );

DeclareOperation( "CochainComplexWithInductiveNegativeSide", [ IsCapCategoryMorphism, IsFunction ] );

DeclareOperation( "CochainComplexWithInductivePositiveSide", [ IsCapCategoryMorphism, IsFunction ] );

#########################################
#
# Attributes of (co)chain complexes
#
#########################################

DeclareAttribute( "Differentials", IsChainOrCochainComplex );

DeclareAttribute( "Objects", IsChainOrCochainComplex );

DeclareAttribute( "CatOfComplex", IsChainOrCochainComplex );

# These two attributes and properties will be used to activate to do lists.
# FAU_BOUND means first active upper bound. FAL_BOUND is for lower bound.
DeclareAttribute( "FAU_BOUND", IsChainOrCochainComplex );

DeclareAttribute( "FAL_BOUND", IsChainOrCochainComplex );

DeclareProperty( "HAS_FAU_BOUND", IsChainOrCochainComplex );

DeclareProperty( "HAS_FAL_BOUND", IsChainOrCochainComplex );

#########################################
#
# operations derived from Attributes
#
#########################################
KeyDependentOperation( "CertainObject", IsChainOrCochainComplex, IsInt, ReturnTrue );

DeclareOperation( "\[\]", [ IsChainOrCochainComplex, IsInt ] );

KeyDependentOperation( "CertainDifferential", IsChainOrCochainComplex, IsInt, ReturnTrue );

DeclareOperation( "\^", [ IsChainOrCochainComplex, IsInt ] );

KeyDependentOperation( "CertainCycle", IsChainOrCochainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "CertainBoundary", IsChainOrCochainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "CertainHomology", IsChainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "CertainCohomology", IsCochainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "DefectOfExactness", IsChainOrCochainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "IsExactInIndex", IsChainOrCochainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "ShiftLazy", IsChainOrCochainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "ShiftUnsignedLazy", IsChainOrCochainComplex, IsInt, ReturnTrue );

DeclareOperation( "GoodTruncationAbove", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "GoodTruncationBelow", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "BrutalTruncationBelow", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "BrutalTruncationAbove", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "SetUpperBound", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "SetLowerBound", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "HasActiveUpperBound", [ IsChainOrCochainComplex ] );

DeclareOperation( "HasActiveLowerBound", [ IsChainOrCochainComplex ] );

DeclareOperation( "ActiveUpperBound", [ IsChainOrCochainComplex ] );

DeclareOperation( "ActiveLowerBound", [ IsChainOrCochainComplex ] );

DeclareOperation( "Display", [ IsChainOrCochainComplex, IsInt, IsInt ] );

##############################################
#
# Methods to maintain upper and lower bounds
#
##############################################

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_BOUNDS" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_PULL_FIRST_UPPER_BOUND" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_PULL_FIRST_LOWER_BOUND" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_PULL_BOUNDS" );

DeclareGlobalFunction( "TODO_LIST_TO_CHANGE_COMPLEX_FILTERS_WHEN_NEEDED" );
