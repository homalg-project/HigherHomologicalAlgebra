# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#
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
#! The argument is a category <A>C</A>. The output is whether the <A>C</A> is abelian and have the following methods
#! <C>IsProjective</C>, <C>SomeProjectiveObject</C>, <C>EpimorphismFromSomeProjectiveObject</C> and <C>ProjectiveLift</C>
#! are installed.
#! @Arguments C
#! @Returns true or false
DeclareProperty( "IsAbelianCategoryWithComputableEnoughProjectives", IsCapCategory );

#! @Description
#! The argument is a category <A>C</A>. The output is whether the <A>C</A> is abelian and have the following methods
#! <C>IsInjective</C>, <C>SomeInjectiveObject</C>, <C>MonomorphismIntoSomeInjectiveObject</C> and <C>InjectiveColift</C>
#! are installed.
#! @Arguments C
#! @Returns true or false
DeclareProperty( "IsAbelianCategoryWithComputableEnoughInjectives", IsCapCategory );

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
#! The input is an object $M$ in an abelian category with enough projectives. The output is 
#! <C>ProjectiveResolution</C>(<A>M</A>) as a cochain complex.
#! @Arguments M
#! @Returns a cochain complex
DeclareAttribute( "ProjectiveCochainResolution", IsCapCategoryObject );

#! @Description
#! The input is an object $M$ in an abelian category with enough projectives. The output is 
#! <C>ProjectiveResolution</C>(<A>M</A>) as a cochain complex after trying to set its bounds.
#! @Arguments M
#! @Returns a cochain complex
DeclareOperation( "ProjectiveCochainResolution", [ IsCapCategoryObject, IsBool ] );

#! @Description
#! The input is an object $M$ in an abelian category with enough projectives. The output is 
#! <C>ProjectiveResolution</C>(<A>M</A>) as a chain complex.
#! @Arguments M
#! @Returns a chain complex
DeclareAttribute( "ProjectiveChainResolution", IsCapCategoryObject );

#! @Description
#! The input is an object $M$ in an abelian category with enough projectives. The output is 
#! <C>ProjectiveResolution</C>(<A>M</A>) as a chain complex after trying to set its bounds.
#! @Arguments M
#! @Returns a chain complex
DeclareOperation( "ProjectiveChainResolution", [ IsCapCategoryObject, IsBool ] );

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
#! #TODO
#! @Arguments alpha
#! @Returns a cochain morphism
DeclareAttribute( "MorphismBetweenProjectiveCochainResolutions", IsCapCategoryMorphism );

#! @Description
#! #TODO
#! @Arguments alpha, bool
#! @Returns a cochain morphism
DeclareOperation( "MorphismBetweenProjectiveCochainResolutions", [ IsCapCategoryMorphism, IsBool ] );

#! @Description
#! #TODO
#! @Arguments alpha
#! @Returns a chain morphism
DeclareAttribute( "MorphismBetweenProjectiveChainResolutions", IsCapCategoryMorphism );

#! @Description
#! #TODO
#! @Arguments alpha, bool
#! @Returns a chain morphism
DeclareOperation( "MorphismBetweenProjectiveChainResolutions", [ IsCapCategoryMorphism, IsBool ] );


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
#! The input is an object $M$ in an abelian category with enough injectives. The output is 
#! <C>InjectiveResolution</C>(<A>M</A>) as a cochain complex.
#! @Arguments M
#! @Returns a cochain complex
DeclareAttribute( "InjectiveCochainResolution", IsCapCategoryObject );

#! @Description
#! The input is an object $M$ in an abelian category with enough injectives. The output is 
#! <C>InjectiveResolution</C>(<A>M</A>) as a cochain complex after trying to set its bounds.
#! @Arguments M
#! @Returns a cochain complex
DeclareOperation( "InjectiveCochainResolution", [ IsCapCategoryObject, IsBool ] );

#! @Description
#! The input is an object $M$ in an abelian category with enough injectives. The output is
#! <C>InjectiveResolution</C>(<A>M</A>) as a chain complex after trying to set its bounds.
#! @Arguments M
#! @Returns a chain complex
DeclareAttribute( "InjectiveChainResolution", IsCapCategoryObject );

#! @Description
#! The input is an object $M$ in an abelian category with enough injectives. The output is
#! <C>InjectiveResolution</C>(<A>M</A>) as a chain complex after trying to set its bounds.
#! @Arguments M
#! @Returns a chain complex
DeclareOperation( "InjectiveChainResolution", [ IsCapCategoryObject, IsBool ] );

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

#! @Description
#! #TODO
#! @Arguments alpha
#! @Returns a cochain morphism
DeclareAttribute( "MorphismBetweenInjectiveCochainResolutions", IsCapCategoryMorphism );

#! @Description
#! #TODO
#! @Arguments alpha, bool
#! @Returns a cochain morphism
DeclareOperation( "MorphismBetweenInjectiveCochainResolutions", [ IsCapCategoryMorphism, IsBool ] );

#! @Description
#! #TODO
#! @Arguments alpha
#! @Returns a chain morphism
DeclareAttribute( "MorphismBetweenInjectiveChainResolutions", IsCapCategoryMorphism );

#! @Description
#! #TODO
#! @Arguments alpha, bool
#! @Returns a chain morphism
DeclareOperation( "MorphismBetweenInjectiveChainResolutions", [ IsCapCategoryMorphism, IsBool ] );

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

#! @Description
#! The input is chain or cochain complex and the output is a quasi-isomorphism from its projective resolution,
#! after trying to find its bounds.
#! @Arguments C
#! @Returns a bounded (co)chain epimorphism
DeclareOperation( "QuasiIsomorphismFromProjectiveResolution", [ IsBoundedChainOrCochainComplex, IsBool ] );

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
DeclareAttribute( "QuasiIsomorphismIntoInjectiveResolution", IsBoundedBelowCochainComplex );
#! @EndGroup
#! @Group 15
#! @Arguments C
DeclareAttribute( "QuasiIsomorphismIntoInjectiveResolution", IsBoundedAboveChainComplex );

#! @Description
#! The input is chain or cochain complex and the output is a quasi-isomorphism into its injective resolution,
#! after trying to find its bounds.
#! @Arguments C
#! @Returns a bounded (co)chain epimorphism
DeclareOperation( "QuasiIsomorphismIntoInjectiveResolution", [ IsBoundedChainOrCochainComplex, IsBool ] );


#! @Section Examples
#? @InsertChunk Z_0

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


