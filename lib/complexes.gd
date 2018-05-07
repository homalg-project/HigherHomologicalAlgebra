#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
#! @Chapter Complexes
##
#############################################################################

#! @Section Categories and filters

#########################################
#
# Categories and filters
#
#########################################

#! @BeginGroup 0
#! @Description
#! Gap-categories for chain and cochain complexes. 
#! @Arguments C
DeclareCategory( "IsChainOrCochainComplex", IsCapCategoryObject );
#! @Arguments C
DeclareCategory( "IsChainComplex", IsChainOrCochainComplex );
#! @Arguments C
DeclareCategory( "IsCochainComplex", IsChainOrCochainComplex );
#! @Arguments C
DeclareCategory( "IsBoundedBelowChainOrCochainComplex", IsChainOrCochainComplex );
#! @Arguments C
DeclareCategory( "IsBoundedAboveChainOrCochainComplex", IsChainOrCochainComplex );
#! @Arguments C
DeclareCategory( "IsBoundedChainOrCochainComplex", IsBoundedBelowChainOrCochainComplex and IsBoundedAboveChainOrCochainComplex );
#! @Arguments C
DeclareCategory( "IsBoundedBelowChainComplex", IsBoundedBelowChainOrCochainComplex and IsChainComplex ); 
#! @Arguments C
DeclareCategory( "IsBoundedAboveChainComplex", IsBoundedAboveChainOrCochainComplex and IsChainComplex ); 
#! @Arguments C
DeclareCategory( "IsBoundedChainComplex", IsBoundedChainOrCochainComplex and IsChainComplex ); 
#! @Arguments C
DeclareCategory( "IsBoundedBelowCochainComplex", IsBoundedBelowChainOrCochainComplex and IsCochainComplex ); 
#! @Arguments C
DeclareCategory( "IsBoundedAboveCochainComplex", IsBoundedAboveChainOrCochainComplex and IsCochainComplex ); 
#! @Arguments C
DeclareCategory( "IsBoundedCochainComplex", IsBoundedChainOrCochainComplex and IsCochainComplex ); 
#! @EndGroup
#! @Group 0

#########################################
#
#  Constructors of (Co)chain complexes 
#
#########################################

#! @Section Creating chain and cochain complexes

DeclareOperation( "ChainComplex", [ IsCapCategory, IsZList, IsBool ] );
DeclareOperation( "CochainComplex", [ IsCapCategory, IsZList, IsBool ] );

#! @BeginGroup 1
#! @Description
#! The input is category <A>A</A> and an infinite list <A>diffs</A>. The output is the chain (resp. cochain) complex $M_{\bullet}\in \mathrm{Ch}(A)$
#! ($M^{\bullet}\in \mathrm{Ch}^\bullet(A)$) where $d^M_{i}=\mathrm{diffs}[ i ]$($d_M^{i}=\mathrm{diffs}[ i ]$).
#! @Arguments A, diffs
#! @Returns a chain complex
DeclareOperation( "ChainComplex", [ IsCapCategory, IsZList ] );
#! @EndGroup
#! @Group 1
#! @Arguments A, diffs
DeclareOperation( "CochainComplex", [ IsCapCategory, IsZList ] );


#! @BeginGroup 2
#! @Description
#! The input is a finite dense list <A>diffs</A> and an integer <A>n</A> . The output is the chain (resp. cochain) complex 
#! $M_{\bullet}\in \mathrm{Ch}(A)$ ($M^{\bullet}\in \mathrm{Ch}^\bullet(A)$) where 
#! $d^M_{n}:= \mathrm{diffs}[ 1 ](d_M^n :=\mathrm{diffs}[ 1 ]),d^M_{n+1}=\mathrm{diffs}[ 2 ](d_M^{n+1}:=\mathrm{diffs}[ 2 ])$, etc.
#! @Arguments diffs, n
#! @Returns a (co)chain complex
DeclareOperation( "ChainComplex", [ IsDenseList, IsInt ] );
#! @EndGroup
#! @Group 2
#! @Arguments diffs, n
DeclareOperation( "CochainComplex", [ IsDenseList, IsInt ] );

