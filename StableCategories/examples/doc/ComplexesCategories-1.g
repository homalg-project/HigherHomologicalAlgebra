


#! @Chunk 625C968E2GmBN9Gh2bLI 
#! In this example we continue the Code example in Subsection
#! @LatexOnly \ref{Subsection_jdHNiWHD10h0jRZTnnH6}. We will construct the stable category $\Ch{\CC}/I$ where $\CC$ is 
#! the additive closure of the $\mathbb{Q}$-algebroid defined by the quiver
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A_0 \arrow[rr, "a_0" description] \arrow[dd, "\beta_0" description, bend left] \arrow[dd, "\alpha_0" description, bend right] &  & A_1 \arrow[rr, "a_1" description] \arrow[lldd, "h_1" description] \arrow[dd, "\beta_1" description, bend left] \arrow[dd, "\alpha_1" description, bend right] &  & A_2 \arrow[dd, "\beta_2" description, bend left] \arrow[lldd, "h_2" description] \arrow[dd, "\alpha_2" description, bend right] \\
#! &  &  &  &  \\
#! B_0 \arrow[rr, "b_0" description]  &  & B_1 \arrow[rr, "b_1" description]    &  & B_2                                                                                                                   
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
#! The stable category $\Ch{\CC}/I$ is isomorphic to the bounded homotopy category $\Ho{\CC}$. This follows from the fact that a morphism
#! $\alpha:A \to B$ in $\Ch{\CC}$ is null-homotopic if and only if it colifts along the $q_A:A \to Q_A$ where $q_A$ is the natural injection
#! of $A$ in the mapping cone of $\id_A$.
#! @Example
ReadPackage( "StableCategories", "examples/doc/ComplexesCategories-0.g" );
#! true
Ch_Aoid;
#! Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 ) ) )
St_Ch_Aoid := StableCategoryBySystemOfColiftingObjects( Ch_Aoid );
#! Stable category( Cochain complexes( Additive closure( 
#! Algebroid( V=6, E=12, Rel=9 ) ) ) ) defined by a system of colifting objects
class_A := StableCategoryObject( St_Ch_Aoid, A );
#! <An object in Stable category( Cochain complexes(
#! Additive closure( Algebroid( V=6, E=12, Rel=9 ) )
#! ) ) defined by a system of colifting objects>
class_B := StableCategoryObject( St_Ch_Aoid, B );
#! <An object in Stable category( Cochain complexes(
#! Additive closure( Algebroid( V=6, E=12, Rel=9 
#! ) ) ) ) defined by a system of colifting objects>
Hom_AB := HomStructure( A, B );
#! <A vector space object over Q of dimension 3>
Hom_A_B := BasisOfExternalHom( A, B );;
Display( Hom_A_B[ 1 ] );
#! 
#! == 2 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_2)-[{ 0 }]->(B_2)
#! == 1 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_1)-[{ 1*(a_1*h_2) + 1*(beta_1) - 1*(alpha_1) }]->(B_1)
#! == 0 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_0)-[{ 1*(beta_0) - 1*(alpha_0) }]->(B_0)
#! 
#! A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 ) 
#! ) ) given by the above data
Display( Hom_A_B[ 2 ] );
#! 
#! == 2 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_2)-[{ 1*(alpha_2) }]->(B_2)
#! == 1 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_1)-[{ 1*(alpha_1) }]->(B_1)
#! == 0 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_0)-[{ 1*(alpha_0) }]->(B_0)
#! 
#! A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#! ) ) given by the above data
Display( Hom_A_B[ 3 ] );
#! 
#! == 2 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_2)-[{ 1*(beta_2) }]->(B_2)
#! == 1 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_1)-[{ 1*(beta_1) }]->(B_1)
#! == 0 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_0)-[{ 1*(beta_0) }]->(B_0)
#! 
#! A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#! ) ) given by the above data
Hom_class_A_class_B := HomStructure( class_A, class_B );
#! <A vector space object over Q of dimension 1>
Hom_class_A_class_B := BasisOfExternalHom( class_A, class_B );;
Display( Hom_class_A_class_B[ 1 ] );
#! A morphism in Stable category( Cochain complexes( Additive closure( 
#! Algebroid( V=6, E=12, Rel=9 ) ) ) ) defined by a system of colifting 
#! objects defined by the underlying morphism:
#! 
#! 
#! == 2 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_2)-[{ 1*(alpha_2) }]->(B_2)
#! == 1 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_1)-[{ 1*(alpha_1) }]->(B_1)
#! == 0 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_0)-[{ 1*(alpha_0) }]->(B_0)
#! 
#! A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 ) 
#! ) ) given by the above data
class_alpha := StableCategoryMorphism( St_Ch_Aoid, alpha );
#! <A morphism in Stable category( Cochain complexes( Additive closure( 
#! Algebroid( V=6, E=12, Rel=9 ) ) ) ) defined by a system of colifting objects>
class_beta := StableCategoryMorphism( St_Ch_Aoid, beta );
#! <A morphism in Stable category( Cochain complexes( Additive closure( 
#! Algebroid( V=6, E=12, Rel=9 ) ) ) ) defined by a system of colifting objects>
IsCongruentForMorphisms( class_alpha, class_beta );
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
Display( w );
#! 
#! == 2 =======================
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_2)-[{ -1*(beta_2) + 1*(alpha_2) }]->(B_2)
#! == 1 =======================
#! A 2 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_2)-[{ 1*(h_2) }]->(B_1)
#! [2,1]: (A_1)-[{ -1*(beta_1) + 1*(alpha_1) }]->(B_1)
#! == 0 =======================
#! A 2 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_1)-[{ 1*(h_1) }]->(B_0)
#! [2,1]: (A_0)-[{ -1*(beta_0) + 1*(alpha_0) }]->(B_0)
#! 
#! A morphism in Cochain complexes( Additive closure( Algebroid( V=6, E=12, Rel=9 )
#! ) ) given by the above data
H := HomotopyMorphisms( gamma );
#! <ZFunction>
Display( H[ 1 ] );
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_1)-[{ 1*(h_1) }]->(B_0)
Display( H[ 2 ] );
#! A 1 x 1 matrix with entries in Algebroid( V=6, E=12, Rel=9 )
#! 
#! [1,1]: (A_2)-[{ 1*(h_2) }]->(B_1)
#! @EndExample
