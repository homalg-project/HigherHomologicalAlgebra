# SPDX-License-Identifier: GPL-2.0-or-later
# TriangulatedCategories: Framework for triangulated categories
#
# Declarations
#

DeclareGlobalVariable( "TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD" );

####################################
#
# to avoid conflicts with modules package
#
####################################

if not IsBound( IsExactTriangle ) then
  DeclareProperty( "IsExactTriangle", IsAdditiveElementWithZero );
fi;

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

DeclareAttribute( "StandardCoConeObject",
                  IsCapCategoryMorphism );


DeclareAttribute( "MorphismFromStandardCoConeObject",
                  IsCapCategoryMorphism );

DeclareOperation( "MorphismBetweenStandardCoConeObjects",
      [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );
#! @Description
#! The arguments are a morphism $\alpha: A \to B$ in a triangulated category and an object $C:=C(\alpha)$.
#! The output is the morphism $\iota(\alpha):B\to C(\alpha)$
#! into the standard cone object $C(\alpha)$.
#! @Arguments alpha, C
#! @Returns a morphism $\iota(\alpha):B\to C(\alpha)$
DeclareOperation( "MorphismToStandardConeObjectWithGivenStandardConeObject", [ IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismToStandardConeObjectWithGivenStandardConeObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismToStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismToStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismToStandardConeObjectWithGivenStandardConeObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a morphism $\alpha: A \to B$ in a triangulated category.
#! The output is the morphism $\iota(\alpha):B\to C(\alpha)$
#! into the standard cone object $C(\alpha)$.
#! @Arguments alpha
#! @Returns a morphism $\iota(\alpha):B\to C(\alpha)$
DeclareAttribute( "MorphismToStandardConeObject", IsCapCategoryMorphism );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismToStandardConeObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismToStandardConeObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToStandardConeObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismToStandardConeObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismToStandardConeObject", [ IsCapCategory, IsList ] );

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
#! This is a convenience method to apply the shift functor on objects or morphisms.
#! The operation delegates to either <C>ShiftOnObject</C> or <C>ShiftOnMorphism</C>.
#! @Returns $\Sigma c$
#! @Arguments c
DeclareOperation( "Shift", [ IsCapCategoryCell ] );

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
#! This is a convenience method to apply the inverse shift functor on objects or morphisms.
#! The operation delegates to either <C>InverseShiftOnObject</C> or <C>InverseShiftOnMorphism</C>.
#! @Returns $\Sigma^{-1} c$
#! @Arguments c
DeclareOperation( "InverseShift", [ IsCapCategoryCell ] );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma \circ \Sigma^{-1}) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Returns a morphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Arguments A, sigma_o_rev_sigma_A
DeclareOperation( "UnitIsomorphismWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>UnitIsomorphismWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddUnitIsomorphismWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUnitIsomorphismWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUnitIsomorphismWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUnitIsomorphismWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Returns a morphism $A \to (\Sigma \circ \Sigma^{-1}) A$
#! @Arguments A
DeclareAttribute( "UnitIsomorphism", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>UnitIsomorphism</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddUnitIsomorphism", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUnitIsomorphism", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUnitIsomorphism", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUnitIsomorphism", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma^{-1} \circ \Sigma) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Returns a morphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Arguments A, rev_sigma_o_sigma_A
DeclareOperation( "InverseOfCounitIsomorphismWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>InverseOfCounitIsomorphismWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddInverseOfCounitIsomorphismWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseOfCounitIsomorphismWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInverseOfCounitIsomorphismWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInverseOfCounitIsomorphismWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Returns a morphism $A \to (\Sigma^{-1} \circ \Sigma) A$
#! @Arguments A
DeclareAttribute( "InverseOfCounitIsomorphism", IsCapCategoryObject );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma \circ \Sigma^{-1}) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Returns a morphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Arguments A, sigma_o_rev_sigma_A
DeclareOperation( "InverseOfUnitIsomorphismWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>InverseOfUnitIsomorphismWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddInverseOfUnitIsomorphismWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseOfUnitIsomorphismWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInverseOfUnitIsomorphismWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInverseOfUnitIsomorphismWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument in an objects $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Returns a morphism $(\Sigma \circ \Sigma^{-1}) A \to A$
#! @Arguments A
DeclareAttribute( "InverseOfUnitIsomorphism", IsCapCategoryObject );

#! @Description
#! The arguments are two objects $A$ and $(\Sigma^{-1} \circ \Sigma) A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Returns a morphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Arguments A, rev_sigma_o_sigma_A
DeclareOperation( "CounitIsomorphismWithGivenObject", [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>CounitIsomorphismWithGivenObject</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddCounitIsomorphismWithGivenObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCounitIsomorphismWithGivenObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCounitIsomorphismWithGivenObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCounitIsomorphismWithGivenObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $A$ in a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Returns a morphism $(\Sigma^{-1} \circ \Sigma) A \to A$
#! @Arguments A
DeclareAttribute( "CounitIsomorphism", IsCapCategoryObject );

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


DeclareOperation( "IsExactTriangle",
      [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddIsExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactTriangle", [ IsCapCategory, IsList ] );



DeclareOperation( "WitnessIsomorphismOntoStandardConeObject",
      [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObject", [ IsCapCategory, IsList ] );


DeclareOperation( "WitnessIsomorphismFromStandardConeObject",
      [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddWitnessIsomorphismFromStandardConeObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismFromStandardConeObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismFromStandardConeObject", [ IsCapCategory, IsList ] );

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
      [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$, $\beta:B\to C$.
#! The output is a morphism $u_{\alpha,\beta}$:$C(\alpha)\to C(\beta\circ\alpha)$
#! such that $u_{\alpha,\beta}\circ\iota(\alpha)=\iota(\beta\circ\alpha)\circ\beta$
#! and $\pi(\alpha)=\pi(\beta\circ\alpha)\circ u_{\alpha,\beta}$.
#! @Returns a morphism $u_{\alpha,\beta}$:$C(\alpha)\to C(\beta\circ\alpha)$
#! @Arguments alpha, beta
DeclareOperation( "DomainMorphismByOctahedralAxiomWithGivenObjects",
    [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "DomainMorphismByOctahedralAxiom",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>DomainMorphismByOctahedralAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddDomainMorphismByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDomainMorphismByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddDomainMorphismByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddDomainMorphismByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are two morphisms $\alpha:A\to B$, $\beta:B\to C$.
#! The output is a morphism $\iota_{\alpha,\beta}$:$C(\beta\circ\alpha) \to C(\beta)$
#! such that $\iota_{\alpha,\beta}\circ\iota(\beta\circ\alpha)=\iota(\beta)$
#! and $\Sigma\alpha\circ\pi(\beta\circ\alpha)=\pi(\beta)$.
#! @Returns a morphism $C(\beta\circ\alpha) \to C(\beta)$ 
#! @Arguments alpha, beta
DeclareOperation( "MorphismToConeObjectByOctahedralAxiomWithGivenObjects",
   [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "MorphismToConeObjectByOctahedralAxiom",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismToConeObjectByOctahedralAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismToConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismToConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismToConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$, $\beta:B\to C$.
#! The output is a morphism $\pi_{\alpha,\beta}$:$C(\beta) \to \Sigma C(\alpha)$
#! such that $\pi_{\alpha,\beta}=\Sigma \iota(\alpha) \circ\pi(\beta)$.
#! @Returns a morphism $C(\beta) \to \Sigma C(\alpha)$
#! @Arguments alpha, beta
DeclareOperation( "MorphismFromConeObjectByOctahedralAxiomWithGivenObjects",
    [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "MorphismFromConeObjectByOctahedralAxiom",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>MorphismFromConeObjectByOctahedralAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddMorphismFromConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddMorphismFromConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddMorphismFromConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

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
DeclareOperation( "WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$ and 
#! $\beta:B\to C$.
#! The output is an isomorphism $C(\beta)\to C(u_{\alpha,\beta})$
#! such that $w_{\alpha,\beta}\circ \iota_{\alpha,\beta}=\iota(u_{\alpha,\beta})$
#! and $\pi_{\alpha,\beta}=\pi(u_{\alpha,\beta})\circ w_{\alpha,\beta}$.
#! @Returns a morphism $C(\beta)\to C(u_{\alpha,\beta})$.
#! @Arguments alpha, beta
DeclareOperation( "WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiom",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two morphisms $\alpha:A\to B$ and $\beta:B\to C$.
#! The output is ...
#! @Returns a morphism $C(u_{\alpha,\beta})\to C(\beta)$
#! @Arguments alpha, beta
DeclareOperation( "WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

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
      [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

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
DeclareAttribute( "MorphismToConeObjectByRotationAxiom",
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
DeclareAttribute( "WitnessIsomorphismOntoStandardConeObjectByRotationAxiom",
     IsCapCategoryMorphism );

#! @Description
#! The arguments are an object $s=\Sigma A$, morphism $\alpha:A\to B$ and
#! an object $r=C(\iota A )$.
#! The output is an isomorphism $\Sigma A \to C(\iota(\alpha))$ such that
#! $?\circ\pi(\alpha)=\iota(\iota(\alpha))$ and
#! $\pi(\iota(\alpha))\circ ?=-\Sigma \alpha$.
#! @Returns a morphism $\Sigma A \to C(\iota(\alpha))$
#! @Arguments s, alpha, r
DeclareOperation( "WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

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
DeclareAttribute( "MorphismToConeObjectByInverseRotationAxiom",
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
DeclareAttribute( "WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiom",
     IsCapCategoryMorphism );

#! @Description
#! The arguments are an object $s=\Sigma A$, morphism $\alpha:A\to B$ and
#! an object $r=C(\iota A )$.
#! The output is an isomorphism $\Sigma A \to C(\iota(\alpha))$ such that
#! $?\circ\pi(\alpha)=\iota(\iota(\alpha))$ and
#! $\pi(\iota(\alpha))\circ ?=-\Sigma \alpha$.
#! @Returns a morphism $\Sigma A \to C(\iota(\alpha))$
#! @Arguments s, alpha, r
DeclareOperation( "WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{T}$ and a function $F$.
#! This operation adds the given function $F$ to
#! the category for the basic operation <C>WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects</C>.
#! @Returns nothing
#! @Arguments T, F
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddWitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects", [ IsCapCategory, IsList ] );

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

##
#! @Description
#! The arguments are list $L=[A_1,\dots,A_n]$ and two objects $X=\Sigma \bigoplus_i A_i, Y=\bigoplus_i \Sigma A_i$.
#! The output is the isomorphism $X \rightarrow Y$ associated to $\Sigma$.
#! @Returns a morphism
#! @Arguments X, L, Y
DeclareOperation( "ShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation ShiftExpandingIsomorphismWithGivenObjects. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a list $L=[A_1,\dots,A_n]$.
#! The output is the isomorphism $X \rightarrow Y$ associated to $\Sigma$, where 
#! $X=\Sigma \bigoplus_i A_i$ and $Y=\bigoplus_i \Sigma A_i$
#! @Returns a morphism
#! @Arguments L
DeclareOperation( "ShiftExpandingIsomorphism", [ IsList ] );

##
#! @Description
#! The arguments are list $L=[A_1,\dots,A_n]$ and two objects $Y=\bigoplus_i \Sigma A_i, X=\Sigma \bigoplus_i A_i$.
#! The output is the isomorphism $Y \rightarrow X$ associated to $\Sigma$.
#! @Returns a morphism
#! @Arguments Y, L, X
DeclareOperation( "ShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation AddShiftFactoringIsomorphismWithGivenObjects. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a list $L=[A_1,\dots,A_n]$.
#! The output is the isomorphism $Y \rightarrow X$ associated to $\Sigma$, where 
#! $Y=\bigoplus_i \Sigma A_i$ and $X=\Sigma \bigoplus_i A_i$.
#! @Returns a morphism
#! @Arguments L
DeclareOperation( "ShiftFactoringIsomorphism", [ IsList ] );

##
#! @Description
#! The arguments are list $L=[A_1,\dots,A_n]$ and two objects $X=\Sigma^{-1} \bigoplus_i A_i, Y=\bigoplus_i \Sigma^{-1} A_i$.
#! The output is the isomorphism $X \rightarrow Y$ associated to $\Sigma^{-1}$.
#! @Returns a morphism
#! @Arguments X, L, Y
DeclareOperation( "InverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation InverseShiftExpandingIsomorphismWithGivenObjects. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a list $L=[A_1,\dots,A_n]$.
#! The output is the isomorphism $X \rightarrow Y$ associated to $\Sigma$, where 
#! $X=\Sigma \bigoplus_i A_i$ and $Y=\bigoplus_i \Sigma A_i$
#! @Returns a morphism
#! @Arguments L
DeclareOperation( "InverseShiftExpandingIsomorphism", [ IsList ] );

##
#! @Description
#! The arguments are list $L=[A_1,\dots,A_n]$ and two objects $Y=\bigoplus_i \Sigma^{-1} A_i, X=\Sigma^{-1} \bigoplus_i A_i$.
#! The output is the isomorphism $Y \rightarrow X$ associated to $\Sigma^{-1}$.
#! @Returns a morphism
#! @Arguments Y, L, X
DeclareOperation( "InverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation InverseShiftFactoringIsomorphismWithGivenObjects. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );
#! @Description
#! The argument is a list $L=[A_1,\dots,A_n]$.
#! The output is the isomorphism $Y \rightarrow X$ associated to $\Sigma^{-1}$, where 
#! $Y=\bigoplus_i \Sigma^{-1} A_i$ and $X=\Sigma^{-1} \bigoplus_i A_i$.
#! @Returns a morphism
#! @Arguments L
DeclareOperation( "InverseShiftFactoringIsomorphism", [ IsList ] );

######################################
##
#! @Section Attributes and Operations
##
######################################

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_TRIANGULATED_CATEGORY", IsCapCategory );
