
LoadPackage( "FrobeniusCategoriesForCAP" );
LoadPackage( "GradedModulePresentations" );
ReadPackage( "FrobeniusCategoriesForCAP", "/examples/glp_over_g_exterior_algebra/tools.g" );

BindGlobal( "ADD_METHODS_TO_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA", 

function( cat )
local R, r;

R := cat!.ring_for_representation_category;

r := UnderlyingNonGradedRing( R );

if HasIsFinalized( cat ) then
    Error( "The category should be not-finalized to be able to add methods" );
fi;

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
    
end, 500 );

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
    
    basis_indices := standard_list_of_basis_indices( l-1 );
    
    Q := CoefficientsRing( R ); 

     if IsZero( P ) then
        sol := RightDivide( A, UnionOfRows(B,N) );
        if sol = fail then 
            return fail;
        else
            return GradedPresentationMorphism( Source( morphism1 ), DecideZeroRows( CertainColumns( sol, [1..NrRows(B) ] ), M ), Source( morphism2 ) );
        fi;
    fi;

    R_B := UnionOfRows( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, B ) ), HomalgIdentityMatrix( NrRows( A ), Q ) ) ) );

    if not IsZero( N ) then 
        R_N := UnionOfRows( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, N ) ), HomalgIdentityMatrix( NrRows( A ), Q ) ) ) );    
    fi;

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
        
    if not IsZero( N ) then
    
        mat1 := UnionOfColumns( [ R_B, R_N, HomalgZeroMatrix( NrRows( A )*NrColumns( A )*2^l, NrRows( M )*NrRows( P )*2^l, Q ) ] );
    
        mat2 := UnionOfColumns( [ L_P_mod, HomalgZeroMatrix( NrRows( P )*NrColumns( M )*2^l, NrRows( N )*NrColumns( P )*2^l, Q ), R_M ] );
    
    else
        
        mat1 := UnionOfColumns( R_B, HomalgZeroMatrix( NrRows( A )*NrColumns( A )*2^l, NrRows( M )*NrRows( P )*2^l, Q ) );
    
        mat2 := UnionOfColumns( L_P_mod, R_M );
    
    fi;

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

    return GradedPresentationMorphism( Source( morphism1 ), DecideZeroRows( X_, M ), Source( morphism2 ) );
    
end, 100 );

AddIsSplitMonomorphism( cat, 
    function( mor )
    local l;
    l := Colift( mor, IdentityMorphism( Source( mor ) ) );

    if l = fail then 
        return false;
    else 
        return true;
    fi;

end );

AddIsSplitEpimorphism( cat, 
    function( mor )
    local l;
    l := Lift( IdentityMorphism( Range( mor ) ), mor );

    if l = fail then 
        return false;
    else 
        return true;
    fi;

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

AddCanBeFactoredThroughExactProjective( cat,  
    function( mor )
    local m;
    m := Colift( MonomorphismIntoSomeInjectiveObject( Source( mor ) ), mor );
    if m = fail then
        return false;
    else
        return true;
    fi;
end );

AddCanBeFactoredThroughExactInjective( cat,  
    function( mor )
    local m;
    m := Colift( MonomorphismIntoSomeInjectiveObject( Source( mor ) ), mor );
    if m = fail then
        return false;
    else
        return true;
    fi;
end );

AddFactorizationThroughExactInjective( cat, 
    function( mor )
    local m;
    m := Colift( MonomorphismIntoSomeInjectiveObject( Source( mor ) ), mor );
    if m = fail then
        return fail;
    else
        return [ MonomorphismIntoSomeInjectiveObject( Source( mor ) ), m ];
    fi;
end );

AddFactorizationThroughExactProjective( cat, 
    function( mor )
    local m;
    m := Colift( MonomorphismIntoSomeInjectiveObject( Source( mor ) ), mor );
    if m = fail then
        return fail;
    else
        return [ MonomorphismIntoSomeInjectiveObject( Source( mor ) ), m ];
    fi;
end );

return cat;

end );

create_random_morphism := 
    function( g1, g2, R )
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

