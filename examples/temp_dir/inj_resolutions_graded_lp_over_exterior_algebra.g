LoadPackage( "GradedModulePresentationsForCap" );;
LoadPackage( "ComplexesForCAP" );;

S := GradedRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );
SetWeightsOfIndeterminates( S, [ 1, 1, 0 ] );
R := KoszulDualRing( S );;

cat := GradedLeftPresentations( R: FinalizeCategory := false );;

func := function( obj )
local ring, dual, nat, dual_obj, free_cover, 
       dual_free_cover, obj_to_double_dual_obj, embedding;
ring := UnderlyingHomalgRing( obj );
dual := FunctorGradedDualLeft( ring );
nat  := NaturalTransformationFromIdentityToGradedDoubleDualLeft( ring );
dual_obj := ApplyFunctor( dual, Opposite( obj ) );
free_cover := EpimorphismFromSomeProjectiveObject( dual_obj );
dual_free_cover := ApplyFunctor( dual, Opposite( free_cover ) );
obj_to_double_dual_obj := ApplyNaturalTransformation( nat, obj );
return PreCompose( obj_to_double_dual_obj, dual_free_cover );
end;;

AddMonomorphismIntoSomeInjectiveObject( cat, func );
SetIsAbelianCategoryWithEnoughInjectives( cat, true );
Finalize( cat );

m := HomalgMatrix( "[ [ -2*e0*e1, 0 ], [ -e0, -e0*e1 ], [ -2*e0-e1, 0 ] ]", 3, 2, R );;
M := AsGradedLeftPresentation( m, [ 1, 2 ] );;
C := StalkChainComplex( M, 0 );;
I := InjectiveResolution( C );
Display( I^-3 );
IsWellDefined( I^-3 );

