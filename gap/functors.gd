#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
#! @Chapter Functors
##
#############################################################################

#! @Section Basic functors for complex categories.

KeyDependentOperation( "StalkChainFunctor", IsCapCategory, IsInt, ReturnTrue );
KeyDependentOperation( "StalkCochainFunctor", IsCapCategory, IsInt, ReturnTrue );


#! @Group f1
#! @Description
#! The first argument in the input must be the chain (resp. cochain) complex category of an abelian category $A$, the second argument is an integer <A>n</A>. 
#! The output is the $n$'th homology (resp. cohomology) functor $\mathrm{Ch}_\bullet(A) \rightarrow A$
#! ( resp. $\mathrm{Ch}^\bullet(A) \rightarrow A$)
#! @Arguments Ch_\bullet(A), A, n
#! @Returns a functor
KeyDependentOperation( "HomologyFunctor", IsChainComplexCategory, IsInt, ReturnTrue );
#! @EndGroup
#! @Group f1
#! @Arguments Ch^\bullet(A), A, n
KeyDependentOperation( "CohomologyFunctor", IsCochainComplexCategory, IsInt, ReturnTrue );

#! @Description
#! The inputs are complex category $\mathrm{Comp}(A)$ and an integer. The output is a the endofunctor $T[n]$ that sends any complex $C$ to $C[n]$ and any complex morphism
#! $\phi:C\rightarrow D$ to $\phi[n]:C[n]\rightarrow D[n]$. The shift chain complex $C[n]$ of a chain complex $C$ is defined by $C[n]_i=C_{n+i}, d_{i}^{C[n]}=(-1)^{n}d_{n+i}^{C}$ 
#! and the same for 
#! chain complex morphisms, i.e., $\phi[n]_i=\phi_{n+i}$. The same holds for cochain complexes and morphisms.
#! @Arguments Comp(A), n
#! @Returns a functor
KeyDependentOperation( "ShiftFunctor", IsChainOrCochainComplexCategory, IsInt, ReturnTrue );


#! @Description
#! The inputs are complex category $\mathrm{Comp}(A)$ and an integer. The output is a the endofunctor $T[n]$ that sends any complex $C$ to $C[n]$ and any complex morphism
#! $\phi:C\rightarrow D$ to $\phi[n]:C[n]\rightarrow D[n]$. The shift chain complex $C[n]$ of a chain complex $C$ is defined by $C[n]_i=C_{n+i}, d_{i}^{C[n]}=d_{n+i}^{C}$ 
#! and the same for 
#! chain complex morphisms, i.e., $\phi[n]_i=\phi_{n+i}$. The same holds for cochain complexes and morphisms.
#! @Arguments Comp(A), n
#! @Returns a functor
KeyDependentOperation( "UnsignedShiftFunctor", IsChainOrCochainComplexCategory, IsInt, ReturnTrue );

#! @Description
#! The arguments are $\mathrm{Ch}_\bullet(A)$ and $\mathrm{Ch}^\bullet(A)$ for some category $A$. 
#! The output is the functor $F:\mathrm{Ch}_\bullet(A)\rightarrow\mathrm{Ch}^\bullet(A)$ 
#! defined by $C_{\bullet}\mapsto C^{\bullet}$ for any 
#! for any chain complex $C_{\bullet}\in \mathrm{Ch}_\bullet(A)$ and by 
#! $\phi_{\bullet}\mapsto \phi^{\bullet}$ for any morphism 
#! $\phi_\bullet$ where $C^\bullet_{i}=C_\bullet^{-i}$ and $\phi^\bullet_{i}=\phi_\bullet^{-i}$ for any $i\in\mathbb{Z}$.
#! @Arguments Ch(A)_\bullet, Ch(A)^\bullet
#! @Returns a functor
DeclareOperation( "ChainToCochainComplexFunctor", [ IsChainComplexCategory, IsCochainComplexCategory ] );

