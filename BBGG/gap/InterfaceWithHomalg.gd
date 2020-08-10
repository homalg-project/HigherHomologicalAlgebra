
#! @Chapter Interface with homalg
#! @Section Operations

#! @Description
#! The input is a graded lp in CAP and the output is
#! the corresponding graded lp in <C>homalg</C>.
#! @Arguments M
#! @Returns a graded lp in homalg
DeclareAttribute( "AsPresentationInHomalg", IsGradedLeftOrRightPresentation  );

#! @Description
#! The input is a graded lp in homalg and the output is the corresponding graded lp
#! in <C>CAP</C>.
#! @Arguments M
#! @Returns a graded lp in CAP
DeclareAttribute( "AsPresentationInCAP", IsHomalgGradedModule  );

#! @Description
#! The input is a graded lp morphism in CAP and the output is
#! the corresponding graded lp morphism in <C>homalg</C>.
#! @Arguments phi
#! @Returns a graded lp in homalg
DeclareAttribute( "AsPresentationMorphismInHomalg", IsGradedLeftOrRightPresentationMorphism  );

#! @Description
#! The input is a graded lp morphism in homalg and the output is the corresponding graded lp morphism
#! in <C>CAP</C>.
#! @Arguments phi
#! @Returns a graded lp in CAP
DeclareAttribute( "AsPresentationMorphismInCAP", IsHomalgGradedMap  );

#! @EndSection

DeclareOperation( "RepresentationMapOfRingElement", [ IsRingElement, IsGradedLeftOrRightPresentation, IsInt ] );
KeyDependentOperation( "GradedLeftPresentationGeneratedByHomogeneousPart", IsGradedLeftPresentation, IsInt, ReturnTrue );
DeclareAttribute( "EmbeddingInSuperObject", IsGradedLeftPresentation);
#DeclareAttribute( "CastelnuovoMumfordRegularity", IsCapCategoryObject );

