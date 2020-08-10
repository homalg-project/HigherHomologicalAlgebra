
ReadPackage( "StableCategoriesForCap", "/examples/StCatOfModOverExtAlg/ADD_METHODS_TO_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA.g" );


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

colift_lift_in_stable_category :=
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
    
    R_1 := VectorSpaceObject( NrRows( L_A_mod ), Q );
    R_2 := VectorSpaceObject( NrRows( L_alpha_mod ), Q );
    R_3 := VectorSpaceObject( NrRows( R_delta ), Q );
    
    C_x := VectorSpaceObject( NrColumns( L_A_mod ), Q );
    C_y := VectorSpaceObject( NrColumns( L_lambda ), Q );
    C_z := VectorSpaceObject( NrColumns( R_B_2 ), Q );
    C_v := VectorSpaceObject( NrColumns( R_B_1 ), Q );
    C_g := VectorSpaceObject( NrColumns( L_tau ), Q );
    C_h := VectorSpaceObject( NrColumns( R_D ), Q );
    C_1 := VectorSpaceObject( 1, Q );

    main_matrix := UnderlyingMatrix( MorphismBetweenDirectSums(
    [ 
        [ VectorSpaceMorphism(R_1,L_A_mod,C_x), ZeroMorphism(R_1,C_y), ZeroMorphism(R_1,C_z), 
            VectorSpaceMorphism(R_1,R_B_1,C_v ), ZeroMorphism(R_1,C_g), ZeroMorphism(R_1,C_h) ],
        [ VectorSpaceMorphism(R_2,L_alpha_mod,C_x), VectorSpaceMorphism(R_2,L_lambda,C_y), VectorSpaceMorphism(R_2,R_B_2,C_z), 
            ZeroMorphism(R_2,C_v), ZeroMorphism(R_2,C_g), ZeroMorphism(R_2,C_h) ],
        [ VectorSpaceMorphism(R_3,R_delta,C_x), ZeroMorphism(R_3,C_y), ZeroMorphism(R_3,C_z),
            ZeroMorphism(R_3,C_v), VectorSpaceMorphism(R_3,L_tau,C_g), VectorSpaceMorphism(R_3,R_D,C_h) 
        ]
        
    ] ) );

    if IsZero( beta ) then
        beta_vec := UnderlyingMatrix( ZeroMorphism( R_2, C_1 ) );
    else
        beta_deco := DecompositionOfHomalgMat( beta );
    
        beta_deco := List( beta_deco, i-> i[ 2 ] );

        beta_deco := List( beta_deco, mat -> Iterated( List( [ 1..NrColumns( beta ) ], i-> CertainColumns( mat, [ i ] ) ), UnionOfRows ) );

        beta_vec := Q*Iterated( beta_deco, UnionOfRows );
    fi;

    if IsZero( gamma ) then 
        gamma_vec := UnderlyingMatrix( ZeroMorphism( R_3, C_1) );
    else

        gamma_deco := DecompositionOfHomalgMat( gamma );
   
        gamma_deco := List( gamma_deco, i-> i[ 2 ] );

        gamma_deco := List( gamma_deco, mat -> Iterated( List( [ 1..NrColumns( gamma ) ], i-> CertainColumns( mat, [ i ] ) ), UnionOfRows ) );

        gamma_vec := Q*Iterated( gamma_deco, UnionOfRows );
    fi;

    constants_matrix := UnderlyingMatrix( MorphismBetweenDirectSums(
        [
            [ZeroMorphism(R_1, C_1) ],
            [ VectorSpaceMorphism( R_2, beta_vec, C_1 ) ],
            [ VectorSpaceMorphism( R_3, gamma_vec, C_1 ) ],
        ] ) );
    
    sol := LeftDivide( main_matrix, constants_matrix );
    
    if sol = fail then 
      
      return fail;
     
    fi;
    
    s := NrColumns( A );
    
    v := NrColumns( B );
    
    XX := CertainRows( sol, [ 1 .. s*v*2^l ] );
    
    XX := UnionOfColumns( List( [ 1 .. v*2^l ], i -> CertainRows( XX, [ ( i - 1 )*s + 1 .. i*s ] ) ) );

    XX := Sum( List( [ 1..2^l ], i-> ( R * CertainColumns( XX, [ ( i - 1 )*v + 1 .. i*v ] ) )* ring_element( basis_indices[ i ], R ) ) );

    return PresentationMorphism( Range( alpha_ ), DecideZeroRows( XX, B ), Range( beta_ ) );