#! @Description
#! The arguments are $\mathrm{Ch}^\bullet(A)$ and $\mathrm{Ch}_\bullet(A)$ for some category $A$. 
#! The output is the functor $F:\mathrm{Ch}^\bullet(A)\rightarrow\mathrm{Ch}_\bullet(A)$ 
#! defined by $C^\bullet\mapsto C_\bullet$ for any 
#! for any chain complex $C^\bullet\in \mathrm{Ch}^\bullet(A)$ and by 
#! $\phi^\bullet\mapsto \phi_\bullet$ for any morphism 
#! $\phi^\bullet$ where $C_\bullet^{i}=C^\bullet_{-i}$ and $\phi_\bullet^{i}=\phi^\bullet_{-i}$ for any $i\in\mathbb{Z}$.
#! @Arguments Ch(A)^\bullet, Ch(A)_\bullet
#! @Returns a functor
DeclareOperation( "CochainToChainComplexFunctor", [ IsCochainComplexCategory, IsChainComplexCategory ] );

#! @Description
#! The input is a functor $F:A\rightarrow B$. 
#! The output is its extention functor 
#! $$\mathrm{Ch}_\bullet F:\mathrm{Ch}_\bullet(A)\rightarrow \mathrm{Ch}_\bullet(B).$$
#! @BeginLatexOnly
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$C_\bullet$};
#!   \node (0V0) at (0,0) {$D_\bullet$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$C_{n-1}$};
#!   \node (3V1) at (3,1) {$C_{n}$};
#!   \node (4V1) at (4,1) {$C_{n+1}$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$D_{n-1}$};
#!   \node (3V0) at (3,0) {$D_{n}$};
#!   \node (4V0) at (4,0) {$D_{n+1}$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\phi$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$\phi_{n-1}$} (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$\phi_{n}$} (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$\phi_{n+1}$} (4V0);
#!   \draw[->,thick] (2V0)-- node[below]{$d_{n-1}$} (1V0);
#!   \draw[->,thick] (3V0)-- node[below]{$d_{n}$} (2V0);
#!   \draw[->,thick] (4V0)-- node[below]{$d_{n+1}$} (3V0);
#!   \draw[->,thick] (2V1)-- node[above]{$d_{n-1}$} (1V1);
#!   \draw[->,thick] (3V1)-- node[above]{$d_{n}$} (2V1);
#!   \draw[->,thick] (4V1)-- node[above]{$d_{n+1}$} (3V1);
#!   \draw[->,thick] (5V0)-- (4V0);
#!   \draw[->,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$\mathrm{Ch}_\bullet F( C_\bullet )$};
#!   \node (0V0) at (0,0) {$\mathrm{Ch}_\bullet F( D_\bullet )$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$F(C_{n-1})$};
#!   \node (3V1) at (3,1) {$F(C_{n})$};
#!   \node (4V1) at (4,1) {$F(C_{n+1})$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$F( D_{n-1})$};
#!   \node (3V0) at (3,0) {$F( D_{n})$};
#!   \node (4V0) at (4,0) {$F( D_{n+1})$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$F( \phi )$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$F( \phi_{n-1} )$} (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$F( \phi_{n} )$} (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$F( \phi_{n+1})$} (4V0);
#!   \draw[->,thick] (2V0)-- node[below]{$F( d_{n-1})$} (1V0);
#!   \draw[->,thick] (3V0)-- node[below]{$F( d_{n} )$} (2V0);
#!   \draw[->,thick] (4V0)-- node[below]{$F( d_{n+1})$} (3V0);
#!   \draw[->,thick] (2V1)-- node[above]{$F( d_{n-1})$} (1V1);
#!   \draw[->,thick] (3V1)-- node[above]{$F( d_{n})$} (2V1);
#!   \draw[->,thick] (4V1)-- node[above]{$F( d_{n+1})$} (3V1);
#!   \draw[->,thick] (5V0)-- (4V0);
#!   \draw[->,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! @EndLatexOnly
#! @Arguments F
#! @Returns a functor
DeclareAttribute( "ExtendFunctorToChainComplexCategories", IsCapFunctor );

