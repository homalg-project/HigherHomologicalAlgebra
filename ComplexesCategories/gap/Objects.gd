# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#

#! @Chapter Constructors

#! @Section Constructing objects

#! @Description
#!  GAP-categories of the chain or cochain complexes.
#! @Arguments C
DeclareCategory( "IsChainOrCochainComplex", IsCapCategoryObject );

#! @Description
#!  GAP-categories of the chain complexes.
#! @Arguments C
DeclareCategory( "IsChainComplex", IsChainOrCochainComplex );

#! @Description
#!  GAP-categories of the cochain complexes.
#! @Arguments C
DeclareCategory( "IsCochainComplex", IsChainOrCochainComplex );

#! @Description
#!  The input is a complexes category $\mathcal{C}^b(A)$ by chains or cochains and a list $L$ with $4$ entries:
#!  $L[1]$ and $L[2]$ are $\mathbb{Z}$-functions and $L[3]$ and $L[4]$ are integers or $\pm\infty$.
#!  The output is an object  $C\in \mathcal{C}^b(A)$ whose object at $i\in\mathbb{Z}$ is $C^i:=L[1][i]$, differential at $i\in\mathbb{Z}$ is
#!  $\partial_{C}^i:=L[2][i]$. Its lower and upper bounds are $L[3]$ resp. $L[4]$.
#! @Arguments C, L
#! @Returns a CAP object
DeclareOperation( "CreateComplex", [ IsComplexesCategory, IsList ] );

#! @Description
#!  The input is a complexes category $\mathcal{C}^b(A)$ by chains or cochains, a dense-list $L$ of morphisms in $A$ and an integer $\ell$.
#!  The output is an object $C\in\mathcal{C}^b(A)$ whose differentials are $\partial_{C}^{\ell}:=L[1], \partial_{C}^{\ell+1}:=L[2],$ etc.
#! @Arguments C, L
#! @Returns a CAP object
DeclareOperation( "CreateComplex", [ IsComplexesCategory, IsDenseList, IsInt ] );

#! @Description
#!  Returns the objects of the complex as a $\mathbb{Z}$-function.
#! @Arguments C
#! @Returns a $\mathbb{Z}$-function
DeclareAttribute( "Objects", IsChainOrCochainComplex );

DeclareAttribute( "UnderlyingCell", IsChainOrCochainComplex );

#! @Description
#! Returns the object $C^i$ of the complex $C$ at the index $i\in\mathbb{Z}$.
#! @Arguments C, i
#! @Returns a CAP object
KeyDependentOperation( "ObjectAt", IsChainOrCochainComplex, IsInt, ReturnTrue );

#! @Description
#! Delegates to <C>ObjectAt</C>($C$,$i$).
#! @Arguments C, i
#! @Returns a CAP object
DeclareOperation( "\[\]", [ IsChainOrCochainComplex, IsInt ] );

#! @Description
#! Returns the differentials of the complex as a $\mathbb{Z}$-function.
#! @Arguments C
#! @Returns a $\mathbb{Z}$-function
DeclareAttribute( "Differentials", IsChainOrCochainComplex );

#! @Description
#! Returns the differential of the complex $C$ at the index $i\in\mathbb{Z}$.
#! @Arguments C, i
#! @Returns a CAP morphism
KeyDependentOperation( "DifferentialAt", IsChainOrCochainComplex, IsInt, ReturnTrue );

#! @Description
#! Delegates to <C>DifferentialAt</C>($C$,$i$).
#! @Arguments C, i
#! @Returns a CAP object
DeclareOperation( "\^", [ IsChainOrCochainComplex, IsInt ] );

#! @Description
#! Returns the lower bound $\ell$ of $C$. I.e., the objects $C^i$ are zero for all $i\prec\ell$.
#! @Arguments C
#! @Returns integer or infinity
DeclareAttribute( "LowerBound", IsChainOrCochainComplex );

#! @Description
#! Returns the upper bound $u$ of $C$. I.e., the objects $C^i$ are zero for all $i\succ u$.
#! @Arguments C
#! @Returns integer or infinity
DeclareAttribute( "UpperBound", IsChainOrCochainComplex );

#! @Description
#! The input is a complex $C$ and two integers $m,n$.
#! The output is the list of indices $m\preceq i \preceq n$ where the objects of $C$ are non-zero.
#! @Arguments C, m, n
#! @Returns a list of integers
DeclareOperation( "ObjectsSupport", [ IsChainOrCochainComplex, IsInt, IsInt ] );

#! @Description
#! The input is a complex $C$ whose lower and upper bounds are integers.
#! The output is the list of indices where the objects of $C$ are non-zero.
#! @Arguments C
#! @Returns a list of integers
DeclareAttribute( "ObjectsSupport", IsChainOrCochainComplex );

