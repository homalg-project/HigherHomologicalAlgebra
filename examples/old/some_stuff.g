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


quit;

AddMorphismFunction( Standard_coh,
    function( source, f, range )
    local M1, M2, r1, r2, r, stand_f;
    M1 := Source( f );
    M2 := Range( f );

    r1 := Maximum( 2, CastelnuovoMumfordRegularity( M1 ) );
    r2 := Maximum( 2, CastelnuovoMumfordRegularity( M2 ) );

    r := Maximum( r1, r2 );

    stand_f := ApplyFunctor( PreCompose(
        [ TT, _Trunc_g_rm1( S, r ), _Coh_r_ext(S, r), LL, _Coh_mr_sym( S, r ), Sh ] ), f );
    if r1 < r then

        tMr1 := ApplyFunctor( PreCompose( [ TT, _Trunc_g_rm1(S, r1) ] ), M1 );
        P1 := ApplyFunctor( _Coh_r_ext( S, r1 ), tMr1 );
        phi := CochainMorphism(
            StalkCochainComplex( P1, r1 ),
            tMr1,
            [ HonestRepresentative( GeneralizedEmbeddingOfCohomologyAt( tMr1, r1 ) ) ],
            r1 );
        phi_r1 := ApplyFunctor( PreCompose( [ ChLL, ChCh_to_Bi_sym ] ), phi );

        tMr := ApplyFunctor( PreCompose( [ TT, _Trunc_g_rm1(S, r) ] ), M1 );
        P := ApplyFunctor( _Coh_r_ext( S, r ), tMr );
        phi := CochainMorphism(
            StalkCochainComplex( P, r ),
            tMr,
            [ HonestRepresentative( GeneralizedEmbeddingOfCohomologyAt( tM, r ) ) ],
            r );
        phi_r := ApplyFunctor( PreCompose( [ ChLL, ChCh_to_Bi_sym ] ), phi );
        i1 := GeneralizedEmbeddingOfVerticalCohomologyAt( Source( phi_r1 ), r1, -r1 );
        i1 := ApplyFunctor( span_to_three_arrows, i1 );
        i2 := MorphismAt( phi_r1, r1, -r1 );
        indices := List( [ r1 + 1 .. r ], i -> [ i, -i + 1 ] );
        L := List( indices, i -> GeneralizedMorphismByCospan(
            HorizontalDifferentialAt( Range( phi_r ), i[1] - 1, i[2] ),
            VerticalDifferentialAt( Range( phi_r ), i[1], i[2] - 1 )
        ) );

        p1 := MorphismAt( phi_r, r, -r );
        p1 := ApplyFunctor( Sh, p1 );
        p2 := GeneralizedProjectionOfVerticalCohomologyAt( Source( phi_r ), r, -r );
        p2 := ApplyFunctor( span_to_three_arrows, p );



    elif r2 < r then
        Error( "to do" );
    else
        return stand_f;
    fi;

end );

Canonicalize_coh_v2 := CapFunctor( "Canonicalization Functor",
                    graded_lp_cat_sym, coh );
AddObjectFunction( Canonicalize_coh_v2,
    function( M )
    local r;
    r := Maximum( 2, CastelnuovoMumfordRegularity( M ) );
    return ApplyFunctor(  PreCompose(
        [ TT,_Trunc_leq_rm1(S,r), ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym,
            _Cochain_of_hor_coho_sym_rm1(S,r), _Coh_mr_sym(S,r), Sh
        ] ), M );
end );

