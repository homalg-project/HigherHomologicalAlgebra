#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

##
KeyDependentOperation( "ForwardConvolutionAtIndex", IsChainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "ForwardConvolutionAtIndex", IsChainMorphism, IsInt, ReturnTrue );


DeclareOperation( "ForwardConvolution", [ IsChainComplex, IsInt ] );
DeclareAttribute( "ForwardConvolution", IsChainComplex );
DeclareAttribute( "ForwardConvolution", IsHomotopyCategoryObject );

DeclareOperation( "ForwardConvolution", [ IsChainMorphism, IsInt ] );
DeclareAttribute( "ForwardConvolution", IsChainMorphism );
DeclareAttribute( "ForwardConvolution", IsHomotopyCategoryMorphism );

##
KeyDependentOperation( "BackwardConvolutionAtIndex", IsChainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "BackwardConvolutionAtIndex", IsChainMorphism, IsInt, ReturnTrue );

DeclareOperation( "BackwardConvolution", [ IsChainComplex, IsInt ] );
DeclareAttribute( "BackwardConvolution", IsChainComplex );
DeclareAttribute( "BackwardConvolution", IsHomotopyCategoryObject );

DeclareOperation( "BackwardConvolution", [ IsChainMorphism, IsInt ] );
DeclareAttribute( "BackwardConvolution", IsChainMorphism );
DeclareAttribute( "BackwardConvolution", IsHomotopyCategoryMorphism );

DeclareSynonym( "Convolution", ForwardConvolution );
#DeclareSynonym( "Convolution", BackwardConvolution );

