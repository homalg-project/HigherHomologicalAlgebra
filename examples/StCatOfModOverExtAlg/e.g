
ReadPackage( "StableCategoriesForCap", "/examples/StCatOfModOverExtAlg/tools.gi" );
LoadPackage( "ModulePresentations" );
LoadPackage( "LinearAlgebra" );

R := KoszulDualRing( HomalgFieldOfRationalsInSingular( )*"x,y,z" );

cat := LeftPresentations( R : FinalizeCategory  := false );

SetIsAbelianCategoryWithEnoughInjectives( cat, true );

AddMonomorphismIntoSomeInjectiveObject( cat, 
    function( obj )
    local ring, dual, nat, dual_obj, proj_cover, dual_proj_cover, obj_to_double_dual_obj;
                                                    
    ring := UnderlyingHomalgRing( obj );
    
    dual := FunctorDualLeft( ring );
    
    nat  := NaturalTransformationFromIdentityToDoubleDualLeft( ring );
    
    dual_obj := ApplyFunctor( dual, Opposite( obj ) );
    
    proj_cover := EpimorphismFromSomeProjectiveObject( dual_obj );
    
    dual_proj_cover := ApplyFunctor( dual, Opposite( proj_cover ) );
    
    obj_to_double_dual_obj := ApplyNaturalTransformation( nat, obj );
    
    return PreCompose( obj_to_double_dual_obj, dual_proj_cover );

end );

AddColift( cat, 

    function( morphism_1, morphism_2 )
    local N, M, A, B, I, B_over_M, zero_mat, A_over_zero, sol, XX;
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
    
       return PresentationMorphism( Range( morphism_1 ), sol[ 1 ], Range( morphism_2 ) );
       
    fi;
    
end );

AddLift( cat, 

   function( morphism_1, morphism_2 )
   local P, N, M, A, B, l, basis_indices, Q, R_B, R_N, L_P, R_M, L_id_s, L_P_mod, 
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
    
    P := UnderlyingMatrix( Source( morphism_1 ) );
    
    N := UnderlyingMatrix( Range(  morphism_1 ) );
    
    M := UnderlyingMatrix( Source( morphism_2 ) );
    
    A := UnderlyingMatrix( morphism_1 );
    
    B := UnderlyingMatrix( morphism_2 );
   
    l := Length( IndeterminatesOfExteriorRing( R ) );
    
    basis_indices := standard_list_of_basis_indices( l-1 );
    
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

    X_ := Sum( List( [ 1..2^l ], i-> ( R * CertainColumns( XX_, [ ( i - 1 )*v + 1 .. i*v ] ) )* ring_element( basis_indices[ i ], R ) ) );

    return PresentationMorphism( Source( morphism_1 ), X_, Source( morphism_2 ) );
    
end );

