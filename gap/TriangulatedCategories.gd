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

#! @Section Triangulated categories

KeyDependentOperation( "Shift", IsCapCategoryCell, IsInt, ReturnTrue );

DeclareCategory( "IsTriangulatedCategory", IsCapCategory );

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
DeclareOperation( "ShiftOnMorphismWithGivenObjects", [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

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
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$. The output is $\Sigma^{-1} A$.
#! @Returns $\Sigma^{-1} A$
#! @Arguments A
DeclareOperation( "InverseShiftOnObject", [ IsObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>InverseShiftOnObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddInverseShiftOnObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseShiftOnObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInverseShiftOnObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInverseShiftOnObject", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an object $\Sigma^{-1} A$, a morphism $\alpha:A\to B$ and an object $\Sigma^{-1} B$ in a triangulated category $\mathcal{T}$.
#! The output is $\Sigma^{-1} \alpha:\Sigma^{-1} A \to \Sigma^{-1} B$.
#! @Returns $\Sigma^{-1} \alpha:\Sigma^{-1} A \to \Sigma^{-1} B$
#! @Arguments rev_sigma_A, alpha, rev_sigma_B
DeclareOperation( "InverseShiftOnMorphismWithGivenObjects", [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>InverseShiftOnMorphismWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddInverseShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInverseShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInverseShiftOnMorphismWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha:A\to B$ in a triangulated category $\mathcal{T}$.
#! The output is $\Sigma^{-1} \alpha:\Sigma^{-1} A \to \Sigma^{-1} B$.
#! @Returns $\Sigma^{-1} \alpha:\Sigma^{-1} A \to \Sigma^{-1} B$
#! @Arguments alpha
DeclareAttribute( "InverseShiftOnMorphism", IsCapCategoryMorphism );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma \circ \Sigma^{-1}) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Returns a morphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Arguments A, sigma_o_rev_sigma_A
DeclareOperation( "IsomorphismIntoShiftOfInverseShiftWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismIntoShiftOfInverseShiftWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismIntoShiftOfInverseShiftWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoShiftOfInverseShiftWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfInverseShiftWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfInverseShiftWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Returns a morphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Arguments A
DeclareOperation( "IsomorphismIntoShiftOfInverseShift", [ IsObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismIntoShiftOfInverseShift</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismIntoShiftOfInverseShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoShiftOfInverseShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfInverseShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfInverseShift", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma^{-1} \circ \Sigma) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Returns a morphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Arguments A, rev_sigma_o_sigma_A
DeclareOperation( "IsomorphismIntoInverseShiftOfShiftWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismIntoInverseShiftOfShiftWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismIntoInverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoInverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoInverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoInverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Returns a morphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Arguments A
DeclareAttribute( "IsomorphismIntoInverseShiftOfShift", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismIntoInverseShiftOfShift</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismIntoInverseShiftOfShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoInverseShiftOfShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoInverseShiftOfShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoInverseShiftOfShift", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma \circ \Sigma^{-1}) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Returns a morphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Arguments A, sigma_o_rev_sigma_A
DeclareOperation( "IsomorphismFromShiftOfInverseShiftWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismFromShiftOfInverseShiftWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismFromShiftOfInverseShiftWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromShiftOfInverseShiftWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfInverseShiftWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfInverseShiftWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument in an objects $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Returns a morphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Arguments A
DeclareAttribute( "IsomorphismFromShiftOfInverseShift", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismFromShiftOfInverseShift</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismFromShiftOfInverseShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromShiftOfInverseShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfInverseShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfInverseShift", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma^{-1} \circ \Sigma) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Returns a morphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Arguments A, rev_sigma_o_sigma_A
DeclareOperation( "IsomorphismFromInverseShiftOfShiftWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismFromInverseShiftOfShiftWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismFromInverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromInverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromInverseShiftOfShiftWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Returns a morphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Arguments A
DeclareAttribute( "IsomorphismFromInverseShiftOfShift", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>IsomorphismFromInverseShiftOfShift</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddIsomorphismFromInverseShiftOfShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInverseShiftOfShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromInverseShiftOfShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromInverseShiftOfShift", [ IsCapCategory, IsList ] );

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
DeclareOperation( "MorphismBetweenStandardConeObjectsWithGivenObjects",
          [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismBetweenStandardConeObjectsWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismBetweenStandardConeObjectsWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismBetweenStandardConeObjectsWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismBetweenStandardConeObjectsWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismBetweenStandardConeObjectsWithGivenObjects", [ IsCapCategory, IsList ] );


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


DeclareOperation( "WitnessIsomorphismIntoStandardConeObjectByExactTriangle",
      [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByExactTriangle", [ IsCapCategory, IsList ] );


DeclareOperation( "WitnessIsomorphismFromStandardConeObjectByExactTriangle",
      [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByExactTriangle", [ IsCapCategory, IsList ] );

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
DeclareOperation( "WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$ and 
#! $\beta:B\to C$.
#! The output is an isomorphism $C(\beta)\to C(u_{\alpha,\beta})$
#! such that $w_{\alpha,\beta}\circ \iota_{\alpha,\beta}=\iota(u_{\alpha,\beta})$
#! and $\pi_{\alpha,\beta}=\pi(u_{\alpha,\beta})\circ w_{\alpha,\beta}$.
#! @Returns a morphism $C(\beta)\to C(u_{\alpha,\beta})$.
#! @Arguments alpha, beta
DeclareOperation( "WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiom",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$ and $\beta:B\to C$.
#! The output is ...
#! @Returns a morphism $C(u_{\alpha,\beta})\to C(\beta)$
#! @Arguments alpha, beta
DeclareOperation( "WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$ and $\beta:B\to C$.
#! The output is ...
#! @Returns a morphism $C(u_{\alpha,\beta})\to C(\beta)$
#! @Arguments alpha, beta
DeclareOperation( "WitnessIsomorphismFromStandardConeObjectByOctahedralAxiom",
      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#################################

#! @Description
#! The argument is a morphism $\alpha:A\to B$
#! The output is $\Sigma A$.
#! @Returns an object $\Sigma A$
#! @Arguments alpha
DeclareAttribute( "ConeObjectByRotationAxiom",
      IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is $\iota(\alpha):B\to C(\alpha)$.
#! @Returns a morphism $B\to C(\alpha)$.
#! @Arguments alpha
DeclareAttribute( "DomainMorphismByRotationAxiom",
      IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is a morphism $\pi(\alpha):C(\alpha)\to \Sigma A$.
#! @Returns a morphism $C(\alpha)\to \Sigma A$
#! @Arguments alpha
DeclareAttribute( "MorphismIntoConeObjectByRotationAxiom",
    IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is a morphism $-\Sigma \alpha:\Sigma A\to\Sigma B$.
#! @Returns a morphism $\Sigma A\to\Sigma B$
#! @Arguments alpha
DeclareAttribute( "MorphismFromConeObjectByRotationAxiom",
    IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is an isomorphism $\Sigma A \to C(\iota(\alpha))$ such that
#! $?\circ\pi(\alpha)=\iota(\iota(\alpha))$ and
#! $\pi(\iota(\alpha))\circ ?=-\Sigma \alpha$.
#! @Returns a morphism $\Sigma A \to C(\iota(\alpha))$
#! @Arguments alpha
DeclareAttribute( "WitnessIsomorphismIntoStandardConeObjectByRotationAxiom",
     IsCapCategoryMorphism );

#! @Description
#! The arguments are an object $s=\Sigma A$, morphism $\alpha:A\to B$ and
#! an object $r=C(\iota A )$.
#! The output is an isomorphism $\Sigma A \to C(\iota(\alpha))$ such that
#! $?\circ\pi(\alpha)=\iota(\iota(\alpha))$ and
#! $\pi(\iota(\alpha))\circ ?=-\Sigma \alpha$.
#! @Returns a morphism $\Sigma A \to C(\iota(\alpha))$
#! @Arguments s, alpha, r
DeclareOperation( "WitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is an isomorphism $C(\iota(\alpha))\to\Sigma A$ such that
#! ???
#! @Returns a morphism $C(\iota(\alpha))\to\Sigma A$
#! @Arguments alpha
DeclareAttribute( "WitnessIsomorphismFromStandardConeObjectByRotationAxiom",
      IsCapCategoryMorphism );

#! @Description
#! The arguments are an object $s=C(\iota(\alpha))$, morphism $\alpha:A\to B$ and
#! an object $r=\Sigma A$.
#! The output is an isomorphism $C(\iota(\alpha))\to\Sigma A$ such that
#! ???
#! @Returns a morphism $C(\iota(\alpha))\to\Sigma A$
#! @Arguments s, alpha, r
DeclareOperation( "WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

#################################

#! @Description
#! The argument is a morphism $\alpha:A\to B$
#! The output is $\Sigma A$.
#! @Returns an object $\Sigma A$
#! @Arguments alpha
DeclareAttribute( "ConeObjectByInverseRotationAxiom",
      IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is $\iota(\alpha):B\to C(\alpha)$.
#! @Returns a morphism $B\to C(\alpha)$.
#! @Arguments alpha
DeclareAttribute( "DomainMorphismByInverseRotationAxiom",
      IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is a morphism $\pi(\alpha):C(\alpha)\to \Sigma A$.
#! @Returns a morphism $C(\alpha)\to \Sigma A$
#! @Arguments alpha
DeclareAttribute( "MorphismIntoConeObjectByInverseRotationAxiom",
    IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is a morphism $-\Sigma \alpha:\Sigma A\to\Sigma B$.
#! @Returns a morphism $\Sigma A\to\Sigma B$
#! @Arguments alpha
DeclareAttribute( "MorphismFromConeObjectByInverseRotationAxiom",
    IsCapCategoryMorphism );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is an isomorphism $\Sigma A \to C(\iota(\alpha))$ such that
#! $?\circ\pi(\alpha)=\iota(\iota(\alpha))$ and
#! $\pi(\iota(\alpha))\circ ?=-\Sigma \alpha$.
#! @Returns a morphism $\Sigma A \to C(\iota(\alpha))$
#! @Arguments alpha
DeclareAttribute( "WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiom",
     IsCapCategoryMorphism );

#! @Description
#! The arguments are an object $s=\Sigma A$, morphism $\alpha:A\to B$ and
#! an object $r=C(\iota A )$.
#! The output is an isomorphism $\Sigma A \to C(\iota(\alpha))$ such that
#! $?\circ\pi(\alpha)=\iota(\iota(\alpha))$ and
#! $\pi(\iota(\alpha))\circ ?=-\Sigma \alpha$.
#! @Returns a morphism $\Sigma A \to C(\iota(\alpha))$
#! @Arguments s, alpha, r
DeclareOperation( "WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha:A\to B$.
#! The output is an isomorphism $C(\iota(\alpha))\to\Sigma A$ such that
#! ???
#! @Returns a morphism $C(\iota(\alpha))\to\Sigma A$
#! @Arguments alpha
DeclareAttribute( "WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiom",
      IsCapCategoryMorphism );

#! @Description
#! The arguments are an object $s=C(\iota(\alpha))$, morphism $\alpha:A\to B$ and
#! an object $r=\Sigma A$.
#! The output is an isomorphism $C(\iota(\alpha))\to\Sigma A$ such that
#! ???
#! @Returns a morphism $C(\iota(\alpha))\to\Sigma A$
#! @Arguments s, alpha, r
DeclareOperation( "WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsList ] );


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

DeclareOperation( "InverseShiftExpandingIsomorphismWithGivenObjects", [ IsObject ] );

DeclareOperation( "AddInverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

DeclareOperation( "InverseShiftFactoringIsomorphismWithGivenObjects", [ IsObject ] );

DeclareOperation( "AddInverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

######################################
##
#! @Section Attributes and Operations
##
######################################

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_TRIANGULATED_CATEGORY", IsCapCategory );