AddMorphismFunction( Canonicalize_coh_v2,
    function( source, f, range )
    local M1, M2, r1, r2, r, can_f_r;
    M1 := Source( f );
    M2 := Range( f );

    r1 := Maximum( 2, CastelnuovoMumfordRegularity( M1 ) );
    r2 := Maximum( 2, CastelnuovoMumfordRegularity( M2 ) );

    r := Maximum( r1, r2 );

    can_f_r := ApplyFunctor(  PreCompose(
        [ TT,_Trunc_leq_rm1(S,r), ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym,
            _Cochain_of_hor_coho_sym_rm1(S,r), _Coh_mr_sym(S,r), Sh
        ] ), f );
    if r1 < r then
        return PreCompose(
        # LiftAlongMonomorphism( TruncationToBeilinson( M1, r ), TruncationToBeilinson( M1, r1 ) )
        # or pre...
            PreCompose( TruncationToBeilinson( M1, r1 ), Inverse( TruncationToBeilinson( M1, r ) ) ),
            can_f_r
            );
    elif r2 < r then
        return PreCompose(
            can_f_r,
        #LiftAlongMonomorphism( TruncationToBeilinson( M2, r2 ), TruncationToBeilinson( M2, r ) )
        # or pre...
            PreCompose( TruncationToBeilinson( M2, r ), Inverse( TruncationToBeilinson( M2, r2 ) ) )
            );
    else
        return can_f_r;
    fi;
end );

test_right := function( M, i )
    local r, Mr, emb_of_Mr, Trunc_leq_m1, Cochain_of_hor_coho_sym_rm1, Coh_mr,
        tM, colift, P, Pr, emb_of_Pr, emb, mat, tau1, tau2, phi, tau, mono1, mono2,
        a, CV, CH, i1, i2, p1, p2, L, iso1, iso2, Trunc_leq_rm1, indices;
    #r := Maximum( 2, CastelnuovoMumfordRegularity( M ) ) + i;;
    r := i;
    Mr := GradedLeftPresentationGeneratedByHomogeneousPart( M, r );
    emb_of_Mr := EmbeddingInSuperObject( Mr );

    # Using r we define 3 functors:

    # the following functor truncates the tate resolution (the output is concentrated in window
    #[ -ifinity .. r - 1 ] ).
    Trunc_leq_rm1 := _Trunc_leq_rm1(S,r);

    # This functor computes the complex of horizontal cohomologies of a bicomplex at index r
    Cochain_of_hor_coho_sym_rm1 := _Cochain_of_hor_coho_sym_rm1(r);

    # This computes the Cohomology at cohomological index -r
    Coh_mr := _Coh_mr_sym(r);

    # Hom_S(L(P),M) \sim Hom_k(P,M) \sim Hom_A(P,R(M))
    tM := ApplyFunctor( TT, M );;
    colift := CokernelColift( tM^(r-2), tM^(r-1) );;
    P := CokernelObject( tM^(r-2) );;
    Pr := GradedLeftPresentationGeneratedByHomogeneousPart( P, r );;
    emb_of_Pr := EmbeddingInSuperObject( Pr );;
    emb := PreCompose( emb_of_Pr, colift );;
    mat := UnderlyingMatrix(emb);;
    mat := DecompositionOfHomalgMat(mat)[2^(n+1)][2]*S;;

    # We don't need tM anymore, we only need now a truncation of it.
    tM := ApplyFunctor( PreCompose( [ TT, Trunc_leq_rm1 ] ), M );
    phi := CochainMorphism( tM, StalkCochainComplex( P, r - 1 ),
                            [ CokernelProjection( tM^(r-2) ) ], r - 1 );

    tau1 := ApplyFunctor(
        PreCompose( [ ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym, Cochain_of_hor_coho_sym_rm1 ] ),
        phi );

    tau2 := CochainMorphism( Range( tau1 ), StalkCochainComplex( M, -r ),
        [ PreCompose(
            GradedPresentationMorphism( Range( tau1 )[ -r ], mat, Mr ), emb_of_Mr ) ], -r );

    # Note: You may think that the following tau is quasi-isomorphism, but it may not.
    # because here we are in modules not in (Serre Quotients).
    tau := PreCompose( tau1, tau2 );

    mono1 := PreCompose(
            ApplyFunctor( Coh_mr, tau ),
            HonestRepresentative( GeneralizedEmbeddingOfCohomologyAt( Range( tau ), -r ) )
            );

    a := ApplyFunctor( PreCompose( [ TT, Trunc_leq_rm1, ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym ] ), M );
    CV := ApplyFunctor( Cochain_of_ver_coho_sym, a );;
    CH := ApplyFunctor( Cochain_of_hor_coho_sym_rm1, a );;
    i1 := GeneralizedEmbeddingOfCohomologyAt( CH, -r );;
    i2 := GeneralizedEmbeddingOfHorizontalCohomologyAt( a, r-1, -r );;
    p1 := GeneralizedProjectionOntoVerticalCohomologyAt( a, 0, -1 );;
    p2 := GeneralizedProjectionOntoCohomologyAt( CV, 0 );
    indices := Reversed( List( [ 1 .. r-1 ], i -> [ i, -i ] ) );;
    L := List( indices,i -> GeneralizedMorphismByCospan(
            VerticalDifferentialAt( a, i[1], i[2]-1 ),
            HorizontalDifferentialAt( a, i[1]-1, i[2] ) ) );;
    cospan_to_span := FunctorFromCospansToSpans( graded_lp_cat_sym );;
    L := List( L, l -> ApplyFunctor( cospan_to_span, l ) );;
    mono2 := PreCompose( Concatenation( [ i1, i2 ], L, [ p1, p2 ] ) );
    return [ mono1, HonestRepresentative( mono2 )];
    iso1 := Inverse( ApplyFunctor( Sh, mono1 ) );
    iso2 := SerreQuotientCategoryMorphism( coh, ApplyFunctor( span_to_three_arrows, mono2 ) );

    return PreCompose( iso1, iso2 );