compute_degree_zero_part := 
    function( M, N, f )
    local mat, required_degrees;
    mat := UnderlyingMatrix( f );
    required_degrees := List( GeneratorDegrees( M ), i -> 
                                    List( GeneratorDegrees( N ), j -> i - j ) );
    mat := ReductionOfHomalgMatrix( mat, required_degrees );
    return GradedPresentationMorphism(M,mat,N);
end;

nongraded_basis_of_external_hom := 
    function( GM, GN )
    local A, B, l, basis_indices, Q, M, N, N_, sN_, r,m,s,n,t,sN_t, basis_sN_t, basis, XX, XX_, X_, i, R;

    R := UnderlyingHomalgRing( GM );
    M := UnderlyingMatrix( GM );
    N := UnderlyingMatrix( GN );

    l := Length( IndeterminatesOfExteriorRing( R ) );
    basis_indices := standard_list_of_basis_indices( l-1 );

    Q := CoefficientsRing( R ); 

    N_ := Q*FF3( M, N );

    sN_ := SyzygiesOfColumns( N_ );

    r := NrRows( M );
    m := NrColumns( M );
    s := NrColumns( N );
    n := NrRows( N );

    t := m*s*2^l;

    sN_t := CertainRows( sN_, [ 1..t ] );
    
    basis_sN_t := BasisOfColumns( sN_t );
    
    basis := [ ];

    for i in [ 1 .. NrColumns( basis_sN_t ) ] do 
        
        XX := CertainColumns( basis_sN_t, [ i ] );

        XX_ := Iterated( List( [ 1 .. s ], i -> CertainRows( XX, [ ( i - 1 )*m*2^l + 1 .. i*m*2^l ] ) ), UnionOfColumns )*R;

        X_ := Sum( List( [ 1..2^l ], i-> ( CertainRows( XX_, [ ( i - 1 )*m + 1 .. i*m ] ) )* ring_element( basis_indices[ i ], R ) ) );

        Add( basis, PresentationMorphism( AsLeftPresentation(M), DecideZeroRows(X_,N), AsLeftPresentation(N) ) );

    od;

return DuplicateFreeList( Filtered( basis, b -> not IsZeroForMorphisms(b) ) );

end;

graded_basis_of_external_hom := 
    function( MA, MB )
    local A, B, l, basis_indices, Q, N, sN, r,m,s,n,t,sN_t, basis_sN_t, basis, XX, XX_, X_, i, R;
    R := UnderlyingHomalgRing( MA );
    A := UnderlyingMatrix( UnderlyingPresentationObject( MA ) );
    B := UnderlyingMatrix( UnderlyingPresentationObject( MB ) );

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

        Add( basis, GradedPresentationMorphism( MA, DecideZeroRows( X_, B ), MB ) );

    od;
    
    basis := List( basis, b -> compute_degree_zero_part( MA, MB, b ) );

return DuplicateFreeList( Filtered( basis, b -> not IsZeroForMorphisms(b) ) );

end;

graded_compute_coefficients := function( b, f )
    local R, l, basis_indices, Q, A, B, C, vec, main_list, matrix, constant, M, N, sol;
    
    M := Source( f );
    N := Range( f );

    if not IsWellDefined( f ) then
        return fail;
    fi;
    
    R := UnderlyingHomalgRing( M );
    l := Length( IndeterminatesOfExteriorRing( R ) );
    basis_indices := standard_list_of_basis_indices( l-1 );
    Q := CoefficientsRing( R ); 
    
    A := List( b, UnderlyingMatrix );
    B := UnderlyingMatrix( N );
    C := UnderlyingMatrix( f );

    vec := function( H ) return Iterated( List( [ 1 .. NrColumns( H ) ], i -> CertainColumns( H, [ i ] ) ), UnionOfRows ); end;

    main_list := 
        List( [ 1 .. Length( basis_indices) ], 
        function( i ) 
        local current_A, current_B, current_C, main;
        current_A := List( A, a -> HomalgTransposedMat( DecompositionOfHomalgMat(a)[i][2]*Q ) );
        current_B := HomalgTransposedMat( FRight( basis_indices[i], B )*Q );
        current_C := HomalgTransposedMat( DecompositionOfHomalgMat(C)[i][2]*Q );
        main := UnionOfColumns( Iterated( List( current_A, vec ), UnionOfColumns ), KroneckerMat( HomalgIdentityMatrix( NrColumns( current_C ), Q ), current_B ) ); 
        return [ main, vec( current_C) ];
        end );

    matrix :=   Iterated( List( main_list, m -> m[ 1 ] ), UnionOfRows );
    constant := Iterated( List( main_list, m -> m[ 2 ] ), UnionOfRows );
    sol := LeftDivide( matrix, constant);
    if sol = fail then 
        return fail;
    else
        return EntriesOfHomalgMatrix( CertainRows( sol, [ 1..Length( b ) ] ) );
    fi;
