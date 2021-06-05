







#! @Chunk sIwHy5MWWYHC74TAiWwI
#!
#! Let $\CC$ be an additive category and $\Ch{\CC}$ be its cochain complexes category. An object $A$ in $\Ch{\CC}$ is called contractible
#! if the identity morphism $\id_{A}$ is null-homotopic. That is, there exists a family of morphisms $(\lambda^i:A^i\to A^{i-1})_{i\in\mathbb{Z}}$ such that
#! $\comp{\partial_{A}^i}{\lambda^{i+1}}+\comp{\lambda^i}{\partial_{A}^{i-1}}\sim \id_{A^i}$ for all $i\in\mathbb{Z}$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! \dots \arrow[r] & A^{i-1} \arrow[r, "\partial_A^{i-1}"'] \arrow[l, bend right=49] & A^i \arrow[r, "\partial_A^{i}"'] \arrow[l, "\lambda^i"', bend right=49] & A^{i+1} \arrow[r] \arrow[l, "\lambda^{i+1}"', bend right=49] & \dots. \arrow[l, bend right=49]
#! \end{tikzcd}
#! \end{center}
#! \phantom{x} 
#! For an object $A$ in $\Ch{\CC}$, we define $Q_A$ by the mapping cone of $\id_A$ and $q_A:A \to Q_A$ by the natural injection of $A$ in $Q_A$.
#! \begin{center}
#! \begin{tikzcd}[ampersand replacement=\&]
#! A  \arrow[dd, "q_A"] \& {\cdots} \arrow[r] \& A^{i-1} \arrow[rr, "\partial_A^{i-1}"] \arrow[dd, "{\big(\begin{smallmatrix} 0 & \partial_A^{i-1}\end{smallmatrix}\big)}"'] \&  \& A^i \arrow[dd, "{\big(\begin{smallmatrix} 0 & \partial_A^{i}\end{smallmatrix}\big)}"] \arrow[rr, "\partial_A^i"] \&  \& A^{i+1} \arrow[dd, "{\big(\begin{smallmatrix} 0 & \partial_A^{i+1}\end{smallmatrix}\big)}"] \arrow[r] \& {\cdots} \\
#!     \&            \&                                                                                                                                               \& \&  \& \&    \\
#! Q_A \& {\cdots} \arrow[r] \& A^i\oplus A^{i-1} \arrow[rr, "{\big(\begin{smallmatrix} -\partial_A^{i} & \mathrm{id}_{A^i} \\ 0 & \partial_A^{i-1}\end{smallmatrix}\big)}"'] \&  \& A^{i+1}\oplus A^i \arrow[rr, "{\big(\begin{smallmatrix} -\partial_A^{i+1} & \mathrm{id}_{A^{i+1}} \\ 0 & \partial_A^{i}\end{smallmatrix}\big)}"'] \&  \& A^{i+2}\oplus A^{i+1} \arrow[r]  \& {\cdots}
#! \end{tikzcd}
#! \end{center}
#! \phantom{x}
#! Let $\alpha:A \to B$ be a morphism in $\Ch{\CC}$. The colifting morphism $Q_\alpha: Q_A \to Q_B$ is defined by the morphism
#! \begin{center}
#! \begin{tikzcd}[ampersand replacement=\&]
#! Q_A \arrow[dd, "Q_\alpha"] \& {\cdots} \arrow[r] \& A^i\oplus A^{i-1} \arrow[rr, "{\big(\begin{smallmatrix} -\partial_A^{i} & \mathrm{id}_{A^i} \\ 0 & \partial_A^{i-1}\end{smallmatrix}\big)}"] \arrow[dd, "{{\big(\begin{smallmatrix} \alpha^{i} & 0 \\ 0 & \alpha^{i-1}\end{smallmatrix}\big)}}"'] \&  \& A^{i+1}\oplus A^i \arrow[rr, "{\big(\begin{smallmatrix} -\partial_A^{i+1} & \mathrm{id}_{A^{i+1}} \\ 0 & \partial_A^{i}\end{smallmatrix}\big)}"] \arrow[dd, "{{\big(\begin{smallmatrix} \alpha^{i+1} & 0 \\ 0 & \alpha^{i}\end{smallmatrix}\big)}}"] \&  \& A^{i+2}\oplus A^{i+1} \arrow[r] \arrow[dd, "{{\big(\begin{smallmatrix} \alpha^{i+2} & 0 \\ 0 & \alpha^{i+1}\end{smallmatrix}\big)}}"] \& {\cdots} \\
#!    \&   \&  \&   \&  \&      \&    \\
#! Q_B \& {\cdots} \arrow[r] \& B^i\oplus B^{i-1} \arrow[rr, "{{\big(\begin{smallmatrix} -\partial_B^{i} & \mathrm{id}_{B^i} \\ 0 & \partial_B^{i-1}\end{smallmatrix}\big)}}"']\&  \& B^{i+1}\oplus B^i \arrow[rr, "{{\big(\begin{smallmatrix} -\partial_B^{i+1} & \mathrm{id}_{B^{i+1}} \\ 0 & \partial_B^{i}\end{smallmatrix}\big)}}"']    \&  \& B^{i+2}\oplus B^{i+1} \arrow[r]    \& {\cdots}
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! An easy verification shows that $\comp{\alpha}{q_B}\sim\comp{q_A}{Q_\alpha}$.
#!