#! @BeginGroup 3
#! @Description
#! The same as the previous operations but with $n=0$.
#! @Arguments diffs
#! @Returns a (co)chain complex
DeclareOperation( "ChainComplex", [ IsDenseList ] );
#! @EndGroup
#! @Group 3
#! @Arguments diffs
DeclareOperation( "CochainComplex", [ IsDenseList ] );

#! @BeginGroup 4
#! @Description
#! The input is an object $M\in A$. The output is chain (resp. cochain) complex $M_{\bullet}\in\mathrm{Ch}_\bullet(A)(M^{\bullet}\in\mathrm{Ch}^\bullet(A))$
#! where $M_n=M( M^n=M)$ and $M_i=0(M^i=0)$ whenever $i\neq n$.
#! @Arguments diffs, n
#! @Returns a (co)chain complex
DeclareOperation( "StalkChainComplex", [ IsCapCategoryObject, IsInt ] );
#! @EndGroup
#! @Group 4
#! @Arguments diffs, n
DeclareOperation( "StalkCochainComplex", [ IsCapCategoryObject, IsInt ] );

#! @InsertChunk 3
#! @Description
#! The input is a morphism $d\in A$ and two functions $F,G$. 
#! The output is chain complex $M_{\bullet}\in\mathrm{Ch}_\bullet(A)$ where $d^{M}_{0}=d$ 
#! and $d^M_{i}=G^{i}(d)$ for all $i\leq -1$ and $d^M_{i}=F^{i}(d )$ for all $i \geq 1$.
#! @Arguments d,G,F
#! @Returns a chain complex
DeclareOperation( "ChainComplexWithInductiveSides", [ IsCapCategoryMorphism, IsFunction, IsFunction ] );

#! @Description
#! The input is a morphism $d\in A$ and two functions $F,G$. 
#! The output is cochain complex $M^{\bullet}\in\mathrm{Ch}^\bullet(A)$ where $d_{M}^{0}=d$ 
#! and $d_M^{i}=G^{i}( d)$ for all $i\leq -1$ and $d_M^{i}=F^{i}( d )$ for all $i \geq 1$.
#! @Arguments d,G,F
#! @Returns a cochain complex
DeclareOperation( "CochainComplexWithInductiveSides", [ IsCapCategoryMorphism, IsFunction, IsFunction ] );

#! @Description
#! The input is a morphism $d\in A$ and a functions $G$. 
#! The output is chain complex $M_{\bullet}\in\mathrm{Ch}_\bullet(A)$ where $d^{M}_{0}=d$ 
#! and $d^M_{i}=G^{i}( d )$ for all $i\leq -1$ and $d^M_{i}=0$ for all $i \geq 1$.
#! @Arguments d,G
#! @Returns a chain complex
DeclareOperation( "ChainComplexWithInductiveNegativeSide", [ IsCapCategoryMorphism, IsFunction ] );

#! @Description
#! The input is a morphism $d\in A$ and a functions $F$. 
#! The output is chain complex $M_{\bullet}\in\mathrm{Ch}_\bullet(A)$ where $d^{M}_{0}=d$ 
#! and $d^M_{i}=F^{i}( d )$ for all $i\geq 1$ and $d^M_{i}=0$ for all $i \leq 1$.
#! @Arguments d,F
#! @Returns a chain complex
DeclareOperation( "ChainComplexWithInductivePositiveSide", [ IsCapCategoryMorphism, IsFunction ] );

#! @Description
#! The input is a morphism $d\in A$ and a functions $G$. 
#! The output is cochain complex $M^{\bullet}\in\mathrm{Ch}^\bullet(A)$ where $d_{M}^{0}=d$ 
#! and $d_M^{i}=G^{i}( d )$ for all $i\leq -1$ and $d_M^{i}=0$ for all $i \geq 1$.
#! @Arguments d,G
#! @Returns a cochain complex
DeclareOperation( "CochainComplexWithInductiveNegativeSide", [ IsCapCategoryMorphism, IsFunction ] );

#! @Description
#! The input is a morphism $d\in A$ and a functions $F$. 
#! The output is cochain complex $M^{\bullet}\in\mathrm{Ch}^\bullet(A)$ where $d_{M}^{0}=d$ 
#! and $d_M^{i}=F^{i}( d )$ for all $i\geq 1$ and $d_M^{i}=0$ for all $i \leq 1$.
#! @Arguments d,F
#! @Returns a cochain complex
DeclareOperation( "CochainComplexWithInductivePositiveSide", [ IsCapCategoryMorphism, IsFunction ] );
#! @EndSection

