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
#! The input is two infinite lists $rows$ and $cols$. The entry in index $j$ of $rows$ should 
#! be an infinite list that represents 
#! the $j$'th row of the double complex. I.e., $h^D_{i,j}:= rows[j][i]$ for all $i\in\mathbb{Z}$. 
#! Again, the entry in index $i$ of $cols$ should be an infinite list that represents the $i$'th 
#! column of the double complex.
#! I.e., $v^D_{i,j}:=cols[i][j]$.
#! @Arguments rows, cols
#! @Returns a double chain complex
DeclareOperation( "DoubleChainComplex", [ IsInfList, IsInfList ] );

#! @Description
#! The input is two functions $R$ and $V$. The output is the double chain complex $D$ defined by 
#! $h^D_{i,j}=H(i,j)$ and $v^D_{i,j}=V(i,j)$.
#! @Arguments H, V
#! @Returns a double chain complex
DeclareOperation( "DoubleChainComplex", [ IsFunction, IsFunction ] );

#! @Description
#! The input is chain complex of chain complexes $C$. The output is the double chain complex
#! $D$ defined using sign trick. I.e., $h^D_{i,j}=(d^C_i)_j$ and $v^D_{i,j}=(-1)^id^{C_i}_j$.
#! @Arguments C
#! @Returns a double chain complex
DeclareOperation( "DoubleChainComplex", [ IsChainComplex ] );

#! @Description
#! The input is double cochain complex $D$. The output is the double chain complex
#! $E$ defined by $h^E_{i,j}=h_D^{-i,-j}$ and $v^E_{i,j}=v_D^{-i,-j}$.
#! @Arguments C
#! @Returns a double chain complex
DeclareOperation( "DoubleChainComplex", [ IsDoubleCochainComplex ] );

#! @Description
#! The input is two infinite lists $rows$ and $cols$. The entry in index $j$ of $rows$ should 
#! be an infinite list that represents 
#! the $j$'th row of the double complex. I.e., $h_D^{i,j}:= rows[j][i]$ for all $i\in\mathbb{Z}$. 
#! Again, the entry in index $i$ of $cols$ should be an infinite list that represents the $i$'th 
#! column of the double complex.
#! I.e., $v_D^{i,j}:=cols[i][j]$.
#! @Arguments rows, cols
#! @Returns a double cochain complex
DeclareOperation( "DoubleCochainComplex", [ IsInfList, IsInfList ] );

#! @Description
#! The input is two functions $R$ and $V$. The output is the double chain complex $D$ defined by 
#! $h_D^{i,j}=H(i,j)$ and $v_D^{i,j}=V(i,j)$.
#! @Arguments H, V
#! @Returns a double cochain complex
DeclareOperation( "DoubleCochainComplex", [ IsFunction, IsFunction ] ); 

#! @Description
#! The input is cochain complex of cochain complexes $C$. The output is the double cochain complex
#! $D$ defined using sign trick. I.e., $h_D^{i,j}=(d_C^i)^j$ and $v_D^{i,j}=(-1)^id_{C^i}^j$.
#! @Arguments C
#! @Returns a double cochain complex
DeclareOperation( "DoubleCochainComplex", [ IsCochainComplex ] );

#! @Description
#! The input is double chain complex $D$. The output is the double cochain complex
#! $E$ defined by $h_E^{i,j}=h^D_{-i,-j}$ and $v_E^{i,j}=v^D_{-i,-j}$.
#! @Arguments C
#! @Returns a double cochain complex
DeclareOperation( "DoubleCochainComplex", [ IsDoubleChainComplex ] );

#! @EndSection

########################################
#
#! @Section  Attributes and operations
#
########################################

DeclareAttribute( "Rows", IsDoubleChainOrCochainComplex );

DeclareAttribute( "Columns", IsDoubleChainOrCochainComplex );

#################################
#
# Exploring the double complexes
#
#################################

#! @Description
#! The input is double chain or cochain complex $D$ and integer $j$. The output is 
#! the infinite list that represents the $j$'th row of $D$.
#! @Arguments D, j
#! @Returns an infinite list
KeyDependentOperation( "CertainRow", IsDoubleChainOrCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is double chain or cochain complex $D$ and integer $i$. The output is 
#! the infinite list that represents the $i$'th column of $D$.
#! @Arguments D, i
#! @Returns an infinite list
KeyDependentOperation( "CertainColumn", IsDoubleChainOrCochainComplex, IsInt, ReturnTrue);

#! @Description
#! The input is double chain or cochain complex $D$ and integers $i,j$. The output is 
#! the object of $D$ in position $(i,j)$.
#! @Arguments D, i, j
#! @Returns an infinite list
DeclareOperation( "CertainObject", [ IsDoubleChainOrCochainComplex, IsInt, IsInt ] );

#! @Description
#! The input is double chain (resp. cochain) complex $D$ and integers $i,j$. The output is 
#! the horizontal differential $h^D_{i,j}$ (resp. $h_D^{i,j}$)
#! @Arguments D, i, j
#! @Returns a morphism
DeclareOperation( "CertainHorizontalMorphism", [ IsDoubleChainOrCochainComplex, IsInt, IsInt ] );

#! @Description
#! The input is double chain (resp. cochain) complex $D$ and integers $i,j$. The output is 
#! the vertical differential $v^D_{i,j}$ (resp. $v_D^{i,j}$)
#! @Arguments D, i, j
#! @Returns a morphism
DeclareOperation( "CertainVerticalMorphism", [ IsDoubleChainOrCochainComplex, IsInt, IsInt ] );

################################
#
# Bounds for double complexes
#
################################

#! @Description
#! Here we can set bounds for the double complex.
#! @Arguments D, i
#! @Group double_1
#! @Returns a morphism
DeclareOperation( "SetAboveBound", [ IsDoubleChainOrCochainComplex, IsInt ] );
#! @Group double_1
#! @Arguments D, i
DeclareOperation( "SetBelowBound", [ IsDoubleChainOrCochainComplex, IsInt ] );
#! @Group double_1
#! @Arguments D, i
DeclareOperation( "SetRightBound", [ IsDoubleChainOrCochainComplex, IsInt ] );
#! @Group double_1
#! @Arguments D, i
DeclareOperation( "SetLeftBound", [ IsDoubleChainOrCochainComplex, IsInt ] );

#! @Description
#! To be able to compute the total complex the double complex we must have one of the following cases:
#! 1. $D$ has left and right bounds.
#! 2. $D$ has below and above bounds.
#! 3. $D$ has left and below bounds.
#! 4. $D$ has right and above bounds.
#! @Group double_2
#! @Arguments D
#! @Returns a morphism
DeclareAttribute( "TotalChainComplex", IsDoubleChainComplex );

#! @Group double_2
#! @Arguments D
DeclareAttribute( "TotalCochainComplex", IsDoubleCochainComplex );