#! @Description
#! The input is a functor $F:A\rightarrow B$. The output is its extention functor 
#! $$\mathrm{Ch}^\bullet F:\mathrm{Ch}^\bullet(A)\rightarrow \mathrm{Ch}^\bullet(B)$$.
#! @BeginLatexOnly
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$C^\bullet$};
#!   \node (0V0) at (0,0) {$D^\bullet$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$C^{n-1}$};
#!   \node (3V1) at (3,1) {$C^{n}$};
#!   \node (4V1) at (4,1) {$C^{n+1}$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$D^{n-1}$};
#!   \node (3V0) at (3,0) {$D^{n}$};
#!   \node (4V0) at (4,0) {$D^{n+1}$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\phi$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$\phi^{n-1}$} (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$\phi^{n}$} (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$\phi^{n+1}$} (4V0);
#!   \draw[<-,thick] (2V0)-- node[below]{$d^{n-2}$} (1V0);
#!   \draw[<-,thick] (3V0)-- node[below]{$d^{n-1}$} (2V0);
#!   \draw[<-,thick] (4V0)-- node[below]{$d^{n}$} (3V0);
#!   \draw[<-,thick] (2V1)-- node[above]{$d^{n-2}$} (1V1);
#!   \draw[<-,thick] (3V1)-- node[above]{$d^{n-1}$} (2V1);
#!   \draw[<-,thick] (4V1)-- node[above]{$d^{n}$} (3V1);
#!   \draw[<-,thick] (5V0)-- (4V0);
#!   \draw[<-,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$\mathrm{Ch}^\bullet F( C^\bullet )$};
#!   \node (0V0) at (0,0) {$\mathrm{Ch}^\bullet F( D^\bullet )$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$F( C^{n-1})$};
#!   \node (3V1) at (3,1) {$F( C^{n})$};
#!   \node (4V1) at (4,1) {$F( C^{n+1})$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$F( D^{n-1})$};
#!   \node (3V0) at (3,0) {$F( D^{n})$};
#!   \node (4V0) at (4,0) {$F( D^{n+1})$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\mathrm{Ch}^\bullet F( \phi )$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$F( \phi^{n-1} )$} (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$F( \phi^{n} )$} (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$F( \phi^{n+1} )$} (4V0);
#!   \draw[<-,thick] (2V0)-- node[below]{$F( d^{n-2} )$} (1V0);
#!   \draw[<-,thick] (3V0)-- node[below]{$F( d^{n-1} )$} (2V0);
#!   \draw[<-,thick] (4V0)-- node[below]{$F( d^{n} )$} (3V0);
#!   \draw[<-,thick] (2V1)-- node[above]{$F( d^{n-2} )$} (1V1);
#!   \draw[<-,thick] (3V1)-- node[above]{$F( d^{n-1} )$} (2V1);
#!   \draw[<-,thick] (4V1)-- node[above]{$F( d^{n} )$} (3V1);
#!   \draw[<-,thick] (5V0)-- (4V0);
#!   \draw[<-,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! @EndLatexOnly
#! @Arguments F
#! @Returns a functor
DeclareAttribute( "ExtendFunctorToCochainComplexCategories", IsCapFunctor );


DeclareAttribute( "ExtendProductFunctorToChainComplexCategoryProductFunctor", IsCapFunctor );
DeclareAttribute( "ExtendProductFunctorToCochainComplexCategoryProductFunctor", IsCapFunctor );