end;

# searching for the nat trans.
_nat := function(i)
local Nat;
if i<0 then Error("?");fi;

Nat := NaturalTransformation( "To be named", Sh, PreCompose( [ Beilinson_complex_sym, Coh0_sym, Sh ] ) );
AddNaturalTransformationFunction( Nat,
    function( source, M, range )
    local r, Mr, emb_of_Mr, Trunc_leq_m1, Cochain_of_hor_coho_sym_rm1, Coh_mr,
        tM, colift, P, Pr, emb_of_Pr, emb, mat, tau1, tau2, phi, tau, mono1, mono2,
        a, CV, CH, i1, i2, p1, p2, L, iso1, iso2, Trunc_leq_rm1, indices;
    #r := Maximum( 2, CastelnuovoMumfordRegularity( M ) ) + i;;
    r := i;
    Mr := GradedLeftPresentationGeneratedByHomogeneousPart( M, r );
    emb_of_Mr := EmbeddingInSuperObject( Mr );

    # Using r we define 3 functors:

    # the following functor truncates the tate resolution (the output is concentrated in window
    #[ -ifinity .. r - 1 ] ).
    Trunc_leq_rm1 := _Trunc_leq_rm1(r);

    # This functor computes the complex of horizontal cohomologies of a bicomplex at index r
    Cochain_of_hor_coho_sym_rm1 := _Cochain_of_hor_coho_sym_rm1(r);

    # This computes the Cohomology at cohomological index -r
    Coh_mr := CohomologyFunctorAt( cochains_graded_lp_cat_sym, graded_lp_cat_sym, -r );

    # Hom_S(L(P),M) \sim Hom_k(P,M) \sim Hom_A(P,R(M))
    tM := ApplyFunctor( TT, M );;
    colift := CokernelColift( tM^(r-2), tM^(r-1) );;
    P := CokernelObject( tM^(r-2) );;
    Pr := GradedLeftPresentationGeneratedByHomogeneousPart( P, r );;
    emb_of_Pr := EmbeddingInSuperObject( Pr );;
    emb := PreCompose( emb_of_Pr, colift );;
    mat := UnderlyingMatrix(emb);;
    mat := DecompositionOfHomalgMat(mat)[2^(n+1)][2]*S;;

    # We don't need tM anymore, we only need now a truncation of it.
    tM := ApplyFunctor( PreCompose( [ TT, Trunc_leq_rm1 ] ), M );
    phi := CochainMorphism( tM, StalkCochainComplex( P, r - 1 ),
                            [ CokernelProjection( tM^(r-2) ) ], r - 1 );

    tau1 := ApplyFunctor(
        PreCompose( [ ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym, Cochain_of_hor_coho_sym_rm1 ] ),
        phi );

    tau2 := CochainMorphism( Range( tau1 ), StalkCochainComplex( M, -r ),
        [ PreCompose(
            GradedPresentationMorphism( Range( tau1 )[ -r ], mat, Mr ), emb_of_Mr ) ], -r );

    # Note: You may think that the following tau is quasi-isomorphism, but it may not.
    # because here we are in modules not in (Serre Quotients).
    tau := PreCompose( tau1, tau2 );

    mono1 := PreCompose(
            ApplyFunctor( Coh_mr, tau ),
            HonestRepresentative( GeneralizedEmbeddingOfCohomologyAt( Range( tau ), -r ) )
            );

    a := ApplyFunctor( PreCompose( [ TT, Trunc_leq_rm1, ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym ] ), M );
    CV := ApplyFunctor( Cochain_of_ver_coho_sym, a );;
    CH := ApplyFunctor( Cochain_of_hor_coho_sym_rm1, a );;
    i1 := GeneralizedEmbeddingOfCohomologyAt( CH, -r );;
    i2 := GeneralizedEmbeddingOfHorizontalCohomologyAt( a, r-1, -r );;
    p1 := GeneralizedProjectionOntoVerticalCohomologyAt( a, 0, -1 );;
    p2 := GeneralizedProjectionOntoCohomologyAt( CV, 0 );
    indices := Reversed( List( [ 1 .. r-1 ], i -> [ i, -i ] ) );;
    L := List( indices,i -> GeneralizedMorphismByCospan(
            VerticalDifferentialAt( a, i[1], i[2]-1 ),
            HorizontalDifferentialAt( a, i[1]-1, i[2] ) ) );;
    cospan_to_span := FunctorFromCospansToSpans( graded_lp_cat_sym );;
    L := List( L, l -> ApplyFunctor( cospan_to_span, l ) );;
    mono2 := PreCompose( Concatenation( [ i1, i2 ], L, [ p1, p2 ] ) );

    iso1 := Inverse( ApplyFunctor( Sh, mono1 ) );
    iso2 := SerreQuotientCategoryMorphism( coh, ApplyFunctor( span_to_three_arrows, mono2 ) );

    return PreCompose( iso1, iso2 );

end );