#########################################
#
# Attributes of (co)chain complexes
#
#########################################

#! @Section Attributes

#! @Description
#! The command returns the differentials of the chain or cochain complex as an infinite list.
#! @Arguments C
#! @Returns an infinite list
DeclareAttribute( "Differentials", IsChainOrCochainComplex );

#! @Description
#! The command returns the objects of the chain or cochain complex as an infinite list.
#! @Arguments C
#! @Returns an infinite list
DeclareAttribute( "Objects", IsChainOrCochainComplex );

#! @Description
#! The command returns the category in which all objects and differentials of $C$ live.
#! @Arguments C
#! @Returns a Cap category
DeclareAttribute( "CatOfComplex", IsChainOrCochainComplex );
#! @EndSection

DeclareProperty( "IsExact", IsChainOrCochainComplex );

# These two attributes and properties will be used to activate to do lists.
# FAU_BOUND means first active upper bound. FAL_BOUND is for lower bound.
# They are written only for internal use.
DeclareAttribute( "FAU_BOUND", IsChainOrCochainComplex );

DeclareAttribute( "FAL_BOUND", IsChainOrCochainComplex );

DeclareProperty( "HAS_FAU_BOUND", IsChainOrCochainComplex );

DeclareProperty( "HAS_FAL_BOUND", IsChainOrCochainComplex );

#########################################
#
# operations derived from Attributes
#
#########################################
KeyDependentOperation( "ObjectAt", IsChainOrCochainComplex, IsInt, ReturnTrue );

#! @Section Operations

#! @Description
#! The command returns the object of the chain or cochain complex in index $i$.
#! @Arguments C, i
#! @Returns an object
# DeclareOperation( "\[\]", [ IsChainOrCochainComplex, IsInt ] );