end;
    
all_colift_lift_in_stable_category :=
    function(alpha_, beta_, gamma_, delta_ )
    local A, B, C, D, alpha, beta, gamma, delta, lambda, I, tau, J, R, l, basis_indices, Q, L_A, L_id_s, L_A_mod, R_C, L_alpha_mod, L_alpha, L_lambda,  
    R_B_2, R_B_1, R_D, R_delta, L_tau, beta_deco, beta_vec, gamma_deco, gamma_vec, R_1, R_2, R_3, C_x, C_y, C_z, C_v, C_g, C_h, C_1, 
    sol, s, v, XX, main_matrix, constants_matrix, i, a, K, sy_main_matrix;

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
    #  X    * deltaY                                  tau * G + H * D   = gamma

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
    
    R_1 := VectorSpaceObject( NrRows( L_A_mod ), Q );
    R_2 := VectorSpaceObject( NrRows( L_alpha_mod ), Q );
    R_3 := VectorSpaceObject( NrRows( R_delta ), Q );
    
    C_x := VectorSpaceObject( NrColumns( L_A_mod ), Q );
    C_y := VectorSpaceObject( NrColumns( L_lambda ), Q );
    C_z := VectorSpaceObject( NrColumns( R_B_2 ), Q );
    C_v := VectorSpaceObject( NrColumns( R_B_1 ), Q );
    C_g := VectorSpaceObject( NrColumns( L_tau ), Q );
    C_h := VectorSpaceObject( NrColumns( R_D ), Q );
    C_1 := VectorSpaceObject( 1, Q );

    main_matrix := UnderlyingMatrix( MorphismBetweenDirectSums(
    [ 
        [ VectorSpaceMorphism(R_1,L_A_mod,C_x), ZeroMorphism(R_1,C_y), ZeroMorphism(R_1,C_z), 
            VectorSpaceMorphism(R_1,R_B_1,C_v ), ZeroMorphism(R_1,C_g), ZeroMorphism(R_1,C_h) ],
        [ VectorSpaceMorphism(R_2,L_alpha_mod,C_x), VectorSpaceMorphism(R_2,L_lambda,C_y), VectorSpaceMorphism(R_2,R_B_2,C_z), 
            ZeroMorphism(R_2,C_v), ZeroMorphism(R_2,C_g), ZeroMorphism(R_2,C_h) ],
        [ VectorSpaceMorphism(R_3,R_delta,C_x), ZeroMorphism(R_3,C_y), ZeroMorphism(R_3,C_z),
            ZeroMorphism(R_3,C_v), VectorSpaceMorphism(R_3,L_tau,C_g), VectorSpaceMorphism(R_3,R_D,C_h) 
        ]
        
    ] ) );

    if IsZero( beta ) then
        beta_vec := UnderlyingMatrix( ZeroMorphism( R_2, C_1 ) );
    else
        beta_deco := DecompositionOfHomalgMat( beta );
    
        beta_deco := List( beta_deco, i-> i[ 2 ] );

        beta_deco := List( beta_deco, mat -> Iterated( List( [ 1..NrColumns( beta ) ], i-> CertainColumns( mat, [ i ] ) ), UnionOfRows ) );

        beta_vec := Q*Iterated( beta_deco, UnionOfRows );
    fi;

    if IsZero( gamma ) then 
        gamma_vec := UnderlyingMatrix( ZeroMorphism( R_3, C_1) );
    else

        gamma_deco := DecompositionOfHomalgMat( gamma );
   
        gamma_deco := List( gamma_deco, i-> i[ 2 ] );

        gamma_deco := List( gamma_deco, mat -> Iterated( List( [ 1..NrColumns( gamma ) ], i-> CertainColumns( mat, [ i ] ) ), UnionOfRows ) );

        gamma_vec := Q*Iterated( gamma_deco, UnionOfRows );
    fi;

    constants_matrix := UnderlyingMatrix( MorphismBetweenDirectSums(
        [
            [ZeroMorphism(R_1, C_1) ],
            [ VectorSpaceMorphism( R_2, beta_vec, C_1 ) ],
            [ VectorSpaceMorphism( R_3, gamma_vec, C_1 ) ],
        ] ) );
    
    sol := LeftDivide( main_matrix, constants_matrix );
    
    if sol = fail then 
      
      return fail;
     
    fi;
    
    s := NrColumns( A );
    
    v := NrColumns( B );
    
    XX := CertainRows( sol, [ 1 .. s*v*2^l ] );
    
    XX := UnionOfColumns( List( [ 1 .. v*2^l ], i -> CertainRows( XX, [ ( i - 1 )*s + 1 .. i*s ] ) ) );

    XX := Sum( List( [ 1..2^l ], i-> ( R * CertainColumns( XX, [ ( i - 1 )*v + 1 .. i*v ] ) )* ring_element( basis_indices[ i ], R ) ) );

    K := [ ];

    sy_main_matrix := BasisOfColumns( CertainRows( SyzygiesOfColumns( main_matrix ), [ 1 .. s*v*2^l ] ) );

    for i in [ 1 .. NrColumns( sy_main_matrix ) ] do 

        a := CertainColumns( sy_main_matrix, [ i ] );
    
        a := UnionOfColumns( List( [ 1 .. v*2^l ], i -> CertainRows( a, [ ( i - 1 )*s + 1 .. i*s ] ) ) );

        a := Sum( List( [ 1..2^l ], i-> ( R * CertainColumns( a, [ ( i - 1 )*v + 1 .. i*v ] ) )* ring_element( basis_indices[ i ], R ) ) );
    
        a := PresentationMorphism( Range( alpha_ ), DecideZeroRows( a, B ), Range( beta_ ) );

        if not IsZeroForMorphisms( a ) then 
            Add( K, a );
        fi;
    od;

    return [ PresentationMorphism( Range( alpha_ ), DecideZeroRows( XX, B ), Range( beta_ ) ), K ];
end;
    
lift_for_stable_category := 
    function( alpha, beta )
    return colift_lift_in_stable_category( 
        UniversalMorphismFromZeroObject( Source( alpha ) ),
        UniversalMorphismFromZeroObject( Source( beta ) ),
        alpha,
        beta 
    );
end;

colift_for_stable_category := 
    function( alpha, beta )
    return colift_lift_in_stable_category( 
        alpha,
        beta,
        UniversalMorphismIntoZeroObject( Range( alpha ) ),
        UniversalMorphismIntoZeroObject( Range( beta ) ) 
    );
end;

is_split_mono_for_stable_category := 
    function( mor )
    local l;
    l := colift_for_stable_category( mor, IdentityMorphism( Source( mor ) ) );

    if l = fail then 
        return false;
    else 
        return true;
    fi;

end;

is_split_epi_for_stable_category := 
    function( mor )
    local l;
    l := lift_for_stable_category( IdentityMorphism( Range( mor ) ), mor );

    if l = fail then 
        return false;
    else 
        return true;
    fi;

end;

is_isomorphism_for_stable_category := 
    function( mor )
    return is_split_epi_for_stable_category( mor ) and is_split_mono_for_stable_category( mor );
end;