return Nat;
end;

Nat := NaturalTransformation( "Name", Sh, Beilinson );
AddNaturalTransformationFunction( Nat,
    function( source, M, range )
    local r, M_geq_r, trunc_leq_m1, T, trunc_leq_rm1,ch_trunc_leq_m1, complexes_sym,
    bicomplxes_sym, complexes_to_bicomplex, L, chL, trunc_leq_rm1_TM_geq_r, phi,
    bicomplexes_morphism, tau, LP, tM, colift, P, Pr, emb, emb_of_Pr, t, mat, i1, i2, i, p1, p2, p, l,
    Hmr, iso1, iso2, cospan_to_span, mor, g_emb, a, CV, CH, indices, iso, Trunc_leq_rm1;

    r := Maximum( 2, CastelnuovoMumfordRegularity( M ) );;
    M_geq_r := GradedLeftPresentationGeneratedByHomogeneousPart( M, r );;
    trunc_leq_rm1 := BrutalTruncationAboveFunctor( cochains_graded_lp_cat_ext, r-1 );;
    T := TateFunctor(S);;
    trunc_leq_m1 := BrutalTruncationAboveFunctor( cochains_graded_lp_cat_sym, -1 );;
    ch_trunc_leq_m1 := ExtendFunctorToCochainComplexCategoryFunctor(trunc_leq_m1 );;
    complexes_sym := CochainComplexCategory( cochains_graded_lp_cat_sym );;
    bicomplxes_sym := AsCategoryOfBicomplexes(complexes_sym);;
    complexes_to_bicomplex := ComplexOfComplexesToBicomplexFunctor(complexes_sym, bicomplxes_sym );;
    L := LFunctor(S);;
    chL := ExtendFunctorToCochainComplexCategoryFunctor(L);;
    trunc_leq_rm1_TM_geq_r := ApplyFunctor( PreCompose(T,trunc_leq_rm1), M_geq_r );;
    phi := CochainMorphism(
    trunc_leq_rm1_TM_geq_r,
    StalkCochainComplex( CokernelObject( trunc_leq_rm1_TM_geq_r^(r-2) ), r-1 ),
    [ CokernelProjection( trunc_leq_rm1_TM_geq_r^(r-2) ) ],
    r-1 );
    bicomplexes_morphism := ApplyFunctor( PreCompose( [ chL, ch_trunc_leq_m1, complexes_to_bicomplex ] ), phi );;
    tau := ComplexMorphismOfHorizontalCohomologiesAt(bicomplexes_morphism, r-1 );;
    LP := Range( tau );
###
    tM := ApplyFunctor(T,M);;
    colift := CokernelColift( tM^(r-2), tM^(r-1) );;
    P := Source(colift);;
    Pr := GradedLeftPresentationGeneratedByHomogeneousPart(P,r);;
    emb_of_Pr := EmbeddingInSuperObject(Pr);;
    emb := PreCompose( emb_of_Pr, colift );;
    mat := UnderlyingMatrix(emb);;
    mat := DecompositionOfHomalgMat(mat)[2^(n+1)][2]*S;;
    ##
    t := GradedPresentationMorphism( LP[ -r ], mat, M_geq_r );;
    emb := EmbeddingInSuperObject( M_geq_r );;
    phi := CochainMorphism( Range(tau), StalkCochainComplex( M, -r ), [ PreCompose( t, emb ) ], -r );;
    Hmr := CohomologyFunctorAt( cochains_graded_lp_cat_sym, graded_lp_cat_sym, -r );;;;
    mor := ApplyFunctor( Hmr, PreCompose( tau, phi ) );;
    g_emb := GeneralizedEmbeddingOfCohomologyAt(Range(phi),-r);;
    iso1 := PreCompose( mor, HonestRepresentative( g_emb ) );;

    #####
    a := ApplyFunctor( PreCompose( [ T, trunc_leq_rm1, chL, ch_trunc_leq_m1, complexes_to_bicomplex ] ), M );;
    #a := Source( bicomplexes_morphism );;
    CV := ComplexOfVerticalCohomologiesAt( a, -1 );;
    CH := ComplexOfHorizontalCohomologiesAt( a, r - 1 );;
    i1 := GeneralizedEmbeddingOfCohomologyAt(CH, -r );;
    i2 := GeneralizedEmbeddingOfHorizontalCohomologyAt(a, r-1, -r );;
    p1 := GeneralizedProjectionOntoVerticalCohomologyAt(a, 0, -1 );;
    p2 := GeneralizedProjectionOntoCohomologyAt(CV, 0);
    i := PreCompose(i1,i2);;
    p := PreCompose(p1,p2);;
    indices := Reversed( List( [ 1 .. r-1 ], i -> [ i, -i ] ) );;
    L := List( indices,i -> GeneralizedMorphismByCospan(
            VerticalDifferentialAt(a, i[1], i[2]-1 ),
            HorizontalDifferentialAt(a, i[1]-1, i[2] ) ) );;
    cospan_to_span := FunctorFromCospansToSpans( graded_lp_cat_sym );;
    L := List( L, l -> ApplyFunctor( cospan_to_span, l ) );;
    iso2  := HonestRepresentative( PreCompose( Concatenation( [ [ i ], L, [ p ] ] ) ) );
    return PreCompose( Inverse( ApplyFunctor( Sh, iso1 ) ), ApplyFunctor( Sh, iso2 ) );
end );

