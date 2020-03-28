#############################################################################
##
##  DerivedCategories: Derived categories for abelian categories
##
##  Copyright 2020, Kamal Saleh, University of Siegen
##
#############################################################################

DeclareOperation( "MonomialsOfDegree", [ IsHomalgGradedRing, IsHomalgModuleElement ] );
DeclareAttribute( "BeilinsonFunctor", IsHomalgGradedRing );


DeclareAttribute( "BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedOmegaModules", IsHomalgGradedRing );
DeclareAttribute( "BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfAlgebroid", IsHomalgGradedRing );
DeclareAttribute( "BeilinsonFunctorIntoHomotopyCategoryOfQuiverRows", IsHomalgGradedRing );
DeclareAttribute( "BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfIndecProjectiveObjects", IsHomalgGradedRing );
DeclareAttribute( "BeilinsonFunctorIntoHomotopyCategoryOfProjectiveObjects", IsHomalgGradedRing );
DeclareAttribute( "BeilinsonFunctorIntoHomotopyCategoryOfAdditiveClosureOfTwistedCotangentModules", IsHomalgGradedRing );
DeclareAttribute( "BeilinsonFunctorIntoDerivedCategory", IsHomalgGradedRing );


DeclareAttribute( "RestrictionOfBeilinsonFunctorToFullSubcategoryGeneratedByTwistsOfStructureSheaf", IsHomalgGradedRing );

