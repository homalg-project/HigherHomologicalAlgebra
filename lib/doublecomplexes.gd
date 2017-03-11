#

DeclareCategory( "IsDoubleChainOrCochainComplex", IsObject );
DeclareCategory( "IsDoubleChainComplex", IsDoubleChainOrCochainComplex );
DeclareCategory( "IsDoubleCochainComplex", IsDoubleChainOrCochainComplex );

#####################

DeclareOperation( "DoubleChainComplex", [ IsInfList, IsInfList ] );

DeclareOperation( "DoubleChainComplex", [ IsChainMorphism ] );

DeclareOperation( "DoubleChainComplex", [ IsFunction, IsFunction ] );        


DeclareOperation( "DoubleCochainComplex", [ IsInfList, IsInfList ] );

DeclareOperation( "DoubleCochainComplex", [ IsChainMorphism ] );

DeclareOperation( "DoubleCochainComplex", [ IsFunction, IsFunction ] ); 


######################
#
#  Attributes
#
######################

DeclareAttribute( "Rows", IsDoubleChainOrCochainComplex );

DeclareAttribute( "Columns", IsDoubleChainOrCochainComplex );

#################################
#
# Exploring the double complexes
#
#################################

DeclareOperation( "CertainRow", [ IsDoubleChainOrCochainComplex, IsInt ] );

DeclareOperation( "CertainColumn", [ IsDoubleChainOrCochainComplex, IsInt ] );

DeclareOperation( "CertainRowMorphism", [ IsDoubleChainOrCochainComplex, IsInt, IsInt ] );

DeclareOperation( "CertainColumnMorphism", [ IsDoubleChainOrCochainComplex, IsInt, IsInt ] );

DeclareOperation( "CertainObject", [ IsDoubleChainOrCochainComplex, IsInt, IsInt ] );


