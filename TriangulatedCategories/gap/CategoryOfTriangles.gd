# SPDX-License-Identifier: GPL-2.0-or-later
# TriangulatedCategories: Framework for triangulated categories
#
# Declarations
#

#! @Chapter Category of triangles
#! @Section Gap categories

#! @Description
#! The &GAP; category for the category of triangles over some triangulated category.
#! @Arguments T
#! @Returns true or false
DeclareCategory( "IsCapCategoryOfExactTriangles", IsCapCategory );

#! @Description
#! The &GAP; category for exact triangles.
#! @Arguments triangle
#! @Returns true or false
DeclareCategory( "IsCapExactTriangle", IsCapCategoryObject );

#! @Description
#! The &GAP; category for morphism of exact triangles
#! @Arguments mu
#! @Returns true or false
DeclareCategory( "IsCapExactTrianglesMorphism", IsCapCategoryMorphism );

######
#! @Section Constructors

#! @Description
#! The argument is some triangulated category $\mathcal{T}$.
#! The output is the category of exact triangles over $\mathcal{T}$.
#! @Arguments T
#! @Returns a CAP category
DeclareAttribute( "CategoryOfExactTriangles", IsTriangulatedCategory );

#! @Description
#! The argument is a category of triangles over some triangulated category $\mathcal{T}$.
#! The output is $\mathcal{T}$.
#! @Arguments C
#! @Returns a CAP category
DeclareAttribute( "UnderlyingCategory", IsCapCategoryOfExactTriangles );

######