AddIsProjective( cat, 
    function( obj )
     local cover, lift; 
     
     # If the number of rows of the matrix is zero then the module is free, hence projective.
       
     if NrRows( UnderlyingMatrix( obj ) ) = 0 then 
     
       return true;
       
     fi;
     
     cover := EpimorphismFromSomeProjectiveObject( obj );
     
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
    local GR, Fr1, Fr2, Fr3, m12, m32, v, g, f, u, fiber, cover_of_fiber;
    GR := GradedRing( R );
    Fr1 := FreeLeftPresentation( Length(g1), R );
    Fr2 := FreeLeftPresentation( Length(g2), R );
    m12 := RandomMatrixBetweenGradedFreeLeftModules( g1, g2, GR )*R;

    g := List( [ 1 .. Length( g2 ) + 2  ], i -> g2[ ( i mod Length(g2) ) + 1 ] + Random([1..2]) );
    m32 := RandomMatrixBetweenGradedFreeLeftModules( g, g2, GR )*R;

    Fr3 := FreeLeftPresentation( Length(g), R );

    v := PresentationMorphism( Fr1, m12, Fr2 );
    g := PresentationMorphism( Fr3, m32, Fr2 );

    f := ProjectionInFactorOfFiberProduct( [ v, g ], 1 );
    u := ProjectionInFactorOfFiberProduct( [ v, g ], 2 );

    fiber := FiberProduct( v, g );

    cover_of_fiber := EpimorphismFromSomeProjectiveObject( fiber );

    f := PreCompose( cover_of_fiber, f );

    return PresentationMorphism( CokernelObject( f), m12, CokernelObject( g ) );

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

basis_of_external_hom := 
    function( MA, MB )
    local A, B, l, basis_indices, Q, N, sN, r,m,s,n,t,sN_t, basis_sN_t, basis, XX, XX_, X_, i;

    A := UnderlyingMatrix( MA );
    B := UnderlyingMatrix( MB );

    l := Length( IndeterminatesOfExteriorRing( R ) );
    basis_indices := standard_list_of_basis_indices( l-1 );

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

        X_ := Sum( List( [ 1..2^l ], i-> ( R*CertainRows( XX_, [ ( i - 1 )*m + 1 .. i*m ] ) )* ring_element( basis_indices[ i ], R ) ) );

        Add( basis, PresentationMorphism( MA, X_, MB ) );

    od;

return Filtered( basis, b -> not IsZeroForMorphisms(b) );

end;

lifts_in_stable_category := 
    function( alpha_, beta_ )
    local A, B, C, alpha, beta, gamma, I, R, l, basis_indices, Q, L_B, L_id_s, L_B_mod, R_C, R_beta, L_gamma, R_A_2, R_A_3, L_I, alpha_deco, alpha_deco_list,
            alpha_deco_list_vec, alpha_vec, R_1, R_2, R_3, C_x, C_y, C_z, C_u, C_w, C_1, sol, s, v, XX, XX_, X_, main_matrix, constants_matrix;
    A := UnderlyingMatrix( Range( alpha_ ) );
    B := UnderlyingMatrix( Source( alpha_ ) );
    C := UnderlyingMatrix( Source( beta_ ) );
    
    alpha := UnderlyingMatrix( alpha_ );
    beta := UnderlyingMatrix( beta_ );
    gamma := UnderlyingMatrix( MonomorphismIntoSomeInjectiveObject( Source( alpha_ ) ) );
    
    I := UnderlyingMatrix( Range( MonomorphismIntoSomeInjectiveObject( Source( alpha_ ) ) ) );
    
    # We need X,Y,Z,U,W such that
    # B*X                         + W*C  = 0
    # X*beta + gamma*Y       + U*A      = alpha
    #              I*Y + Z*A            = 0

    R := HomalgRing( A );
    
    l := Length( IndeterminatesOfExteriorRing( R ) );

    basis_indices := standard_list_of_basis_indices( l-1 );
    
    Q := CoefficientsRing( R );
    
    L_B := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( C ), Q ), Q*FLeft( u, B ) ) ), UnionOfRows );
    L_id_s := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrRows( beta ), Q ), Q*FLeft( u, HomalgIdentityMatrix( NrRows( alpha ), R ) ) ) ), UnionOfRows );
    L_B_mod :=  L_B* Involution( L_id_s );
    
    R_C := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, C ) ), HomalgIdentityMatrix( NrRows( B ), Q ) ) ), UnionOfRows );
    R_beta := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, beta ) ), HomalgIdentityMatrix( NrRows( alpha ), Q ) ) ), UnionOfRows );
    L_gamma := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( alpha ), Q ), Q*FLeft( u, gamma ) ) ), UnionOfRows );
    R_A_2 := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, A ) ), HomalgIdentityMatrix( NrRows( alpha ), Q ) ) ), UnionOfRows ); 
    R_A_3 := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, A ) ), HomalgIdentityMatrix( NrRows( I ), Q ) ) ), UnionOfRows ); 
    L_I := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( A ), Q ), Q*FLeft( u, I ) ) ), UnionOfRows );
    
    alpha_deco := DecompositionOfHomalgMat( alpha );
   
    alpha_deco_list := List( alpha_deco, i-> i[ 2 ] );

    alpha_deco_list_vec := List( alpha_deco_list, mat -> UnionOfRows( List( [ 1..NrColumns( alpha ) ], i-> CertainColumns( mat, [ i ] ) ) ) );

    alpha_vec := Q*UnionOfRows( alpha_deco_list_vec );
    
    R_1 := VectorSpaceObject( NrRows( L_B_mod ), Q );
    R_2 := VectorSpaceObject( NrRows( R_beta ), Q );
    R_3 := VectorSpaceObject( NrRows( L_I ), Q );
    
    C_x := VectorSpaceObject( NrColumns( L_B_mod ), Q );
    C_y := VectorSpaceObject( NrColumns( L_gamma ), Q );
    C_z := VectorSpaceObject( NrColumns( R_A_3 ), Q );
    C_u := VectorSpaceObject( NrColumns( R_A_2 ), Q );
    C_w := VectorSpaceObject( NrColumns( R_C ), Q );
    C_1 := VectorSpaceObject( 1, Q );
    
    # main matrix is 
    # L_B_mod* vec(X)                                                   + R_C*vec(W)   = 0
    # R_beta * vec(X) + L_gamma * vec(Y)                + R_A_2*vec(U)                 = vec( alpha )
    #                       L_I * vec(Y) + R_A_3*vec(Z)                                = 0

    main_matrix := UnderlyingMatrix( MorphismBetweenDirectSums(
    [ [ VectorSpaceMorphism(R_1,L_B_mod,C_x), ZeroMorphism(R_1,C_y), ZeroMorphism(R_1,C_z), ZeroMorphism(R_1,C_u), VectorSpaceMorphism(R_1,R_C,C_w ) ],
    [ VectorSpaceMorphism(R_2,R_beta,C_x) , VectorSpaceMorphism(R_2,L_gamma,C_y), ZeroMorphism(R_2,C_z), VectorSpaceMorphism(R_2,R_A_2,C_u), ZeroMorphism(R_2,C_w) ],
    [ ZeroMorphism(R_3,C_x) , VectorSpaceMorphism(R_3,L_I,C_y), VectorSpaceMorphism(R_3,R_A_3,C_z), ZeroMorphism(R_3,C_u), ZeroMorphism(R_3,C_w) ] ] ) );
        
    
    constants_matrix := UnderlyingMatrix( MorphismBetweenDirectSums( [ [ ZeroMorphism( R_1, C_1 ) ], [ VectorSpaceMorphism( R_2, alpha_vec, C_1 ) ], [ ZeroMorphism( R_3,C_1) ] ] ) );
    
    sol := LeftDivide( main_matrix, constants_matrix );
    
    if sol = fail then 
      
      return fail;
     
    fi;
    
    s := NrColumns( B );
    
    v := NrColumns( C );
    
    XX := CertainRows( sol, [ 1 .. s*v*2^l ] );
    
    XX_ := UnionOfColumns( List( [ 1 .. v*2^l ], i -> CertainRows( XX, [ ( i - 1 )*s + 1 .. i*s ] ) ) );

    X_ := Sum( List( [ 1..2^l ], i-> ( R * CertainColumns( XX_, [ ( i - 1 )*v + 1 .. i*v ] ) )* ring_element( basis_indices[ i ], R ) ) );

    return PresentationMorphism( Source( alpha_ ), X_, Source( beta_ ) );