end;

is_reduced_graded_module := 
    function( GM )
    local R, F, b, f, l,p;
    R := UnderlyingHomalgRing( GM );
    F := FreeLeftPresentation( 1, R );
    b := nongraded_basis_of_external_hom(GM, F );
    if not ForAny( b, IsEpimorphism ) then 
        return true;
    else
        f := b[ PositionProperty(b, IsEpimorphism ) ];
        l := EntriesOfHomalgMatrix( UnderlyingMatrix( f ) );
        p := PositionProperty( l, e -> Inverse( e ) <> fail );
        F := GradedFreeLeftPresentation( 1, R, [ GeneratorDegrees( GM )[ p ] ] );
        return [ false, Lift( IdentityMorphism( F ), compute_degree_zero_part( GM, F, f ) ) ];
    fi;
end;

graded_colift_lift_in_stable_category :=
    function(alpha_, beta_, gamma_, delta_ )
    local A, B, C, D, alpha, beta, gamma, delta, lambda, I, tau, J, R, l, basis_indices, Q, L_A, L_id_s, L_A_mod, R_C, L_alpha_mod, L_alpha, L_lambda,  
    R_B_2, R_B_1, R_D, R_delta, L_tau, beta_deco, beta_vec, gamma_deco, gamma_vec, R_1, R_2, R_3, C_x, C_y, C_z, C_v, C_g, C_h, C_1, 
    sol, s, v, XX, main_matrix, constants_matrix;
    alpha := UnderlyingMatrix( alpha_);
    beta := UnderlyingMatrix( beta_ );
    gamma := UnderlyingMatrix( gamma_ );
    delta := UnderlyingMatrix( delta_ );
    A := UnderlyingMatrix(   Source( gamma_ ) );
    B := UnderlyingMatrix(  Source( delta_ ) );
    C := UnderlyingMatrix(  Source( alpha_ ) );
    D := UnderlyingMatrix(  Range( gamma_ ) );
    lambda := UnderlyingMatrix(  MonomorphismIntoSomeInjectiveObject( Source( alpha_ ) ) );
    I := UnderlyingMatrix( Range( MonomorphismIntoSomeInjectiveObject(Source(alpha_))));
    tau := UnderlyingMatrix( MonomorphismIntoSomeInjectiveObject( Source( gamma_)));
    J := UnderlyingMatrix( Range( MonomorphismIntoSomeInjectiveObject( Source( gamma_))));

    # We need X,Y,Z,V,G, H such that
    #
    # A     * X                             + V*B                       = 0
    # alpha * X      + lambda * Y + Z * B                               = beta
    #  X    * delta                                   tau * G + H * D   = gamma

    R := HomalgRing( A );
    
    l := Length( IndeterminatesOfExteriorRing( R ) );

    basis_indices := standard_list_of_basis_indices( l-1 );
    
    Q := CoefficientsRing( R );
    
    # X
    L_id_s := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrRows( delta ), Q ), Q*FLeft( u, HomalgIdentityMatrix( NrRows( tau ), R ) ) ) ), UnionOfRows );
    L_A := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( B ), Q ), Q*FLeft( u, A ) ) ), UnionOfRows );
    L_A_mod :=  L_A* Involution( L_id_s );
    L_alpha := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( B ), Q ), Q*FLeft( u, alpha ) ) ), UnionOfRows );
    L_alpha_mod :=  L_alpha* Involution( L_id_s );
    R_delta := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, delta ) ), HomalgIdentityMatrix( NrRows( tau ), Q ) ) ), UnionOfRows );
    
    # Y
    L_lambda := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( B ), Q ), Q*FLeft( u, lambda ) ) ), UnionOfRows );
    
    # Z
    R_B_2 := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, B ) ), HomalgIdentityMatrix( NrRows( alpha ), Q ) ) ), UnionOfRows );
    
    # V
    R_B_1 := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, B ) ), HomalgIdentityMatrix( NrRows( A ), Q ) ) ), UnionOfRows );
    
    # G
    L_tau := Iterated( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( D ), Q ), Q*FLeft( u, tau ) ) ), UnionOfRows );

    # H
    R_D := Iterated( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, D ) ), HomalgIdentityMatrix( NrRows( tau ), Q ) ) ), UnionOfRows );
    
    R_1 := NrRows( L_A_mod );
    R_2 := NrRows( L_alpha_mod );
    R_3 := NrRows( R_delta );
    
    C_x := NrColumns( L_A_mod );
    C_y := NrColumns( L_lambda );
    C_z := NrColumns( R_B_2 );
    C_v := NrColumns( R_B_1 );
    C_g := NrColumns( L_tau );
    C_h := NrColumns( R_D );
    C_1 := 1;

    main_matrix := Iterated( 
    [ 
        Iterated( [ L_A_mod, HomalgZeroMatrix(R_1,C_y, Q), HomalgZeroMatrix(R_1,C_z, Q), R_B_1, HomalgZeroMatrix(R_1,C_g, Q), HomalgZeroMatrix(R_1,C_h, Q) ], UnionOfColumns ),
        Iterated( [ L_alpha_mod, L_lambda,R_B_2, HomalgZeroMatrix(R_2,C_v, Q), HomalgZeroMatrix(R_2,C_g, Q), HomalgZeroMatrix(R_2,C_h, Q) ], UnionOfColumns ),
        Iterated( [ R_delta, HomalgZeroMatrix(R_3,C_y, Q), HomalgZeroMatrix(R_3,C_z, Q), HomalgZeroMatrix(R_3,C_v, Q), L_tau, R_D ], UnionOfColumns )
    ], UnionOfRows );

    if IsZero( beta ) then
        beta_vec := HomalgZeroMatrix( R_2, C_1, Q );
    else
        beta_deco := DecompositionOfHomalgMat( beta );
    
        beta_deco := List( beta_deco, i-> i[ 2 ] );

        beta_deco := List( beta_deco, mat -> Iterated( List( [ 1..NrColumns( beta ) ], i-> CertainColumns( mat, [ i ] ) ), UnionOfRows ) );

        beta_vec := Q*Iterated( beta_deco, UnionOfRows );
    fi;

    if IsZero( gamma ) then 
        gamma_vec := HomalgZeroMatrix( R_3, C_1, Q );
    else

        gamma_deco := DecompositionOfHomalgMat( gamma );
   
        gamma_deco := List( gamma_deco, i-> i[ 2 ] );

        gamma_deco := List( gamma_deco, mat -> Iterated( List( [ 1..NrColumns( gamma ) ], i-> CertainColumns( mat, [ i ] ) ), UnionOfRows ) );

        gamma_vec := Q*Iterated( gamma_deco, UnionOfRows );
    fi;

    constants_matrix :=  Iterated( [ HomalgZeroMatrix(R_1, C_1, Q ), beta_vec, gamma_vec ], UnionOfRows );
    
    sol := LeftDivide( main_matrix, constants_matrix );
    
    if sol = fail then 
      
      return fail;
     
    fi;
    
    s := NrColumns( A );
    
    v := NrColumns( B );
    
    XX := CertainRows( sol, [ 1 .. s*v*2^l ] );
    
    XX := UnionOfColumns( List( [ 1 .. v*2^l ], i -> CertainRows( XX, [ ( i - 1 )*s + 1 .. i*s ] ) ) );

    XX := Sum( List( [ 1..2^l ], i-> ( R * CertainColumns( XX, [ ( i - 1 )*v + 1 .. i*v ] ) )* ring_element( basis_indices[ i ], R ) ) );

    return GradedPresentationMorphism( Range( alpha_ ), DecideZeroRows( XX, B ), Range( beta_ ) );
