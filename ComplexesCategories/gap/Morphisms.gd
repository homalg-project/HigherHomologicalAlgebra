# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#

#! @Chapter Constructors

#! @Section Constructing morphisms

#! @Description
#!  GAP-categories of the complex morphisms.
#! @Arguments phi
DeclareCategory( "IsChainOrCochainMorphism", IsCapCategoryMorphism );

#! @Description
#!  GAP-categories of the chain complex morphisms.
#! @Arguments phi
DeclareCategory( "IsChainMorphism", IsChainOrCochainMorphism );

#! @Description
#!  GAP-categories of the cochain complex morphisms.
#! @Arguments phi
DeclareCategory( "IsCochainMorphism", IsChainOrCochainMorphism );

#! @Description
#!  The input is a complexes category $\mathcal{C}^b(A)$ by chains or cochains, two objects $S$ and $R$ and a list $L$ with $3$ entries:
#!  $L[1]$ is a $\mathbb{Z}$-function; $L[2]$ and $L[3]$ are integers or $\pm\infty$.
#!  The output is the morphism $\phi:S \to R$ in $\mathcal{C}^b(A)$ whose morphism at $i\in\mathbb{Z}$ is $L[1][i]$
#!  and its lower and upper bounds are $L[2]$ resp. $L[3]$.
#! @Arguments C, S, L, R
#! @Returns a CAP morphism
DeclareOperation( "CreateComplexMorphism", [ IsComplexesCategory, IsChainOrCochainComplex, IsList, IsChainOrCochainComplex ] );

#! @Description
#!  The input is a complexes category $\mathcal{C}^b(A)$ by chains or cochains, two objects $S$ and $R$ and a dense-list $L$ of morphisms in $A$ and an integer $\ell$.
#!  The output is the morphism $\phi:S \to R$ in $\mathcal{C}^b(A)$ whose morphism at $\ell$ is $L[1]$, at $\ell+1$ is $L[2]$, etc.
#!  In particular, $\ell$ is a lower bound of $\phi$.
#! @Arguments C, S, L, ell, R
#! @Returns a CAP morphism
DeclareOperation( "CreateComplexMorphism", [ IsComplexesCategory, IsChainOrCochainComplex, IsDenseList, IsInt, IsChainOrCochainComplex ] );

#! @Description
#!  Returns the morphisms as a $\mathbb{Z}$-function.
#! @Arguments phi
#! @Returns a $\mathbb{Z}$-function
DeclareAttribute( "Morphisms", IsChainOrCochainMorphism );

DeclareAttribute( "UnderlyingCell", IsChainOrCochainMorphism );

#! @Description
#! Returns the morphism of $\phi$ at the index $i\in\mathbb{Z}$.
#! @Arguments phi, i
#! @Returns a CAP morphism
KeyDependentOperation( "MorphismAt", IsChainOrCochainMorphism, IsInt, ReturnTrue );

#! @Description
#! Delegates to <C>MorphismAt</C>($\phi$, $i$).
#! @Arguments phi, i
#! @Returns a CAP morphism
DeclareOperation( "\[\]", [ IsChainOrCochainMorphism, IsInt ] );

#! @Description
#! Returns an integer $\ell$ with $S^i=R^i=0$ for all $i\prec\ell$.
#! @Arguments phi
#! @Returns integer or infinity
DeclareAttribute( "LowerBound", IsChainOrCochainMorphism );

#! @Description
#! Returns an integer $u$ with $S^i=R^i=0$ for all $i\succ u$.
#! @Arguments phi
#! @Returns integer or infinity
DeclareAttribute( "UpperBound", IsChainOrCochainMorphism );

#! @Description
#! The input is a complex morphism $\phi$ and two integers $m,n$.
#! The output is the list of indices $m\preceq i \preceq n$ where the morphisms of $\phi$ are non-zero.
#! @Arguments phi, m, n
#! @Returns a list of integers
DeclareOperation( "MorphismsSupport", [ IsChainOrCochainMorphism, IsInt, IsInt ] );

#! @Description
#! The input is a complex morphism $\phi$ whose lower and upper bounds are integers.
#! The output is the list of indices where the morphisms of $\phi$ are non-zero.
#! @Arguments phi, i
#! @Returns a list of integers
DeclareAttribute( "MorphismsSupport", IsChainOrCochainMorphism );

#! @Description
#! The input is a complex morphism $\phi:S \to R$ and an integer $i$.
#! The output is the morphism induced by the functoriality of the cycle objects of $S$ and $R$ at the index $i$.
#! @Arguments phi, i
#! @Returns a CAP morphism
KeyDependentOperation( "CyclesFunctorialAt", IsChainMorphism, IsInt, ReturnTrue );

#! @Description
#! The input is a complex morphism $\phi:S \to R$ and an integer $i$.
#! The output is the morphism induced by the functoriality of the cocycle objects of $S$ and $R$ at the index $i$.
#! @Arguments phi, i
#! @Returns a CAP morphism
KeyDependentOperation( "CocyclesFunctorialAt", IsCochainMorphism, IsInt, ReturnTrue );

#! @Description
#! The input is a complex morphism $\phi:S \to R$ and an integer $i$.
#! The output is the morphism induced by the functoriality of the cohomology objects of $S$ and $R$ at the index $i$.
#! @Arguments phi, i
#! @Returns a CAP morphism
KeyDependentOperation( "CohomologyFunctorialAt", IsCochainMorphism, IsInt, ReturnTrue );

#! @Description
#! The input is a complex morphism $\phi:S \to R$ and an integer $i$.
#! The output is the morphism induced by the functoriality of the homology objects of $S$ and $R$ at the index $i$.
#! @Arguments phi, i
#! @Returns a CAP morphism
KeyDependentOperation( "HomologyFunctorialAt", IsChainMorphism, IsInt, ReturnTrue );

#! @Description
#! Returns wheather $\phi$ is a quasi-isomorphism, i.e., wheather it induces isomorphisms between the (co)homology objects of $S$ and $R$.
#! @Arguments phi
#! @Returns true or false
DeclareProperty( "IsQuasiIsomorphism", IsChainOrCochainMorphism );

#! @Description
#! Returns wheather $\phi$ is homotopic to the zero morphism.
#! @Arguments phi
#! @Returns true or false
DeclareProperty( "IsHomotopicToZeroMorphism", IsChainOrCochainMorphism );

#! @Description
#! Returns a $\mathbb{Z}$-function $w$ witnessing that $\phi$ is homotopic to the zero morphism.
#! If $\phi$ is a chain morphism, then $w^i$ is a morphism from $S^i$ to $R^{i+1}$ and
#! if $\phi$ is a cochain morphism, then $w^i$ is a morphism from $S^i$ to $R^{i-1}$.
#! @Arguments phi
#! @Returns $\mathbb{Z}$-function
DeclareAttribute( "WitnessForBeingHomotopicToZeroMorphism", IsChainOrCochainMorphism );

DeclareAttribute( "AsComplexMorphismOverOppositeCategory", IsChainOrCochainMorphism );

#! @Description
#! Convert a chain morphism into a cochain morphism.
#! @Arguments phi
#! @Returns a CAP morphism
DeclareAttribute( "AsChainComplexMorphism", IsCochainMorphism );

#! @Description
#! Convert a cochain morphism into a chain morphism.
#! @Arguments phi
#! @Returns a CAP morphism
DeclareAttribute( "AsCochainComplexMorphism", IsChainMorphism );

