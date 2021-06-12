#################################
##
##  Declarations
##
#################################

#! @Chapter Exact and Frobenius Categories
#! @Section GAP categories

DeclareGlobalVariable( "CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "FROBENIUS_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The &GAP; category of short sequences.
#! @Arguments seq_obj
DeclareCategory( "IsCapCategoryShortSequence", IsCapCategoryObject );

#! @Description
#! The &GAP; category of morphisms of short sequences.
#! @Arguments seq_mor
DeclareCategory( "IsCapCategoryMorphismOfShortSequences", IsCapCategoryMorphism );

#! @Description
#! The &GAP; category of short exact sequences.
#! @Arguments seq_obj
DeclareCategory( "IsCapCategoryShortExactSequence", IsCapCategoryShortSequence );

#! @Description
#! The &GAP; category of conflations. If a short sequence is a conflation, then it is a short exact sequence.
#! @Arguments seq_obj
DeclareCategory( "IsCapCategoryConflation", IsCapCategoryShortExactSequence );

####################################
##
#! @Section Exact categories operations
##
####################################

#! @Description
#!  The input is a &CAP; category. The output is <C>true</C> if $\CC$ is an exact category with respect to some
#!  class $\EE$ of short exact sequences.
#! @Arguments C
DeclareProperty( "IsExactCategory", IsCapCategory );

#! @Description
#!  The argument is a morphism $\iota:A\to B$ in $\CC$.
#!  The output is whether or not $\iota$ is an inflation.
#! @Arguments iota
#! @Returns a boolian
DeclareAttribute( "IsInflation", IsCapCategoryMorphism );

DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\pi:B\to C$ in $\CC$.
#!  The output is whether or not $\pi$ is a deflation.
#! @Arguments pi
#! @Returns a boolian
DeclareAttribute( "IsDeflation", IsCapCategoryMorphism );

DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a pair of morphisms $\iota:A\to B$ and $\pi:B\to C$.
#!  The output is whether or not the pair $(\iota,\pi)$ defines a conflation.
#! @Arguments iota, pi
#! @Returns a boolian
DeclareOperation( "IsConflationPair",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an inflation $\iota:A\to B$.
#!  The output is the cokernel object $C$ of $\iota$.
#! @Arguments iota
#! @Returns an object $C$
DeclareAttribute( "ExactCokernelObject", IsCapCategoryMorphism );

DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an inflation $\iota:A\to B$. The output is a deflation $\pi(\iota):B\to C$ with
#!  $C=\mathrm{ExactCokernelObject}(\iota)$ such that
#!  the pair $(\iota,\pi(\iota))$ defines a conflation.
#! @Arguments iota
#! @Returns a deflation $B\to C$
DeclareAttribute( "ExactCokernelProjection", IsCapCategoryMorphism );

DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an inflation $\iota:A\to B$ and an object $C=\mathrm{ExactCokernelObject}(\iota)$.
#!  The output is a deflation $\pi(\iota):B\to C$ such that $(\iota,\pi(\iota))$ defines a conflation.
#! @Arguments iota, C
#! @Returns a deflation $B\to C$
DeclareOperation( "ExactCokernelProjectionWithGivenExactCokernelObject",
    [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an inflation $\iota: A \rightarrow B$
#! and a test morphism $\tau: B \rightarrow T$ satisfying $\comp{\iota}{\tau} \sim 0$.
#! The output is the morphism $\lambda: C \rightarrow T$ with $C=\mathrm{ExactCokernelObject}(\iota)$ and $\lambda$ is
#! given by the universal property of the cokernel object, i.e., $\comp{\pi(\iota)}{\lambda} \sim \tau$ where
#! $\pi(\iota) = \mathrm{ExactCokernelProjection}(\iota)$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A \arrow[r, "\iota", hook] & B \arrow[r, "\pi(\iota)", two heads] \arrow[rd, "\tau"'] & C \arrow[d, "\exists!~\lambda", dashed] \\ & & \phantom{.}T.
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism $C \to T$
#! @Arguments iota, tau
DeclareOperation( "ExactCokernelColift",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are an inflation $\iota_1:A_1 \to B_1$, a morphism $\nu: B_1 \to B_2$ and an inflation $\iota_2:A_2 \to B_2$
#!  such that there $\mu: A_1 \to A_2$ with $\comp{\iota_1}{\nu} \sim \comp{\mu}{\iota_2}$.
#!  The operation delegates to the operation
#!  $\mathrm{ExactCokernelObjectFunctorialWithGivenExactCokernelObjects}(C_1,\iota_1,\nu,\iota_2,C_2)$ such that
#!  $C_1=\mathrm{ExactCokernelObject}(\iota_1)$, $C_2=\mathrm{ExactCokernelObject}(\iota_2)$.
#! @Returns a morphism $C_1 \to C_2$
#! @Arguments iota_1, nu, iota_2
DeclareOperation( "ExactCokernelObjectFunctorial",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  The arguments are an object $C_1$, an inflation $\iota_1:A_1 \to B_1$, a morphism $\nu: B_1 \to B_2$, an inflation $\iota_2:A_2 \to B_2$ and
#!  an object $C_2$ such that $C_1=\mathrm{ExactCokernelObject}(\iota_1)$, $C_2=\mathrm{ExactCokernelObject}(\iota_2)$ and there exists
#!  a morphism $\mu: A_1 \to A_2$ with $\comp{\iota_1}{\nu} \sim \comp{\mu}{\iota_2}$.
#!  The output is the universal morphism $\lambda: C_1 \rightarrow C_2$ given by the universal property of the cokernel object,
#!  i.e., $\comp{\pi(\iota_1)}{\lambda} \sim \comp{\nu}{\pi(\iota_2)}$ where
#!  $\pi(\iota_1) = \mathrm{ExactCokernelProjection}(\iota_1)$ and $\pi(\iota_2) = \mathrm{ExactCokernelProjection}(\iota_2)$.
#!  @BeginLatexOnly
#!  \begin{center}
#! \begin{tikzcd}
#! A_1 \arrow[r, "\iota_1", hook] \arrow[d, "\exists ~\mu"', dashed] & B_1 \arrow[r, "\pi(\iota_1)", two heads] \arrow[d, "\nu"] & \phantom{.}C_1 \arrow[d, "\exists!~\lambda", dashed] \\
#! A_2 \arrow[r, "\iota_2"', hook]                                   & B_2 \arrow[r, "\pi(\iota_2)"', two heads]                 & \phantom{.}C_2.
#! \end{tikzcd}
#!  \end{center}
#!  @EndLatexOnly
#! @Returns a morphism $C_1 \to C_2$
#! @Arguments C_1, iota_1, nu, iota_2, C_2
DeclareOperation( "ExactCokernelObjectFunctorialWithGivenExactCokernelObjects",
    [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddExactCokernelObjectFunctorialWithGivenExactCokernelObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelObjectFunctorialWithGivenExactCokernelObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelObjectFunctorialWithGivenExactCokernelObjects",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelObjectFunctorialWithGivenExactCokernelObjects",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a deflation $\pi: B \rightarrow C$ and a morphism $\tau: B \to T$
#! such that $\tau$ is coliftable along $\pi$. That is, $\comp{\iota(\pi)}{\tau} \sim 0$.
#! The output is the unique colift morphism $\lambda:C\to T$ of $\tau$ along $\pi$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! K \arrow[r, "\iota(\pi)", hook] & B \arrow[r, "\pi", two heads] \arrow[rd, "\tau"'] & C \arrow[d, "\exists !~\lambda", dashed] \\
#!                                &                                                   & \phantom{.}T. 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism $C \to T$
#! @Arguments pi, tau
DeclareOperation( "ColiftAlongDeflation",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a deflation $\pi:B\to C$.
#!  The output is the kernel object $K$ of $\pi$.
#! @Arguments pi
#! @Returns an object $K$
DeclareAttribute( "ExactKernelObject", IsCapCategoryMorphism );

DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a deflation $\pi:B\to C$.
#!  The output is an inflation $\iota(\pi):K\to B$ with
#!  $K=\mathrm{ExactKernelObject}(\pi)$ such that
#!  the pair $(\iota(\pi),\pi)$ defines a conflation.
#! @Arguments pi
#! @Returns an inflation $K\to B$
DeclareAttribute( "ExactKernelEmbedding", IsCapCategoryMorphism );

DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a deflation $\pi:B\to C$ and an object $K=\mathrm{ExactKernelObject}(\pi)$.
#!  The output is an inflation $\iota(\pi):K\to B$ such that
#!  the pair $(\iota(\pi),\pi)$ defines a conflation.
#! @Arguments pi, K
#! @Returns an inflation $K\to B$
DeclareOperation( "ExactKernelEmbeddingWithGivenExactKernelObject",
  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a deflation $\pi: B \rightarrow C$
#!  and a test morphism $\tau: T \rightarrow B$ satisfying $\comp{\tau}{\pi} \sim 0$.
#!  The output is the morphism $\lambda: T \rightarrow K$ with $K=\mathrm{ExactKernelObject}(\pi)$ and $\lambda$ is
#!  given by the universal property of the kernel object, i.e., $\comp{\lambda}{\iota(\pi)} \sim \tau$ where
#!  $\iota(\pi) = \mathrm{ExactKernelEmbedding}(\pi)$.
#!  @BeginLatexOnly
#!  \begin{center}
#!  \begin{tikzcd}
#!  K \arrow[r, "\iota(\pi)", hook]                             & B \arrow[r, "\pi", two heads] & C \\
#!  \phantom{.}T. \arrow[ru, "\tau"'] \arrow[u, "\exists!~\lambda", dashed] &                               &  
#!  \end{tikzcd}
#!  \end{center}
#!  @EndLatexOnly
#! @Returns a morphism $T \to K$
#! @Arguments pi, tau
DeclareOperation( "ExactKernelLift",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a deflation $\pi_1:B_1 \to C_1$, a morphism $\mu: B_1 \to B_2$ and a deflation $\pi_2: B_2 \to C_2$
#!  such that there exists a morphism $\nu: C_1 \to C_2$ with $\comp{\pi_1}{\nu} \sim \comp{\mu}{\pi_2}$.
#!  The operation delegates to the operation $\mathrm{ExactKernelObjectFunctorialWithGivenExactKernelObjects}(K_1,\pi_1,\mu,\pi_2,K_2)$
#!  where $K_1=\mathrm{ExactKernelObject}(\pi_1)$ and $K_2=\mathrm{ExactKernelObject}(\pi_2)$.
#! @Returns a morphism $K_1 \to K_2$
#! @Arguments pi_1, mu, pi_2
DeclareOperation( "ExactKernelObjectFunctorial",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  The arguments are an object $K_1$, a deflation $\pi_1:B_1 \to C_1$, a morphism $\mu: B_1 \to B_2$, a deflation $\pi_2: B_2 \to C_2$ and
#!  an object $K_2$ such that $K_1 = \mathrm{ExactKernelObject}(\pi_1)$, $K_2 = \mathrm{ExactKernelObject}(\pi_2)$ and there exists
#!  a morphism $\nu: C_1 \to C_2$ with $\comp{\pi_1}{\nu} \sim \comp{\mu}{\pi_2}$.
#!  The output is the universal morphism $\lambda: K_1 \rightarrow K_2$ given by the universal property of the kernel object,
#!  i.e., $\comp{\lambda}{\iota(\pi_2)} \sim \comp{\iota(\pi_1)}{\mu}$ where
#!  $\iota(\pi_1) = \mathrm{ExactKernelEmbedding}(\pi_1)$ and $\iota(\pi_2) = \mathrm{ExactKernelEmbedding}(\pi_2)$.
#!  @BeginLatexOnly
#!  \begin{center}
#! \begin{tikzcd}
#! K_1 \arrow[r, "\iota(\pi_1)", hook] \arrow[d, "\exists !~\lambda"', dashed] & B_1 \arrow[r, "\pi_1", two heads] \arrow[d, "\mu"] & \phantom{.}C_1 \arrow[d, "\exists~\nu", dashed] \\
#! K_2 \arrow[r, "\iota(\pi_2)"', hook]                                        & B_2 \arrow[r, "\pi_2"', two heads]                 & \phantom{.}C_2.
#! \end{tikzcd}
#!  \end{center}
#!  @EndLatexOnly
#! @Returns a morphism $K_1 \to K_2$
#! @Arguments K_1, pi_1, mu, pi_2, K_2
DeclareOperation( "ExactKernelObjectFunctorialWithGivenExactKernelObjects",
    [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddExactKernelObjectFunctorialWithGivenExactKernelObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelObjectFunctorialWithGivenExactKernelObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelObjectFunctorialWithGivenExactKernelObjects",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelObjectFunctorialWithGivenExactKernelObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an inflation $\iota: A \rightarrow B$ and a morphism $\tau: T \to B$
#! such that $\tau$ is liftable along $\iota$. That is, $\comp{\tau}{\pi(\iota)} \sim 0$.
#! The output is the unique lift morphism $\lambda:T\to A$ of $\tau$ along $\iota$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A \arrow[r, "\iota", hook] & B \arrow[r, "\pi(\iota)", two heads] & C \\
#! \phantom{.}T. \arrow[ru, "\tau"'] \arrow[u, "\exists!~\lambda", dashed] &&
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism $C \to T$
#! @Arguments iota, tau
DeclareOperation( "LiftAlongInflation",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra


#! @Subsection Exact Fiber Product
#!
#! Given a deflation $\pi:A\to C$ and a morphism $\alpha:B\to C$, an exact fiber product diagram of $(\pi,\alpha)$ is defined by an object $A\times_C B$, a morphism $p_A:A\times_C B\to A$
#! and a deflation $p_B:A\times_C B\to B$ such that $\comp{p_A}{\pi}\sim \comp{p_B}{\alpha}$ and for any two morphisms $p'_A:T\to A,p'_B:T\to B$ with $\comp{p'_A}{\pi}\sim \comp{p'_B}{\alpha}$, there exists
#! a unique morphism $u:T\to A\times_C B$ with $\comp{u}{p_A} \sim p'_A$ and $\comp{u}{p_B} \sim p'_B$.
#! @BeginLatexOnly
#! \begin{center}
#!        \begin{tikzcd}
#!            T \arrow[rrd, "p'_A"] \arrow[rdd, "p'_B"'] \arrow[rd, "u" description, dashed] &                                                           &                               \\
#!                                                                                   & A\times_C B \arrow[r, "p_A"', dashed] \arrow[d, "p_B", two heads, dashed] & A \arrow[d, "\pi", two heads] \\
#!                                                                                   & B \arrow[r, "\alpha"']                                    & C.                          
#!            \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#! @Description
#! The arguments are a deflation $\pi:A\to C$ and a morphism $\alpha:B\to C$.
#! The output is the fiber product object $A\times_C B$ of $\pi$ and $\alpha$.
#! @Returns an object
#! @Arguments pi, alpha
DeclareOperation( "ExactFiberProduct", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a deflation $\pi:A\to C$ and a morphism $\alpha:B\to C$.
#!  The output is a morphism $p_A:A\times_C B \to A$ which is a part of a fiber product diagram of $\pi$ and $\alpha$.
#! @Returns a morphism $p_A:A\times_C B\to A$
#! @Arguments pi, alpha
DeclareOperation( "ProjectionInFirstFactorOfExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a deflation $\pi:A\to C$ and a morphism $\alpha:B\to C$.
#!  The output is a morphism $p_B:A\times_C B \to B$ which is a part of a fiber product diagram of $\pi$ and $\alpha$.
#! @Returns a morphism $p_B:A\times_C B\to B$
#! @Arguments pi, alpha
DeclareOperation( "ProjectionInSecondFactorOfExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a deflation $\pi:A\to C$ and three morphisms $\alpha:B\to C$, $p'_A:T\to A$ and $p'_B:T\to B$ such that  $\comp{p'_A}{\pi} \sim \comp{p'_B}{\alpha}$.
#! The output is the universal morphism $u:T\to A\times_C B$ with $\comp{u}{p_A} \sim p'_A$ and $\comp{u}{p_B}\sim p'_B$.
#! @Returns a morphism $u:T \to A \times_C B$
#! @Arguments pi, alpha, pprime_A, pprime_B
DeclareOperation( "UniversalMorphismIntoExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "UniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra-fiber-product




#! @Subsection Exact Pushout
#!  Given an inflation $\iota:C\to A$ and a morphism $\alpha:C\to B$, an exact pushout diagram of $(\iota,\alpha)$ is defined by an object $A\oplus_C B$, a morphism $q_A:A \to A\oplus_C B$
#!  and an inflation $q_B:B\to A\oplus_C B$ such that $\comp{\iota}{q_A} \sim \comp{\alpha}{q_B}$ and for any two morphisms $q'_A:A\to T,q'_B:B\to T$ with
#!  $\comp{\iota}{q'_A}\sim \comp{\alpha}{q'_B}$, there exists a unique morphism $u: A\oplus_C B \to T$ with $\comp{q_A}{ u}\sim q'_A$ and $\comp{q_B}{ u} \sim q'_B$.
#! @BeginLatexOnly
#! \begin{center}
#!        \begin{tikzcd}
#!            C \arrow[r, "\alpha"] \arrow[d, "\iota"', hook] & B \arrow[d, "q_B"', hook] \arrow[rdd, "q'_B"] &   \\
#!            A \arrow[r, "q_A"] \arrow[rrd, "q'_A"']         & A \oplus_C B \arrow[rd, "u" description]      &   \\
#!                                                            &                                               & T.
#!        \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#! @Description
#!  The arguments are an inflation $\iota:C\to A$ and a morphism $\alpha:C\to B$.
#!  The output is the pushout object $A\oplus_C B$ of $\iota$ and $\alpha$.
#! @Returns an object
#! @Arguments iota, alpha
DeclareOperation( "ExactPushout", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are an inflation $\iota:C\to A$ and a morphism $\alpha:C\to B$.
#!  The output is a morphism $q_A:A \to A\oplus_C B$ which is a part of a pushout diagram of $\iota$ and $\alpha$.
#! @Returns a morphism $A \to A\oplus_C B$
#! @Arguments iota, alpha
DeclareOperation( "InjectionOfFirstCofactorOfExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
#!  The arguments are an inflation $\iota:C\to A$ and a morphism $\alpha:C\to B$.
#!  The output is an inflation $q_B:B \to A\oplus_C B$ which is a part of a pushout diagram of $\iota$ and $\alpha$.
#! @Returns a inflation $B \to A\oplus_C B$
#! @Arguments iota, alpha
DeclareOperation( "InjectionOfSecondCofactorOfExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a inflation $\iota:C\to A$ and three morphisms $\alpha:C\to B$, $q'_A:A\to T$ 
#!  and $q'_B:B\to T$ such that $\comp{\iota}{ q'_A}\sim \comp{\alpha}{ q'_B}$.
#!  The output is the universal morphism $u:A\oplus_C B\to T$ with $\comp{q_A}{ u}\sim q'_A$ and $\comp{q_B}{u} \sim q'_B$.
#! @Returns a morphism $A\oplus_C B \to T$
#! @Arguments iota, alpha, qprime_A, qprime_B
DeclareOperation( "UniversalMorphismFromExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a inflation $\iota:C\to A$, three morphisms $\alpha:C\to B$, $q'_A:A\to T$,
#!  $q'_B:B\to T$ and an object $P=A\oplus_C B=\mathrm{ExactPushout}(\iota,\alpha)$
#!  such that $\comp{\iota}{ q'_A}\sim \comp{\alpha}{ q'_B}$.
#!  The output is the universal morphism $u:P \to T$ with $\comp{q_A}{ u}\sim q'_A$ and $\comp{q_B}{u} \sim q'_B$.
#! @Returns a morphism $P \to T$
#! @Arguments iota, alpha, qprime_A, qprime_B, P
DeclareOperation( "UniversalMorphismFromExactPushoutWithGivenExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra-fiber-product

#! @Subsection Exact Categories With Enough E-projectives
#!  Let $(\CC,\EE)$ be an exact category. An object $P$ is called $\mathcal{E}$-projective if for every
#!  morphism $\tau:P\to C$ and every deflation $\pi:B\to C$, there exists a lift morphism $\lambda:P\to B$
#!  of $\tau$ along $\pi$, i.e., $\comp{\lambda}{\pi}=\tau$.
#!  @BeginLatexOnly
#!  \begin{center}
#! \begin{tikzcd}
#!                                & P \arrow[d, "\tau"] \arrow[ld, "\lambda"', dashed] \\
#! B \arrow[r, "\pi"', two heads] & C. 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#!  The exact category $(\CC,\EE)$ is said to have enough $\EE$-projectives if for each object $A$ in $\CC$, there exists
#!  a deflation $p_A:P_A \to A$ where $P_A$ is an $\EE$-projecitve object.

#! @Description
#!  The input is a &CAP; category. The output is <C>true</C> if $\CC$ is an exact category with respect to some
#!  class $\EE$ of short exact sequences and $(\CC,\EE)$ has enough $\EE$-projectives.
#! @Arguments C
DeclareProperty( "IsExactCategoryWithEnoughExactProjectives", IsCapCategory );

#! @Description
#!  The argument is an object $P$ in $\CC$.
#!  The output is whether or not $P$ is an $\EE$-projective object.
#! @Returns a boolian 
#! @Arguments P
DeclareProperty( "IsExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a morphism $\tau:P\to C$ where $P$ is an $\EE$-projective object
#!  and a deflation $\pi:B\to C$.
#!  The output is a lift morphism $\lambda:P\to B$ of $\tau$ along $\pi$, i.e.,
#!  $\comp{\lambda}{\pi} \sim \tau$.
#! @Returns a morphism $\lambda:P\to B$
#! @Arguments tau, pi
DeclareOperation( "ExactProjectiveLift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra-exact-projectives

#! @Description
#!  The argument is an object $A$ in $\CC$.
#!  The output is an $\EE$-projective object $P_A$ such that
#!  there exists a deflation $P_A \to A$.
#! @Returns an $\EE$-projective object 
#! @Arguments A
DeclareAttribute( "SomeExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $A$ in $\CC$.
#!  The output is a deflation morphism $p_A:P_A \to A$ where
#!  $P_A = \mathrm{SomeExactProjectiveObject}(A)$.
#! @Returns a deflation $P_A \to A$
#! @Arguments A
DeclareAttribute( "DeflationFromSomeExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra-enough-exact-projectives

#! @Subsection Exact Categories With Enough E-injecitves
#!  Let $(\CC,\EE)$ be an exact category. An object $I$ is called $\mathcal{E}$-injective if for
#!  every inflation $\iota:A\to B$ and every morphism $\tau:A \to I$, there exists a colift morphism
#!  of $\tau$ along $\iota$.
#!  @BeginLatexOnly
#!  \begin{center}
#! \begin{tikzcd}
#! A \arrow[r, "\iota", hook] \arrow[d, "\tau"'] & B \arrow[ld, "\lambda", dashed]                \\
#! I                                             & {}
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#!  The exact category $(\CC,\EE)$ is said to have enough $\EE$-injectives if for each object $A$ in $\CC$, there exists
#!  an inflation $\iota_A:A \to I_A$ where $I_A$ is an $\EE$-injective object.


#! @Description
#!  The input is a &CAP; category. The output is <C>true</C> if $\CC$ is an exact category with respect to some
#!  class $\EE$ of short exact sequences and $(\CC,\EE)$ has enough $\EE$-injectives.
#! @Arguments C
DeclareProperty( "IsExactCategoryWithEnoughExactInjectives", IsCapCategory );

#! @Description
#!  The argument is an object $I$ in $\CC$.
#!  The output is whether or not $I$ is an $\EE$-injective object.
#! @Returns a boolian
#! @Arguments I
DeclareProperty( "IsExactInjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are an inflation $\iota:A\to B$ and a morphism $\tau:A\to I$
#!  where $I$ is an $\EE$-injective object.
#!  The output is a colift morphism $\lambda:B \to I$ of $\tau$ along $\iota$, i.e.,
#!  $\comp{\iota}{\lambda} \sim \tau$.
#! @Returns a morphism $\lambda:B \to I$
#! @Arguments iota, tau
DeclareOperation( "ExactInjectiveColift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra-exact-injectives

#! @Description
#!  The argument is an object $A$ in $\CC$.
#!  The output is an $\EE$-injective object $I_A$ such that
#!  there exists an inflation $A \to I_A$.
#! @Returns an $\EE$-injective object 
#! @Arguments A
DeclareOperation( "SomeExactInjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $A$ in $\CC$.
#!  The output is an inflation $\iota_A:A \to I_A$ where
#!  $I_A = \mathrm{SomeExactInjectiveObject}(A)$.
#! @Returns an inflation $A \to I_A$
#! @Arguments A
DeclareOperation( "InflationIntoSomeExactInjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra-enough-exact-injectives

#! @Description
#!  The argument if a morphism $\alpha:A\to B$ in an exact category $(\CC,\EE)$ with enough $\EE$-projectives.
#!  The output is whether or not $\alpha$ lifts along $p_B:P_B\to B$ where $p_B=\mathrm{DeflationFromSomeExactProjectiveObject}(B)$.
#! @Arguments alpha
DeclareProperty( "IsLiftableAlongDeflationFromSomeExactProjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\alpha:A\to B$ such that $\alpha$ lifts along $p_B:P_B \to B$ where
#!  $p_B=\mathrm{DeflationFromSomeExactProjectiveObject}(B)$.
#!  The output is a lift morphism $\lambda: A \to P_B$ of $\alpha$ along $p_B$.
#! @Arguments alpha
DeclareAttribute( "LiftAlongDeflationFromSomeExactProjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra-enough-exact-projectives-liftable-along-deflation

#! @Description
#!  The argument if a morphism $\alpha:A\to B$ in an exact category $(\CC,\EE)$ with enough $\EE$-injectives.
#!  The output is whether or not $\alpha$ colifts along $\iota_A:A\to I_A$ where $\iota_A=\mathrm{InflationIntoSomeExactInjectiveObject}(A)$.
#! @Arguments alpha
DeclareProperty( "IsColiftableAlongInflationIntoSomeExactInjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\alpha:A\to B$ such that $\alpha$ colifts along $\iota_A:A \to I_A$ where
#!  $\iota_A=\mathrm{InflationIntoSomeExactInjectiveObject}(A)$.
#!  The output is a colift morphism $\lambda: I_A \to B$ of $\alpha$ along $\iota_A$.
#! @Arguments alpha
DeclareAttribute( "ColiftAlongInflationIntoSomeExactInjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @InsertChunk freyd_categories_graded_exterior_algebra-enough-exact-injectives-coliftable-along-inflation

#! @Description
#!  The argument is a &CAP; category. The output is <C>true</C> if 
#!  * $\CC$ is exact with respect to some class $\EE$ of short exact sequences,
#!  * $(\CC,\EE)$ has enough $\EE$-projectives and $\EE$-injectives,
#!  * an object in $\CC$ is $\EE$-projective if and only if it is $\EE$-injective.
#! @Arguments C
DeclareProperty( "IsFrobeniusCategory", IsCapCategory );

#? @InsertChunk freyd_categories_graded_exterior_algebra-is-frobenius

#################################
##
## Methods 
##
#################################

DeclareAttribute( "CategoryOfShortSequences", IsCapCategory );

DeclareOperation( "CreateShortSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CreateShortExactSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
           
DeclareOperation( "CreateConflation", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SchanuelsIsomorphism", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsString ] );

DeclareAttribute( "IsShortExactSequence_", IsCapCategoryShortSequence );
#################################
##
##  Attributes
##
#################################

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY", IsCapCategory );
DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_EXACT_CATEGORY", IsCapCategory );
        
#################################
##
## Properties
##
#################################

DeclareAttribute( "AsResidueClassOfInflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoFromRangeToRangeOfResidueClassOfInflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoToRangeFromRangeOfResidueClassOfInflation", IsStableCategoryMorphism );

DeclareAttribute( "AsResidueClassOfDeflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoFromSourceToSourceOfResidueClassOfDefflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoToSourceFromSourceOfResidueClassOfDeflation", IsStableCategoryMorphism );


KeyDependentOperation( "MorphismAt", IsCapCategoryShortSequence, IsInt, ReturnTrue );
DeclareOperation( "\^", [ IsCapCategoryShortSequence, IsInt ] );

KeyDependentOperation( "ObjectAt", IsCapCategoryShortSequence, IsInt, ReturnTrue );
DeclareOperation( "\[\]", [ IsCapCategoryShortSequence, IsInt ] );