end;

colifts_in_stable_category := 
    function( alpha_, beta_ )
    local A, B, C, alpha, beta, gamma, I, R, sol, mat1, mat2;

    A := UnderlyingMatrix( Source( alpha_ ) );
    B := UnderlyingMatrix( Range( alpha_ ) );
    C := UnderlyingMatrix( Range( beta_ ) );

    alpha := UnderlyingMatrix( alpha_ );
    beta := UnderlyingMatrix( beta_ );
    gamma := UnderlyingMatrix( MonomorphismIntoSomeInjectiveObject( Source( alpha_ ) ) );
    I := UnderlyingMatrix( Range( MonomorphismIntoSomeInjectiveObject( Source( alpha_ ) ) ) );
    R := HomalgRing( A );

    mat1 := Iterated( 
            [
                UnionOfColumns( B, HomalgZeroMatrix( NrRows(B), NrColumns(gamma), R ) ),
                UnionOfColumns( alpha, gamma ),
                UnionOfColumns( HomalgZeroMatrix( NrRows(I), NrColumns(alpha), R), I )
            ], UnionOfRows );

    mat2 := Iterated(
            [
                HomalgZeroMatrix( NrRows( B ), NrColumns( C ), R ),
                beta,
                HomalgZeroMatrix( NrRows( I), NrColumns( C ), R )
            ], UnionOfRows );
    
    sol := SolveTwoSidedEquationOverExteriorAlgebra( mat1, C, mat2 );

    if sol = fail then
        return fail;
    else
        return PresentationMorphism( Range( alpha_ ), CertainRows( sol[1], [ 1..NrColumns( B ) ] ), Range( beta_ ) );
    fi;
end;

f := create_random_morphism( [ 1, 2 ],[ 1, 0 ] );
i := MonomorphismIntoSomeInjectiveObject( Source( f ) );

# The following morphism factors through the range of i which is free,
# let us test that.
mor := PreCompose( f, InjectionOfCofactorOfPushout( [ f, i ], 1 ) );
can_be_factored_through_free_module(mor);
