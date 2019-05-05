LoadPackage( "ExamplesForModelCategories" );
 
A := CotangentBeilinsonQuiverAlgebra( Rationals, 3: VariableString := "x" );
 
quiver_reps := CategoryOfQuiverRepresentations( A : FinalizeCategory := false );

AddMorphismFromLiftingObject( quiver_reps, ProjectiveCover );

Finalize( quiver_reps );

stable_quiver_reps := StableCategoryByLiftingStructure( quiver_reps );

F := CanonicalProjectionFunctor( stable_quiver_reps );

a := RandomObject( quiver_reps, 4 );
b := RandomObject( quiver_reps, 4 );

HomomorphismStructureOnObjects( a, b );
HomomorphismStructureOnObjects( ApplyFunctor( F, a ), ApplyFunctor( F, b ) );


