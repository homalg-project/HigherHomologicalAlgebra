#! @Chapter Double complexes
#! @Section Categories and filters

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
#! @BeginLatexOnly
#!  Let $\mathcal{A}$ be an additive category.
#!  A {\it double chain complex} in $\mathcal{A}$ is given
#!  by a system $(\{D_{i, j}, h^D_{i, j}, v^D_{i, j}\}_{i, j\in \mathbf{Z}})$,
#!  where each $D_{i, j}$ is an object of $\mathcal{A}$ and
#!  $h^D_{i, j} : D_{i, j} \to D_{i - 1, j}$ and
#!  $v^D_{i, j} : D_{i, j} \to D_{i, j - 1}$ are morphisms of $\mathcal{A}$
#!  such that the following rules hold:
#!  \begin{enumerate}
#!  \item $h^D_{i - 1, j} \circ h^D_{i, j} = 0$
#!  \item $v^D_{i, j - 1} \circ v^D_{i, j} = 0$
#!  \item $h^D_{i, j - 1} \circ v^D_{i, j} + v^D_{i - 1, j} \circ h^D_{i, j}=0$
#!  \end{enumerate}
#!  for all $i, j \in \mathbf{Z}$.
#!
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=3em,column sep=3em,minimum width=2em]
#!   {
#!    &      & \vdots & \vdots &  &\\
#!    &   \phantom{D_{n}}\cdots   & D_{i-1,j} & D_{i,j} & \cdots\phantom{D_{n}} & row_{j}\\
#!    &   \phantom{D_{n}}\cdots   & D_{i-1,j-1} & D_{i,j-1} & \cdots\phantom{D_{n}} & row_{j-1}\\ 
#!    &      & \vdots & \vdots &  &\\
#!    &      & col_{i-1} & col_{i} &  &\\};
#!   \path[-stealth]
#!     (m-2-2) edge[ <-,thick] (m-2-3)
#!     (m-2-3) edge[ <-,thick] node[above]{$h^D_{i,j}$}(m-2-4)
#!     (m-2-4) edge[ <-,thick] (m-2-5)
#!     (m-3-2) edge[ <-,thick] (m-3-3)
#!     (m-3-3) edge[ <-,thick] (m-3-4)
#!     (m-3-4) edge[ <-,thick] (m-3-5)
#!     (m-2-3) edge[ <-,thick] (m-1-3)
#!     (m-2-4) edge[ <-,thick] (m-1-4)
#!     (m-3-3) edge[ <-,thick] (m-2-3)
#!     (m-3-4) edge[ <-,thick] node[right]{$v^D_{i,j}$}(m-2-4)
#!     (m-4-3) edge[ <-,thick] (m-3-3)
#!     (m-4-4) edge[ <-,thick] (m-3-4)
#! ;
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly

#! @Description
#! The input is a Cap category $\mathcal{A}$ and two infinite lists $rows$ and $cols$. The entry in index $j$ of $rows$ should 
#! be an infinite list that represents 
#! the $j$'th row of the double complex. I.e., $h^D_{i,j}:= rows[j][i]$ for all $i\in\mathbb{Z}$. 
#! Again, the entry in index $i$ of $cols$ should be an infinite list that represents the $i$'th 
#! column of the double complex.
#! I.e., $v^D_{i,j}:=cols[i][j]$.
#! @Arguments A, rows, cols
#! @Returns a double chain complex
DeclareOperation( "DoubleChainComplex", [ IsCapCategory, IsInfList, IsInfList ] );

#! @Description
#! The input is a Cap category $\mathcal{A}$ and  two functions $R$ and $V$. The output is the double chain complex $D$ defined by 
#! $h^D_{i,j}=H(i,j)$ and $v^D_{i,j}=V(i,j)$.
#! @Arguments A, H, V
#! @Returns a double chain complex
DeclareOperation( "DoubleChainComplex", [ IsCapCategory, IsFunction, IsFunction ] );

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