#! @Description
#! The arguments are three morphisms $\alpha:A\to B$, $\iota:B\to C$ and $\pi:C\to\Sigma A$ in some triangulated
#! category $\mathcal{T}$.
#! The output the exact triangle $A\to B \to C \to \Sigma A$ defined by them.
#! @Arguments alpha, iota, pi
#! @Returns an exact triangle
DeclareOperation( "ExactTriangle", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments is an exact triangle defined by three morphisms
#! $\alpha:A\to B$, $\iota:B\to C$ and $\pi:C\to\Sigma A$.
#! The output is $\alpha:A\to B$.
#! @Arguments t
#! @Returns a morphism
DeclareAttribute( "DomainMorphism", IsCapExactTriangle );

#! @Description
#! The arguments is an exact triangle defined by three morphisms
#! $\alpha:A\to B$, $\iota:B\to C$ and $\pi:C\to\Sigma A$.
#! The output is $\iota:B\to C$.
#! @Arguments t
#! @Returns a morphism
DeclareAttribute( "MorphismToConeObject", IsCapExactTriangle );

#! @Description
#! The arguments is an exact triangle defined by three morphisms
#! $\alpha:A\to B$, $\iota:B\to C$ and $\pi:C\to\Sigma A$.
#! The output is $\pi:C\to\Sigma A$.
#! @Arguments t
#! @Returns a morphism
DeclareAttribute( "MorphismFromConeObject", IsCapExactTriangle );

#! @Description
#! The arguments is an exact triangle defined by three morphisms
#! $\alpha:A\to B$, $\iota:B\to C$ and $\pi:C\to\Sigma A$ and an integer $i\in\{0,1,2,3\}$.
#! The output is $A$ if $i=0$, $B$ if $i=1$, $C$ if $i=2$ and $\Sigma A$ if $i=3$.
#! @Arguments t, i
#! @Returns an object
KeyDependentOperation( "ObjectAt", IsCapExactTriangle, IsInt, ReturnTrue );

#! @Description
#! Delegates to the operation <C>ObjectAt</C>.
#! @Arguments t, i
#! @Returns an object
DeclareOperation( "\[\]", [ IsCapExactTriangle, IsInt ] );

#! @Description
#! The arguments is an exact triangle defined by three morphisms
#! $\alpha:A\to B$, $\iota:B\to C$ and $\pi:C\to\Sigma A$ and an integer $i\in\{0,1,2\}$.
#! The output is $\alpha$ if $i=0$, $\iota$ if $i=1$, $\pi$ if $i=2$.
#! @Arguments t, i
#! @Returns a morphism
KeyDependentOperation( "MorphismAt", IsCapExactTriangle, IsInt, ReturnTrue );

#! @Description
#! Delegates to the operation <C>MorphismAt</C>.
#! @Arguments t, i
#! @Returns a morphism
DeclareOperation( "\^", [ IsCapExactTriangle, IsInt ] );

#! @Description
#! The arguments is a morphism $\alpha:A\to B$ in some triangulated
#! category $\mathcal{T}$.
#! The output the standard exact triangle $A\to B \to C(\alpha) \to \Sigma A$ defined by $\alpha$.
#! @Arguments alpha
#! @Returns an standard exact triangle
DeclareAttribute( "StandardExactTriangle", IsCapCategoryMorphism );

#! @Description
#! The arguments is an exact triangle $t=(\alpha,\iota,\pi)$.
#! The output the standard exact triangle $(\alpha,\iota(\alpha),\pi(\alpha))$.
#! @Arguments t
#! @Returns an standard exact triangle
DeclareAttribute( "StandardExactTriangle", IsCapExactTriangle );

#! @Description
#! The argument is an exact triangle $t=(\alpha,\iota,\pi)$. The operation checks whether $t$ is
#! standard exact triangle or not. I.e., it checks whether $\iota=\iota(\alpha)$
#! and $\pi=\pi(\alpha)$.
#! @Arguments t
#! @Returns true or false
DeclareProperty( "IsStandardExactTriangle", IsCapExactTriangle );

#! @Description
#! The argument is an exact triangle $t=(\alpha,\iota,\pi)$.
#! The output is an isomorphism of triangles from $t$ into the standard
#! exact triangle $(\alpha,\iota(\alpha),\pi(\alpha))$.
#! @Arguments t
#! @Returns a morphism of triangles
DeclareAttribute( "WitnessIsomorphismOntoStandardExactTriangle", IsCapExactTriangle );

#! @Description
#! The argument is an exact triangle $t=(\alpha,\iota,\pi)$.
#! The output is an isomorphism of triangles from the standard
#! exact triangle $(\alpha,\iota(\alpha),\pi(\alpha))$ into t.
#! This isomorphism is equal to the inverse of the witness isomorphism into
#! the standard exact triangle.
#! @Arguments t
#! @Returns a morphism of triangles
DeclareAttribute( "WitnessIsomorphismFromStandardExactTriangle", IsCapExactTriangle );

#! @Description
#! The arguments are an exact triangle $t_1$, three morphisms
#! $\mu_0:t_1[0]\to t_2[0]$, $\mu_1:t_1[1]\to t_2[1]$, $\mu_2:t_1[2]\to t_2[2]$
#! and an exact triangle $t_2$.
#! The output is the morphism of exact triangles from $t_1\to t_2$ defined by these morphisms.
#! @Arguments t_1, mu_0, mu_1, mu_2, t_2
#! @Returns a morphism $t_1\to t_2$
DeclareOperation( "MorphismOfExactTriangles",
      [ IsCapExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapExactTriangle ] );

#! @Description
#! The arguments is a morphism $\mu:t_1\to t_2$ of exact triangles defined by three morphisms
#! $\mu_0:t_1[0]\to t_2[0]$, $\mu_1:t_1[1]\to t_2[1]$ and $\mu_2:t_1[2]\to t_2[2]$; and an integer $i\in\{0,1,2\}$.
#! The output is $\mu_0$ if $i=0$, $\mu_1$ if $i=1$, $\mu_2$ if $i=2$.
#! @Arguments phi, i
#! @Returns a morphism
KeyDependentOperation( "MorphismAt", IsCapExactTrianglesMorphism, IsInt, ReturnTrue );

#! @Description
#! Delegates to the operation <C>MorphismAt</C>.
#! @Arguments phi, i
#! @Returns a morphism
DeclareOperation( "\[\]", [ IsCapExactTrianglesMorphism, IsInt ] );

#! @Description
#!  The arguments are an exact triangle $t_1$, two morphisms $\mu_0:t_1[0]\to t_2[0]$, $\mu_1:t_1[1]\to t_2[1]$,
#!  and an exact triangle $t_2$. The output is some morphism $\mu_2:t_1[2]\to t_2[2]$ such that
#!  $(t_1,\mu_0,\mu_1,\mu_2,t_2)$ is a morphism of exact triangles.
#! @Arguments t_1, mu_0, mu_1, t_2
#! @Returns a morphism
DeclareOperation( "MorphismBetweenConeObjects",
    [ IsCapExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapExactTriangle ] );

#! @Description
#!  The arguments are an exact triangle $t_1$, two morphisms $\mu_0:t_1[0]\to t_2[0]$, $\mu_1:t_1[1]\to t_2[1]$,
#!  and an exact triangle $t_2$. The output is some morphism of exact triangles $(t_1,\mu_0,\mu_1,\mu_2,t_2)$.
#!  The morphism $\mu_2$ will be computed by using the operation <C>MorphismBetweenConeObjects</C>.
#! @Arguments t_1, mu_0, mu_1, t_2
#! @Returns a morphism
DeclareOperation( "MorphismOfExactTriangles",
    [ IsCapExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapExactTriangle ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$, $\beta:B\to C$. The output is the exact triangle
#! defined by the Octhedral axiom.
#! @Arguments alpha, beta, gamma
#! @Returns a triangle
DeclareOperation( "ExactTriangleByOctahedralAxiom", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$, $\beta:B\to C$ and a boolian $b$.
#! The output is the exact triangle defined by the Octhedral axiom. If $b$=<C>true</C>, then
#! the operation will compute a witness isomorphism into the standard exact triangle.
#! @Arguments alpha, beta, gamma, b
#! @Returns a triangle
DeclareOperation( "ExactTriangleByOctahedralAxiom", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsBool ] );

#! @Description
#! The arguments are two exact triangles $t_1,t_2$ such that $t_1[1]=t_2[0]$ and a boolian $b$.
#! The output is <C>ExactTriangleByOctahedralAxiom</C>$(t_1,t_2)$.
#! If $b$ = <C>true</C> then the operation will compute a witness isomorphism into the standard exact triangle.
#! @Arguments t_1, t_2, b
#! @Returns a triangle
DeclareOperation( "ExactTriangleByOctahedralAxiom", [ IsCapExactTriangle, IsCapExactTriangle, IsCapExactTriangle, IsBool ] );

#! @Description
#! The arguments are three exact triangles $t_1,t_2,t_3$ such that $t_1[1]=t_2[0]$,
#! $t_1[0]=t_3[0]$, $t_2[1]=t_3[1]$ and $t_2^0\circ t_1^0=t_3^0$.
#! The output is the exact triangle defined by the Octahedral axiom.
#! @Arguments t_1, t_2, t_3
#! @Returns a triangle
DeclareOperation( "ExactTriangleByOctahedralAxiom", [ IsCapExactTriangle, IsCapExactTriangle, IsCapExactTriangle ] );

#! @Description
#! The argument is an exact triangle $t=(\alpha,\iota,\pi)$. The output is the exact triangle
#! defined by the rotation axiom, i.e., the exact triangle $(\iota,\pi,-\Sigma \alpha)$.
#! @Arguments t
#! @Returns a triangle
DeclareAttribute( "Rotation", IsCapExactTriangle );

#! @Description
#! The arguments are an exact triangle $t=(\alpha,\iota,\pi)$ and a boolian $b$. The output
#! is <C>Rotation</C>$(t)$.
#! If $b$=<C>true</C>, then
#! the operation will compute a witness isomorphism into the standard exact triangle.
#! @Arguments t, b
#! @Returns a triangle
DeclareOperation( "Rotation", [ IsCapExactTriangle, IsBool ] );

#! @Description
#! The argument is an exact triangle $t=(\alpha,\iota,\pi)$. The output is the exact triangle
#! defined by the inverse rotation axiom, i.e., the exact triangle
#! $(-\eta(A)\circ\Sigma^{-1}\pi,\alpha,\mu(C)\circ\iota)$, such that 
#! $\eta$ := <C>CounitIsomorphism</C>, $\mu$ := <C>UnitIsomorphism</C>,
#! $A$ := <C>Source</C>$(\alpha)$ and
#! $C$ := <C>Range</C>$(\iota)$.
#! @Arguments t
#! @Returns a triangle
DeclareAttribute( "InverseRotation", IsCapExactTriangle );

#! @Description
#! The arguments are an exact triangle $t=(\alpha,\iota,\pi)$ and a boolian $b$.
#! The output is <C>InverseRotation</C>$(t)$.
#! If $b$=<C>true</C>, then
#! the operation will compute a witness isomorphism into the standard exact triangle.
#! @Arguments t, bool
#! @Returns a triangle
DeclareOperation( "InverseRotation", [ IsCapExactTriangle, IsBool ] );

if false then
  KeyDependentOperation( "Shift", IsCapExactTriangle, IsInt, ReturnTrue );
  KeyDependentOperation( "Shift", IsCapExactTrianglesMorphism, IsInt, ReturnTrue );
fi;

DeclareOperation( "ViewExactTriangle", [ IsCapExactTriangle ] );
DeclareOperation( "ViewMorphismOfExactTriangles", [ IsCapExactTrianglesMorphism ] );