#! @Chunk jdHNiWHD10h0jRZTnnH6
#! The following example is an illustration for the system of colifting objects on $\Ch{\CC}$ where
#! $\CC$ be additive closure category of the $\mathbb{Q}$-algebroid $\Lambda_{\mathrm{oid}}$ defined by the following quiver
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A_0 \arrow[rr, "a_0" description] \arrow[dd, "\beta_0" description, bend left] \arrow[dd, "\alpha_0" description, bend right] &  & A_1 \arrow[rr, "a_1" description] \arrow[lldd, "h_1" description] \arrow[dd, "\beta_1" description, bend left] \arrow[dd, "\alpha_1" description, bend right] &  & A_2 \arrow[dd, "\beta_2" description, bend left] \arrow[lldd, "h_2" description] \arrow[dd, "\alpha_2" description, bend right] \\
#!                                                                                                                              &  &                                                                                                                                                              &  &                                                                                                                                \\
#! B_0 \arrow[rr, "b_0" description]                                                                                            &  & B_1 \arrow[rr, "b_1" description]                                                                                                                            &  & B_2                                                                                                                         
#! \end{tikzcd}
#! \end{center}
#! subject to the following relations
#! \begin{itemize}
#! \item $\comp{a_0}{a_1}$, $\comp{b_0}{b_1}$,
#! \item $\comp{a_0}{\alpha_1}-\comp{\alpha_0}{b_0}$, $\comp{a_1}{\alpha_2}-\comp{\alpha_1}{b_1}$,
#! \item $\comp{a_0}{\beta_1}-\comp{\beta_0}{b_0}$, $\comp{a_1}{\beta_2}-\comp{\beta_1}{b_1}$,
#! \item $\alpha_0-\beta_0-\comp{a_0}{h_1}$, $\alpha_1-\beta_1-\comp{a_1}{h_2}-\comp{h_1}{b_0}$, $\alpha_2-\beta_2-\comp{h_2}{b_1}$.
#! \end{itemize}
#! @EndLatexOnly
#! @Example
LoadPackage( "StableCategories" );;
LoadPackage( "FunctorCategories" );;
LoadPackage( "FreydCategories" );;
vertices := [ "A_0", "A_1", "A_2", "B_0", "B_1", "B_2" ];;
sources := [ 1, 2, 4, 5, 2, 3, 1, 2, 3, 1, 2, 3 ];;
targets := [ 2, 3, 5, 6, 4, 5, 4, 5, 6, 4, 5, 6 ];;
arrows :=  [
              "a_0", "a_1", "b_0", "b_1", "h_1", "h_2",
              "alpha_0", "alpha_1", "alpha_2",
              "beta_0", "beta_1", "beta_2"
            ];;
quiver := RightQuiver( "quiver", vertices, arrows, sources, targets );
#! quiver(A_0,A_1,A_2,B_0,B_1,B_2)[a_0:A_0->A_1,a_1:A_1->A_2,b_0:B_0->B_1,
#! b_1:B_1->B_2,h_1:A_1->B_0,h_2:A_2->B_1,alpha_0:A_0->B_0,alpha_1:A_1->B_1,
#! alpha_2:A_2->B_2,beta_0:A_0->B_0,beta_1:A_1->B_1,beta_2:A_2->B_2]
QQ := HomalgFieldOfRationals( );
#! Q
oid := Algebroid( QQ, quiver );;
AssignSetOfObjects( oid );
AssignSetOfGeneratingMorphisms( oid );
rels := [
           PreCompose( a_0, a_1 ), PreCompose( b_0, b_1 ),
           PreCompose( a_0, alpha_1 ) - PreCompose( alpha_0, b_0),
           PreCompose( a_1, alpha_2 ) - PreCompose( alpha_1, b_1 ),
           PreCompose( a_0, beta_1 ) - PreCompose( beta_0, b_0 ),
           PreCompose( a_1, beta_2 ) - PreCompose( beta_1, b_1 ),
           alpha_0 - beta_0 - PreCompose( a_0, h_1 ),
           alpha_1 - beta_1 - PreCompose( a_1, h_2 ) - PreCompose( h_1, b_0 ), 
           alpha_2 - beta_2 - PreCompose( h_2, b_1 )
        ];
