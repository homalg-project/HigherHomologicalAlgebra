LoadPackage( "RingsForHomalg" );
LoadPackage( "GradedModulePresentations" );
LoadPackage( "ComplexesForCAP" );
LoadPackage( "BBGG" );

generators_of_hom_for_chains := 
    function( C, D )
    local chains, H, kernel_mor_of_H, kernel_obj_of_H, morphisms_C_to_D, morphisms_from_R_to_kernel, morphisms_from_T_to_H, T;
    chains := CapCategory( C );
    H := InternalHomOnObjects( C, D );
    kernel_mor_of_H := CyclesAt( H, 0 );
    kernel_obj_of_H := Source( kernel_mor_of_H );
    morphisms_from_R_to_kernel := List( [ 1 .. NrColumns( UnderlyingMatrix( kernel_obj_of_H ) ) ], i-> StandardGeneratorMorphism( kernel_obj_of_H, i ) );;
    T := TensorUnit( chains );
    morphisms_from_T_to_H := List( morphisms_from_R_to_kernel, m -> ChainMorphism( T, H, [ PreCompose( m, kernel_mor_of_H) ], 0 ) );
    return List( morphisms_from_T_to_H, m-> InternalHomToTensorProductAdjunctionMap( C, D, m ) );
end;

graded_generators_of_hom_for_chains := 
    function( C, D )
    local chains, H, kernel_mor_of_H, kernel_obj_of_H, morphisms_C_to_D, morphisms_from_R_to_kernel, morphisms_from_T_to_H, T, U, cat;
    chains := CapCategory( C );
    cat := UnderlyingCategory( chains );
    U := TensorUnit( cat );
    H := InternalHomOnObjects( C, D );
    kernel_mor_of_H := CyclesAt( H, 0 );
    kernel_obj_of_H := Source( kernel_mor_of_H );
    morphisms_from_R_to_kernel := GetGenerators( Hom( AsPresentationInHomalg( U ), AsPresentationInHomalg( kernel_obj_of_H ) ) );
    morphisms_from_R_to_kernel := List( morphisms_from_R_to_kernel, AsPresentationMorphismInCAP );
    T := TensorUnit( chains );
    morphisms_from_T_to_H := List( morphisms_from_R_to_kernel, m -> ChainMorphism( T, H, [ PreCompose( m, kernel_mor_of_H) ], 0 ) );
    return List( morphisms_from_T_to_H, m-> InternalHomToTensorProductAdjunctionMap( C, D, m ) );
end;

generators_of_hom_for_cochains := 
        function( C, D )
        local cochains_cat, chains_cat, cat, cochains_to_chains, chains_to_cochains, l, m;
        cochains_cat := CapCategory( C );
        cat := UnderlyingCategory( cochains_cat );
        chains_cat := ChainComplexCategory( cat );
        cochains_to_chains := CochainToChainComplexFunctor( cochains_cat, chains_cat );
        chains_to_cochains := ChainToCochainComplexFunctor( chains_cat, cochains_cat );
        l := generators_of_hom_for_chains( ApplyFunctor( cochains_to_chains, C ), ApplyFunctor( cochains_to_chains, D ) );
        return List( l, m -> ApplyFunctor( chains_to_cochains, m ) );
end;

graded_generators_of_hom_for_cochains := 
        function( C, D )
        local cochains_cat, chains_cat, cat, cochains_to_chains, chains_to_cochains, l, m;
        cochains_cat := CapCategory( C );
        cat := UnderlyingCategory( cochains_cat );
        chains_cat := ChainComplexCategory( cat );
        cochains_to_chains := CochainToChainComplexFunctor( cochains_cat, chains_cat );
        chains_to_cochains := ChainToCochainComplexFunctor( chains_cat, cochains_cat );
        l := graded_generators_of_hom_for_chains( ApplyFunctor( cochains_to_chains, C ), ApplyFunctor( cochains_to_chains, D ) );
        return List( l, m -> ApplyFunctor( chains_to_cochains, m ) );
end;

DeclareGlobalFunction( "ForgetfullFunctorFromGradedLeftPresentations" );
InstallGlobalFunction( ForgetfullFunctorFromGradedLeftPresentations,
    function( S )
    local R, F;
    R := UnderlyingNonGradedRing( S );
    F := CapFunctor( "forgetfull functor", GradedLeftPresentations( S ), LeftPresentations( R ) );

    AddObjectFunction( F,
        function( M )
        local M_;
        M_ := UnderlyingMatrix( UnderlyingPresentationObject( M ) )*R;
        return AsLeftPresentation( M_ );
        end );

    AddMorphismFunction( F,
        function( s, f, r )
        local f_;
        f_ := UnderlyingMatrix( UnderlyingPresentationMorphism( f ) )*R;
        return PresentationMorphism( s, f_, r );
        end );
    
    return F;
end );

# #################################

# # \begin{tikzcd}
# # 0 \arrow[rd, "0", dashed] & 
# # R/\langle xy \rangle \arrow[l] \arrow[d, "(zt)"'] \arrow[rd, "(z)", dashed] &
# # R/\langle x \rangle \arrow[l, "(y)"'] \arrow[d, "(yz)"] \arrow[rd, "0", dashed] & 0 \arrow[l] \\
# # 0 & R/\langle xyt \rangle \arrow[l] & R/\langle xy \rangle \arrow[l, "(t)"] & 0 \arrow[l]
# # \end{tikzcd}

# A4 := AsGradedLeftPresentation( HomalgMatrix( "[ [ x ] ]",1,1, S ), [ 3 ] );
# A3 := AsGradedLeftPresentation( HomalgMatrix( "[ [ xy ] ]",1,1, S ), [ 2 ] );
# a43 := GradedPresentationMorphism( A4, HomalgMatrix( "[ [ y ] ]",1,1, S ), A3 );

# B4 := AsGradedLeftPresentation( HomalgMatrix( "[ [ xy ] ]",1,1, S ), [ 1 ] );
# B3 := AsGradedLeftPresentation( HomalgMatrix( "[ [ xyt ] ]",1,1, S ), [ 0 ] );
# b43 := GradedPresentationMorphism( B4, HomalgMatrix( "[ [ t ] ]",1,1, S ), B3 );

# CA := ChainComplex( [ a43 ], 4 );
# CB := ChainComplex( [ b43 ], 4 );
# phi3 := GradedPresentationMorphism( A3, HomalgMatrix( "[ [ zt ] ]",1,1, S ), B3 );
# phi4 := GradedPresentationMorphism( A4, HomalgMatrix( "[ [ yz ] ]",1,1, S ), B4 );
# phi := ChainMorphism( CA, CB, [ phi3, phi4 ], 3 );
# IsZeroForMorphisms( phi );
# IsNullHomotopic( phi );
# # true
# h := HomotopyMorphisms( phi );
# Display( h[ 3 ] );
