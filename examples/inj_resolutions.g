LoadPackage( "ModulePresentationsForCap" );;
LoadPackage( "ComplexesForCAP" );;

#! @Chunk complexes_example_2
#! @BeginLatexOnly
#! bla latex code here.
#! @EndLatexOnly
#! @Example
S := KoszulDualRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );;

left_pre_category := LeftPresentations( S:FinalizeCategory := false );;

func := function( obj )
local ring, dual, nat, dual_obj, free_cover, 
       dual_free_cover, obj_to_double_dual_obj, embedding;
ring := UnderlyingHomalgRing( obj );
dual := FunctorDualForLeftPresentations( ring );
nat  := NaturalTransformationFromIdentityToDoubleDualForLeftPresentations( ring );
dual_obj := ApplyFunctor( dual, obj );
free_cover := CoverByFreeModule( dual_obj );
dual_free_cover := ApplyFunctor( dual, free_cover );
obj_to_double_dual_obj := ApplyNaturalTransformation( nat, obj );
return PreCompose( obj_to_double_dual_obj, dual_free_cover );
end;;

AddMonomorphismInInjectiveObject( left_pre_category, func );
SetHasEnoughInjectives( left_pre_category, true );
Finalize( left_pre_category );

m := HomalgMatrix( "[ [ e0, e1, e2 ],[ 0, 0, e0 ] ]", 2, 3, S );;
M := AsLeftPresentation( m );;
F := FreeLeftPresentation( 2, S );;
f_matrix := HomalgMatrix( "[ [ e1, 0, 0], [1, 0, 1 ] ]", 2, 3, S );;
f := PresentationMorphism( F, f_matrix, M );;
g := KernelEmbedding( f );;
K := Source( g );;
h := ZeroMorphism( M, K );;
C := CochainComplex( [ h, g, f ] );;
# Display( C, 0, 1 );
C[ 2 ];;
C^2;;
#! @EndExample
#! @EndChunk

