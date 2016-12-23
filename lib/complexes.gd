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

#########################################
#
# operations derived from Attributes
#
#########################################

DeclareOperation( "\[\]", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "CertainObject", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "\^", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "CertainDifferential", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "CertainCycle", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "CertainBoundary", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "CertainHomology", [ IsChainComplex, IsInt ] );

DeclareOperation( "CertainCohomology", [ IsCochainComplex, IsInt ] );

DeclareOperation( "DefectOfExactness", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "IsExactInIndex", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "SetUpperBound", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "SetLowerBound", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "HasActiveUpperBound", [ IsChainOrCochainComplex ] );

DeclareOperation( "HasActiveLowerBound", [ IsChainOrCochainComplex ] );

DeclareOperation( "ActiveUpperBound", [ IsChainOrCochainComplex ] );

DeclareOperation( "ActiveLowerBound", [ IsChainOrCochainComplex ] );

DeclareOperation( "Display", [ IsChainOrCochainComplex, IsInt, IsInt ] );

DeclareOperation( "ShiftLazy", [ IsChainOrCochainComplex, IsInt ] );

DeclareOperation( "ShiftUnsignedLazy", [ IsChainOrCochainComplex, IsInt ] );