#! @Description
#! The input is a complex $C$ and two integers $m,n$.
#! The output is the list of indices $m\preceq i \preceq n$ where the differentials of $C$ are non-zero.
#! @Arguments C, m, n
#! @Returns a list of integers
DeclareOperation( "DifferentialsSupport", [ IsChainOrCochainComplex, IsInt, IsInt ] );

#! @Description
#! The input is a complex $C$ whose lower and upper bounds are integers.
#! The output is the list of indices where the differentials of $C$ are non-zero.
#! @Arguments C
#! @Returns a list of integers
DeclareAttribute( "DifferentialsSupport", IsChainOrCochainComplex );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the kernel object of $\partial_{C}^i$.
#! @Arguments C, i
#! @Returns a CAP object
KeyDependentOperation( "CocyclesAt", IsCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the kernel embedding of $\partial_{C}^i$.
#! @Arguments C, i
#! @Returns a CAP object
KeyDependentOperation( "CocyclesEmbeddingAt", IsCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the image object of the differential $\partial_{C}^{i-1}$.
#! @Arguments C, i
#! @Returns a CAP object
KeyDependentOperation( "CoboundariesAt", IsCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the image embedding of the differential $\partial_{C}^{i-1}$.
#! @Arguments C, i
#! @Returns a CAP morphism
KeyDependentOperation( "CoboundariesEmbeddingAt", IsCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the cohomology object of $C$ at $i$.
#! @Arguments C, i
#! @Returns a CAP object
KeyDependentOperation( "CohomologyAt", IsCochainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a complex $C$ and two integers $m,n$.
#! The output is the list of indices $m\preceq i \preceq n$ where the cohomology objects of $C$ are non-zero.
#! @Arguments C, m, n
#! @Returns a list of integers
DeclareOperation( "CohomologySupport", [ IsCochainComplex, IsInt, IsInt ] );

#! @Description
#! The input is a complex $C$ whose lower and upper bounds are integers.
#! The output is the list of indices where the cohomology objects of $C$ are non-zero.
#! @Arguments C
#! @Returns a list of integers
DeclareAttribute( "CohomologySupport", IsCochainComplex );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the kernel object of $\partial_{C}^i$.
#! @Arguments C, i
#! @Returns a CAP object
KeyDependentOperation( "CyclesAt", IsChainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the kernel embedding of $\partial_{C}^i$.
#! @Arguments C, i
#! @Returns a CAP object
KeyDependentOperation( "CyclesEmbeddingAt", IsChainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the image object of the differential $\partial_{C}^{i+1}$.
#! @Arguments C, i
#! @Returns a CAP object
KeyDependentOperation( "BoundariesAt", IsChainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the image embedding of the differential $\partial_{C}^{i+1}$.
#! @Arguments C, i
#! @Returns a CAP morphism
KeyDependentOperation( "BoundariesEmbeddingAt", IsChainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a cochain complex $C$.
#! The output is the homology object of $C$ at $i$.
#! @Arguments C, i
#! @Returns a CAP object
KeyDependentOperation( "HomologyAt", IsChainComplex, IsInt, ReturnTrue );

#! @Description
#! The input is a complex $C$ and two integers $m,n$.
#! The output is the list of indices $m\preceq i \preceq n$ where the homology objects of $C$ are non-zero.
#! @Arguments C, m, n
#! @Returns a list of integers
DeclareOperation( "HomologySupport", [ IsChainComplex, IsInt, IsInt ] );

#! @Description
#! The input is a complex $C$ whose lower and upper bounds are integers.
#! The output is the list of indices where the homology objects of $C$ are non-zero.
#! @Arguments C
#! @Returns a list of integers
DeclareAttribute( "HomologySupport", IsChainComplex );

#! @Description
#! The input is a complex $C$ whose lower and upper bounds are integers.
#! The output is wheather the (co)homology support is empty.
#! @Arguments C
#! @Returns a list of integers
DeclareProperty( "IsExact", IsChainOrCochainComplex );

#! @Description
#! The input is a complex $C$ and two integers $m,n$.
#! The output is wheather the (co)homology support between $m$ and $n$ is empty.
#! @Arguments C, m, n
#! @Returns a list of integers
DeclareOperation( "IsExact", [ IsChainOrCochainComplex, IsInt, IsInt ] );

DeclareAttribute( "AsComplexOverOppositeCategory", IsCochainComplex );

#! @Description
#! Convert a cochain complex into a chain complex.
#! @Arguments C
#! @Returns a CAP object
DeclareAttribute( "AsChainComplex", IsCochainComplex );

#! @Description
#! Convert a chain complex into a cochain complex.
#! @Arguments C
#! @Returns a CAP object
DeclareAttribute( "AsCochainComplex", IsChainComplex );


DeclareSynonym( "ChainComplex", CreateComplex );
DeclareSynonym( "CochainComplex", CreateComplex );
