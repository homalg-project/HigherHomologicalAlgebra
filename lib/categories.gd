###################################################
#
# (Co)chain complexes categories filters
#
###################################################

DeclareCategory( "IsChainOrCochainComplexCategory", IsCapCategory );

DeclareCategory( "IsChainComplexCategory", IsChainOrCochainComplexCategory );

DeclareCategory( "IsCochainComplexCategory", IsChainOrCochainComplexCategory );

###################################################
#
#  Constructors of (Co)chain complexes categories
#
###################################################

DeclareAttribute( "ChainComplexCategory", IsCapCategory );

DeclareAttribute( "CochainComplexCategory", IsCapCategory );

DeclareAttribute( "UnderlyingCategory", IsChainOrCochainComplexCategory );

