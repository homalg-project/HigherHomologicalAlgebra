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

KeyDependentOperation( "ShiftOfBackwardConvolution_into_BackwardConvolutionOfShift", IsHomotopyCategoryObject, IsInt, ReturnTrue );
KeyDependentOperation( "BackwardConvolutionOfShift_into_ShiftOfBackwardConvolution", IsHomotopyCategoryObject, IsInt, ReturnTrue );

DeclareSynonym( "fconv", ForwardConvolution );
DeclareSynonym( "bconv", BackwardConvolution );

