LoadPackage( "ModulePresentations" );
LoadPackage( "RingsForHomalg" );
LoadPackage( "ComplexesForCAP" );

R := HomalgFieldOfRationalsInSingular()*"x,y,z";;
R := R/( "x*y-z^3"/R );
cat := LeftPresentations( R: FinalizeCategory := false );
AddEpimorphismFromSomeProjectiveObject( cat, CoverByFreeModule );
SetIsAbelianCategoryWithEnoughProjectives( cat, true );
Finalize( cat );
chains := ChainComplexCategory( cat : FinalizeCategory := false );
Finalize( chains );

# The functor: __ tensor M
tensor_functor := function( M )
local Tensor_product_with_M;
Tensor_product_with_M := CapFunctor( "Tensor product functor", cat, cat );
AddObjectFunction( Tensor_product_with_M, 
    function( obj )
    return TensorProductOnObjects( obj, M );
    end );
AddMorphismFunction( Tensor_product_with_M, 
    function( obj1, mor, obj2 )
    return TensorProductOnMorphisms( mor, IdentityMorphism( M ) );
    end );
return Tensor_product_with_M;
end;
    
# The functor: Hom( __, M ) as covariant functor
hom_functor := function( M )
local Hom_Obj_M;
Hom_Obj_M := CapFunctor( "Hom(_,N) functor", Opposite( cat ), cat );
AddObjectFunction( Hom_Obj_M,
    function( obj )
    return InternalHomOnObjects( Opposite( obj ), M );
    end );
AddMorphismFunction( Hom_Obj_M,
    function( obj1, mor, obj2 )
    return InternalHomOnMorphisms( Opposite( mor ), IdentityMorphism( M ) );
    end );
return Hom_Obj_M;
end;

m := HomalgMatrix( "[ x, y, z ]", 3, 1, R );
M := AsLeftPresentation( m );

# n := HomalgMatrix( "[ [ w, t, 0, z ], [ x*y, w, s, s ] ]", 2, 4, R );
n := HomalgMatrix( "[ x*y,y,z,y*x*z,x,-y,y*z,x ]", 4, 2, R );

N := AsLeftPresentation( n );

# Tensor_product_with_M_in_chains := ExtendFunctorToChainComplexCategoryFunctor( tensor_functor( M ) );
hom_to_N := hom_functor( N );
Hom_Obj_N_from_cochains_to_cochains := ExtendFunctorToCochainComplexCategoryFunctor( hom_to_N );
Hom_Obj_N_from_chains_to_cochains := 
    PreCompose( ChainCategoryToCochainCategoryOfOppositeCategory( cat ), Hom_Obj_N_from_cochains_to_cochains );

quit;

CM := StalkChainComplex( M, 0 );
P := ProjectiveResolutionWithBounds( CM, 5000 );
lambdas := List( [ 2 .. ActiveUpperBound( P ) ], i-> KernelEmbedding( P^(i-1) ) );
kappas  := List( [ 2 .. ActiveUpperBound( P ) ], i-> KernelLift( P^(i-1), P^i ) );
List( kappas, IsEpimorphism );
hom_P := ApplyFunctor( Hom_Obj_N_from_chains_to_cochains, P );
SetLowerBound( hom_P, -1 );
SetUpperBound( hom_P, ActiveUpperBound( P ) );
IsWellDefined( hom_P, -1, ActiveUpperBound( P ) );

hom_lambdas := List( lambdas, l -> ApplyFunctor( hom_to_N, Opposite( l ) ) );
hom_kappas := List( kappas, k -> ApplyFunctor( hom_to_N, Opposite( k ) ) );
# The following list should contain only true's
List( hom_kappas, IsMonomorphism );
# The following two lists are supposed to be equals
List( hom_lambdas, IsEpimorphism );
List( [ 2 .. ActiveUpperBound( P ) ], i-> IsExactInIndex( hom_P, i ) );
pres := List( [ 2 .. ActiveUpperBound( P ) ], i-> PreCompose( hom_kappas[i-1], hom_P^(i) ) );
# The output should be true
IsZero( pres );
l := List( [ 2 .. ActiveUpperBound( P ) ], i -> KernelLift( hom_P^(i), hom_kappas[ i-1 ] ) );
# The list should contain only true's
List( l, f-> IsIsomorphism( f ) );
