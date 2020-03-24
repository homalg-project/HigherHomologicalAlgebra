#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

KeyDependentOperation( "ForwardConvolutionAtIndex", IsChainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "ForwardConvolutionAtIndex", IsChainMorphism, IsInt, ReturnTrue );

DeclareAttribute( "ForwardConvolution", IsChainComplex );
DeclareAttribute( "ForwardConvolution", IsChainMorphism );

DeclareAttribute( "ForwardConvolution", IsHomotopyCategoryObject );
DeclareAttribute( "ForwardConvolution", IsHomotopyCategoryMorphism );

KeyDependentOperation( "BackwardConvolutionAtIndex", IsChainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "BackwardConvolutionAtIndex", IsChainMorphism, IsInt, ReturnTrue );

DeclareAttribute( "BackwardConvolution", IsChainComplex );
DeclareAttribute( "BackwardConvolution", IsChainMorphism );

DeclareAttribute( "BackwardConvolution", IsHomotopyCategoryObject );
DeclareAttribute( "BackwardConvolution", IsHomotopyCategoryMorphism );

DeclareSynonym( "Convolution", ForwardConvolution );
#DeclareSynonym( "Convolution", BackwardConvolution );

