#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

##
KeyDependentOperation( "ForwardConvolutionAtIndex", IsChainOrCochainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "ForwardConvolutionAtIndex", IsChainOrCochainMorphism, IsInt, ReturnTrue );


DeclareOperation( "ForwardConvolution", [ IsChainOrCochainComplex, IsInt ] );
DeclareAttribute( "ForwardConvolution", IsChainOrCochainComplex );
DeclareAttribute( "ForwardConvolution", IsHomotopyCategoryObject );

DeclareOperation( "ForwardConvolution", [ IsChainOrCochainMorphism, IsInt ] );
DeclareAttribute( "ForwardConvolution", IsChainOrCochainMorphism );
DeclareAttribute( "ForwardConvolution", IsHomotopyCategoryMorphism );

##
KeyDependentOperation( "BackwardConvolutionAtIndex", IsChainOrCochainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "BackwardConvolutionAtIndex", IsChainOrCochainMorphism, IsInt, ReturnTrue );

DeclareOperation( "BackwardConvolution", [ IsChainOrCochainComplex, IsInt ] );
DeclareAttribute( "BackwardConvolution", IsChainOrCochainComplex );
DeclareAttribute( "BackwardConvolution", IsHomotopyCategoryObject );

DeclareOperation( "BackwardConvolution", [ IsChainOrCochainMorphism, IsInt ] );
DeclareAttribute( "BackwardConvolution", IsChainOrCochainMorphism );
DeclareAttribute( "BackwardConvolution", IsHomotopyCategoryMorphism );

DeclareSynonym( "Convolution", ForwardConvolution );
#DeclareSynonym( "Convolution", BackwardConvolution );

