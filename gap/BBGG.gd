#
# BBGG: BBG correspondence and Beilinson monad
#
# Declarations
#

DeclareAttribute( "AsPresentationInCAP",  IsHomalgGradedModule  );
DeclareAttribute( "AsPresentationInHomalg",  IsGradedLeftOrRightPresentation  );

DeclareAttribute( "AsPresentationMorphismInCAP",  IsHomalgGradedMap  );
DeclareAttribute( "AsPresentationMorphismInHomalg",  IsGradedLeftOrRightPresentationMorphism  );


DeclareAttribute( "RFunctor", IsHomalgGradedRing );
DeclareAttribute( "LFunctor", IsHomalgGradedRing );
DeclareAttribute( "TateFunctor", IsHomalgGradedRing );
DeclareAttribute( "TateSequenceFunctor", IsHomalgGradedRing );

DeclareAttribute( "CastelnuovoMumfordRegularity", IsCapCategoryObject );
DeclareAttribute( "TateResolution",  IsGradedLeftOrRightPresentation  );
DeclareAttribute( "TateResolution",  IsGradedLeftOrRightPresentationMorphism );

DeclareOperation( "DimensionOfTateCohomology", [ IsCochainComplex, IsInt, IsInt ] );