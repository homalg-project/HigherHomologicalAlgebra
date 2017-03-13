#! @Chapter Double complexes
#! @Section Categories and filters
#! Here we ...

DeclareCategory( "IsDoubleChainOrCochainComplex", IsObject );
DeclareCategory( "IsDoubleChainComplex", IsDoubleChainOrCochainComplex );
DeclareCategory( "IsDoubleCochainComplex", IsDoubleChainOrCochainComplex );

#! @EndSection

##############################
#
# Creating double  complexes
#
##############################

#! @Section Creating double complexes

#! @Description
#! The input is two infinite lists $rows$ and $cols$. The entry in index $j$ of $rows$ should represent 
#! the $j$'th row of the double complex. I.e., $h_{i,j}:= rows[j][i]$ for all $i\in\mathbb{Z}$. 
#! Again, every entry in index $i$ of $cols$ should represent the $i$'th column of the double complex.
#! I.e., $v_{i,j}:=cols[i][j]$.
#! @Arguments rows, cols
#! @Returns a chain morphism
DeclareOperation( "DoubleChainComplex", [ IsInfList, IsInfList ] );

#! @Description
#! The input is two functions $R$ and $V$. The output is the double chain complex where 
#! $h_{i,j}=R(i,j)$ and $v_{i,j}=V(i,j)$.
#! @Arguments rows, cols
#! @Returns a chain morphism
DeclareOperation( "DoubleChainComplex", [ IsFunction, IsFunction ] );        

DeclareOperation( "DoubleChainComplex", [ IsChainMorphism ] );

DeclareOperation( "DoubleCochainComplex", [ IsInfList, IsInfList ] );

DeclareOperation( "DoubleCochainComplex", [ IsChainMorphism ] );

DeclareOperation( "DoubleCochainComplex", [ IsFunction, IsFunction ] ); 

#! @EndSection

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


