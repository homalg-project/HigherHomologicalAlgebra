#
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
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

##
Append( LIST_OF_SYNONYMS_FOR_CAP_OPERATIONS,
  [
    [ "fconv", ForwardConvolution ],
    [ "bconv", BackwardConvolution ],
    [ "fpkv", ForwardPostnikovSystemAt ],
    [ "bpkv", BackwardPostnikovSystemAt ]
  ]
);