#! @Description
#! The input is a complex category $\mathrm{Com}(A)$ of some Cap category $A$ 
#! and an integer $n$. 
#! The output is an endofunctor from $\mathrm{Com}(A) \rightarrow \mathrm{Com}(A)$.
#! @BeginLatexOnly
#! If $\mathrm{Com}(A)=\mathrm{Ch_\bullet}(A)$ is a chain complex category then the output is the functor
#! $$\sigma_{< n}:\mathrm{Ch_\bullet}(A)\rightarrow \mathrm{Ch_\bullet}(A)$$
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$C_\bullet$};
#!   \node (0V0) at (0,0) {$D_\bullet$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$C_{n-1}$};
#!   \node (3V1) at (3,1) {$C_{n}$};
#!   \node (4V1) at (4,1) {$C_{n+1}$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$D_{n-1}$};
#!   \node (3V0) at (3,0) {$D_{n}$};
#!   \node (4V0) at (4,0) {$D_{n+1}$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\phi$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$\phi_{n-1}$} (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$\phi_{n}$} (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$\phi_{n+1}$} (4V0);
#!   \draw[->,thick] (2V0)-- node[below]{$d_{n-1}$} (1V0);
#!   \draw[->,thick] (3V0)-- node[below]{$d_{n}$} (2V0);
#!   \draw[->,thick] (4V0)-- node[below]{$d_{n+1}$} (3V0);
#!   \draw[->,thick] (2V1)-- node[above]{$d_{n-1}$} (1V1);
#!   \draw[->,thick] (3V1)-- node[above]{$d_{n}$} (2V1);
#!   \draw[->,thick] (4V1)-- node[above]{$d_{n+1}$} (3V1);
#!   \draw[->,thick] (5V0)-- (4V0);
#!   \draw[->,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$\sigma_{<n}(C_\bullet)$};
#!   \node (0V0) at (0,0) {$\sigma_{<n}(D_\bullet)$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$C_{n-1}$};
#!   \node (3V1) at (3,1) {$0$};
#!   \node (4V1) at (4,1) {$0$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$D_{n-1}$};
#!   \node (3V0) at (3,0) {$0$};
#!   \node (4V0) at (4,0) {$0$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\sigma_{<n}(\phi)$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$\phi_{n-1}$} (2V0);
#!   \draw[->,thick] (3V1)-- (3V0);
#!   \draw[->,thick] (4V1)-- (4V0);
#!   \draw[->,thick] (2V0)-- node[below]{$d_{n-1}$} (1V0);
#!   \draw[->,thick] (3V0)-- (2V0);
#!   \draw[->,thick] (4V0)-- (3V0);
#!   \draw[->,thick] (2V1)-- node[above]{$d_{n-1}$} (1V1);
#!   \draw[->,thick] (3V1)-- (2V1);
#!   \draw[->,thick] (4V1)-- (3V1);
#!   \draw[->,thick] (5V0)-- (4V0);
#!   \draw[->,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! If $\mathrm{Com}(A)=\mathrm{Ch^\bullet}(A)$ is a cochain complex category then the output is the 
#! functor $$\sigma^{\leq n}:\mathrm{Ch^\bullet}(A)\rightarrow \mathrm{Ch^\bullet}(A)$$
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$C^\bullet$};
#!   \node (0V0) at (0,0) {$D^\bullet$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$C^{n-1}$};
#!   \node (3V1) at (3,1) {$C^{n}$};
#!   \node (4V1) at (4,1) {$C^{n+1}$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$D^{n-1}$};
#!   \node (3V0) at (3,0) {$D^{n}$};
#!   \node (4V0) at (4,0) {$D^{n+1}$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\phi$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$\phi^{n-1}$} (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$\phi^{n}$} (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$\phi^{n+1}$} (4V0);
#!   \draw[<-,thick] (2V0)-- node[below]{$d^{n-2}$} (1V0);
#!   \draw[<-,thick] (3V0)-- node[below]{$d^{n-1}$} (2V0);
#!   \draw[<-,thick] (4V0)-- node[below]{$d^{n}$} (3V0);
#!   \draw[<-,thick] (2V1)-- node[above]{$d^{n-2}$} (1V1);
#!   \draw[<-,thick] (3V1)-- node[above]{$d^{n-1}$} (2V1);
#!   \draw[<-,thick] (4V1)-- node[above]{$d^{n}$} (3V1);
#!   \draw[<-,thick] (5V0)-- (4V0);
#!   \draw[<-,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$\sigma^{\leq n}(C^\bullet)$};
#!   \node (0V0) at (0,0) {$\sigma^{\leq n}(D^\bullet)$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$C^{n-1}$};
#!   \node (3V1) at (3,1) {$C^{n}$};
#!   \node (4V1) at (4,1) {$0$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$D^{n-1}$};
#!   \node (3V0) at (3,0) {$D^{n}$};
#!   \node (4V0) at (4,0) {$0$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\sigma^{\leq n}(\phi)$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$\phi^{n-1}$} (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$\phi^{n}$} (3V0);
#!   \draw[->,thick] (4V1)-- (4V0);
#!   \draw[<-,thick] (2V0)-- node[below]{$d^{n-2}$} (1V0);
#!   \draw[<-,thick] (3V0)-- node[below]{$d^{n-1}$} (2V0);
#!   \draw[<-,thick] (4V0)-- (3V0);
#!   \draw[<-,thick] (2V1)-- node[above]{$d^{n-2}$} (1V1);
#!   \draw[<-,thick] (3V1)-- node[above]{$d^{n-1}$} (2V1);
#!   \draw[<-,thick] (4V1)-- (3V1);
#!   \draw[<-,thick] (5V0)-- (4V0);
#!   \draw[<-,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! @EndLatexOnly
#! @Arguments Com(A), n
#! @Returns a endofunctor
KeyDependentOperation( "BrutalTruncationAboveFunctor", IsChainOrCochainComplexCategory, IsInt, ReturnTrue );

