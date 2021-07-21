

LoadPackage( "FreydCategoriesForCAP" );
LoadPackage( "GradedModulePresent" );
LoadPackage( "DerivedC" );

Q := HomalgFieldOfRationalsInSingular( );
EEE := KoszulDualRing( GradedRing( Q * "x,y" ) );

EnhanceAllPackages( );
Gpres_EEE := GradedLeftPresentations( EEE );
Grows_EEE := CategoryOfGradedRows( EEE );
Grmod_EEE := FreydCategory( Grows_EEE );
Grmod_EEE!.Name := Concatenation( "Freyd( ", Name( Grows_EEE ), " )" );

St_Grmod_EEE := StableCategoryBySystemOfColiftingObjects( Grmod_EEE : FinalizeCategory := false );
ADD_TRIANGULATED_STRUCTURE( St_Grmod_EEE );
Finalize( St_Grmod_EEE );

St_Gpres_EEE := StableCategoryBySystemOfColiftingObjects( Gpres_EEE : FinalizeCategory := false );
ADD_TRIANGULATED_STRUCTURE( St_Gpres_EEE );
Finalize( St_Gpres_EEE );