KeyDependentOperation( "TruncToTrunc2_test_old", IsGradedLeftPresentation, IsInt, ReturnTrue );
InstallMethod( TruncToTrunc2_test_oldOp,
    [ IsGradedLeftPresentation, IsInt ],
    function( M, r )
    local tM, M_geq_r,f,emb,Pr,LP,mat,mor;
    tM := ApplyFunctor( TT, M );
    M_geq_r := ApplyFunctor( GeneratedByHomogeneousPart_sym(S,r), M );
    f := tM^r;
    emb := KernelEmbedding( f );
    Pr := GradedLeftPresentationGeneratedByHomogeneousPart( Source( emb ), r );
    LP := ApplyFunctor( LL, Source( emb ) );
    mat := UnderlyingMatrix( PreCompose( EmbeddingInSuperObject( Pr ), emb ) );
    mat := DecompositionOfHomalgMat(mat)[2^( nr_indeterminates+1)][2]*S;
    mor := GradedPresentationMorphism( LP[ -r ], mat, M_geq_r );
    
    if IsBicomplexCategoryWithCommutativeSquares( bicomplexes_of_graded_lp_cat_sym ) then
        return ApplyFunctor( Sh, CokernelColift( LP^(-r-1), mor ) );
    else
        if r mod 2 = 0 then
            return ApplyFunctor( Sh, CokernelColift( AdditiveInverseForMorphisms( LP^(-r-1) ), mor ) );
        else
            return ApplyFunctor( Sh, CokernelColift( LP^(-r-1), mor ) );
        fi;
    fi;
end );