end;

graded_lift_for_stable_category := 
    function( alpha, beta )
    return graded_colift_lift_in_stable_category( 
        UniversalMorphismFromZeroObject( Source( alpha ) ),
        UniversalMorphismFromZeroObject( Source( beta ) ),
        alpha,
        beta 
    );
end;

graded_colift_for_stable_category := 
    function( alpha, beta )
    return graded_colift_lift_in_stable_category( 
        alpha,
        beta,
        UniversalMorphismIntoZeroObject( Range( alpha ) ),
        UniversalMorphismIntoZeroObject( Range( beta ) ) 
    );
end;

is_split_graded_mono_for_stable_category := 
    function( mor )
    local l;
    l := graded_colift_for_stable_category( mor, IdentityMorphism( Source( mor ) ) );

    if l = fail then 
        return false;
    else 
        return true;
    fi;

end;

is_split_graded_epi_for_stable_category := 
    function( mor )
    local l;
    l := graded_lift_for_stable_category( IdentityMorphism( Range( mor ) ), mor );

    if l = fail then 
        return false;
    else 
        return true;
    fi;

end;

is_isomorphism_for_stable_category := 
    function( mor )
    return is_split_graded_epi_for_stable_category( mor ) and is_split_graded_mono_for_stable_category( mor );
