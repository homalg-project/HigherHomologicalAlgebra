#
# BBGG: BBG correspondence and Beilinson monad
#
# Declarations
#

DeclareInfoClass( "InfoBBGG" );

#! @Chapter Operations and attributes

#! @Section Attributes

#! @Description
#! The input is a graded lp $M$ over a graded polynomial ring $S$.
#! The output is the Castelnuovo-Mumford regularity of $M$.
#! @Arguments M
#! @Returns an integer
DeclareAttribute( "CastelnuovoMumfordRegularity", IsCapCategoryObject );

#! @Description
#! The input is a graded lp $M$ over a graded polynomial ring $S$ or a chain complex of graded lp's over $S$ or a graded 
#! lp over <C>KoszulDualRing(S)</C>.
#! The output is the Tate resolution given as a chain complex. To convert this chain complex to a cochain complex
#! we can use the command <C>AsCochainComplex</C>.
#! @Arguments M
#! @Returns a chain complex
DeclareAttribute( "TateResolution",  IsCapCategoryObject  );

#! @Description
#! The input is a morphism $\phi$ of graded lp's over a graded polynomial ring $S$ or a chain morphism 
#! of graded lp's over $S$ or a graded lp morphism over <C>KoszulDualRing(S)</C>.
#! The output is the Tate resolution of $\phi$ given as a chain morphism. To convert this chain morphism to a cochain morphism
#! we can use the command <C>AsCochainMorphism</C>.
#! @Arguments phi
#! @Returns a chain morphism
DeclareAttribute( "TateResolution",  IsCapCategoryMorphism );

#! @Description

#! @Arguments S
#! The input is a graded polynomial ring with $deg(x_i)=1$ for all indeterminates $x_i$'s. The output is the $R$ functor
#! from the category of graded lp's over $S$ to the cochains category of the graded lp's over 
#! <C>KoszulDualRing(S)</C>.
#! @Returns a CAP functor
DeclareAttribute( "RCochainFunctor", IsHomalgGradedRing );

#! @Arguments S
#! The input is a graded polynomial ring with $deg(x_i)=1$ for all indeterminates $x_i$'s. The output is the $R$ functor
#! from the category of graded lp's over $S$ to the chains category of the graded lp's over 
#! <C>KoszulDualRing(S)</C>.
#! @Returns a CAP functor
DeclareAttribute( "RChainFunctor", IsHomalgGradedRing );

#! @Arguments S
#! The input is a graded polynomial ring with $deg(x_i)=1$ for all indeterminates $x_i$'s. The output is the $L$ functor
#! from the category of graded lp's over <C>KoszulDualRing(S)</C> to the cochains category of the graded 
#! lp's over $S$.
#! @Returns a CAP functor
DeclareAttribute( "LCochainFunctor", IsHomalgGradedRing );

#! @Arguments S
#! The input is a graded polynomial ring with $deg(x_i)=1$ for all indeterminates $x_i$'s. The output is the $L$ functor
#! from the category of graded lp's over <C>KoszulDualRing(S)</C> to the chains category of the graded 
#! lp's over $S$.
#! @Returns a CAP functor
DeclareAttribute( "LChainFunctor", IsHomalgGradedRing );

#! @Arguments S, n
#! The input is a graded polynomial ring with $deg(x_i)=1$ for all indeterminates $x_i$'s and an integer $n$.
#! The output is an endofunctor on the category of lp's over $S$ that send each $M$ with $reg(M)\leq n$ to $M_{\geq n}$ and
#! each morphism $f$ to $f_{\geq n}$.
#! @Returns a CAP functor
KeyDependentOperation( "TruncationFunctorUsingTateResolution", IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, n
#! The input is a graded polynomial ring with $deg(x_i)=1$ for all indeterminates $x_i$'s and an integer $n$.
#! The output is a natural transformation from the truncation functor (using Tate resolution) to identity functor.
#! @Returns a CAP natural transformation
KeyDependentOperation( "NatTransFromTruncationUsingTateResolutionToIdentityFunctor",  IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, n
#! The input is a graded polynomial ring with $deg(x_i)=1$ for all indeterminates $x_i$'s and an integer $n$.
#! The output is an endofunctor on the category of lp's over $S$ that send each $M$ with $reg(M)\leq n$ to $M_{\geq n}$ and
#! each morphism $f$ to $f_{\geq n}$. This is much more faster than the truncation using Tate resolition.
#! @Returns a CAP functor
KeyDependentOperation( "TruncationFunctorUsingHomalg", IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, n
#! The input is a graded polynomial ring with $deg(x_i)=1$ for all indeterminates $x_i$'s and an integer $n$.
#! The output is a natural transformation from the truncation functor (using homalg) to identity functor.
#! @Returns a CAP natural transformation
KeyDependentOperation( "NatTransFromTruncationUsingHomalgToIdentityFunctor", IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, n
#! The input is a graded polynomial ring with $deg(x_i)=1$ for all indeterminates $x_i$'s and an integer $n$.
#! The output is a natural transformation from the truncation functor (using Tate resolution) to the truncation
#! functor (using homalg).
#! @Returns a CAP natural transformation
KeyDependentOperation( "NatTransFromTruncationUsingTateResolutionToTruncationFunctorUsingHomalg",  IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, n
#! The input is a graded ring $S$ and an integer $n$.
#! The output is an endofunctor on the category of lp's over $S$ that send each $M$ to the submodule of $M$
#! generated by all homogeneous elements of degree $n$. <C>GLP</C> stands for Graded Left Presentation.
#! @Returns a CAP functor
KeyDependentOperation( "GLPGeneratedByHomogeneousPartFunctor", IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, n
#! The input is a graded ring and an integer $n$.
#! The output is a natural transformation from the <C>GLPGeneratedByHomogeneousPartFunctor(S,n)</C> to the 
#! identity functor.
#! @Returns a CAP natural transformation
KeyDependentOperation( "NatTransFromGLPGeneratedByHomogeneousPartToIdentityFunctor", IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, n
#! The input is a graded ring an integer $n$.
#! The output is an functor from the category of lp's over $S$ to the category of vector spaces over the Coefficient
#! field of $S$ that sends each $M$ to the vector space of $M_n$.
#! @Returns a CAP functor
KeyDependentOperation( "HomogeneousPartOverCoefficientsRingFunctor", IsHomalgGradedRing, IsInt, ReturnTrue );


DeclareGlobalFunction( "RandomGradedPresentationMorphism" ); 

#! @EndSection

# to be removed and renamed!
DeclareOperation( "DimensionOfTateCohomology", [ IsCochainComplex, IsInt, IsInt ] );

KeyDependentOperation( "TwistFunctor", IsHomalgGradedRing, IsInt, ReturnTrue );
DeclareOperation( "\[\]", [ IsGradedLeftOrRightPresentation, IsInt ] );

KeyDependentOperation( "TwistedStructureBundle", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "TwistedCotangentBundle", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "KoszulSyzygyModule", IsHomalgGradedRing, IsInt, ReturnTrue );