Canonicalize_coh_v1 := CapFunctor( "Canonicalization Functor version 1",
                    graded_lp_cat_sym, coh );
AddObjectFunction( Canonicalize_coh_v1,
    function( M )
    local r;
    r := Maximum( 2, CastelnuovoMumfordRegularity( M ) );
    return ApplyFunctor(  PreCompose(
        [ TT,_Trunc_leq_rm1(S,r), ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym,
            _Cochain_of_hor_coho_sym_rm1(S,r), _Coh_mr_sym(S,r), Sh
        ] ), M );
end );

AddMorphismFunction( Canonicalize_coh_v1,
    function( source, f, range )
    local M1, M2, r1, r2, r, can_f_r, Br, Br1, Br2, CH,
    CH1, CH2, L, indices, lift, i1, i2, p1, p2, i, p;
    M1 := Source( f );
    M2 := Range( f );

    r1 := Maximum( 2, CastelnuovoMumfordRegularity( M1 ) );
    r2 := Maximum( 2, CastelnuovoMumfordRegularity( M2 ) );

    r := Maximum( r1, r2 );

    can_f_r := ApplyFunctor(  PreCompose(
        [ TT,_Trunc_leq_rm1(S,r), ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym,
            _Cochain_of_hor_coho_sym_rm1(S,r), _Coh_mr_sym(S,r), Sh
        ] ), f );
    if r1 < r then
        Br := ApplyFunctor(  PreCompose(
        [ TT,_Trunc_leq_rm1(S,r), ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym ] ), M1 );

        CH := ApplyFunctor( _Cochain_of_hor_coho_sym_rm1(S,r), Br );;

        Br1 := ApplyFunctor(  PreCompose(
        [ TT,_Trunc_leq_rm1(S,r1), ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym ] ), M1 );

        CH1 := ApplyFunctor( _Cochain_of_hor_coho_sym_rm1(S,r1), Br1 );;

        i1 := GeneralizedEmbeddingOfCohomologyAt( CH1, -r1 );
        i2 := GeneralizedEmbeddingOfHorizontalCohomologyAt( Br1, r1 - 1, -r1 );
        i := PreCompose( i1, i2 );
        i := ApplyFunctor( span_to_cospan, i );
        p1 := GeneralizedProjectionOntoHorizontalCohomologyAt( Br, r - 1, -r );
        p2 := GeneralizedProjectionOntoCohomologyAt( CH, -r );
        p := PreCompose( p1, p2 );
        p := ApplyFunctor( span_to_cospan, p );
        indices := List( [ r1 .. r - 1 ], i -> [ i, -i ] );
        L := List( indices, i -> GeneralizedMorphismByCospan(
            HorizontalDifferentialAt( Br, i[1]-1, i[2] ), VerticalDifferentialAt( Br, i[1], i[2] -1 )
            ) );

        lift := PreCompose( [ i, L, p ] );
        lift := ApplyFunctor( cospan_to_three_arrows, lift );
        lift := SerreQuotientCategoryMorphism( coh, lift );

        return PreCompose( lift, can_f_r );
    elif r2 < r then
        Br := ApplyFunctor(  PreCompose(
        [ TT,_Trunc_leq_rm1(S,r), ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym ] ), M2 );

        CH := ApplyFunctor( _Cochain_of_hor_coho_sym_rm1(S,r), Br );;

        Br2 := ApplyFunctor(  PreCompose(
        [ TT,_Trunc_leq_rm1(S,r2), ChLL, ChTrunc_leq_m1, ChCh_to_Bi_sym ] ), M2 );

        CH2 := ApplyFunctor( _Cochain_of_hor_coho_sym_rm1(S,r2), Br2 );;

        i1 := GeneralizedEmbeddingOfCohomologyAt( CH, -r );
        i2 := GeneralizedEmbeddingOfHorizontalCohomologyAt( Br, r - 1, -r );
        i := PreCompose( i1, i2 );
        i := ApplyFunctor( span_to_cospan, i );
        p1 := GeneralizedProjectionOntoHorizontalCohomologyAt( Br2, r2 - 1, -r2 );
        p2 := GeneralizedProjectionOntoCohomologyAt( CH2, -r2 );
        p := PreCompose( p1, p2 );
        p := ApplyFunctor( span_to_cospan, p );
        indices := Reversed( List( [ r2 .. r - 1 ], i -> [ i, -i ] ) );
        L := List( indices, i -> GeneralizedMorphismByCospan(
            VerticalDifferentialAt( Br, i[1], i[2] -1 ), HorizontalDifferentialAt( Br, i[1]-1, i[2] )
            ) );
        L := PreCompose(L);

        lift := PreCompose( [ i, L, p ] );
        lift := ApplyFunctor( cospan_to_three_arrows, lift );
        lift := SerreQuotientCategoryMorphism( coh, lift );

        return PreCompose( can_f_r, lift );
    else
        return can_f_r;
    fi;
end );