#! [ (A_0)-[1*(a_0*a_1)]->(A_2), (B_0)-[1*(b_0*b_1)]->(B_2), 
#!   (A_0)-[-1*(alpha_0*b_0) + 1*(a_0*alpha_1)]->(B_1), 
#!   (A_1)-[-1*(alpha_1*b_1) + 1*(a_1*alpha_2)]->(B_2),
#!   (A_0)-[-1*(beta_0*b_0) + 1*(a_0*beta_1)]->(B_1), 
#!   (A_1)-[-1*(beta_1*b_1) + 1*(a_1*beta_2)]->(B_2),
#!   (A_0)-[-1*(a_0*h_1) - 1*(beta_0) + 1*(alpha_0)]->(B_0), 
#!   (A_1)-[-1*(h_1*b_0) - 1*(a_1*h_2) - 1*(beta_1) + 1*(alpha_1)]->(B_1), 
#!   (A_2)-[-1*(h_2*b_1) - 1*(beta_2) + 1*(alpha_2)]->(B_2) ]
oid := oid / rels;;
oid!.Name := "Algebroid( V=6, E=12, Rel=9 )";;
AssignSetOfObjects( oid );
AssignSetOfGeneratingMorphisms( oid );
Aoid := AdditiveClosure( oid );
#! Additive closure( Algebroid( V=6, E=12, Rel=9 ) )
Ch_Aoid := CochainComplexCategory( Aoid );
#! Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 ) ) )
A := CochainComplex( [ [[a_0]]/Aoid, [[a_1]]/Aoid ], 0 );
#! <An object in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound 0 and active upper bound 2>
Q_A := ColiftingObject( A );
#! <An object in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound -1 and active upper bound 2>
q_A := MorphismToColiftingObjectWithGivenColiftingObject( A, Q_A );
#! <A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound 0 and active upper bound 2>
IsColiftingObject( Q_A );
#! true
Q_Q_A := ColiftingObject( Q_A );
#! <An object in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound -2 and active upper bound 2>
q_Q_A := MorphismToColiftingObject( Q_A );
#! <A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound -1 and active upper bound 2>
r_Q_A := RetractionOfMorphismToColiftingObject( Q_A );
#! <A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound -1 and active upper bound 2>
IsCongruentForMorphisms(
        PreCompose( q_Q_A, r_Q_A ), IdentityMorphism( Q_A )
      );
#! true
B := CochainComplex( [ [[b_0]]/Aoid, [[b_1]]/Aoid ], 0 );
#! <An object in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound 0 and active upper bound 2>
Q_B := ColiftingObject( B );
#! <An object in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound -1 and active upper bound 2>
q_B := MorphismToColiftingObjectWithGivenColiftingObject( B, Q_B );
#! <A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound 0 and active upper bound 2>
alpha := CochainMorphism(
             A, B,
             [ [[alpha_0]]/Aoid, [[alpha_1]]/Aoid, [[alpha_2]]/Aoid ],
             0
         );
#! <A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound 0 and active upper bound 2>
IsWellDefined( alpha );
#! true
Q_alpha := ColiftingMorphismWithGivenColiftingObjects( Q_A, alpha, Q_B );
#! <A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound -1 and active upper bound 2>
IsCongruentForMorphisms(
      PreCompose( alpha, q_B ), PreCompose( q_A, Q_alpha )
    );
#! true
beta :=  CochainMorphism(
             A, B,
             [ [[beta_0]]/Aoid, [[beta_1]]/Aoid, [[beta_2]]/Aoid ],
             0
         );
#! <A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound 0 and active upper bound 2>
IsWellDefined( beta );
#! true
gamma := alpha - beta;
#! <A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound 0 and active upper bound 2>
IsColiftableAlongMorphismToColiftingObject( gamma );
#! true
w := WitnessForBeingColiftableAlongMorphismToColiftingObject( gamma );
#! <A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#!  ) ) with active lower bound 0 and active upper bound 2>
IsCongruentForMorphisms( PreCompose( q_A, w ), gamma );
#! true
#! @EndExample
