#
# TriangulatedCategories: Framework for triangulated categories
#
# Declarations
#

#! @Chapter Operations
#! @Section Functors and natural transformations

DeclareAttribute( "ShiftFunctorAttr", IsTriangulatedCategory );

if not IsBound( ShiftFunctor ) then

  #! @Description
  #! The argument is a triangulated category $\mathcal{T}$.
  #! The output is the shift autoequivalence $\Sigma:\mathcal{T}\to\mathcal{T}$.
  #! @Arguments T
  #! @Returns a functor $\mathcal{T}\to\mathcal{T}$
  DeclareOperation( "ShiftFunctor", [ IsTriangulatedCategory ] );
  
fi;

#! @Description
#! The argument is a triangulated category $\mathcal{T}$.
#! The output is the auto-equivalence $\Sigma^{-1}:\mathcal{T}\to\mathcal{T}$.
#! @Arguments T
#! @Returns a functor $\mathcal{T}\to\mathcal{T}$
DeclareAttribute( "InverseShiftFunctor", IsTriangulatedCategory );

#! @Description
#! The argument is a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism
#! $\eta:\mathrm{Id}_{\mathcal{T}}\Rightarrow\Sigma^{-1}\circ\Sigma$.
#! @Arguments T
#! @Returns a natural transformation $\mathrm{Id}_{\mathcal{T}}\Rightarrow\Sigma^{-1}\circ\Sigma$
DeclareAttribute( "NaturalIsomorphismFromIdentityIntoInverseShiftOfShift", IsTriangulatedCategory );

#! @Description
#! The argument is a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism
#! $\eta:\mathrm{Id}_{\mathcal{T}}\Rightarrow\Sigma\circ\Sigma^{-1}$.
#! @Arguments T
#! @Returns a natural transformation $\mathrm{Id}_{\mathcal{T}}\Rightarrow\Sigma\circ\Sigma^{-1}$
DeclareAttribute( "NaturalIsomorphismFromIdentityIntoShiftOfInverseShift", IsTriangulatedCategory );

#! @Description
#! The argument is a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism
#! $\eta:\Sigma^{-1}\circ\Sigma\Rightarrow\mathrm{Id}_{\mathcal{T}}$.
#! @Arguments T
#! @Returns a natural transformation $\Sigma^{-1}\circ\Sigma\Rightarrow\mathrm{Id}_{\mathcal{T}}$
DeclareAttribute( "NaturalIsomorphismFromInverseShiftOfShiftIntoIdentity", IsTriangulatedCategory );

#! @Description
#! The argument is a triangulated category $\mathcal{T}$.
#! The output is the natural isomorphism
#! $\eta:\Sigma\circ\Sigma^{-1}\Rightarrow\mathrm{Id}_{\mathcal{T}}$.
#! @Arguments T
#! @Returns a natural isomorphism $\Sigma\circ\Sigma^{-1}\Rightarrow\mathrm{Id}_{\mathcal{T}}$
DeclareAttribute( "NaturalIsomorphismFromShiftOfInverseShiftIntoIdentity", IsTriangulatedCategory );

#! @Description
#! The argument is an exact functor $F:\mathcal{T}_1\to\mathcal{T}_2$ between triangulated categories.
#! The output is a natural isomorphism $\eta:F\circ \Sigma_{\mathcal{T}_1} \Rightarrow \Sigma_{\mathcal{T}_2} \circ F$.
#! @Arguments F
#! @Returns a natural transformation $F\circ \Sigma_{\mathcal{T}_1} \Rightarrow \Sigma_{\mathcal{T}_2} \circ F$
DeclareAttribute( "CommutativityNaturalTransformationWithShiftFunctor", IsCapFunctor );

#! @Description
#! The argument is an exact functor $F:\mathcal{T}_1\to\mathcal{T}_2$ between triangulated categories, for which
#! the attribute <C>CommutativityNaturalIsomorphismForExactFunctor</C> has already been set.
#! The output is the extension functor of $F$ to the categories of triangles over $\mathcal{T}_1$ and $\mathcal{T}_2$.
#! @Arguments F
#! @Returns a natural isomorphism $F\circ \Sigma_{\mathcal{T}_1} \Rightarrow \Sigma_{\mathcal{T}_2} \circ F$
DeclareAttribute( "ExtendFunctorToCategoryOfTriangles", IsCapFunctor );

#! @Description
#! The arguments are a category of exact triangles $T$ of some triangulated category and a boolian $b$.
#! The output is the rotation endofunctor on $T$. If $b$ = <C>true</C>, then the functor computes
#! witnesses when applied on objects.
#! @Arguments T, b
#! @Returns an endofunctor $T\to T$
KeyDependentOperation( "RotationFunctor", IsCapCategoryOfExactTriangles, IsBool, ReturnTrue );

#! @Description
#! The arguments are a category of exact triangles $T$ of some triangulated category and a boolian $b$.
#! The output is the inverse rotation endofunctor on $T$. If $b$ = <C>true</C>, then the functor computes
#! witnesses when applied on objects.
#! @Arguments T, b
#! @Returns an endofunctor $T\to T$
KeyDependentOperation( "InverseRotationFunctor", IsCapCategoryOfExactTriangles, IsBool, ReturnTrue );

