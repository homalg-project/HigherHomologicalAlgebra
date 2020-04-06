#############################################################################
##
## DerivedCategories: Derived categories for abelian categories
##
## Copyright 2020, Kamal Saleh, University of Siegen
##
## Some qpa tweaks to improve performance and functionality
##
#############################################################################


##
DeclareGlobalVariable( "GLOBAL_FIELD_FOR_QPA" );

## If this is used, then the methods SolutionMat and NullspaceMat will use this field.
DeclareGlobalFunction( "SET_GLOBAL_FIELD_FOR_QPA" );

DeclareGlobalFunction( "CertainRowsOfQPAMatrix" );

DeclareGlobalFunction( "CertainColumnsOfQPAMatrix" );

DeclareOperation( "StackMatricesDiagonally", [ IsQPAMatrix, IsQPAMatrix ] );

DeclareOperation( "StackMatricesDiagonally", [ IsDenseList ] );

DeclareGlobalFunction( "QuiverRepresentationNoCheck" );

DeclareGlobalFunction( "QuiverRepresentationHomomorphismNoCheck" );

DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheRightWithAlgebraElement" );

DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheLeftWithAlgebraElement" );

DeclareOperation( "MorphismBetweenIndecProjectivesGivenByElement",
  [ IsQuiverRepresentation, IsQuiverAlgebraElement, IsQuiverRepresentation ] );

DeclareAttribute( "UnderlyingProjectiveSummands", IsQuiverRepresentation );

DeclareAttribute( "UnderlyingInjectiveSummands", IsQuiverRepresentation );

DeclareAttribute( "DecomposeProjectiveQuiverRepresentation", IsQuiverRepresentation );

DeclareAttribute( "DecomposeInjectiveQuiverRepresentation", IsQuiverRepresentation );

DeclareAttribute( "IsomorphismOntoProjectiveRepresentationFromCanonicalDecomposition", IsQuiverRepresentation );

DeclareAttribute( "IsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition", IsQuiverRepresentation );

DeclareAttribute( "IsomorphismFromInjectiveRepresentationIntoCanonicalDecomposition", IsQuiverRepresentation );

DeclareAttribute( "IsomorphismOntoInjectiveRepresentationFromCanonicalDecomposition", IsQuiverRepresentation );

DeclareGlobalFunction( "Homalg_to_QPA_Matrix" );

DeclareGlobalFunction( "QPA_to_Homalg_Matrix" );

DeclareGlobalFunction( "QPA_to_Homalg_Matrix_With_Given_Homalg_Field" );

DeclareOperation( "SolutionMat", [ IsQPAMatrix, IsDenseList ] );

DeclareOperation( "AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM",
  [ IsQuiverRepresentation, IsQuiverRepresentation ] );

DeclareOperation( "PARTITIONS_OF_AUXILIARY_MATRIX_FOR_BASIS_OF_EXTERNAL_HOM",
  [ IsQuiverRepresentation, IsQuiverRepresentation ] );

DeclareGlobalFunction( "BASIS_OF_EXTERNAL_HOM_OF_QUIVER_REPRESENTATIONS" );

DeclareGlobalFunction( "COEFFICIENTS_OF_QUIVER_REPRESENTATIONS_HOMOMORPHISM" );

DeclareGlobalFunction( "HOM_STRUCTURE_ON_QUIVER_REPRESENTATIONS" );

DeclareGlobalFunction( "HOM_STRUCTURE_ON_QUIVER_REPRESENTATION_HOMOMORPHISMS_WITH_GIVEN_OBJECTS" );

DeclareGlobalFunction( "INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE" );

DeclareGlobalFunction( "INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM" );

DeclareOperation( "CategoryOfQuiverRepresentations",
  [ IsQuiverAlgebra, IsRationalsForHomalg ] );

DeclareAttribute( "IndecProjectiveObjects", IsQuiverRepresentationCategory );
DeclareAttribute( "IndecInjectiveObjects", IsQuiverRepresentationCategory );

