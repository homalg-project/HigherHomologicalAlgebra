#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
#! @Chapter Resolutions
##
#############################################################################

#! @Section Definitions
#! @BeginLatexOnly
#! Let $A$ be an abelian category and is $C^\bullet$ is a complex in $\mathrm{Ch}^\bullet(A)$.
#! A \emph{projective resolution } of $C^\bullet$ is a complex $P^\bullet$ together with cochain morphism 
#! $\alpha:P^\bullet \rightarrow C^\bullet$ of complexes such that
#! \begin{itemize}
#! \item We have $P^n=0$ for $n\gg 0$, i.e., $P^\bullet$ is bounded above.
#! \item Each $P^n$ is projective object of $A$.
#! \item The morphism $\alpha$ is quasi-isomorphism. 
#! \end{itemize}
#! It turns out that if $A$ is abelian category that has enough projective, then every above bounded cochain
#! complex admits a projective resolution.
#! @EndLatexOnly
#! @EndSection

#! @Section Computing resolutions

#! @Description
#! If the input is bounded above cochain complex or bounded below chain complex then the 
#! output is projective resolution in the sense of the above definition. If the input is
#! an object $M$ which is not a complex and its category has enough projectives, then the output is 
#! its projective resolution in the classical sense
#! , i.e., complex $P^\bullet$ which is exact everywhere but in index $0$,
#! where $H^0(P^\bullet)\cong M$.
#! @Arguments arg
#! @Returns a (co)chain complex
DeclareAttribute( "ProjectiveResolution", IsCapCategoryObject );

DeclareOperation( "ProjectiveResolutionWithBounds", [ IsCapCategoryObject, IsInt ] );

# DeclareAttribute( "ProjectiveResolution", IsCapCategoryObject and IsBoundedBelowChainComplex );

# DeclareAttribute( "ProjectiveResolution", IsCapCategoryObject and IsBoundedAboveCochainComplex );

#! @Description
#! If the input is bounded above chain complex or bounded below cochain complex then the 
#! output is injective resolution in the sense of the above definition. If the input is
#! an object $M$ which is not a complex and its category has enough injectives, then the output is 
#! its injective resolution in the classical sense
#! , i.e., complex $I^\bullet$ which is exact everywhere but in index $0$,
#! where $H^0(I^\bullet)\cong M$.
#! @Arguments arg
#! @Returns a (co)chain complex
DeclareAttribute( "InjectiveResolution", IsCapCategoryObject );

DeclareOperation( "InjectiveResolutionWithBounds", [ IsCapCategoryObject, IsInt ] );

# DeclareAttribute( "InjectiveResolution", IsCapCategoryObject and IsBoundedAboveChainComplex );

# DeclareAttribute( "InjectiveResolution", IsCapCategoryObject and IsBoundedBelowCochainComplex );


#! @BeginGroup 5
#! @Description
#! The input is an above bounded cochain complex $C^\bullet$. The output is
#! a quasi-isomorphism $q:P^\bullet \rightarrow C^\bullet$ such that 
#! $P^\bullet$ is upper bounded and all its objects
#! are projective in the underlying abelian category.
#! In the second command the input is a below bounded chain complex $C_\bullet$. The output is
#! a quasi-isomorphism $q:P_\bullet \rightarrow C_\bullet$ such that 
#! $P_\bullet$ is lower bounded and all its objects
#! are projective in the underlying abelian category.
#! @Arguments C
#! @Returns a (co)chain epimorphism
DeclareAttribute( "QuasiIsomorphismFromProjectiveResolution", IsBoundedAboveCochainComplex );
#! @EndGroup
#! @Group 5
#! @Arguments C
DeclareAttribute( "QuasiIsomorphismFromProjectiveResolution", IsBoundedBelowChainComplex );

#! @BeginGroup 15
#! @Description
#! The input is a below bounded cochain complex $C^\bullet$. The output is
#! a quasi-isomorphism $q:C^\bullet \rightarrow I^\bullet$ such that 
#! $I^\bullet$ is below bounded and all its objects
#! are injective in the underlying abelian category.
#! In the second command the input is an above bounded chain complex $C_\bullet$. The output is
#! a quasi-isomorphism $q: C_\bullet\rightarrow I_\bullet$ such that 
#! $I_\bullet$ is below bounded and all its objects
#! are injective in the underlying abelian category.
#! @Arguments C
#! @Returns a (co)chain epimorphism
DeclareAttribute( "QuasiIsomorphismInInjectiveResolution", IsBoundedBelowCochainComplex );
#! @EndGroup
#! @Group 15
#! @Arguments C
DeclareAttribute( "QuasiIsomorphismInInjectiveResolution", IsBoundedAboveChainComplex );
#! @EndSection
#! @Section Examples
#! @InsertChunk Z_0
#! @EndSection
