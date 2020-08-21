#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

##
KeyDependentOperation( "ForwardPostnikovSystemAt", IsChainOrCochainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "ForwardPostnikovSystemAt", IsChainOrCochainMorphism, IsInt, ReturnTrue );


DeclareAttribute( "ForwardConvolution", IsChainOrCochainComplex );
DeclareAttribute( "ForwardConvolution", IsChainOrCochainMorphism );
DeclareAttribute( "ForwardConvolution", IsHomotopyCategoryCell );

##
KeyDependentOperation( "BackwardPostnikovSystemAt", IsChainOrCochainComplex, IsInt, ReturnTrue );
KeyDependentOperation( "BackwardPostnikovSystemAt", IsChainOrCochainMorphism, IsInt, ReturnTrue );

DeclareAttribute( "BackwardConvolution", IsChainOrCochainComplex );
DeclareAttribute( "BackwardConvolution", IsChainOrCochainMorphism );
DeclareAttribute( "BackwardConvolution", IsHomotopyCategoryCell );

KeyDependentOperation( "ShiftOfBackwardConvolution_into_BackwardConvolutionOfShift", IsHomotopyCategoryObject, IsInt, ReturnTrue );
KeyDependentOperation( "BackwardConvolutionOfShift_into_ShiftOfBackwardConvolution", IsHomotopyCategoryObject, IsInt, ReturnTrue );

DeclareSynonym( "fconv", ForwardConvolution );
DeclareSynonym( "bconv", BackwardConvolution );
DeclareSynonym( "fpkv", ForwardPostnikovSystemAt );
DeclareSynonym( "bpkv", BackwardPostnikovSystemAt );

