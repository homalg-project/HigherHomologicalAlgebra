###############################################
# resolutions.gd             complex package
#
# Feb. 2017
###############################################

#! @Chapter Resolutions
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
#! @EndLatexOnly
#! @EndSection

#! @Section Computing resolutions

DeclareOperationWithCache( "EpimorphismFromProjectiveObject", [ IsCapCategoryObject  ] );

DeclareOperation( "AddEpimorphismFromProjectiveObject",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEpimorphismFromProjectiveObject",
                   [ IsCapCategory, IsFunction ] );


DeclareOperation( "AddEpimorphismFromProjectiveObject",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEpimorphismFromProjectiveObject",
                   [ IsCapCategory, IsList ] );


DeclareOperationWithCache( "MonomorphismInInjectiveObject", [ IsCapCategoryObject  ] );

DeclareOperation( "AddMonomorphismInInjectiveObject",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonomorphismInInjectiveObject",
                   [ IsCapCategory, IsFunction ] );


DeclareOperation( "AddMonomorphismInInjectiveObject",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonomorphismInInjectiveObject",
                   [ IsCapCategory, IsList ] );

# New properties of cap categories

DeclareProperty( "HasEnoughProjectives", IsCapCategory );

DeclareProperty( "HasEnoughInjectives", IsCapCategory );



DeclareAttribute( "ProjectiveResolution", IsBoundedBelowChainComplex );

DeclareAttribute( "ProjectiveResolution", IsBoundedAboveCochainComplex );

DeclareAttribute( "InjectiveResolution", IsBoundedAboveChainComplex );

DeclareAttribute( "InjectiveResolution", IsBoundedBelowCochainComplex );


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