Nat_1 := NaturalTransformation( "Nat. iso. from Canonicalize -> Sh(H0(Beilinson))",
        Canonicalize_coh_v1, PreCompose( [ Beilinson_complex_sym, Coh0_sym, Sh ] ) );
AddNaturalTransformationFunction( Nat_1,
    function( source, M, range )
    return TruncationToBeilinson( M, Maximum( 2, CastelnuovoMumfordRegularity ( M ) ) );
end );

Standard_coh_v1 := CapFunctor( "Some Name", graded_lp_cat_sym, coh );
Nat_2 := NaturalTransformation( "Nat. iso. from Canonicalize -> Standard",
    Canonicalize_coh_v1, Standard_coh_v1 );

AddObjectFunction( Standard_coh_v1,
    function( M )
    local r, tM, lift, P, phi;
    r := Maximum( 2, CastelnuovoMumfordRegularity( M ) );
    tM := ApplyFunctor( PreCompose( [ TT ] ), M );
    lift := KernelLift( tM^r, tM^(r-1) );
    P := Range( lift );
    phi := CochainMorphism(
        ApplyFunctor( _Trunc_leq_rm1(S,r), tM ),
        StalkCochainComplex( P, r - 1 ),
        [ lift ], r - 1 );
    phi := ApplyFunctor(
        PreCompose( [ ChLL, ChCh_to_Bi_sym, _Cochain_of_hor_coho_sym_rm1(S,r), _Coh_mr_sym(S,r), Sh ] ),
         phi );
    return Range( phi );
end );

AddMorphismFunction( Standard_coh_v1,
    function( source, f, range )
    local M1, M2;

    M1 := Source( f );
    M2 := Range( f );

    return PreCompose(
        [
            Inverse( ApplyNaturalTransformation( Nat_2, M1 ) ),
            ApplyFunctor( Canonicalize_coh_v1, f ),
            ApplyNaturalTransformation( Nat_2, M2 )
        ]
    );
end );

AddNaturalTransformationFunction( Nat_2,
    function( source, M, range )
    local r, tM, lift, P, phi;
    r := Maximum( 2, CastelnuovoMumfordRegularity( M ) );
    tM := ApplyFunctor( PreCompose( [ TT ] ), M );
    lift := KernelLift( tM^r, tM^(r-1) );
    P := Range( lift );
    phi := CochainMorphism(
        ApplyFunctor( _Trunc_leq_rm1(S,r), tM ),
        StalkCochainComplex( P, r - 1 ),
        [ lift ], r - 1 );
    phi := ApplyFunctor(
        PreCompose( [ ChLL, ChCh_to_Bi_sym, _Cochain_of_hor_coho_sym_rm1(S,r), _Coh_mr_sym(S,r), Sh ] ),
         phi );
    return phi;
end );
