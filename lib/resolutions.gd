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

#! @Section Computing resolutions

#! @Description
#! If the input is bounded above cochain complex or bounded below chain complex then the 
#! output is projective resolution in the sense of the above definition. If the input is
#! an object $M$ which is not a complex and its category has enough projectives, then the output is 
#! its projective resolution in the classical sense
#! , i.e., complex $P^\bullet$ which is exact everywhere but in index $0$,
#! where $H^0(P^\bullet)\cong M$.
#! @Arguments C
#! @Returns a (co)chain complex
DeclareAttribute( "ProjectiveResolution", IsCapCategoryObject );

#! @Description
#! The arguments are an object <A>C</A> and a boolian <A>bool</A>. If <A>bool</A> = <K>false</K> then the ouput is 
#! <C>ProjectiveResolution</C>(<A>C</A>), otherwise the output is <C>ProjectiveResolution</C>(<A>C</A>) after trying to find its bounds.
#! @Arguments C, bool
#! @Returns a (co)chain complex
DeclareOperation( "ProjectiveResolution", [ IsCapCategoryObject, IsBool ] );

#! @Description
#! The input is a morphism $\alpha$ whose category is abelian with enough projectives. The output is the induced
#! cochain morphism between the projective resolutions of the source and range of $\alpha$. This morphism is unique up to homotopy.
#! @Arguments alpha
#! @Returns a (co)chain morphism
DeclareAttribute( "MorphismBetweenProjectiveResolutions", IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha$ and a boolian <A>bool</A>. If <A>bool</A> = <K>false</K> then the ouput is 
#! <C>MorphismBetweenProjectiveResolutions</C>($\alpha$), otherwise the output is 
#! <C>MorphismBetweenProjectiveResolutions</C>($\alpha$) after trying to find its bounds.
#! @Arguments alpha, bool
#! @Returns a (co)chain morphism
DeclareOperation( "MorphismBetweenProjectiveResolutions", [ IsCapCategoryMorphism, IsBool ] );

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

#! @Description
#! The arguments are an object <A>C</A> and a boolian <A>bool</A>. If <A>bool</A> = <K>false</K> then the ouput is 
#! <C>InjectiveResolution</C>(<A>C</A>), otherwise the output is <C>InjectiveResolution</C>(<A>C</A>) after trying to find its bounds.
#! @Arguments C, bool
#! @Returns a (co)chain complex
DeclareOperation( "InjectiveResolution", [ IsCapCategoryObject, IsBool ] );

#! @Description
#! The input is a morphism $\alpha$ whose category is abelian with enough injectives. The output is the induced
#! cochain morphism between the injective resolutions of the source and range of $\alpha$.
#! This morphism is unique up to homotopy.
#! @Arguments alpha
#! @Returns a (co)chain morphism
DeclareAttribute( "MorphismBetweenInjectiveResolutions", IsCapCategoryMorphism );

#! @Description
#! The arguments are a morphism $\alpha$ and a boolian <A>bool</A>. If <A>bool</A> = <K>false</K> then the ouput is 
#! <C>MorphismBetweenInjectiveResolutions</C>($\alpha$), otherwise the output is 
#! <C>MorphismBetweenInjectiveResolutions</C>($\alpha$) after trying to find its bounds.
#! @Arguments alpha, bool
#! @Returns a (co)chain morphism
DeclareOperation( "MorphismBetweenInjectiveResolutions", [ IsCapCategoryMorphism, IsBool ] );

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

#! @Section Examples
#! @InsertChunk Z_0

#! @Description
#! The input is a short exact sequence defined as a chain complex and the 
#! output is a chain morphism from the Horseshoe resolution (which is a complex of
#! complexes and each object in this complex is again a complex that consists of
#! a short exact sequence of projective objects). The total complex of the
#! resolution is quasi isomorphic to $C$ and both are exact complexes.
#! @Arguments C
#! @Returns chain morphism of chain complexes
DeclareAttribute( "MorphismFromHorseshoeResolution", IsBoundedChainComplex );

#! @Description
#! @BeginLatexOnly
#! Draw here the diagram
#! @EndLatexOnly
#! The input is a short exact sequence defined as a chain complex and the output
#! is the source of the morphism from Horseshoe resolution.
#! @Arguments C
#! @Returns chain complex of chain complexes
DeclareAttribute( "HorseshoeResolution", IsBoundedChainComplex );

DeclareAttribute( "MorphismFromCartanResolution", IsBoundedChainComplex );
DeclareAttribute( "CartanResolution", IsBoundedChainComplex );

DeclareAttribute( "CARTAN_HELPER", IsBoundedChainComplex );