#! @Description
#! The input is a complex category $\mathrm{Com}(A)$ of some Cap category $A$ 
#! and an integer $n$. 
#! The output is an endofunctor from $\mathrm{Com}(A) \rightarrow \mathrm{Com}(A)$.
#! @BeginLatexOnly
#! If $\mathrm{Com}(A)=\mathrm{Ch_\bullet}(A)$ is a chain complex category then the output is the functor
#! $$\sigma_{\geq n}:\mathrm{Ch_\bullet}(A)\rightarrow \mathrm{Ch_\bullet}(A)$$
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$C_\bullet$};
#!   \node (0V0) at (0,0) {$D_\bullet$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$C_{n-1}$};
#!   \node (3V1) at (3,1) {$C_{n}$};
#!   \node (4V1) at (4,1) {$C_{n+1}$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$D_{n-1}$};
#!   \node (3V0) at (3,0) {$D_{n}$};
#!   \node (4V0) at (4,0) {$D_{n+1}$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\phi$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$\phi_{n-1}$} (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$\phi_{n}$} (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$\phi_{n+1}$} (4V0);
#!   \draw[->,thick] (2V0)-- node[below]{$d_{n-1}$} (1V0);
#!   \draw[->,thick] (3V0)-- node[below]{$d_{n}$} (2V0);
#!   \draw[->,thick] (4V0)-- node[below]{$d_{n+1}$} (3V0);
#!   \draw[->,thick] (2V1)-- node[below]{$d_{n-1}$} (1V1);
#!   \draw[->,thick] (3V1)-- node[below]{$d_{n}$} (2V1);
#!   \draw[->,thick] (4V1)-- node[below]{$d_{n+1}$} (3V1);
#!   \draw[->,thick] (5V0)-- (4V0);
#!   \draw[->,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$\sigma_{\geq n}(C_\bullet)$};
#!   \node (0V0) at (0,0) {$\sigma_{\geq n}(D_\bullet)$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$0$};
#!   \node (3V1) at (3,1) {$C_{n}$};
#!   \node (4V1) at (4,1) {$C_{n+1}$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$0$};
#!   \node (3V0) at (3,0) {$D_{n}$};
#!   \node (4V0) at (4,0) {$D_{n+1}$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\sigma_{\geq n}(\phi)$} (0V0);
#!   \draw[->,thick] (2V1)-- (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$\phi_{n}$} (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$\phi_{n+1}$} (4V0);
#!   \draw[->,thick] (2V0)--  (1V0);
#!   \draw[->,thick] (3V0)-- (2V0);
#!   \draw[->,thick] (4V0)-- node[below]{$d_{n+1}$} (3V0);
#!   \draw[->,thick] (2V1)--  (1V1);
#!   \draw[->,thick] (3V1)-- (2V1);
#!   \draw[->,thick] (4V1)-- node[above]{$d_{n+1}$} (3V1);
#!   \draw[->,thick] (5V0)-- (4V0);
#!   \draw[->,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! If $\mathrm{Com}(A)=\mathrm{Ch^\bullet}(A)$ is a cochain complex category then the output is the 
#! functor $$\sigma^{> n}:\mathrm{Ch^\bullet}(A)\rightarrow \mathrm{Ch^\bullet}(A)$$
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$C^\bullet$};
#!   \node (0V0) at (0,0) {$D^\bullet$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$C^{n-1}$};
#!   \node (3V1) at (3,1) {$C^{n}$};
#!   \node (4V1) at (4,1) {$C^{n+1}$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$D^{n-1}$};
#!   \node (3V0) at (3,0) {$D^{n}$};
#!   \node (4V0) at (4,0) {$D^{n+1}$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\phi$} (0V0);
#!   \draw[->,thick] (2V1)-- node[left]{$\phi^{n-1}$} (2V0);
#!   \draw[->,thick] (3V1)-- node[left]{$\phi^{n}$} (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$\phi^{n+1}$} (4V0);
#!   \draw[<-,thick] (2V0)-- node[below]{$d^{n-2}$} (1V0);
#!   \draw[<-,thick] (3V0)-- node[below]{$d^{n-1}$} (2V0);
#!   \draw[<-,thick] (4V0)-- node[below]{$d^{n}$} (3V0);
#!   \draw[<-,thick] (2V1)-- node[above]{$d^{n-2}$} (1V1);
#!   \draw[<-,thick] (3V1)-- node[above]{$d^{n-1}$} (2V1);
#!   \draw[<-,thick] (4V1)-- node[above]{$d^{n}$} (3V1);
#!   \draw[<-,thick] (5V0)-- (4V0);
#!   \draw[<-,thick] (5V1)-- (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! \begin{center}
#!   \begin{tikzpicture}[x=2.5cm,y=2cm,transform shape,
#!   mylabel/.style={thick, draw=black, 
#!   align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white} ]
#!   \node (0V1) at (0,1) {$\sigma^{> n}(C^\bullet)$};
#!   \node (0V0) at (0,0) {$\sigma^{> n}(D^\bullet)$};
#!   \node (1V1) at (1,1) {$\cdots$};
#!   \node (2V1) at (2,1) {$0$};
#!   \node (3V1) at (3,1) {$0$};
#!   \node (4V1) at (4,1) {$C^{n+1}$};
#!   \node (5V1) at (5,1) {$\cdots$};
#!   \node (1V0) at (1,0) {$\cdots$};
#!   \node (2V0) at (2,0) {$0$};
#!   \node (3V0) at (3,0) {$0$};
#!   \node (4V0) at (4,0) {$D^{n+1}$};
#!   \node (5V0) at (5,0) {$\cdots$};
#!   \draw[->,thick] (0V1)-- node[left]{$\sigma^{> n}(\phi)$} (0V0);
#!   \draw[->,thick] (2V1)-- (2V0);
#!   \draw[->,thick] (3V1)-- (3V0);
#!   \draw[->,thick] (4V1)-- node[left]{$\phi^{n+1}$} (4V0);
#!   \draw[<-,thick] (2V0)-- (1V0);
#!   \draw[<-,thick] (3V0)-- (2V0);
#!   \draw[<-,thick] (4V0)-- (3V0);
#!   \draw[<-,thick] (2V1)-- (1V1);
#!   \draw[<-,thick] (3V1)-- (2V1);
#!   \draw[<-,thick] (4V1)-- (3V1);
#!   \draw[<-,thick] (5V0)-- node[below]{$d^{n+1}$} (4V0);
#!   \draw[<-,thick] (5V1)-- node[above]{$d^{n+1}$} (4V1);
#!   \end{tikzpicture}
#!   \end{center}
#! @EndLatexOnly
#! @Arguments Com(A), n
#! @Returns a endofunctor
KeyDependentOperation( "BrutalTruncationBelowFunctor", IsChainOrCochainComplexCategory, IsInt, ReturnTrue );

# @Description
# The input is a category $A$. The output is the functor 
# $F:\mathrm{Ch}_\bullet(A)\rightarrow \mathrm{Ch}^\bullet(A^{\mathrm{op}).$
# @Arguments A
# @Returns a functor
DeclareOperation( "ChainCategoryToCochainCategoryOfOppositeCategory", [ IsCapCategory ] );

#! @Section Examples
#! @InsertChunk vec_3


DeclareOperation( "CochainCategoryToChainCategoryOfOppositeCategory", [ IsCapCategory ] );

#! @Description
#! To do.
#! @Arguments A
#! @Returns a functor
KeyDependentOperation( "GoodTruncationAboveFunctor", IsCapCategory, IsInt, ReturnTrue );

KeyDependentOperation( "GoodTruncationBelowFunctor", IsCapCategory, IsInt, ReturnTrue );

DeclareOperation( "KernelObjectFunctor",   [ IsChainOrCochainComplexCategory, IsCapCategory,  IsInt ] );
DeclareOperation( "CokernelObjectFunctor", [ IsChainOrCochainComplexCategory, IsCapCategory,  IsInt ] );

