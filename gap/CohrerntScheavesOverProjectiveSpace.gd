#############################################################################
##
##  DerivedCategories: Derived categories for abelian categories
##
##  Copyright 2020, Kamal Saleh, University of Siegen
##
#############################################################################

DeclareOperation( "MonomialsOfDegree", [ IsHomalgGradedRing, IsHomalgModuleElement ] );

DeclareAttribute( "FullSubcategoryGeneratedByTwistedOmegaModules", IsExteriorRing );

DeclareAttribute( "FullSubcategoryGeneratedByTwistsOfStructureSheaf", IsHomalgGradedRing );

DeclareAttribute( "FullSubcategoryGeneratedByTwistedCotangentSheaves", IsHomalgGradedRing );

DeclareAttribute( "FullSubcategoryGeneratedByDirectSumsOfTwistsOfStructureSheaf", IsHomalgGradedRing );

DeclareAttribute( "BeilinsonFunctor", IsHomalgGradedRing );

DeclareAttribute( "RestrictionOfBeilinsonFunctorToFullSubcategoryGeneratedByTwistsOfStructureSheaf", IsHomalgGradedRing );

DeclareAttribute( "IsomorphismFromFullSubcategoryGeneratedByTwistedOmegaModulesIntoTwistedCotangentSheaves", IsHomalgGradedRing );
