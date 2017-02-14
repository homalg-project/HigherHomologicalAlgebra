#

#! @Chapter Functors
#! @Section Basic functors for complex categories.

#! @Group f1
#! @Description
#! The first argument in the input must be the chain (resp. cochain) complex category of an abelian category $A$, the second argument is <A>A</A> and 
#! the third argument is an integer <A>n</A>. The output is the $n$'th homology (resp. cohomology) functor $:\mathrm{Ch}(A) \rightarrow A$.
#! @Arguments Ch(A), A, n
#! @Returns a functor
DeclareOperation( "HomologyFunctor", [ IsHomotopyCategory, IsCapCategory, IsInt  ] );
#! @EndGroup
#! @Group f1
#! @Arguments Coch(A), A, n
DeclareOperation( "CohomologyFunctor", [ IsHomotopyCategory, IsCapCategory, IsInt ] );

#! @Description
#! The inputs are complex category $\mathrm{Comp}(A)$ and an integer. The output is a the endofunctor $T[n]$ that sends any complex $C$ to $C[n]$ and any complex morphism
#! $\phi:C\rightarrow D$ to $\phi[n]:C[n]\rightarrow D[n]$. The shift chain complex $C[n]$ of a chain complex $C$ is defined by $C[n]_i=C_{n+i}, d_{i}^{C[n]}=(-1)^{n}d_{n+i}^{C}$ 
#! and the same for 
#! chain complex morphisms, i.e., $\phi[n]_i=\phi_{n+i}$. The same holds for cochain complexes and morphisms.
#! @Arguments Comp(A), n
#! @Returns a functor
DeclareOperation( "ShiftFunctor", [ IsHomotopyCategory, IsInt ] );


#! @Description
#! The inputs are complex category $\mathrm{Comp}(A)$ and an integer. The output is a the endofunctor $T[n]$ that sends any complex $C$ to $C[n]$ and any complex morphism
#! $\phi:C\rightarrow D$ to $\phi[n]:C[n]\rightarrow D[n]$. The shift chain complex $C[n]$ of a chain complex $C$ is defined by $C[n]_i=C_{n+i}, d_{i}^{C[n]}=d_{n+i}^{C}$ 
#! and the same for 
#! chain complex morphisms, i.e., $\phi[n]_i=\phi_{n+i}$. The same holds for cochain complexes and morphisms.
#! @Arguments Comp(A), n
#! @Returns a functor
DeclareOperation( "UnsignedShiftFunctor", [ IsHomotopyCategory, IsInt ] );

DeclareOperation( "ChainToCochainComplexFunctor", [ IsHomotopyCategory, IsHomotopyCategory ] );

DeclareOperation( "CochainToChainComplexFunctor", [ IsHomotopyCategory, IsHomotopyCategory ] );

DeclareOperation( "ExtendFunctorToChainHomotopyCategoryFunctor", [ IsCapFunctor ] );

DeclareOperation( "ExtendFunctorToCochainHomotopyCategoryFunctor", [ IsCapFunctor ] );

# DeclareOperation( "LeftDerivedFunctor", [ IsCapFunctor ] );

# DeclareOperation( "RightDerivedFunctor", [ IsCapFunctor ] );