#! @BeginLatexOnly
#!  Let $\mathcal{A}$ be an additive category.
#!  A {\it double cochain complex} in $\mathcal{A}$ is given
#!  by a system $(\{D^{i, j}, h_D^{i, j}, v_D^{i, j}\}_{i, j\in \mathbf{Z}})$,
#!  where each $D^{i, j}$ is an object of $\mathcal{A}$ and
#!  $h_D^{i, j} : D^{i, j} \to D^{i + 1, j}$ and
#!  $v_D^{i, j} : D^{i, j} \to D^{i, j + 1}$ are morphisms of $\mathcal{A}$
#!  such that the following rules hold:
#!  \begin{enumerate}
#!  \item $h_D^{i + 1, j} \circ h_D^{i, j} = 0$
#!  \item $v_D^{i, j + 1} \circ v_D^{i, j} = 0$
#!  \item $h_D^{i, j + 1} \circ v_D^{i, j} + v_D^{i + 1, j} \circ h_D^{i, j}=0$
#!  \end{enumerate}
#!  for all $i, j \in \mathbf{Z}$.
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=3em,column sep=3em,minimum width=2em]
#!   {
#!    &      & \vdots & \vdots &  &\\
#!    &   \phantom{D^{i}}\cdots   & D^{i,j+1} & D^{i+1,j+1} & \cdots\phantom{D^{i}} & row_{j+1}\\
#!    &   \phantom{D^{i}}\cdots   & D^{i,j} & D^{i+1,j} & \cdots\phantom{D^{i}} & row_j\\ 
#!    &      & \vdots & \vdots &  &\\
#!    &      & col_i & col_{i+1} &  &\\};
#!   \path[-stealth]
#!     (m-2-2) edge[ thick] (m-2-3)
#!     (m-2-3) edge[ thick] (m-2-4)
#!     (m-2-4) edge[ thick] (m-2-5)
#!     (m-3-2) edge[ thick] (m-3-3)
#!     (m-3-3) edge[ thick] node[above]{$h_D^{i,j}$}(m-3-4)
#!     (m-3-4) edge[ thick] (m-3-5)
#!     (m-2-3) edge[ thick] (m-1-3)
#!     (m-2-4) edge[ thick] (m-1-4)
#!     (m-3-3) edge[ thick] node[left]{$v_D^{i,j}$}(m-2-3)
#!     (m-3-4) edge[ thick] (m-2-4)
#!     (m-4-3) edge[ thick] (m-3-3)
#!     (m-4-4) edge[ thick] (m-3-4)
#! ;
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly


#! @Description
#! The input is a Cap category $\mathcal{A}$ and  two infinite lists $rows$ and $cols$. The entry in index $j$ of $rows$ should 
#! be an infinite list that represents 
#! the $j$'th row of the double complex. I.e., $h_D^{i,j}:= rows[j][i]$ for all $i\in\mathbb{Z}$. 
#! Again, the entry in index $i$ of $cols$ should be an infinite list that represents the $i$'th 
#! column of the double complex.
#! I.e., $v_D^{i,j}:=cols[i][j]$.
#! @Arguments A, rows, cols
#! @Returns a double cochain complex
DeclareOperation( "DoubleCochainComplex", [ IsCapCategory, IsInfList, IsInfList ] );

#! @Description
#! The input is a Cap category $\mathcal{A}$ and two functions $R$ and $V$. The output is the double chain complex $D$ defined by 
#! $h_D^{i,j}=H(i,j)$ and $v_D^{i,j}=V(i,j)$.
#! @Arguments A, H, V
#! @Returns a double cochain complex
DeclareOperation( "DoubleCochainComplex", [ IsCapCategory, IsFunction, IsFunction ] ); 

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

#! @Description
#!  The input is double chain or cochain complex $D$.
#!  The output is the infinite list of rows.
#! @Arguments D
#! @Returns an infinite list of infinite lists.
DeclareAttribute( "Rows", IsDoubleChainOrCochainComplex );

#! @Description
#!  The input is double chain or cochain complex $D$.
#!  The output is the infinite list of columns.
#! @Arguments D
#! @Returns an infinite list of infinite lists.
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
DeclareOperation( "ObjectAt", [ IsDoubleChainOrCochainComplex, IsInt, IsInt ] );

#! @Description
#! The input is double chain (resp. cochain) complex $D$ and integers $i,j$. The output is 
#! the horizontal differential $h^D_{i,j}$ (resp. $h_D^{i,j}$)
#! @Arguments D, i, j
#! @Returns a morphism
DeclareOperation( "HorizontalDifferentialAt", [ IsDoubleChainOrCochainComplex, IsInt, IsInt ] );

#! @Description
#! The input is double chain (resp. cochain) complex $D$ and integers $i,j$. The output is 
#! the vertical differential $v^D_{i,j}$ (resp. $v_D^{i,j}$)
#! @Arguments D, i, j
#! @Returns a morphism
DeclareOperation( "VerticalDifferentialAt", [ IsDoubleChainOrCochainComplex, IsInt, IsInt ] );

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

DeclareAttribute( "CatOfDoubleComplex", IsDoubleChainOrCochainComplex );