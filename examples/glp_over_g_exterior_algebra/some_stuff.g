DeclareAttribute( "ToMorphismBetweenCotangentBundles", IsCapCategoryMorphism );
InstallMethod( ToMorphismBetweenCotangentBundles,
    [ IsCapCategoryMorphism ],
    function( phi )
    local A, n, F1, d1, k1, F2, d2, k2, i1, i2, Cotangent_bundle_1, Cotangent_bundle_2, is_zero_obj_1, is_zero_obj_2, l;

    # Omega^i(i) correspondes to E( -n + i ) = E( -n )( i ) = w_i
    # degree of E( -n + i ) is n - i
    # hence i = n  - degree of w_i

    A := UnderlyingHomalgRing( phi );
    n := Length( IndeterminatesOfExteriorRing( A ) );

    F1 := Source( phi );
    if Length( GeneratorDegrees( F1 ) ) <> 1 then 
        Error( "The source must be free of rank 1" );
    fi;

    d1 := GeneratorDegrees( F1 )[ 1 ];
    
    k1 := n - Int( String( d1 ) );

    F2 := Range( phi );
    if Length( GeneratorDegrees( F2 ) ) <> 1 then 
        Error( "The range must be free of rank 1" );
    fi;
     
    d2 := GeneratorDegrees( F2 )[ 1 ];
    k2 := n - Int( String( d2 ) );
    
    is_zero_obj_1 := false;
    if -1 < k1 and k1 < n then
       	Cotangent_bundle_1 := TwistedCotangentBundle( A, k1 );
    else
	    Cotangent_bundle_1 := ZeroObject( CapCategory( phi ) );
	    is_zero_obj_1 := true;
    fi;

    is_zero_obj_2 := false;
    if -1 < k2 and k2 < n then
       	Cotangent_bundle_2 := TwistedCotangentBundle( A, k2 );
    else
	    Cotangent_bundle_2 := ZeroObject( CapCategory( phi ) );
	    is_zero_obj_2 := true;
    fi;
	
    if is_zero_obj_1 or is_zero_obj_2 then
	    return ZeroMorphism( Cotangent_bundle_1, Cotangent_bundle_2 );
    fi;
    
    if IsZeroForMorphisms( phi ) then
	    return ZeroMorphism(  Cotangent_bundle_1, Cotangent_bundle_2 );
    fi;
    # The embedding of a submodule of a graded ring in a free module of rank 1 is unique up to 
    # multiplication by a scalar.
    i1 := MonomorphismIntoSomeInjectiveObject( Cotangent_bundle_1 );
    i2 := MonomorphismIntoSomeInjectiveObject( Cotangent_bundle_2 );
    
    #return Lift( PreCompose( i1, phi ), i2 );
    return LiftAlongMonomorphism( i2, PreCompose( i1, phi ) );
end );

name := Concatenation( "ω_A(i)->ω_A(j) to Ω^i_A(i)->Ω^j_A(j) endofunctor in ", Name( graded_lp_cat_ext ) );
ToMorphismBetweenCotangentBundlesFunctor := CapFunctor( name, graded_lp_cat_ext, graded_lp_cat_ext );
AddObjectFunction( ToMorphismBetweenCotangentBundlesFunctor,
function( M )
local mat, degrees_M, summands_M, list, d, k, n, F;
n := Length( IndeterminatesOfExteriorRing( A ) );
degrees_M := GeneratorDegrees( M );
degrees_M := List( degrees_M, i -> Int( String( i ) ) );
summands_M := List( degrees_M, d -> GradedFreeLeftPresentation(1,A,[d]) );

if summands_M = [ ] then
    return ZeroObject( graded_lp_cat_ext );
fi;

list := [ ];
for F in summands_M do 
    d := GeneratorDegrees( F )[ 1 ];
    
    k := n - Int( String( d ) );
    
    if -1 < k and k < n then
       	Add( list, TwistedCotangentBundle( A, k ) );
    else
	    Add( list, ZeroObject( CapCategory( M ) ) );
    fi;
od;
return DirectSum( list );
end ); 

AddMorphismFunction( ToMorphismBetweenCotangentBundlesFunctor,
function( new_source, t, new_range )
local mat, M, N, degrees_N, degrees_M, summands_N, summands_M, L;
mat := UnderlyingMatrix( t );
M := Source( t );
N := Range( t );
degrees_M := GeneratorDegrees( M );
degrees_N := GeneratorDegrees( N );
degrees_M := List( degrees_M, i -> Int( String( i ) ) );
degrees_N := List( degrees_N, i -> Int( String( i ) ) );
summands_M := List( degrees_M, d -> GradedFreeLeftPresentation(1,A,[d]) );;
summands_N := List( degrees_N, d -> GradedFreeLeftPresentation(1,A,[d]) );;
L := List( [ 1 .. Length( degrees_M ) ], i -> List( [ 1 .. Length( degrees_N ) ], 
        j -> ToMorphismBetweenCotangentBundles( GradedPresentationMorphism( summands_M[i],HomalgMatrix([ MatElm(mat,i,j)],1,1,A), summands_N[j]) ) ) );;
if Concatenation( L ) = [ ] then
    return ZeroMorphism( new_source, new_range );
else
    return MorphismBetweenDirectSums( L );
fi;
end );


