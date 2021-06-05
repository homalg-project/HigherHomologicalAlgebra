
#! @Chunk YlKk3B5n4Q15dKo81eOJ
#! In this example we continue the Code example in Subsection
#! @LatexOnly \ref{Subsection_NVqCpmp6ccYzEKjwZX5B}.
#! We will construct the stable category of $\mathrm{Arr}(\CC)$ where $\CC$ is the additive closure of the $\mathbb{Q}$-algebroid
#! defined by the quiver
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A_1 \arrow[rrr, "\alpha" description] \arrow[dd, "\phi_1" description] \arrow[rrr, "u" description, bend left] \arrow[dd, "\psi_1" description, bend left=49] \arrow[dd, "\tau" description, bend right=49] &  &  & A_2 \arrow[dd, "\phi_2" description] \arrow[lll, "v" description, bend right=49, shift right] \arrow[dd, "\psi_2" description, bend left=49] \arrow[llldd, "w" description] \\
#! {}                                                                                                                                                                                                          &  &  &                                                                                                                                                                             \\
#! B_1 \arrow[rrr, "\beta" description]                                                                                                                                                                        &  &  & B_2                                                                                                                                                                        
#! \end{tikzcd}
#! \end{center}
#! subject to the following relations:
#! \begin{itemize}
#! \item $\comp{v}{\alpha}$, $\comp{v}{ \tau}$, $\comp{v}{ \phi_1}$, $\comp{v}{ \psi_1}$, $\comp{v}{ u} - \id_{ A_2 },$
#! \item $\comp{\alpha}{ \phi_2} - \comp{\phi_1}{ \beta}$, $\comp{\alpha}{ \phi_2} - \comp{\tau}{ \beta}$,
#! \item $\comp{\alpha}{ \psi_2} - \comp{\psi_1}{ \beta}$,
#! \item $\comp{w}{ \beta} - \psi_2$.
#! \end{itemize}
#! @EndLatexOnly

#! @Example
ReadPackage( "StableCategories", "examples/doc/CategoryOfArrows-1.g" );
#! true
AAoid;
#! The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )
St_AAoid := StableCategoryBySystemOfColiftingObjects( AAoid );
#! Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects
class_A := StableCategoryObject( St_AAoid, A );
#! <An object in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZeroForObjects( class_A );
#! false
class_B := StableCategoryObject( St_AAoid, B );
#! <An object in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZeroForObjects( class_B );
#! false
class_U := StableCategoryObject( St_AAoid, U );
#! <An object in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZeroForObjects( class_U );
#! true
class_phi := StableCategoryMorphism( class_A, phi, class_B );
#! <A morphism in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZeroForMorphisms( class_phi );
#! false
class_psi := StableCategoryMorphism( class_A, psi, class_B );
#! <A morphism in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects>
IsZeroForMorphisms( class_psi );
#! true
IsLiftable( [ [ psi_2 ] ] / Aoid, [ [ beta ] ] / Aoid );
#! true
IsCongruentForMorphisms(
        PreCompose( [ [ w ] ] / Aoid, [ [ beta ] ] / Aoid ),
        [ [ psi_2 ] ] / Aoid
  );
#! true
HomStructure( A, B );
#! <A vector space object over Q of dimension 4>
HomStructure( class_A, class_B );
#! <A vector space object over Q of dimension 1>
Hom_class_A_class_B := BasisOfExternalHom( class_A, class_B );
#! [ <A morphism in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects> ]
Display( Hom_class_A_class_B[ 1 ] );
#! A morphism in Stable category( The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) ) 
#! defined by a system of colifting objects defined by the underlying morphism:
#! 
#! A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )
#! defined by the following data:
#! 
#! Image of <(1)>:
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (A_1)-[{ 1*(tau) }]->(B_1)
#! 
#! Image of <(2)>:
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (A_2)-[{ 1*(phi_2) }]->(B_2)
Freyd_Aoid := FreydCategory( Aoid );
#! Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )
FA := FreydCategoryObject( [ [ alpha ] ] / Aoid );
#! <An object in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )>
IsZeroForObjects( FA );
#! false
FB := FreydCategoryObject( [ [ beta ] ] / Aoid );
#! <An object in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )>
IsZeroForObjects( FB );
#! false
FU := FreydCategoryObject( [ [ u ] ] / Aoid );
#! <An object in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )>
IsZeroForObjects( FU );
#! true
Fphi := FreydCategoryMorphism( FA, [ [ phi_2 ] ] / Aoid, FB );
#! <A morphism in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )>
IsZeroForMorphisms( Fphi );
#! false
Fpsi := FreydCategoryMorphism( FA, [ [ psi_2 ] ] / Aoid, FB );
#! <A morphism in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )>
IsZeroForMorphisms( Fpsi );
#! true
HomStructure( FA, FB );
#! <A vector space object over Q of dimension 1>
Hom_FA_FB := BasisOfExternalHom( FA, FB );
#! [ <A morphism in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )> ]
Display( Hom_FA_FB[ 1 ] );
#! 
#! --------------------------------
#! Source:
#! --------------------------------
#! 
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (A_1)-[{ 1*(alpha) }]->(A_2)
#! 
#! --------------------------------
#! Morphism datum:
#! --------------------------------
#! 
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (A_2)-[{ 1*(phi_2) }]->(B_2)
#! 
#! --------------------------------
#! Range:
#! --------------------------------
#! 
#! A 1 x 1 matrix with entries in Algebroid( V=4, E=10, Rel=7 )
#! 
#! [1,1]: (B_1)-[{ 1*(beta) }]->(B_2)
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#! 
#! A morphism in Freyd( Additive closure( Algebroid( V=4, E=10, Rel=7 ) ) )
#! @EndExample
