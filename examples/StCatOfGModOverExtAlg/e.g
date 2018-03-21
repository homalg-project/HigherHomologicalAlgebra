
ReadPackage( "StableCategoriesForCap", "/examples/StCatOfGModOverExtAlg/tools.gi" );
LoadPackage( "GradedModulePresentations" );

r := KoszulDualRing( HomalgFieldOfRationalsInSingular( )*"x,y,z,t" );
R := GradedRing( r );
SetWeightsOfIndeterminates( R, [ 1,1,1,0] );

cat := GradedLeftPresentations( R : FinalizeCategory  := false );

SetIsAbelianCategoryWithEnoughInjectives( cat, true );

AddMonomorphismIntoSomeInjectiveObject( cat, 
    function( obj )
    local ring, dual, nat, dual_obj, proj_cover, dual_proj_cover, obj_to_double_dual_obj;
                                                    
    ring := UnderlyingHomalgRing( obj );
    
    dual := FunctorGradedDualLeft( ring );
    
    nat  := NaturalTransformationFromIdentityToGradedDoubleDualLeft( ring );
    
    dual_obj := ApplyFunctor( dual, Opposite( obj ) );
    
    proj_cover := EpimorphismFromSomeProjectiveObject( dual_obj );
    
    dual_proj_cover := ApplyFunctor( dual, Opposite( proj_cover ) );
    
    obj_to_double_dual_obj := ApplyNaturalTransformation( nat, obj );
    
    return PreCompose( obj_to_double_dual_obj, dual_proj_cover );

end );

AddColift( cat, 

    function( morphism1, morphism2 )
    local N, M, A, B, I, B_over_M, zero_mat, A_over_zero, sol, XX, morphism_1, morphism_2;
    #                 rxs
    #                I
    #                ꓥ
    #         vxs    | nxs 
    #       ?X      (A)    morphism 2
    #                |
    #                |
    #    uxv    nxv   mxn
    #   M <----(B)-- N
    #
    #      morphism 1
    #
    # We need to solve the system
    #     B*X + Y*I = A
    #     M*X + Z*I = 0
    # i.e.,
    #        [ B ]            [ Y ]        [ A ]
    #        [   ] * X   +    [   ] * I =  [   ]
    #        [ M ]            [ Z ]        [ 0 ]
    #
    # the function is supposed to return X as a ( well defined ) morphism from M to I.
    
    morphism_1 := UnderlyingPresentationMorphism( morphism1 );
    
    morphism_2 := UnderlyingPresentationMorphism( morphism2 );
    
    I := UnderlyingMatrix( Range( morphism_2 ) );
    
    N := UnderlyingMatrix( Source( morphism_1 ) );
    
    M := UnderlyingMatrix( Range( morphism_1 ) );
    
    B := UnderlyingMatrix( morphism_1 );
    
    A := UnderlyingMatrix( morphism_2 );
    
    B_over_M := UnionOfRows( B, M );
    
    zero_mat := HomalgZeroMatrix( NrRows( M ), NrColumns( I ), HomalgRing( M ) );
    
    A_over_zero := UnionOfRows( A, zero_mat );

    sol := SolveTwoSidedEquationOverExteriorAlgebra( B_over_M, I, A_over_zero );
    
    if sol= fail then 
    
       return fail;
       
    else 
    
       return GradedPresentationMorphism( Range( morphism1 ), sol[ 1 ], Range( morphism2 ) );
       
    fi;
    
end );