end;

graded_inverse_in_stable_category := 
    function( mor )
    # check if mor is really iso
    return graded_lift_for_stable_category( IdentityMorphism( Range( mor ) ), mor );
end;

r := KoszulDualRing( HomalgFieldOfRationalsInSingular( )*"x,y,z,t" );
R := GradedRing( r );
SetWeightsOfIndeterminates( R, [ 1,1,1,0] );
cat := GradedLeftPresentations( R: FinalizeCategory := false );
ADD_METHODS_TO_GRADED_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( cat );
TurnAbelianCategoryToExactCategory( cat );
SetIsFrobeniusCategory( cat, true );
Finalize( cat );

# gap> Display( Source(f) );
# 0,           0,   0,        0,   0,     
# 0,           7*e1,0,        0,   0,     
# 0,           0,   0,        2*e1,0,     
# e1,          0,   e1,       2,   0,     
# 20*e0-151*e1,20,  15*e1,    -154,0,     
# 7*e1,        0,   2*e0-3*e1,10,  0,     
# -81*e1,      20,  25*e1,    -114,0,     
# 29*e1,       -20, -5*e1,    26,  0,     
# -7*e1,       0,   -5*e1,    2,   4*e0*e1
# (over a graded ring)

# An object in The category of graded left f.p. modules over Q{e0,e1} (with weights [ 1, 1 ])

# (graded, degrees of generators:[ 2, 3, 2, 3, 1 ])
# gap> Display( Range(f) );
# -e0*e1,    -2*e0-e1,2*e0-2*e1,0,     
# 0,         3*e0*e1, 4*e0*e1,  0,     
# -2*e0+2*e1,0,       -1,       -e0+e1,
# -e0,       2,       -1,       e1,    
# 0,         2*e0*e1, -2*e0*e1, 0,     
# 0,         e0*e1,   2*e0*e1,  0      
# (over a graded ring)

# An object in The category of graded left f.p. modules over Q{e0,e1} (with weights [ 1, 1 ])

# (graded, degrees of generators:[ 1, 2, 2, 1 ])
# gap> is_reduced_graded_module(Source(f));
# [ false, <A morphism in The category of graded left f.p. modules over Q{e0,e1} (with weights [ 1, 1 ])> ]
# gap> is_reduced_graded_module(Range(f));
# [ false, <A morphism in The category of graded left f.p. modules over Q{e0,e1} (with weights [ 1, 1 ])> ]
# gap> 
