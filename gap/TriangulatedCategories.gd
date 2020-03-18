#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2020,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################


#################################
##
##  Declarations
##
#################################

DeclareGlobalVariable( "TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD" );

####################################
##
#! @Chapter Triangulated Categories
##
####################################

#! @Section Categorical operations

#! @Description
#! The argument is a morphism $\alpha:A\to B$ in a triangulated category.
#! The output is the standard cone object $C(\alpha)$ of $\alpha$.
#! @Arguments alpha
#! @Returns an object
DeclareAttribute( "StandardConeObject",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation <C>StandardConeObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddStandardConeObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddStandardConeObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddStandardConeObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddStandardConeObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a morphism $\alpha: A \to B$ in a triangulated category and an object $C:=C(\alpha)$.
#! The output is the morphism $\iota(\alpha):B\to C(\alpha)$
#! into the standard cone object $C(\alpha)$.
#! @Arguments alpha, C
#! @Returns a morphism $\iota(\alpha):B\to C(\alpha)$
DeclareOperation( "MorphismIntoStandardConeObjectWithGivenStandardConeObject", [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismIntoStandardConeObjectWithGivenStandardConeObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismIntoStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismIntoStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismIntoStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismIntoStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha: A \to B$ in a triangulated category.
#! The output is the morphism $\iota(\alpha):B\to C(\alpha)$
#! into the standard cone object $C(\alpha)$.
#! @Arguments alpha
#! @Returns a morphism $\iota(\alpha):B\to C(\alpha)$
DeclareAttribute( "MorphismIntoStandardConeObject", IsCapCategoryMorphism );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismIntoStandardConeObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismIntoStandardConeObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismIntoStandardConeObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismIntoStandardConeObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismIntoStandardConeObject", [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are a morphism $\alpha: A \to B$ in a triangulated category and an object $C:=C(\alpha)$.
#! The output is the morphism $\pi(\alpha):C(\alpha)\to\Sigma A$
#! from the standard cone object $C(\alpha)$.
#! @Arguments alpha, C
#! @Returns a morphism $\pi(\alpha):C(\alpha)\to\Sigma A$
DeclareOperation( "MorphismFromStandardConeObjectWithGivenStandardConeObject", [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismFromStandardConeObjectWithGivenStandardConeObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismFromStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismFromStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismFromStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha: A \to B$ in a triangulated category.
#! The output is the morphism $\pi(\alpha):C(\alpha)\to\Sigma A$
#! from the standard cone object $C(\alpha)$.
#! @Arguments alpha, C
#! @Returns a morphism $\pi(\alpha):C(\alpha)\to\Sigma A$
DeclareAttribute( "MorphismFromStandardConeObject", IsCapCategoryMorphism );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismFromStandardConeObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismFromStandardConeObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromStandardConeObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismFromStandardConeObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismFromStandardConeObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$. The output is $\Sigma A$.
#! @Returns $\Sigma A$
#! @Arguments A
DeclareAttribute( "ShiftOnObject", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>ShiftOnObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddShiftOnObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftOnObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftOnObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftOnObject", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an object $\Sigma A$, a morphism $\alpha:A\to B$ and an object $\Sigma B$ in a triangulated category $\mathcal{T}$.
#! The output is $\Sigma \alpha:\Sigma A \to \Sigma B$.
#! @Returns $\Sigma \alpha:\Sigma A \to \Sigma B$
#! @Arguments sigma_A, alpha, sigma_B
DeclareOperation( "ShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>ShiftOnMorphismWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha:A\to B$ in a triangulated category $\mathcal{T}$.
#! The output is $\Sigma \alpha:\Sigma A \to \Sigma B$.
#! @Returns $\Sigma \alpha:\Sigma A \to \Sigma B$
#! @Arguments alpha
DeclareAttribute( "ShiftOnMorphism", IsCapCategoryMorphism );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>ShiftOnMorphism</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddShiftOnMorphism", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftOnMorphism", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftOnMorphism", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftOnMorphism", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$. The output is $\Sigma^{-1} A$.
#! @Returns $\Sigma^{-1} A$
#! @Arguments A
DeclareOperation( "ReverseShiftOnObject", [ IsObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>ReverseShiftOnObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddReverseShiftOnObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddReverseShiftOnObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseShiftOnObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseShiftOnObject", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an object $\Sigma^{-1} A$, a morphism $\alpha:A\to B$ and an object $\Sigma^{-1} B$ in a triangulated category $\mathcal{T}$.
#! The output is $\Sigma^{-1} \alpha:\Sigma^{-1} A \to \Sigma^{-1} B$.
#! @Returns $\Sigma^{-1} \alpha:\Sigma^{-1} A \to \Sigma^{-1} B$
#! @Arguments rev_sigma_A, alpha, rev_sigma_B
DeclareOperation( "ReverseShiftOnMorphismWithGivenObjects", [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>ReverseShiftOnMorphismWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddReverseShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddReverseShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha:A\to B$ in a triangulated category $\mathcal{T}$.
#! The output is $\Sigma^{-1} \alpha:\Sigma^{-1} A \to \Sigma^{-1} B$.
#! @Returns $\Sigma^{-1} \alpha:\Sigma^{-1} A \to \Sigma^{-1} B$
#! @Arguments alpha
DeclareAttribute( "ReverseShiftOnMorphism", IsCapCategoryMorphism );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>ReverseShiftOnMorphism</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddReverseShiftOnMorphism", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddReverseShiftOnMorphism", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseShiftOnMorphism", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseShiftOnMorphism", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma \circ \Sigma^{-1}) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Returns a morphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Arguments A, sigma_o_rev_sigma_A
DeclareOperation( "IsomorphismIntoShiftOfReverseShiftWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismIntoShiftOfReverseShiftWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismIntoShiftOfReverseShiftWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoShiftOfReverseShiftWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfReverseShiftWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfReverseShiftWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Returns a morphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Arguments A
DeclareOperation( "IsomorphismIntoShiftOfReverseShift", [ IsObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismIntoShiftOfReverseShift</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismIntoShiftOfReverseShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoShiftOfReverseShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfReverseShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfReverseShift", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma^{-1} \circ \Sigma) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Returns a morphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Arguments A, rev_sigma_o_sigma_A
DeclareOperation( "IsomorphismIntoReverseShiftOfShiftWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismIntoReverseShiftOfShiftWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismIntoReverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoReverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoReverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoReverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Returns a morphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Arguments A
DeclareAttribute( "IsomorphismIntoReverseShiftOfShift", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismIntoReverseShiftOfShift</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismIntoReverseShiftOfShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoReverseShiftOfShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoReverseShiftOfShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoReverseShiftOfShift", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma \circ \Sigma^{-1}) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Returns a morphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Arguments A, sigma_o_rev_sigma_A
DeclareOperation( "IsomorphismFromShiftOfReverseShiftWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismFromShiftOfReverseShiftWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismFromShiftOfReverseShiftWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromShiftOfReverseShiftWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfReverseShiftWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfReverseShiftWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument in an objects $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Returns a morphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Arguments A
DeclareAttribute( "IsomorphismFromShiftOfReverseShift", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismFromShiftOfReverseShift</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismFromShiftOfReverseShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromShiftOfReverseShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfReverseShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfReverseShift", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma^{-1} \circ \Sigma) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Returns a morphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Arguments A, rev_sigma_o_sigma_A
DeclareOperation( "IsomorphismFromReverseShiftOfShiftWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismFromReverseShiftOfShiftWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismFromReverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromReverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromReverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromReverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Returns a morphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Arguments A
DeclareAttribute( "IsomorphismFromReverseShiftOfShift", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismFromReverseShiftOfShift</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismFromReverseShiftOfShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromReverseShiftOfShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromReverseShiftOfShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromReverseShiftOfShift", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an object $C_{\alpha_1}$, four morphisms $\alpha_1:A_1\to B_1$, $u:A_1\to A_2$,
#! $v:B_1\to B_2$, $\alpha_2:A_2\to B_2$ and an object $C_{\alpha_2}$ such that $C_{\alpha_1}:=C(\alpha_1)$,
#! $C_{\alpha_2}:=C(\alpha_2)$ and $v\circ \alpha_1=\alpha_2\circ u$.
#! The output is a morphism $w:C(\alpha_1) \to C(\alpha_2)$
#! such that $w\circ \iota(\alpha_1)=\iota(\alpha_2)\circ v$
#! and $\Sigma u\circ\pi(\alpha_1)=\pi(\alpha_2)\circ w$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A_1 \arrow[r, "\alpha_1"] \arrow[d, "u"'] & B_1 \arrow[r, "\iota(\alpha_1)"] \arrow[d, "v"] &
#! C(\alpha_1) \arrow[r, "\pi(\alpha_1)"] \arrow[d, "w", dashed] & \Sigma A_1 \arrow[d, "\Sigma u"] \\
#! A_2 \arrow[r, "\alpha_2"'] & B_2 \arrow[r, "\iota(\alpha_2)"'] & C(\alpha_2) \arrow[r, "\pi(\alpha_2)"'] & \Sigma A_2
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism $C(\alpha_1) \to C(\alpha_2)$
#! @Arguments C_alpha_1, alpha_1, u, v, alpha_2, C_alpha_2
DeclareOperation( "MorphismBetweenStandardConeObjectsWithGivenStandardConeObjects",
          [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismBetweenStandardConeObjectsWithGivenStandardConeObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismBetweenStandardConeObjectsWithGivenStandardConeObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismBetweenStandardConeObjectsWithGivenStandardConeObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismBetweenStandardConeObjectsWithGivenStandardConeObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismBetweenStandardConeObjectsWithGivenStandardConeObjects", [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are morphisms $\alpha_1:A_1\to B_1$, $u:A_1\to A_2$,
#! $v:B_1\to B_2$, $\alpha_2:A_2\to B_2$ such that $v\circ \alpha_1=\alpha_2\circ u$.
#! The output is a morphism $w:C(\alpha_1) \to C(\alpha_2)$
#! such that $w\circ \iota(\alpha_1)=\iota(\alpha_2)\circ v$
#! and $\Sigma u\circ\pi(\alpha_1)=\pi(\alpha_2)\circ w$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A_1 \arrow[r, "\alpha_1"] \arrow[d, "u"'] & B_1 \arrow[r, "\iota(\alpha_1)"] \arrow[d, "v"] &
#! C(\alpha_1) \arrow[r, "\pi(\alpha_1)"] \arrow[d, "w", dashed] & \Sigma A_1 \arrow[d, "\Sigma u"] \\
#! A_2 \arrow[r, "\alpha_2"'] & B_2 \arrow[r, "\iota(\alpha_2)"'] & C(\alpha_2) \arrow[r, "\pi(\alpha_2)"'] & \Sigma A_2
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism $C(\alpha_1) \to C(\alpha_2)$
#! @Arguments alpha_1, u, v, alpha_2
DeclareOperation( "MorphismBetweenStandardConeObjects",
      [  IsCapCategoryMorphism, IsCapCategoryMorphism, 
          IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismBetweenStandardConeObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismBetweenStandardConeObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismBetweenStandardConeObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismBetweenStandardConeObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismBetweenStandardConeObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$, $\beta:B\to C$.
#! The output is the standard cone object $C(\beta)$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A \arrow[r, "\alpha"] \arrow[rd, "\beta\circ \alpha"', bend right] &
#! B \arrow[r, "\iota(\alpha)"] \arrow[d, "\beta"] & 
#! C(\alpha) \arrow[r, "\pi(\alpha)"] \arrow[d, "u_{\alpha,\beta}", dashed] & 
#! \Sigma A \arrow[d, "\mathrm{id}_{\Sigma A}"] \\
#!  & C \arrow[d, "\iota(\beta)"'] \arrow[r, "\iota(\beta\circ \alpha)"] & 
#! C(\beta\circ \alpha) \arrow[r, "\pi(\beta\circ \alpha)"] \arrow[d, "\iota_{\alpha,\beta}", dashed] & 
#! \Sigma A \arrow[d, "\Sigma \alpha"] \\
#!  & C(\beta) \arrow[d, "\pi(\beta)"'] \arrow[r, "\mathrm{id}_{C(\beta)}"] & 
#! C(\beta) \arrow[d, "\pi_{\alpha,\beta}", dashed] \arrow[r, "\pi(\beta)"] & \Sigma B \\
#!  & \Sigma B \arrow[r, "\Sigma \iota(\alpha)"'] & \Sigma C(\alpha) & 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns $C(\beta)$
#! @Arguments alpha, beta
DeclareOperation( "ConeObjectByOctahedralAxiom",
      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>ConeObjectByOctahedralAxiom</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddConeObjectByOctahedralAxiom", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddConeObjectByOctahedralAxiom", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddConeObjectByOctahedralAxiom", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddConeObjectByOctahedralAxiom", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$, $\beta:B\to C$.
#! The output is a morphism $u_{\alpha,\beta}$:$C(\alpha)\to C(\beta\circ\alpha)$
#! such that $u_{\alpha,\beta}\circ\iota(\alpha)=\iota(\beta\circ\alpha)\circ\beta$
#! and $\pi(\alpha)=\pi(\beta\circ\alpha)\circ u_{\alpha,\beta}$.
#! @Returns a morphism $u_{\alpha,\beta}$:$C(\alpha)\to C(\beta\circ\alpha)$
#! @Arguments alpha, beta
DeclareOperation( "DomainMorphismByOctahedralAxiom",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>DomainMorphismByOctahedralAxiom</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddDomainMorphismByOctahedralAxiom", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDomainMorphismByOctahedralAxiom", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddDomainMorphismByOctahedralAxiom", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddDomainMorphismByOctahedralAxiom", [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are two morphisms $\alpha:A\to B$, $\beta:B\to C$.
#! The output is a morphism $\iota_{\alpha,\beta}$:$C(\beta\circ\alpha) \to C(\beta)$
#! such that $\iota_{\alpha,\beta}\circ\iota(\beta\circ\alpha)=\iota(\beta)$
#! and $\Sigma\alpha\circ\pi(\beta\circ\alpha)=\pi(\beta)$.
#! @Returns a morphism $C(\beta\circ\alpha) \to C(\beta)$ 
#! @Arguments alpha, beta
DeclareOperation( "MorphismIntoConeObjectByOctahedralAxiom",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismIntoConeObjectByOctahedralAxiom</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismIntoConeObjectByOctahedralAxiom", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismIntoConeObjectByOctahedralAxiom", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismIntoConeObjectByOctahedralAxiom", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismIntoConeObjectByOctahedralAxiom", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$, $\beta:B\to C$.
#! The output is a morphism $\pi_{\alpha,\beta}$:$C(\beta) \to \Sigma C(\alpha)$
#! such that $\pi_{\alpha,\beta}=\Sigma \iota(\alpha) \circ\pi(\beta)$.
#! @Returns a morphism $C(\beta) \to \Sigma C(\alpha)$
#! @Arguments alpha, beta
DeclareOperation( "MorphismFromConeObjectByOctahedralAxiom",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismFromConeObjectByOctahedralAxiom</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismFromConeObjectByOctahedralAxiom", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromConeObjectByOctahedralAxiom", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismFromConeObjectByOctahedralAxiom", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismFromConeObjectByOctahedralAxiom", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an object $s=C(\beta)$, a morphism $\alpha:A\to B$,
#! a morphism $\beta:B\to C$ and an object $r=C(u_{\alpha,\beta})$.
#! The output is an isomorphism $w_{\alpha,\beta}:C(\beta)\to C(u_{\alpha,\beta})$
#! such that $w_{\alpha,\beta}\circ \iota_{\alpha,\beta}=\iota(u_{\alpha,\beta})$
#! and $\pi_{\alpha,\beta}=\pi(u_{\alpha,\beta})\circ w_{\alpha,\beta}$.
#! I.e., the following diagram is commutative:
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! C(\alpha) \arrow[r, "u_{\alpha,\beta}"] \arrow[d, "\mathrm{id}_{C(\alpha)}"'] & C(\beta\circ\alpha)
#! \arrow[r, "\iota_{\alpha,\beta}"] \arrow[d, "\mathrm{id}_{C(\beta\circ\alpha)}"] &
#! C(\beta) \arrow[r, "\pi_{\alpha,\beta}"] \arrow[d, "w_{\alpha,\beta}", dashed] &
#! \Sigma C(\alpha) \arrow[d, "\mathrm{id}_{\Sigma C(\alpha)}"] \\
#! C(\alpha) \arrow[r, "u_{\alpha,\beta}"'] &
#! C(\beta\circ\alpha) \arrow[r, "\iota(u_{\alpha,\beta})"'] &
#! C(u_{\alpha,\beta}) \arrow[r, "\pi(u_{\alpha,\beta})"'] & \Sigma C(\alpha).
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism $C(\beta)\to C(u_{\alpha,\beta})$
#! @Arguments s, alpha, beta, r
DeclareOperation( "WitnessIsomorphismByOctahedralAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismByOctahedralAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$ and 
#! $\beta:B\to C$.
#! The output is an isomorphism $C(\beta)\to C(u_{\alpha,\beta})$
#! such that $w_{\alpha,\beta}\circ \iota_{\alpha,\beta}=\iota(u_{\alpha,\beta})$
#! and $\pi_{\alpha,\beta}=\pi(u_{\alpha,\beta})\circ w_{\alpha,\beta}$.
#! @Returns a morphism $C(\beta)\to C(u_{\alpha,\beta})$.
#! @Arguments alpha, beta
DeclareOperation( "WitnessIsomorphismByOctahedralAxiom",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismByOctahedralAxiom</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismByOctahedralAxiom", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismByOctahedralAxiom", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismByOctahedralAxiom", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismByOctahedralAxiom", [ IsCapCategory, IsList ] );

DeclareOperation( "ShiftExpandingIsomorphismWithGivenObjects", [ IsObject ] );

DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

DeclareOperation( "ShiftFactoringIsomorphismWithGivenObjects", [ IsObject ] );

DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

DeclareOperation( "ReverseShiftExpandingIsomorphismWithGivenObjects", [ IsObject ] );

DeclareOperation( "AddReverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddReverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

DeclareOperation( "ReverseShiftFactoringIsomorphismWithGivenObjects", [ IsObject ] );

DeclareOperation( "AddReverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddReverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

####################################
##
#! @Section GAP Categories
##
####################################


DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_TRIANGULATED_CATEGORY", IsCapCategory );
