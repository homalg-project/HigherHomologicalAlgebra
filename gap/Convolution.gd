#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

##
DeclareAttribute( "BackwardConvolution", IsChainComplex );

##
KeyDependentOperation( "BackwardConvolution", IsChainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "BackwardConvolution", IsChainMorphism, IsInt, ReturnTrue );

##
DeclareAttribute( "BackwardConvolution", IsHomotopyCategoryObject );

##
DeclareAttribute( "BackwardConvolution", IsChainMorphism );

##
DeclareAttribute( "BackwardConvolution", IsHomotopyCategoryMorphism );

