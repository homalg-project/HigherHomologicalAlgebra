############################################################################
#                                     GAP package
#
#  Copyright 2017,                    Kamal Saleh
#                                     Siegen University
#
#! @Chapter HomotopyCategories
#
#############################################################################

#! Objects of the homotopy category are the same of the original but morphisms ...

#! @Section Filters and categories

#! @BeginGroup 1
#! @Description
#! The objects of the homotopy category can have the same filters that objects of chain or cochain 
#! categories can have, but they have one extra filter, namely, <C>IsHomotopyCategoryObject</C>.
#! The same holds for morphisms in homotopy categories.
#! @Arguments A
DeclareCategory( "IsHomotopyCategory",
                 IsCapCategory );
#! @Arguments C
DeclareCategory( "IsHomotopyCategoryObject",
                 IsChainOrCochainComplex );
#! @EndGroup
#! @Group 1
#! @Arguments phi
DeclareCategory( "IsHomotopyCategoryMorphism",
                 IsChainOrCochainMorphism );

DeclareFilter( "WasCreatedAsHomotopyCategory" );

#! @Section Creating homotopy categories

#! @Description
#! The input is chain (or cochain category) $Ch(A)$ of some additive category $A$ and 
#! a function $F$. This operation adds the given function $F$ to the category $Ch(A)$ for the basic 
#! operation <C>IsNullHomotopic</C>. So, $F$ should be a function whose input is a chain or cochain morphism 
#! $\phi\in Ch(A)$ and output is **true** if  $\phi$ is null-homotopic and **false** otherwise.
#! @Returns <C>true</C> or <C>false</C>
#! @Arguments A, F
DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsNullHomotopic",
                   [ IsCapCategory, IsList ] );

#! @Description
#! The input is a chain or cochain morphism 
#! $\phi$ and output is **true** if  $\phi$ is null-homotopic and **false** otherwise.
#! @Arguments phi
DeclareProperty( "IsNullHomotopic", IsChainOrCochainMorphism );

#! @Description
#! The input is a chain (or cochain complex category) $Ch(A)$ of an additive category $A$, in which the 
#! method <C>IsNullHomotopic</C> can be computed. The output is the homotopy category of $H(A)$.
#! @Arguments Ch(A)
#! @Returns a CAP category
DeclareAttribute( "HomotopyCategory", IsCapCategory );

#! @Section Attributes

#####################
##
## Attributes
##
#####################

# @Description
# This attribute is a function that tests if a given morphism can be factored through a projective function or not.
# @Arguments A
# @Returns <A>f</A>
DeclareAttribute( "TestFunctionForHomotopyCategory", IsCapCategory );

#! @Description
#! bla bla
#! @Arguments S
#! @Returns <A>A</A>
DeclareAttribute( "UnderlyingCategory" ,IsHomotopyCategory  );

#! @Description
#! bla bla
#! @Arguments f
#! @Returns <A>g</A>
DeclareAttribute( "UnderlyingMorphism" ,IsHomotopyCategoryMorphism  );

#! @Description
#! bla bla
#! @Arguments obj
#! @Returns <A>obj</A>
DeclareAttribute( "UnderlyingComplex_" ,IsHomotopyCategoryObject  );

#! @Description
#! c
#! @Arguments phi
#! @Returns a morphism
DeclareAttribute( "AsHomotopyCategoryMorphism", IsChainOrCochainMorphism );

#! @Description
#! c
#! @Arguments M
#! @Returns an object
DeclareAttribute( "AsHomotopyCategoryObject", IsChainOrCochainComplex );