AddLift( cat, 

   function( morphism1, morphism2 )
   local P, N, M, A, B, l, basis_indices, Q, R_B, R_N, L_P, R_M, L_id_s, L_P_mod, morphism_1, morphism_2, 
    A_deco, A_deco_list, A_deco_list_vec, A_vec, mat1, mat2, A_vec_over_zero_vec, mat, sol, XX, XX_, X_, s, v;
   
    #                 rxs
    #                P
    #                |
    #         sxv    | sxn 
    #        X      (A) 
    #                |
    #                V
    #    uxv    vxn   mxn
    #   M ----(B)--> N
    #
    #
    # We need to solve the system
    #     X*B + Y*N = A
    #     P*X + Z*M = 0
    # the function is supposed to return X as a ( well defined ) morphism from P to M.
    
    morphism_1 := UnderlyingPresentationMorphism( morphism1 );
    
    morphism_2 := UnderlyingPresentationMorphism( morphism2 );
    
    P := UnderlyingMatrix( Source( morphism_1 ) );
    
    N := UnderlyingMatrix( Range(  morphism_1 ) );
    
    M := UnderlyingMatrix( Source( morphism_2 ) );
    
    A := UnderlyingMatrix( morphism_1 );
    
    B := UnderlyingMatrix( morphism_2 );
   
    l := Length( IndeterminatesOfExteriorRing( R ) );
    
    basis_indices := MyList( l-1 );
    
    Q := CoefficientsRing( R ); 

    R_B := UnionOfRows( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, B ) ), HomalgIdentityMatrix( NrRows( A ), Q ) ) ) );

    R_N := UnionOfRows( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, N ) ), HomalgIdentityMatrix( NrRows( A ), Q ) ) ) );    

    L_P := UnionOfRows( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( M ), Q ), Q*FLeft( u, P ) ) ) );

    R_M := UnionOfRows( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, M ) ), HomalgIdentityMatrix( NrRows( P ), Q ) ) ) );

    L_id_s := UnionOfRows( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrRows( B ), Q ), Q*FLeft( u, HomalgIdentityMatrix( NrRows( A ), R ) ) ) ) );

    L_P_mod := L_P* Involution( L_id_s );

    A_deco := DecompositionOfHomalgMat( A );
   
    A_deco_list := List( A_deco, i-> i[ 2 ] );

    A_deco_list_vec := List( A_deco_list, mat -> UnionOfRows( List( [ 1..NrColumns( A ) ], i-> CertainColumns( mat, [ i ] ) ) ) );

    A_vec := Q*UnionOfRows( A_deco_list_vec );
    
    
    # Now we should have 
    #   R_B     * vec( X ) + R_N * vec( Y )                  = vec_A
    #   L_P_mod * vec( X ) +                + R_M * vec( Z ) = zero
    
    # or  [   R_B    R_N     0  ]      [  vec( X ) ]        [ vec_A ]
    #     [                     ]  *   [  vec( Y ) ]   =    [       ]
    #     [ L_P_mod  0      R_M ]      [  vec( Z ) ]        [   0   ]
    #
    # in the underlying field Q
    
    
    mat1 := UnionOfColumns( [ R_B, R_N, HomalgZeroMatrix( NrRows( A )*NrColumns( A )*2^l, NrRows( M )*NrRows( P )*2^l, Q ) ] );
    
    mat2 := UnionOfColumns( [ L_P_mod, HomalgZeroMatrix( NrRows( P )*NrColumns( M )*2^l, NrRows( N )*NrColumns( P )*2^l, Q ), R_M ] );
    
    mat := UnionOfRows( mat1, mat2 );
     
    A_vec_over_zero_vec := UnionOfRows( A_vec, HomalgZeroMatrix( NrColumns( M )*NrRows( P )*2^l, 1, Q ) );

    sol := LeftDivide( mat, A_vec_over_zero_vec );
    
    if sol = fail then 
      
      return fail;
     
    fi;
    
    s := NrColumns( P );
    
    v := NrColumns( M );
    
    XX := CertainRows( sol, [ 1 .. s*v*2^l ] );
    
    XX_ := UnionOfColumns( List( [ 1 .. v*2^l ], i -> CertainRows( XX, [ ( i - 1 )*s + 1 .. i*s ] ) ) );

    X_ := Sum( List( [ 1..2^l ], i-> ( R * CertainColumns( XX_, [ ( i - 1 )*v + 1 .. i*v ] ) )* RingElement( basis_indices[ i ], R ) ) );

    return GradedPresentationMorphism( Source( morphism1 ), X_, Source( morphism2 ) );
    
end );

AddIsProjective( cat, 
    function( obj )
     local cover, lift; 
     
     # If the number of rows of the matrix is zero then the module is free, hence projective.
       
     if NrRows( UnderlyingMatrix( obj ) ) = 0 then 
     
       return true;
       
     fi;
     
     cover := CoverByProjective( obj );
     
     lift := Lift( IdentityMorphism( obj ), cover );
     
     if lift = fail then 
     
        return false;
       
     fi; 
     
     return true;
     
end );
 
