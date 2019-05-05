LoadPackage( "ExamplesForModelCategories" );
 
A := CotangentBeilinsonQuiverAlgebra( Rationals, 3: VariableString := "x" );
 
quiver_reps := CategoryOfQuiverRepresentations( A : FinalizeCategory := false );
 
AddMorphismIntoColiftingObject( quiver_reps, InjectiveEnvelope );

Finalize( quiver_reps );

stable_quiver_reps := StableCategoryByColiftingStructure( quiver_reps );

F := CanonicalProjectionFunctor( stable_quiver_reps );

a := RandomObject( quiver_reps, 4 );
b := RandomObject( quiver_reps, 4 );

hom_ab := HomomorphismStructureOnObjects( a, b );
hom_stable_ab := HomomorphismStructureOnObjects( ApplyFunctor( F, a ), ApplyFunctor( F, b ) );

