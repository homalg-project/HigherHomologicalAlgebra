#

#! @Chapter Functors
#! @Section Basic functors for complex categories.

#! @Group f1
#! @Description
#! The first argument in the input must be the chain (resp. cochain) complex category of an abelian category $A$, the second argument is <A>A</A> and 
#! the third argument is an integer <A>n</A>. The output is the $n$'th homology (resp. cohomology) functor $:\mathrm{Ch}(A) \rightarrow A$.
#! @Arguments Ch(A), A, n
#! @Returns a functor
DeclareOperation( "HomologyFunctor", [ IsChainComplexCategory, IsCapCategory, IsInt  ] );
#! @EndGroup
#! @Group f1
#! @Arguments Coch(A), A, n
DeclareOperation( "CohomologyFunctor", [ IsCochainComplexCategory, IsCapCategory, IsInt ] );

#! @Description
#! The inputs are complex category $\mathrm{Comp}(A)$ and an integer. The output is a the endofunctor $T[n]$ that sends any complex $C$ to $C[n]$ and any complex morphism
#! $\phi:C\rightarrow D$ to $\phi[n]:C[n]\rightarrow D[n]$. The shift chain complex $C[n]$ of a chain complex $C$ is defined by $C[n]_i=C_{n+i}, d_{i}^{C[n]}=(-1)^{n}d_{n+i}^{C}$ 
#! and the same for 
#! chain complex morphisms, i.e., $\phi[n]_i=\phi_{n+i}$. The same holds for cochain complexes and morphisms.
#! @Arguments Comp(A), n
#! @Returns a functor
DeclareOperation( "ShiftFunctor", [ IsChainOrCochainComplexCategory, IsInt ] );


#! @Description
#! The inputs are complex category $\mathrm{Comp}(A)$ and an integer. The output is a the endofunctor $T[n]$ that sends any complex $C$ to $C[n]$ and any complex morphism
#! $\phi:C\rightarrow D$ to $\phi[n]:C[n]\rightarrow D[n]$. The shift chain complex $C[n]$ of a chain complex $C$ is defined by $C[n]_i=C_{n+i}, d_{i}^{C[n]}=d_{n+i}^{C}$ 
#! and the same for 
#! chain complex morphisms, i.e., $\phi[n]_i=\phi_{n+i}$. The same holds for cochain complexes and morphisms.
#! @Arguments Comp(A), n
#! @Returns a functor
DeclareOperation( "UnsignedShiftFunctor", [ IsChainOrCochainComplexCategory, IsInt ] );

#! @Description
#! The input is a category <A>A</A>. The output is the functor $F:\mathrm{Ch(A)}\rightarrow\mathrm{Coch(A)}$ defined by $C_{\bullet}\mapsto C^{\bullet}$ for any 
#! for any chain complex $C_{\bullet}\in \mathrm{Ch}(A)$ and by $\phi_{\bullet}\mapsto \phi^{\bullet}$ for any map $\phi$ where $C^{i}=C_{-i}$ and $\phi^{i}=\phi_{-i}$.
#! @Arguments A
#! @Returns a functor
DeclareOperation( "ChainToCochainComplexFunctor", [ IsChainComplexCategory, IsCochainComplexCategory ] );

#! @Description
#! TO CHANGE: The input is a category <A>A</A>. The output is the functor $F:\mathrm{Coch(A)}\rightarrow\mathrm{Ch(A)}$ defined by $C^{\bullet}\mapsto C_{\bullet}$ for any 
#! cochain complex $C^{\bullet}\in \mathrm{Coch}(A)$ and by $\phi^{\bullet}\mapsto \phi_{\bullet}$ for any map $\phi$ where $C_{i}=C^{-i}$ and $\phi_{i}=\phi^{-i}$.
#! @Arguments A
#! @Returns a functor
DeclareOperation( "CochainToChainComplexFunctor", [ IsCochainComplexCategory, IsChainComplexCategory ] );

#! @Description
#! The input is a functor $F:A\rightarrow B$. The output is its extention functor $F:\mathrm{Ch}(A)\rightarrow \mathrm{Ch}(B)$.
#! @Arguments F
#! @Returns a functor
DeclareOperation( "ExtendFunctorToChainComplexCategoryFunctor", [ IsCapFunctor ] );

#! @Description
#! The input is a functor $F:A\rightarrow B$. The output is its extention functor $F:\mathrm{Coch}(A)\rightarrow \mathrm{Coch}(B)$.
#! @Arguments F
#! @Returns a functor
DeclareOperation( "ExtendFunctorToCochainComplexCategoryFunctor", [ IsCapFunctor ] );
#! @EndSection
#! @Section Examples
#! @InsertChunk vec_3

DeclareOperation( "LeftDerivedFunctor", [ IsCapFunctor ] );

DeclareOperation( "RightDerivedFunctor", [ IsCapFunctor ] );

#! @EndSection
