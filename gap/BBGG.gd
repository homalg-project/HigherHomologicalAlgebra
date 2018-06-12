#
# BBGG: BBG correspondence and Beilinson monad
#
# Declarations
#

DeclareAttribute( "AsPresentationInCAP",  IsHomalgGradedModule  );
DeclareAttribute( "AsPresentationInHomalg",  IsGradedLeftOrRightPresentation  );

DeclareAttribute( "AsPresentationMorphismInCAP",  IsHomalgGradedMap  );
DeclareAttribute( "AsPresentationMorphismInHomalg",  IsGradedLeftOrRightPresentationMorphism  );

KeyDependentOperation( "GradedLeftPresentationGeneratedByHomogeneousPart", IsGradedLeftPresentation, IsInt, ReturnTrue );
DeclareAttribute( "EmbeddingInSuperObject", IsGradedLeftPresentation);

DeclareAttribute( "CastelnuovoMumfordRegularity", IsCapCategoryObject );
DeclareAttribute( "TateResolution",  IsGradedLeftOrRightPresentation  );
DeclareAttribute( "TateResolution",  IsGradedLeftOrRightPresentationMorphism );

DeclareOperation( "DimensionOfTateCohomology", [ IsCochainComplex, IsInt, IsInt ] );

KeyDependentOperation( "TwistFunctor", IsHomalgGradedRing, IsInt, ReturnTrue );
DeclareOperation( "\[\]", [ IsGradedLeftOrRightPresentation, IsInt ] );

KeyDependentOperation( "TwistedStructureBundle", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "TwistedCotangentBundle", IsHomalgGradedRing, IsInt, ReturnTrue );
KeyDependentOperation( "KoszulSyzygyModule", IsHomalgGradedRing, IsInt, ReturnTrue );
DeclareAttribute( "RFunctor", IsHomalgGradedRing );
DeclareAttribute( "LFunctor", IsHomalgGradedRing );
DeclareAttribute( "TateFunctor", IsHomalgGradedRing );
DeclareAttribute( "TateFunctorForCochains", IsHomalgGradedRing );
DeclareAttribute( "TateSequenceFunctor", IsHomalgGradedRing );
