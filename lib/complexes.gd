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
DeclareCategory( "IsBoundedBellowChainOrCochainComplex", IsChainOrCochainComplex );

DeclareCategory( "IsBoundedAboveChainOrCochainComplex", IsChainOrCochainComplex );

DeclareCategory( "IsBoundedChainOrCochainComplex", IsBoundedBellowChainOrCochainComplex and IsBoundedAboveChainOrCochainComplex );

##
DeclareCategory( "IsBoundedBellowChainComplex", IsBoundedBellowChainOrCochainComplex and IsChainComplex ); 

DeclareCategory( "IsBoundedBellowCochainComplex", IsBoundedBellowChainOrCochainComplex and IsCochainComplex ); 

##
DeclareCategory( "IsBoundedAboveChainComplex", IsBoundedAboveChainOrCochainComplex and IsChainComplex ); 

DeclareCategory( "IsBoundedAboveCochainComplex", IsBoundedAboveChainOrCochainComplex and IsCochainComplex ); 

##
DeclareCategory( "IsBoundedChainComplex", IsBoundedChainOrCochainComplex and IsBoundedAboveChainComplex and IsBoundedBellowChainComplex ); 

DeclareCategory( "IsBoundedCochainComplex", IsBoundedChainOrCochainComplex and IsBoundedAboveCochainComplex and IsBoundedBellowCochainComplex ); 

##
DeclareCategory( "IsFiniteChainComplex", IsChainComplex );

DeclareCategory( "IsFiniteCochainComplex", IsCochainComplex );

#########################################
#
#  Constructors of (Co)chain complexes 
#
#########################################

DeclareOperation( "ChainComplex", [ IsCapCategory, IsZList, IsBool ] );

DeclareOperation( "ChainComplex", [ IsCapCategory, IsZList ] );

DeclareOperation( "CochainComplex", [ IsCapCategory, IsZList, IsBool ] );

DeclareOperation( "CochainComplex", [ IsCapCategory, IsZList ] );

DeclareOperation( "FiniteChainComplex", [ IsDenseList, IsInt ] );

DeclareOperation( "FiniteChainComplex", [ IsDenseList ] );

DeclareOperation( "FiniteCochainComplex", [ IsDenseList, IsInt ] );

DeclareOperation( "FiniteCochainComplex", [ IsDenseList ] );

DeclareOperation( "StalkChainComplex", [ IsCapCategoryObject ] );

DeclareOperation( "StalkCochainComplex", [ IsCapCategoryObject ] );

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

DeclareOperation( "ToDoListToPushFirstUpperBound", [ IsChainOrCochainComplex, IsChainOrCochainComplex ] );

DeclareOperation( "ToDoListToPushFirstLowerBound", [ IsChainOrCochainComplex, IsChainOrCochainComplex ] );

DeclareOperation( "ToDoListToPushBounds", [ IsChainOrCochainComplex, IsChainOrCochainComplex ] );


