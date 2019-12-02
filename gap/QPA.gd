
DeclareAttribute( "DecomposeProjectiveQuiverRepresentation", IsQuiverRepresentation );
DeclareAttribute( "DecomposeInjectiveQuiverRepresentation", IsQuiverRepresentation );

DeclareAttribute( "IsomorphismIntoProjectiveRepresentationFromCanonicalDecomposition", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismFromProjectiveRepresentationIntoCanonicalDecomposition", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismFromInjectiveRepresentationIntoCanonicalDecomposition", IsQuiverRepresentation );
DeclareAttribute( "IsomorphismIntoInjectiveRepresentationFromCanonicalDecomposition", IsQuiverRepresentation );

DeclareAttribute( "UnderlyingProjectiveSummands", IsQuiverRepresentation );
DeclareAttribute( "UnderlyingInjectiveSummands", IsQuiverRepresentation );

DeclareOperation( "EpimorphismFromSomeDirectSum", [ IsList, IsCapCategoryObject ] );

DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheRightWithAlgebraElement" );
DeclareGlobalFunction( "MatrixOfLinearMapDefinedByPreComposingFromTheLeftWithAlgebraElement" );
DeclareOperation( "MorphismBetweenIndecProjectivesGivenByElement",
  [ IsQuiverRepresentation, IsQuiverAlgebraElement, IsQuiverRepresentation ] );

DeclareOperation( "SolutionMat", [ IsQPAMatrix, IsDenseList ] );

#DeclareOperation( "PreImagesRepresentative", [ IsQPAMatrix, IsDenseList ] );
#DeclareOperation( "PreImagesRepresentative", [ IsQuiverRepresentationHomomorphism, IsDenseList ] );


DeclareGlobalFunction( "CertainRowsOfQPAMatrix" );
DeclareGlobalFunction( "CertainColumnsOfQPAMatrix" );

DeclareOperation( "StackMatricesDiagonally", [ IsQPAMatrix, IsQPAMatrix ] );
DeclareOperation( "StackMatricesDiagonally", [ IsDenseList ] );
