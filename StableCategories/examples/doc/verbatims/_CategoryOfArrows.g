




#! @Chunk RQztP14RWWSvFYPgkHbn
#! Let $\CC$ be an additive category and $\mathrm{Arr}(\CC)$ its category of arrows, i.e.,
#! its objects are morphisms in $\CC$ and its morphisms are commutative squars in $\CC$.
#! The class $\QQ$ of all objects in $\mathrm{Arr}(\CC)$ that are represented by split-epimorphisms defines a system of colifting objects in $\mathrm{Arr}(\CC)$.
#! For an object $A=(\alpha:A_1 \to A_2)$ in $\mathrm{Arr}(\CC)$, we define $Q_A$ by
#! @LatexOnly $\bigl(\bigl(\begin{smallmatrix} \alpha \\ \id_{A_2}\end{smallmatrix}\bigr): A_1 \oplus A_2 \to A_2\bigr)$
#! and $q_A: A \to Q_A$ by the commutative square whose legs are
#! @LatexOnly $\bigl(\begin{smallmatrix} \id_{A_1} & 0\end{smallmatrix}\bigr): A_1 \to A_1 \oplus A_2$
#! and $\id_{A_2}:A_2 \to A_2$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}[ampersand replacement=\&]
#! A \arrow[d, "q_A"] \& A_1 \arrow[r, "\alpha"] \arrow[d, "{\bigl(\begin{smallmatrix}\mathrm{id}_{A_1} & 0 \end{smallmatrix}\bigr)}"', hook] \& A_2 \arrow[d, "\mathrm{id}_{A_2}", hook] \\
#! Q_A                \& A_1 \oplus A_2 \arrow[r, "{\bigl(\begin{smallmatrix}\alpha \\ \mathrm{id}_{A_2} \end{smallmatrix}\bigr)}"']          \& \phantom{.}A_2.
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#!
#! If $A$ belong to $\QQ$, then $\alpha:A_1 \to A_2$ is a split-epimorphism and it has a section morphism is $\gamma: A_2 \to A_1$. In this case $q_A$ is a split-monomorphism and its retraction morphism is given by the commutative square
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}[ampersand replacement=\&]
#! A                    \& A_1 \arrow[r, "\alpha"]                                                                                                                                                                                 \& A_2                                 \\
#! Q_A \arrow[u, "r_A"] \& A_1 \oplus A_2 \arrow[u, "{\bigl(\begin{smallmatrix}\mathrm{id}_{A_1} \\ \gamma \end{smallmatrix}\bigr)}"] \arrow[r, "{\bigl(\begin{smallmatrix}\alpha \\ \mathrm{id}_{A_2} \end{smallmatrix}\bigr)}"'] \& \phantom{.}A_2. \arrow[u, "\mathrm{id}_{A_2}"']
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#! Let $B=(\beta:B_1 \to B_2)$ be an object in $\mathrm{Arr}(\CC)$ and $\varphi: A \to B$ be a morphism defined by a commutative square
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A \arrow[d, "\varphi"'] & A_1 \arrow[r, "\alpha"] \arrow[d, "\varphi_1"'] & A_2 \arrow[d, "\varphi_2"] \\
#! B                       & B_1 \arrow[r, "\beta"']                         & B_2. 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! We define $Q_{\varphi}: Q_A \to Q_B$ by the commutative square
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}[ampersand replacement=\&]
#! Q_A \arrow[d, "Q_\varphi"'] \& A_1 \oplus A_2 \arrow[r, "{\bigl(\begin{smallmatrix}\alpha \\ \mathrm{id}_{A_2} \end{smallmatrix}\bigr)}"] \arrow[d, "{\bigl(\begin{smallmatrix}\varphi_1 & 0 \\ 0 & \varphi_2 \end{smallmatrix}\bigr)}"'] \& A_2 \arrow[d, "\varphi_2"] \\
#! Q_B                         \& B_1 \oplus B_2 \arrow[r, "{\bigl(\begin{smallmatrix}\beta \\ \mathrm{id}_{B_2} \end{smallmatrix}\bigr)}"']                                                                                                 \& \phantom{.}B_2                      . 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#!
#! The arrows category $\mathrm{Arr}(\CC)$ is isomorphic to the category of functors $\mathrm{Hom}(1\to 2,\CC)$, 
#! where $1 \to 2$ is the interval category which is the $\mathbb{Z}$-linear
#! closure of the quiver consisting of two vertices $v_1,v_2$ and an arrow $m:v_1\to v_2$.
#!
#! The following operation takes and additive category $\CC$ and constructs its arrows category $\mathrm{Arr}(\CC)$ and equipps it with the above system of colifting objects.
#! It requires the &GAP; package
#! @LatexOnly \cite[FunctorCategories]{FunctorCategories2021.05-01}.
#! 
#! @BeginLatexOnly
#!\begin{Verbatim}[commandchars=!?|,fontsize=\small,frame=single,label=Code]
#!  LoadPackage!cbracket?(| !cstring?"FunctorCategories"| !cbracket?)|;
#!  LoadPackage!cbracket?(| !cstring?"StableCategories"| !cbracket?)|;
#!  !gapinput?|
#!  !ccomment?##|
#!  DeclareAttribute!cbracket?(| !cstring?"CategoryOfArrows"|!cbracket?,| IsCapCategory !cbracket?)|;
#!  !gapinput?| 
#!  !ccomment?##|
#!  InstallMethod!cbracket?(| CategoryOfArrows!cbracket?,|
#!            !cbracket?[| IsCapCategory !cbracket?]|!cbracket?,|
#!     !gapinput?| 
#!     !ckey?function|!cbracket?(| C !cbracket?)|
#!       !ckey?local| quiver!cbracket?,| ring!cbracket?,| algebra!cbracket?,| over_Z!cbracket?,| algebroid!cbracket?,| arrows;
#!     !gapinput?|        
#!       quiver !cequality?:=| RightQuiver!cbracket?(| !cstring?"q(1,2)[m:1->2]"| !cbracket?)|;
#!    !gapinput?|        
#!       ring !cequality?:=| CommutativeRingOfLinearCategory!cbracket?(| C !cbracket?)|;
#!    !gapinput?|        
#!       !ckey?if| HasIsFieldForHomalg!cbracket?(| ring !cbracket?)| and IsFieldForHomalg!cbracket?(| ring !cbracket?)| then
#!    !gapinput?|            
#!         algebra !cequality?:=| PathAlgebra!cbracket?(| ring!cbracket?,| quiver !cbracket?)|;
#!    !gapinput?|            
#!         over_Z !cequality?:=| false;
#!    !gapinput?|            
#!       !ckey?else|
#!    !gapinput?|            
#!         algebra !cequality?:=| PathAlgebra!cbracket?(| HomalgFieldOfRationals!cbracket?(| !cbracket?)|!cbracket?,| quiver !cbracket?)|;
#!    !gapinput?|            
#!         over_Z !cequality?:=| true;
#!    !gapinput?|            
#!       !ckey?fi|;
#!    !gapinput?|            
#!       algebroid !cequality?:=| Algebroid!cbracket?(| algebra!cbracket?,| over_Z !cbracket?)|;
#!    !gapinput?|            
#!       arrows !cequality?:=| Hom!cbracket?(| algebroid!cbracket?,| C : FinalizeCategory !cequality?:=| false !cbracket?)|;
#!    !gapinput?|            
#!       !ccomment?## Defining the system of colifting objects|
#!    !gapinput?|    
#!       AddIsColiftingObject!cbracket?(| arrows!cbracket?,|
#!           { category!cbracket?,| A } -> IsSplitEpimorphism!cbracket?(| A!cbracket?(| algebroid.m !cbracket?)| !cbracket?)|
#!       !cbracket?)|;
#!    !gapinput?|    
#!       !ccomment?##|
#!       AddColiftingObject!cbracket?(| arrows!cbracket?,|
#!         !ckey?function|!cbracket?(| category!cbracket?,| A !cbracket?)|
#!           !ckey?local| A_1!cbracket?,| A_2!cbracket?,| QA_1!cbracket?,| QA_2!cbracket?,| A_m!cbracket?,| QA_m;
#!    !gapinput?|                    
#!           A_1 !cequality?:=| A!cbracket?(| algebroid.!cint?1| !cbracket?)|;
#!           A_2 !cequality?:=| A!cbracket?(| algebroid.!cint?2| !cbracket?)|;
#!    !gapinput?|                    
#!           QA_1 !cequality?:=| DirectSum!cbracket?(| A_1!cbracket?,| A_2 !cbracket?)|;
#!           QA_2 !cequality?:=| A_2;
#!    !gapinput?|                    
#!           A_m !cequality?:=| A!cbracket?(| algebroid.m !cbracket?)|;
#!    !gapinput?|            
#!           QA_m !cequality?:=| !cbracket?[|
#!                     MorphismBetweenDirectSums!cbracket?(|
#!                         !cbracket?[|
#!                             !cbracket?[| A_m !cbracket?]|!cbracket?,|
#!                             !cbracket?[| IdentityMorphism!cbracket?(| A_2 !cbracket?)| !cbracket?]|
#!                         !cbracket?]|
#!                      !cbracket?)|
#!                   !cbracket?]|;
#!    !gapinput?|                    
#!           !ckey?return| AsObjectInHomCategory!cbracket?(| algebroid!cbracket?,| !cbracket?[| QA_1!cbracket?,| QA_2 !cbracket?]|!cbracket?,| QA_m !cbracket?)|;
#!    !gapinput?|
#!         !ckey?end| !cbracket?)|;
#!    !gapinput?|    
#!       !ccomment?##|
#!       AddMorphismToColiftingObjectWithGivenColiftingObject!cbracket?(| arrows!cbracket?,|
#!         !ckey?function|!cbracket?(| category!cbracket?,| A!cbracket?,| QA !cbracket?)|
#!           !ckey?local| A_1!cbracket?,| A_2!cbracket?,| qA_1!cbracket?,| qA_2;
#!   !gapinput?|                    
#!           A_1 !cequality?:=| A!cbracket?(| algebroid.!cint?1| !cbracket?)|;
#!   !gapinput?|                    
#!           A_2 !cequality?:=| A!cbracket?(| algebroid.!cint?2| !cbracket?)|;
#!   !gapinput?|                    
#!           qA_1 !cequality?:=| MorphismBetweenDirectSums!cbracket?(|
#!                        !cbracket?[|
#!                            !cbracket?[| IdentityMorphism!cbracket?(| A_1 !cbracket?)|!cbracket?,| ZeroMorphism!cbracket?(| A_1!cbracket?,| A_2 !cbracket?)| !cbracket?]|
#!                        !cbracket?]|
#!                    !cbracket?)|;
#!   !gapinput?|                    
#!           qA_2 !cequality?:=| IdentityMorphism!cbracket?(| A_2 !cbracket?)|;
#!   !gapinput?|            
#!           !ckey?return| AsMorphismInHomCategory!cbracket?(| A!cbracket?,| !cbracket?[| qA_1!cbracket?,| qA_2 !cbracket?]|!cbracket?,| QA !cbracket?)|;
#!   !gapinput?|            
#!         !ckey?end| !cbracket?)|;
#!   !gapinput?|
#!       !ccomment?##|
#!       AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject!cbracket?(| arrows,
#!         !ckey?function|!cbracket?(| category!cbracket?,| A!cbracket?,| QA !cbracket?)|
#!           !ckey?local| A_1!cbracket?,| A_2!cbracket?,| alpha!cbracket?,| gamma!cbracket?,| rA_1!cbracket?,| rA_2;
#!          !gapinput?| 
#!           A_1 !cequality?:=| A!cbracket?(| algebroid.!cint?1| !cbracket?)|;
#!           !gapinput?|
#!           A_2 !cequality?:=| A!cbracket?(| algebroid.!cint?2| !cbracket?)|;
#!           !gapinput?|
#!           alpha !cequality?:=| A!cbracket?(| algebroid.m !cbracket?)|;
#!           !gapinput?|
#!           gamma !cequality?:=| SectionForMorphisms!cbracket?(| alpha !cbracket?)|;
#!           !gapinput?|
#!           rA_1 !cequality?:=| MorphismBetweenDirectSums(
#!                     !cbracket?[|
#!                       !cbracket?[| IdentityMorphism!cbracket?(| A_1 !cbracket?)| !cbracket?]|!cbracket?,|
#!                       !cbracket?[| gamma !cbracket?]|
#!                     !cbracket?]|
#!                   !cbracket?)|;
#!           !gapinput?|
#!           rA_2 !cequality?:=| IdentityMorphism!cbracket?(| A_2 !cbracket?)|;
#!           !gapinput?|
#!           !ckey?return| AsMorphismInHomCategory!cbracket?(| QA!cbracket?,| !cbracket?[| rA_1!cbracket?,| rA_2 !cbracket?]|!cbracket?,| A !cbracket?)|;
#!           !gapinput?|
#!         !ckey?end| );
#! !gapinput?|
#!       !ccomment?##|
#!       AddColiftingMorphismWithGivenColiftingObjects!cbracket?(| arrows!cbracket?,|
#!         !ckey?function|!cbracket?(| category!cbracket?,| QA!cbracket?,| phi!cbracket?,| QB !cbracket?)|
#!           !ckey?local| phi_1!cbracket?,| phi_2!cbracket?,| Qphi_1!cbracket?,| Qphi_2;
#!   !gapinput?|                    
#!           phi_1 !cequality?:=| phi!cbracket?(| algebroid.!cint?1| !cbracket?)|;
#!   !gapinput?|                    
#!           phi_2 !cequality?:=| phi!cbracket?(| algebroid.!cint?2| !cbracket?)|;
#!   !gapinput?|                    
#!           Qphi_1 !cequality?:=| DirectSumFunctorial!cbracket?(| !cbracket?[| phi_1!cbracket?,| phi_2 !cbracket?]| !cbracket?)|;
#!   !gapinput?|                    
#!           Qphi_2 !cequality?:=| phi_2;
#!   !gapinput?|                    
#!           !ckey?return| AsMorphismInHomCategory!cbracket?(| QA!cbracket?,| !cbracket?[| Qphi_1!cbracket?,| Qphi_2 !cbracket?]|!cbracket?,| QB !cbracket?)|;
#!    !gapinput?|
#!         !ckey?end| !cbracket?)|;
#!   !gapinput?|            
#!       Finalize!cbracket?(| arrows !cbracket?)|;
#!   !gapinput?|            
#!       !ckey?return| arrows;
#!   !gapinput?| 
#!     !ckey?end| !cbracket?)|;
#! !gapinput?|
#! !ccomment?##|
#! DeclareOperation!cbracket?(| !cstring?"CategoryOfArrowsObject"|!cbracket?,|
#!   !cbracket?[| IsCapCategory!cbracket?,| IsCapCategoryMorphism !cbracket?]| !cbracket?)|;
#! !gapinput?|
#! !ccomment?##|
#! InstallMethod!cbracket?(| CategoryOfArrowsObject!cbracket?,|
#!           !cbracket?[| IsCapCategory!cbracket?,| IsCapCategoryMorphism !cbracket?]|!cbracket?,|
#! !gapinput?|
#!   !ckey?function|!cbracket?(| category!cbracket?,| alpha !cbracket?)|
#!     !ckey?local| 1_m_2;
#! !gapinput?|
#!     1_m_2 !cequality?:=| Source!cbracket?(| category !cbracket?)|;
#! !gapinput?|    
#!     !ckey?return| AsObjectInHomCategory!cbracket?(|
#!                1_m_2!cbracket?,|
#!                !cbracket?[| Source!cbracket?(| alpha !cbracket?)|!cbracket?,| Range!cbracket?(| alpha !cbracket?)| !cbracket?]|!cbracket?,|
#!                !cbracket?[| alpha !cbracket?]|
#!              !cbracket?)|;
#! !gapinput?|
#! !ckey?end| !cbracket?)|;
#! !gapinput?|
#! !ccomment?##|
#! DeclareOperation!cbracket?(| !cstring?"CategoryOfArrowsMorphism"|!cbracket?,|
#!   !cbracket?[| IsCapCategoryObject!cbracket?,| IsCapCategoryMorphism!cbracket?,|
#!       IsCapCategoryMorphism!cbracket?,| IsCapCategoryObject !cbracket?]| !cbracket?)|;
#! !gapinput?|
#! !ccomment?##|
#! InstallMethod!cbracket?(| CategoryOfArrowsMorphism!cbracket?,|
#!           !cbracket?[| IsCapCategoryObject!cbracket?,| IsCapCategoryMorphism!cbracket?,|
#!              IsCapCategoryMorphism!cbracket?,| IsCapCategoryObject !cbracket?]|!cbracket?,|
#! !gapinput?|
#!   !ckey?function|!cbracket?(| A!cbracket?,| phi_1!cbracket?,| phi_2!cbracket?,| B !cbracket?)|
#! !gapinput?|    
#!     !ckey?return| AsMorphismInHomCategory!cbracket?(| A!cbracket?,| !cbracket?[| phi_1!cbracket?,| phi_2 !cbracket?]|!cbracket?,| B !cbracket?)|;
#! !gapinput?|
#! !ckey?end| !cbracket?)|;
#! \end{Verbatim}
#! @EndLatexOnly