KeyDependentOperation( "DifferentialAt", IsChainOrCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The command returns the differential of the chain or cochain complex in index $i$.
#! @Arguments C, i
#! @Returns a morphism
DeclareOperation( "\^", [ IsChainOrCochainComplex, IsInt ] );

#! @Description
#! The input is a chain or cochain complex $C$ and an integer $n$. The output is the kernel embedding of the differential in index $n$.
#! @Arguments C, n
#! @Returns a morphism
KeyDependentOperation( "CyclesAt", IsChainOrCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a chain (resp. cochain) complex $C$ and an integer $n$. The output is the image embeddin of $i+1$'th ( resp. $i-1$'th) differential of $C$.
#! @Arguments C, n
#! @Returns a morphism
KeyDependentOperation( "BoundariesAt", IsChainOrCochainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "HomologyAt", IsChainComplex, IsInt, ReturnTrue );


KeyDependentOperation( "CohomologyAt", IsCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a chain (resp. cochain) complex $C$ and an integer $n$. The outout is the homology (resp. cohomology)
#! object of $C$ in index $n$.
#! @Arguments C, n
#! @Returns a object
KeyDependentOperation( "DefectOfExactnessAt", IsChainOrCochainComplex, IsInt, ReturnTrue );

#! @BeginGroup 100
#! @Description
#! The input is a chain (resp. cochain) complex $C$ and two integers $m,n$. The outout is the list of indices where 
#! the homology (resp. cohomology) object of $C$ is not zero.
#! @Arguments C, m, n
#! @Returns a list
DeclareOperation( "HomologySupport", [ IsChainComplex, IsInt, IsInt ] );
#! @EndGroup
#! @Group 100
#! @Arguments C, m, n
DeclareOperation( "CohomologySupport", [ IsCochainComplex, IsInt, IsInt ] );

#! @Description
#! The input is a chain (resp. cochain) complex $C$ and two integers $m,n$. 
#! The output is true when $C$ is a complex and false otherwise.
#! @Arguments C, n
#! @Returns a object
DeclareOperation( "IsWellDefined", [ IsChainOrCochainComplex, IsInt, IsInt ] );
# DeclareProperty( "IsWellDefined", IsBoundedChainOrCochainComplex );

#! @Description
#! The input is a chain or cochain complex $C$ and an integer $n$. The outout is <A>true</A> if $C$ is exact in $i$. Otherwise the output is <A>false</A>.
#! @Arguments C, n
#! @Returns true or false
KeyDependentOperation( "IsExactInIndex", IsChainOrCochainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "ShiftLazy", IsChainOrCochainComplex, IsInt, ReturnTrue );

KeyDependentOperation( "ShiftUnsignedLazy", IsChainOrCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The command sets an upper bound $n$ to the chain (resp. cochain) complex $C$. 
#! This means $C_{i\geq n}=0(C^{\geq n}=0)$. This upper bound will be called $\textit{active}$ upper bound of $C$. 
#! If $C$ already has an active upper bound $m$, then $m$ will be replaced by $n$ only if $n$ is better upper bound 
#! than $m$, i.e., $n\leq m$. If $C$ has an active lower bound $l$
#! and $n\leq l$ then the upper bound will set to equal $l$ and as a consequence $C$ will be set to zero.
#! @Arguments C, n
#! @Returns Side effect
DeclareOperation( "SetUpperBound", [ IsChainOrCochainComplex, IsInt ] );

#! @Description
#! The command sets an lower bound $n$ to the chain (resp. cochain) complex $C$. 
#! This means $C_{i\leq n}=0(C^{\leq n}=0)$. This lower bound will be called $\textit{active}$ lower bound of $C$. 
#! If $C$ already has an active lower bound $m$, then $m$ will be replaced by $n$ only if $n$ is better lower
#! bound than $m$, i.e., $n\geq m$. If $C$ has an active upper bound $u$
#! and $n\geq u$ then the lower bound will set to equal $u$ and as a consequence $C$ will be set to zero.
#! @Arguments C, n
#! @Returns Side effect
DeclareOperation( "SetLowerBound", [ IsChainOrCochainComplex, IsInt ] );

#! @Description
#! The input is chain or cochain complex. The output is <A>true</A> if an upper bound has been set to $C$ and <A>false</A> otherwise.
#! @Arguments C
#! @Returns true or false
DeclareOperation( "HasActiveUpperBound", [ IsChainOrCochainComplex ] );

#! @Description
#! The input is chain or cochain complex. The output is <A>true</A> if a lower bound has been set to $C$ and <A>false</A> otherwise.
#! @Arguments C
#! @Returns true or false
DeclareOperation( "HasActiveLowerBound", [ IsChainOrCochainComplex ] );

#! @Description
#! The input is chain or cochain complex. The output is its active upper bound if such has been set to $C$. Otherwise we get error.
#! @Arguments C
#! @Returns an integer
DeclareOperation( "ActiveUpperBound", [ IsChainOrCochainComplex ] );

#! @Description
#! The input is chain or cochain complex. The output is its active lower bound if such has been set to $C$. Otherwise we get error.
#! @Arguments C
#! @Returns an integer
DeclareOperation( "ActiveLowerBound", [ IsChainOrCochainComplex ] );

#! @Description
#! The input is chain or cochain complex $C$ and two integers $m$ and $n$. The command displays all components of $C$ between the indices $m,n$.
#! @Arguments C, m, n
#! @Returns nothing
DeclareOperation( "Display", [ IsChainOrCochainComplex, IsInt, IsInt ] );

#! @EndSection

#! @Section Truncations

#! @Description
#! @BeginLatexOnly
#! Let $C_\bullet$ be chain complex. A good truncation of $C_\bullet$ below $n$ is the chain 
#! complex $\tau_{\geq n}C_\bullet$ whose differentials are defined by
#! $$d_i^{\tau_{\geq n}C_\bullet} = 
#!     \begin{cases}
#!        0:0\leftarrow 0 & \quad \text{if}\quad i<n, \\
#!        0:0\leftarrow Z_n & \quad \text{if}\quad i=n,\\
#!        \mathrm{KernelLift}( d^C_n, d^C_{n+1} ):Z_n\leftarrow C_{n+1} & \quad \text{if}\quad i=n+1,\\
#!        d^C_i:C_{i-1}\leftarrow C_{i}& \quad \text{if}\quad i>n+1.
#!     \end{cases}$$
#! where $Z_n$ is the cycle in index $n$. It can be shown that $H_i(\tau_{\geq n}C_\bullet)=0$ for $i<n$
#! and $H_i(\tau_{\geq n}C_\bullet)=H_i( C_\bullet)$ for $i\geq n$.
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=1em,column sep=3em,minimum width=2em]
#!   {
#!          C_\bullet       &   \cdots   & C_{n-1} & C_{n} & C_{n+1} & C_{n+2} & \cdots\\
#!   \tau_{\geq n}C_\bullet &   \cdots   & 0_{\phantom{n}} & Z_{n} &  &  &  \\};
#!   \path[-stealth]
#!     (m-1-3) edge (m-1-2)
#!     (m-1-4) edge (m-1-3)
#!     (m-1-5) edge (m-1-4)
#!     (m-1-6) edge[ blue, thick ] (m-1-5)
#!     (m-1-7) edge[ blue, thick ] (m-1-6)
#!     (m-2-4) edge[>->] (m-1-4)
#!     (m-1-5) edge[ blue, thick ] (m-2-4)
#!     (m-2-3) edge[ blue, thick ] (m-2-2)
#!     (m-2-4) edge[ blue, thick ] (m-2-3);
#!
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! @Arguments C, n
#! @Returns chain complex
KeyDependentOperation( "GoodTruncationBelow", IsChainComplex, IsInt, ReturnTrue );

#! @Description
#! @BeginLatexOnly
#! Let $C_\bullet$ be chain complex. A good truncation of $C_\bullet$ above $n$ is the quotient chain 
#! complex $\tau_{<n}C_\bullet=C_\bullet/\tau_{\geq n}C_\bullet$. 
#!  It can be shown that $H_i(\tau_{<n}C_\bullet)=0$ for $i\geq n$
#! and $H_i(\tau_{<n}C_\bullet)=H_i( C_\bullet)$ for $i<n$.
#! @EndLatexOnly
#! @Arguments C, n
#! @Returns chain complex
KeyDependentOperation( "GoodTruncationAbove", IsChainComplex, IsInt, ReturnTrue );

#! @Description
#! @BeginLatexOnly
#! Let $C^\bullet$ be cochain complex. A good truncation of $C^\bullet$ above $n$ is the cochain 
#! complex $\tau^{\leq n}C^\bullet$ whose differentials are defined by
#! $$d^i_{\tau^{\leq n}C^\bullet} = 
#!     \begin{cases}
#!        0:0\rightarrow 0 & \quad \text{if}\quad i>n, \\
#!        0:Z^n\rightarrow 0 & \quad \text{if}\quad i=n,\\
#!        \mathrm{KernelLift}( d_C^n, d_C^{n-1} ):C^{n-1}\rightarrow Z^n & \quad \text{if}\quad i=n-1,\\
#!        d_C^i:C^{i}\rightarrow C^{i+1}& \quad \text{if}\quad i<n-1.
#!     \end{cases}$$
#! where $Z_n$ is the cycle in index $n$. It can be shown that $H^i(\tau^{\leq n}C^\bullet)=0$ for $i>n$
#! and $H^i(\tau^{\leq n}C^\bullet)=H_i( C^\bullet)$ for $i\leq n$.
#! \begin{center}
#! \begin{tikzpicture}
#!   \matrix (m) [matrix of math nodes,row sep=1em,column sep=3em,minimum width=2em]
#!   {
#!           &   \phantom{C^{n}}\cdots   &C^{n-2}& C^{n-1} & C^{n} & C^{n+1} & \cdots\phantom{C^{n}} & C^\bullet\\
#!    &      & & & Z^n & 0 & \cdots\phantom{C^{n}} & \tau^{\leq n}C^\bullet \\};
#!   \path[-stealth]
#!     (m-1-2) edge[blue, thick] (m-1-3)
#!     (m-1-3) edge[blue, thick] (m-1-4)
#!     (m-1-4) edge (m-1-5)
#!     (m-1-5) edge (m-1-6)
#!     (m-2-5) edge[>->] (m-1-5)
#!     (m-2-5) edge[blue, thick] (m-2-6)
#!     (m-2-6) edge[blue, thick] (m-2-7)
#!     (m-1-4) edge[blue, thick] (m-2-5)
#!     (m-1-6) edge (m-1-7);
#!
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! @Arguments C, n
#! @Returns
KeyDependentOperation( "GoodTruncationAbove", IsCochainComplex, IsInt, ReturnTrue );

#! @Description
#! @BeginLatexOnly
#! Let $C^\bullet$ be cochain complex. A good truncation of $C^\bullet$ below $n$ is the quotient cochain 
#! complex $\tau^{>n}C^\bullet=C^\bullet/\tau^{\leq n}C^\bullet$.
#!  It can be shown that $H^i(\tau^{>n}C^\bullet)=0$ for $i\leq n$
#! and $H^i(\tau^{>n}C^\bullet)=H_i( C^\bullet)$ for $i>n$.
#! @EndLatexOnly
#! @Arguments C, n
#! @Returns cochain complex
KeyDependentOperation( "GoodTruncationBelow", IsCochainComplex, IsInt, ReturnTrue );

#! @Description
#! @BeginLatexOnly
#! Let $C_\bullet$ be chain complex. A brutal truncation of $C_\bullet$ below $n$ is the chain 
#! complex $\sigma_{\geq n}C_\bullet$ where $(\sigma_{\geq n}C_\bullet)_i=C_i$ when 
#! $i\geq n$ and $(\sigma_{\geq n}C_\bullet)_i=0$ otherwise.
#! @EndLatexOnly
#! @Arguments C, n
#! @Returns chain complex
KeyDependentOperation( "BrutalTruncationBelow", IsChainComplex, IsInt, ReturnTrue );


#! @Description
#! @BeginLatexOnly
#! Let $C_\bullet$ be chain complex. A brutal truncation of $C_\bullet$ above $n$ is the chain 
#! quotient chain complex $\sigma_{<n}C_\bullet:=C_\bullet/\sigma_{\geq n}C_\bullet$.
#! Hence $(\sigma_{<n}C_\bullet)_i=C_i$ when 
#! $i< n$ and $(\sigma_{< n}C_\bullet)_i=0$ otherwise.
#! @EndLatexOnly
#! @Arguments C, n
#! @Returns chain complex
KeyDependentOperation( "BrutalTruncationAbove", IsChainComplex, IsInt, ReturnTrue );

#! @Description
#! @BeginLatexOnly
#! Let $C^\bullet$ be cochain complex. A brutal truncation of $C_\bullet$ above $n$ is the cochain 
#! complex $\sigma^{\leq n}C^\bullet$ where $(\sigma^{\leq n}C^\bullet)_i=C_i$ when 
#! $i\leq n$ and $(\sigma^{\leq n}C^\bullet)_i=0$ otherwise.
#! @EndLatexOnly
#! @Arguments C, n
#! @Returns chain complex
KeyDependentOperation( "BrutalTruncationAbove", IsCochainComplex, IsInt, ReturnTrue );

#! @Description
#! @BeginLatexOnly
#! Let $C^\bullet$ be cochain complex. A brutal truncation of $C^\bullet$ bellow $n$ is the
#! quotient cochain complex $\sigma^{>n}C^\bullet:=C^\bullet/\sigma^{\leq n}C_\bullet$.
#! Hence $(\sigma^{>n}C^\bullet)_i=C_i$ when 
#! $i> n$ and $(\sigma^{< n}C^\bullet)_i=0$ otherwise.
#! @EndLatexOnly
#! @Arguments C, n
#! @Returns chain complex
KeyDependentOperation( "BrutalTruncationBelow", IsCochainComplex, IsInt, ReturnTrue );
#! @EndSection

#! @Section Examples
#! @InsertChunk vec_1
# @InsertChunk complexes_example_2
#! @EndSection

##############################################
#
# Methods to maintain upper and lower bounds
#
##############################################

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_FIRST_UPPER_BOUND" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_FIRST_LOWER_BOUND" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_BOUNDS" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_PULL_FIRST_UPPER_BOUND" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_PULL_FIRST_LOWER_BOUND" );

DeclareGlobalFunction( "TODO_LIST_TO_PUSH_PULL_BOUNDS" );

DeclareGlobalFunction( "TODO_LIST_TO_CHANGE_COMPLEX_FILTERS_WHEN_NEEDED" );
