#? ReadPackage( "StableCategories", "examples/doc/CategoryOfArrows.g" );

#! @Chunk NVqCpmp6ccYzEKjwZX5B
#! @BeginLatexOnly
#! The following example is an illustration for the system of colifting objects on $\mathrm{Arr}(\CC)$ where
#! $\CC$ be additive closure category of the $\mathbb{Q}$-algebroid $\Lambda_{\mathrm{oid}}$ defined by the following quiver
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
#! In the next chapter
#! @LatexOnly subsection \ref{Subsection_YlKk3B5n4Q15dKo81eOJ},
#! we will see that the associated stable category is equivalent to the Freyd category of $\CC$.
#! @Example
ReadPackage( "StableCategories", "examples/doc/CategoryOfArrows-0.g" );
#! true

MAKE_READ_WRITE_GLOBAL( "REREADING" );
REREADING := true;;
SetInfoLevel( InfoWarning, 0 );

vertices := [ "A_1", "A_2", "B_1", "B_2" ];;
sources := [ 1, 1, 1, 1, 1, 2, 2, 2, 2, 3 ];;
targets := [ 2, 2, 3, 3, 3, 1, 3, 4, 4, 4 ];;
arrows :=  [ "u", "alpha",   "tau", "phi_1", "psi_1",
             "v", "w", "phi_2", "psi_2", "beta" ];;
quiver := RightQuiver( "quiver", vertices, arrows, sources, targets );
#! quiver(A_1,A_2,B_1,B_2)[u:A_1->A_2,alpha:A_1->A_2,tau:A_1->B_1,phi_1:A_1->B_1,
#! psi_1:A_1->B_1,v:A_2->A_1,w:A_2->B_1,phi_2:A_2->B_2,psi_2:A_2->B_2,beta:B_1->B_2]
QQ := HomalgFieldOfRationals( );
#! Q
oid := Algebroid( QQ, quiver );;
AssignSetOfObjects( oid );
AssignSetOfGeneratingMorphisms( oid );
rels := [
              PreCompose( v, alpha ),
              PreCompose( v, tau ),
              PreCompose( v, phi_1 ),
              PreCompose( v, psi_1 ),
              PreCompose( v, u ) - IdentityMorphism( A_2 ),
              PreCompose( alpha, phi_2 ) - PreCompose( phi_1, beta ),
              PreCompose( alpha, phi_2 ) - PreCompose( tau, beta ),
              PreCompose( alpha, psi_2 ) - PreCompose( psi_1, beta ),
              PreCompose( w, beta ) - psi_2
           ];
#! [ (A_2)-[1*(v*alpha)]->(A_2), (A_2)-[1*(v*tau)]->(B_1),
#!   (A_2)-[1*(v*phi_1)]->(B_1), (A_2)-[1*(v*psi_1)]->(B_1), 
#!   (A_2)-[1*(v*u) - 1*(A_2)]->(A_2),
#!   (A_1)-[-1*(phi_1*beta) + 1*(alpha*phi_2)]->(B_2), 
#!   (A_1)-[-1*(tau*beta) + 1*(alpha*phi_2)]->(B_2),
#!   (A_1)-[-1*(psi_1*beta) + 1*(alpha*psi_2)]->(B_2), 
#!   (A_2)-[1*(w*beta) - 1*(psi_2)]->(B_2) ]
oid := oid / rels;;
oid!.Name := "Algebroid( V=4, E=10, Rel=7 )";;
AssignSetOfObjects( oid );
AssignSetOfGeneratingMorphisms( oid );
Aoid := AdditiveClosure( oid );
#! Additive closure( Algebroid( V=4, E=10, Rel=7 ) )
AAoid := CategoryOfArrows( Aoid );
#! The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )
1_m_2 := Source( AAoid );
#! Algebroid( q(2)[m:1->2] )
Aoid = Range( AAoid );
#! true
A := CategoryOfArrowsObject( AAoid, [ [ alpha ] ] / Aoid );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsZeroForObjects( A );
#! false
B := CategoryOfArrowsObject( AAoid, [ [ beta ] ] / Aoid );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsZeroForObjects( B );
#! false
phi := CategoryOfArrowsMorphism(
            A,
            [ [ phi_1 ] ] / Aoid,
            [ [ phi_2 ] ] / Aoid,
            B
        );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
psi := CategoryOfArrowsMorphism(
            A,
            [ [ psi_1 ] ] / Aoid,
            [ [ psi_2 ] ] / Aoid,
            B
        );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsWellDefined( phi );
#! true
IsWellDefined( psi );
#! true
Q_A := ColiftingObject( A );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
Q_B := ColiftingObject( B );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
q_A := MorphismToColiftingObjectWithGivenColiftingObject( A, Q_A );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
q_B := MorphismToColiftingObjectWithGivenColiftingObject( B, Q_B );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
Q_phi := ColiftingMorphismWithGivenColiftingObjects( Q_A, phi, Q_B );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsCongruentForMorphisms( PreCompose( q_A, Q_phi ), PreCompose( phi, q_B ) );
#! true
Q_psi := ColiftingMorphismWithGivenColiftingObjects( Q_A, psi, Q_B );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsCongruentForMorphisms( PreCompose( q_A, Q_psi ), PreCompose( psi, q_B ) );
#! true
IsSplitEpimorphism( [ [ u ] ] / Aoid );
#! true
U := CategoryOfArrowsObject( AAoid, [ [ u ] ] / Aoid );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsZeroForObjects( U );
#! false
Q_U := ColiftingObject( U );
#! <An object in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
q_U := MorphismToColiftingObjectWithGivenColiftingObject( U, Q_U );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsSplitMonomorphism( q_U );
#! true
r_U := RetractionOfMorphismToColiftingObject( U );
#! <A morphism in The category of functors:
#! Algebroid( q(2)[m:1->2] ) -> Additive closure( Algebroid( V=4, E=10, Rel=7 ) )>
IsWellDefined( r_U );
#! true
IsCongruentForMorphisms( PreCompose( q_U, r_U ), IdentityMorphism( U ) );
#! true
#! @EndExample