AddIsInjective( cat, IsProjective );
                        
Finalize( cat );

create_random_morphism := 
    function( g1, g2 )
    local Fr1, Fr2, Fr3, m12, m32, v, g, f, u, fiber, cover_of_fiber;
    Fr1 := GradedFreeLeftPresentation( Length(g1), R, g1 );
    Fr2 := GradedFreeLeftPresentation( Length(g2), R, g2 );
    m12 := RandomMatrixBetweenGradedFreeLeftModules( g1, g2, R );

    g := List( [ 1 .. Length( g2 ) + 2  ], i -> g2[ ( i mod Length(g2) ) + 1 ] + Random([1..2]) );
    m32 := RandomMatrixBetweenGradedFreeLeftModules( g, g2, R );

    Fr3 := GradedFreeLeftPresentation( Length(g), R, g );

    v := GradedPresentationMorphism( Fr1, m12, Fr2 );
    g := GradedPresentationMorphism( Fr3, m32, Fr2 );

    f := ProjectionInFactorOfFiberProduct( [ v, g ], 1 );
    u := ProjectionInFactorOfFiberProduct( [ v, g ], 2 );

    fiber := FiberProduct( v, g );

    cover_of_fiber := EpimorphismFromSomeProjectiveObject( fiber );

    f := PreCompose( cover_of_fiber, f );

    return GradedPresentationMorphism( CokernelObject( f), m12, CokernelObject( g ) );

end;

can_be_factored_through_free_module := 
    function( mor )
    local m;
    m := Colift( MonomorphismIntoSomeInjectiveObject( Source( mor ) ), mor );
    if m = fail then
        return false;
    else
        return true;
    fi;
end;

return_degree_zero_part := 
    function( M, N, f )
    local mat, required_degrees;
    mat := UnderlyingMatrix( f );
    required_degrees := List( GeneratorDegrees( M ), i -> 
                                    List( GeneratorDegrees( N ), j -> i - j ) );
    mat := ReductionOfHomalgMatrix( mat, required_degrees );
    return GradedPresentationMorphism(M,mat,N);
end;

try_of_external_hom := 
    function( MA, MB )
    local A, B, l, basis_indices, Q, N, sN, r,m,s,n,t,sN_t, basis_sN_t, basis, XX, XX_, X_, i;

    A := UnderlyingMatrix( UnderlyingPresentationObject( MA ) );
    B := UnderlyingMatrix( UnderlyingPresentationObject( MB ) );

    l := Length( IndeterminatesOfExteriorRing( R ) );
    basis_indices := MyList( l-1 );

    Q := CoefficientsRing( R ); 

    N := Q*FF3( A, B );

    sN := SyzygiesOfColumns( N );

    r := NrRows( A );
    m := NrColumns( A );
    s := NrColumns( B );
    n := NrRows( B );

    t := m*s*2^l;

    sN_t := CertainRows( sN, [ 1..t ] );
    
    basis_sN_t := BasisOfColumns( sN_t );
    
    basis := [ ];

    for i in [ 1 .. NrColumns( basis_sN_t ) ] do 
        
        XX := CertainColumns( basis_sN_t, [ i ] );

        XX_ := Iterated( List( [ 1 .. s ], i -> CertainRows( XX, [ ( i - 1 )*m*2^l + 1 .. i*m*2^l ] ) ), UnionOfColumns );

        X_ := Sum( List( [ 1..2^l ], i-> ( R*CertainRows( XX_, [ ( i - 1 )*m + 1 .. i*m ] ) )* RingElement( basis_indices[ i ], R ) ) );

        Add( basis, GradedPresentationMorphism( MA, X_, MB ) );

    od;
    basis := List( basis, b -> return_degree_zero_part( MA, MB, b ) );
return Filtered( basis, b -> not IsZeroForMorphisms(b) );

end;

f := create_random_morphism( [ 1, 2, 2 ],[ 1, 0 ] );
i := MonomorphismIntoSomeInjectiveObject( Source( f ) );

# The following morphism factors through the range of i which is free,
# let us test that.
mor := PreCompose( f, InjectionOfCofactorOfPushout( [ f, i ], 1 ) );
can_be_factored_through_free_module(mor);
# true
