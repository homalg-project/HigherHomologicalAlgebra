#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

##
DeclareAttribute( "ForwardConvolution", IsChainComplex );

##
DeclareAttribute( "ForwardConvolution", IsHomotopyCategoryObject );

##
DeclareAttribute( "ForwardConvolution", IsChainMorphism );

##
DeclareAttribute( "ForwardConvolution", IsHomotopyCategoryMorphism );

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

