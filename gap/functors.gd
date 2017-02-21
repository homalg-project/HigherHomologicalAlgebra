#

#! @Chapter Functors
#! @Section Basic functors for homotopy categories.

#! @Description
#! The arguments are $\mathrm{Ch}_\bullet(A),\mathrm{H}_\bullet(A)$ or $\mathrm{Ch}^\bullet(A),\mathrm{H}^\bullet(A)$ for 
#! some additive category $A$. The output
#! is the natural quotient functor $h:\mathrm{Ch}(A)\rightarrow\mathrm{H}(A)$.
#! @Arguments Ch(A), H(A)
#! @Returns a functor
DeclareOperation( "NaturalQuotientFunctor", [ IsChainOrCochainComplexCategory, IsHomotopyCategory ] );


#! @Group f1
#! @Description
#! The first argument in the input must be the chain (resp. cochain) homotopy category of an additive category $A$, 
#! the second argument is <A>A</A> and 
#! the third argument is an integer <A>n</A>. The output is the $n$'th homology (resp. cohomology) functor $:\mathrm{H}(A) \rightarrow A$.
#! @Arguments H(A), A, n
#! @Returns a functor
DeclareOperation( "HomologyFunctor", [ IsHomotopyCategory, IsCapCategory, IsInt  ] );
#! @EndGroup
#! @Group f1
#! @Arguments H(A), A, n
DeclareOperation( "CohomologyFunctor", [ IsHomotopyCategory, IsCapCategory, IsInt ] );

#! @Description
#! The inputs are homotopy category $\mathrm{H}(A)$ of an additive category $A$ and an integer $n$. The output is a the endofunctor $T[n]$ that sends any complex $C$ to $C[n]$ and any complex morphism
#! $\phi:C\rightarrow D$ to $\phi[n]:C[n]\rightarrow D[n]$.
#! @Arguments H(A), n
#! @Returns a functor
DeclareOperation( "ShiftFunctor", [ IsHomotopyCategory, IsInt ] );


#! @Description
#! The inputs are homotopy category $\mathrm{H}(A)$ of an additive category $A$ and an integer $n$. The output is a the endofunctor $T(n)$ that sends any complex $C$ to $C(n)$ and any complex morphism
#! $\phi:C\rightarrow D$ to $\phi(n):C(n)\rightarrow D(n)$. The unsigned shift chain complex $C(n)$ of a chain complex $C$ is defined by $C(n)_i=C_{n+i}, d_{i}^{C(n)}=d_{n+i}^{C}$ 
#! and the same for 
#! chain complex morphisms, i.e., $\phi(n)_i=\phi_{n+i}$. The same holds for cochain complexes and morphisms. 
#! @Arguments H(A), n
#! @Returns a functor
DeclareOperation( "UnsignedShiftFunctor", [ IsHomotopyCategory, IsInt ] );

#! @Description
#! The arguments are $\mathrm{H}_\bullet(A), \mathrm{H}^\bullet(A)$ of an additive category $A$. The output is the functor 
#! $F:\mathrm{H}_\bullet(A)\rightarrow\mathrm{H}^\bullet(A)$ defined by $C_{\bullet}\mapsto C^{\bullet}$ for any 
#! for any chain complex $C_{\bullet}\in \mathrm{H}_\bullet(A)$ and by $\phi_{\bullet}\mapsto \phi^{\bullet}$ for any map $\phi_\bullet\in \mathrm{H}_\bullet(A)$ where $C^{i}=C_{-i}$ 
#! and $\phi^{i}=\phi_{-i}$.
#! @Returns a functor
DeclareOperation( "ChainToCochainComplexFunctor", [ IsHomotopyCategory, IsHomotopyCategory ] );

#! @Description
#! The arguments are $\mathrm{H}^\bullet(A), \mathrm{H}_\bullet(A)$ of an additive category $A$. The output is the functor 
#! $F:\mathrm{H}^\bullet(A)\rightarrow\mathrm{H}_\bullet(A)$ defined by $C^{\bullet}\mapsto C_{\bullet}$ for any 
#! for any cochain complex $C^{\bullet}\in \mathrm{H}^\bullet(A)$ and by $\phi^{\bullet}\mapsto \phi_{\bullet}$ for any map $\phi^\bullet\in \mathrm{H}^\bullet(A)$ where $C_{i}=C^{-i}$ 
#! and $\phi_{i}=\phi^{-i}$.
#! @Returns a functor
DeclareOperation( "CochainToChainComplexFunctor", [ IsHomotopyCategory, IsHomotopyCategory ] );

#! @Section Examples
#! @InsertChunk 0

DeclareOperation( "ExtendFunctorToChainHomotopyCategoryFunctor", [ IsCapFunctor ] );

DeclareOperation( "ExtendFunctorToCochainHomotopyCategoryFunctor", [ IsCapFunctor ] );

# DeclareOperation( "LeftDerivedFunctor", [ IsCapFunctor ] );

# DeclareOperation( "RightDerivedFunctor", [ IsCapFunctor ] );


