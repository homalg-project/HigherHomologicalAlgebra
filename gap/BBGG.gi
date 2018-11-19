#
# BBGG: BBG correspondence and Beilinson monad
#
# Implementations
#
InstallMethod( AsPresentationInCAP,
                [ IsHomalgGradedModule ],
    function( M )
    local N, s;
    s := PositionOfTheDefaultPresentation( M );
    SetPositionOfTheDefaultPresentation( M, 1 );
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        N := AsGradedRightPresentation( MatrixOfRelations( M ), DegreesOfGenerators( M ) );
        SetPositionOfTheDefaultPresentation( M, s );
        SetAsPresentationInHomalg( N, M );
        return N;
    else
        N := AsGradedLeftPresentation( MatrixOfRelations( M ), DegreesOfGenerators( M ) );
        SetPositionOfTheDefaultPresentation( M, s );
        SetAsPresentationInHomalg( N, M );
        return N;
    fi;
end );

InstallMethod( AsPresentationInHomalg,
                [ IsGradedLeftOrRightPresentation ],
    function( M )
    local N;
    if IsGradedRightPresentation( M ) then
        N := RightPresentationWithDegrees( UnderlyingMatrix( M ), GeneratorDegrees( M ) );
        SetAsPresentationInCAP( N, M );
        return N;
    else
        N := LeftPresentationWithDegrees( UnderlyingMatrix( M ), GeneratorDegrees( M ) );
        SetAsPresentationInCAP( N, M );
        return N;
    fi;
end );

InstallMethod( GradedLeftPresentationGeneratedByHomogeneousPartOp,
        [ IsGradedLeftPresentation, IsInt ],
    function( M, n )
    local Mn, Mn_in_homalg;
    Mn_in_homalg := SubmoduleGeneratedByHomogeneousPart( n, AsPresentationInHomalg(M) );
    Mn := AsPresentationInCAP( UnderlyingObject( Mn_in_homalg ) );
    SetEmbeddingInSuperObject( Mn, AsPresentationMorphismInCAP( EmbeddingInSuperObject( Mn_in_homalg ) ) );
    return Mn;
end );

InstallMethod( EmbeddingInSuperObject,
      [ IsGradedLeftPresentation ],
    function( M )
    Error( "This attribute should be set by: GradedLeftPresentationGeneratedByHomogeneousPart" );  
end );
InstallMethod( AsPresentationMorphismInCAP,
                [ IsHomalgGradedMap ],
    function( f )
    local g, M, N, s, t;
    s := PositionOfTheDefaultPresentation( Source( f ) );
    t := PositionOfTheDefaultPresentation( Range( f ) );
    
    SetPositionOfTheDefaultPresentation( Source( f ), 1 );
    SetPositionOfTheDefaultPresentation( Range( f ), 1 );
    
    M := AsPresentationInCAP( Source( f ) );
    N := AsPresentationInCAP( Range( f ) );
    
    g := GradedPresentationMorphism( M, MatrixOfMap( f ), N );

    SetPositionOfTheDefaultPresentation( Source( f ), s );
    SetPositionOfTheDefaultPresentation( Range( f ), t );
    SetAsPresentationInHomalg( g, f );
    
    return g;

end );

InstallMethod( AsPresentationMorphismInHomalg,
                [ IsGradedLeftOrRightPresentationMorphism ],
    function( f )
    local M, N, g;
    M := AsPresentationInHomalg( Source( f ) );
    N := AsPresentationInHomalg( Range( f ) );
    g :=  GradedMap( UnderlyingMatrix( f ), M, N );
    SetAsPresentationMorphismInCAP( g, f );
    return g;
end );

InstallMethod( RFunctor,
                [ IsHomalgGradedRing ],
    function( S )
    local cat_lp_ext, cat_lp_sym, cochains, R, KS, n, name; 

    n := Length( IndeterminatesOfPolynomialRing( S ) );
    KS := KoszulDualRing( S );
    cat_lp_sym := GradedLeftPresentations( S );
    cat_lp_ext := GradedLeftPresentations( KS );
    cochains := CochainComplexCategory( cat_lp_ext );
    name := Concatenation( "R functor from ", Name( cat_lp_sym ), " to ", Name( cochains ) );

    R := CapFunctor( name, cat_lp_sym, cochains );
    
    AddObjectFunction( R, 
        function( M )
        local hM, diff, d, C;
        hM := AsPresentationInHomalg( M );
        SetPositionOfTheDefaultPresentation( hM, 1 );
        diff := MapLazy( IntegersList, i -> AsPresentationMorphismInCAP( RepresentationMapOfKoszulId( i, hM ) ), 1 );
        C := CochainComplex( cat_lp_ext , diff );
        d := ShallowCopy( GeneratorDegrees( M ) );

        # the output of GeneratorDegrees is in general not integer.
        Apply( d, String );
        Apply( d, Int );

        if Length( d ) = 0 then
            SetLowerBound( C, 0 );
        else
            SetLowerBound( C, Minimum( d ) - 1 );
        fi;
        
        return C;
        end );

    AddMorphismFunction( R, 
        function( new_source, f, new_range )
        local M, N, G1, G2, hM, hN, mors;
        M := Source( f );
        N := Range( f );
        hM := AsPresentationInHomalg( M );
        hN := AsPresentationInHomalg( N );
        mors := MapLazy( IntegersList, 
                function( k )
                local emb_hMk, emb_hNk, l;
                emb_hMk := EmbeddingInSuperObject( SubmoduleGeneratedByHomogeneousPart( k, hM ) );
                emb_hMk := AsPresentationMorphismInCAP( emb_hMk );
                emb_hNk := EmbeddingInSuperObject( SubmoduleGeneratedByHomogeneousPart( k, hN ) );
                emb_hNk := AsPresentationMorphismInCAP( emb_hNk );
                if not IsMonomorphism( emb_hNk ) then
                    Error( "Something unexpected happend!"  );
                fi;
                l := LiftAlongMonomorphism( emb_hNk, PreCompose( emb_hMk, f ) );
                return GradedPresentationMorphism( new_source[ k ], UnderlyingMatrix( l )*KoszulDualRing( S ), new_range[ k ] );
                end, 1 );
        return CochainMorphism( new_source, new_range, mors );
        end );

    return R;
end );

InstallMethod( LFunctor, 
            [ IsHomalgGradedRing ],
    function( S )
    local cat_lp_ext, cat_lp_sym, cochains, ind_ext, ind_sym, L, KS, n, name; 

    n := Length( IndeterminatesOfPolynomialRing( S ) );
    KS := KoszulDualRing( S );
    ind_ext := IndeterminatesOfExteriorRing( KS );
    ind_sym := IndeterminatesOfPolynomialRing( S );
    
    cat_lp_sym := GradedLeftPresentations( S );
    cat_lp_ext := GradedLeftPresentations( KS );
    cochains := CochainComplexCategory( cat_lp_sym );
    name := Concatenation( "L functor from ", Name( cat_lp_ext ), " to ", Name( cochains ) );
    L := CapFunctor( name, cat_lp_ext, cochains );
    
    AddObjectFunction( L, 
        function( M )
        local hM, diffs, C, d;
        hM := AsPresentationInHomalg( M );
        diffs := MapLazy( IntegersList, 
            function( i )
            local l, source, range;
            l := List( ind_ext, e -> RepresentationMapOfRingElement( e, hM, -i ) );
            l := List( l, m -> UnderlyingMorphism( m ) );
            l := List( l, m -> m!.matrices!.( "[ 1, 1 ]" ) * S );
            l := Sum( List( [ 1 .. n ], j -> ind_sym[ j ]* l[ j ] ) );
            source := GradedFreeLeftPresentation( NrRows( l ), S, List( [ 1 .. NrRows( l )], j -> -i ) );
            range := GradedFreeLeftPresentation( NrColumns( l ), S, List( [ 1 .. NrColumns( l )], j -> -i - 1 ) );
            return GradedPresentationMorphism( source, l, range );
            end, 1 );
        C :=  CochainComplex( cat_lp_sym, diffs );

        d := ShallowCopy( GeneratorDegrees( M ) );

        # the output of GeneratorDegrees is in general not integer.
        Apply( d, String );
        Apply( d, Int );

        if Length( d ) = 0 then
            SetLowerBound( C, 0 );
            SetUpperBound( C, 0 );
        else
            SetLowerBound( C, -Maximum( d ) - 1 );
            SetUpperBound( C, -Minimum( d ) + n + 1);
        fi;
        
        return C;

        end );

    AddMorphismFunction( L, 
        function( new_source, f, new_range )
        local M, N, G1, G2, mors;
        M := Source( f );
        N := Range( f );
        mors := MapLazy( IntegersList, 
                 function( k )
                local hM, hN, hMk, hNk, hMk_, hNk_, iMk, iNk, l;
                # There is a reason to write the next two lines like this
                # See AdjustedGenerators.
                hM := LeftPresentationWithDegrees( UnderlyingMatrix( M ), GeneratorDegrees( M ) );
                hN := LeftPresentationWithDegrees( UnderlyingMatrix( N ), GeneratorDegrees( N ) );
                hMk := HomogeneousPartOverCoefficientsRing( -k, hM );
                hNk := HomogeneousPartOverCoefficientsRing( -k, hN );
                G1 := GetGenerators( hMk );
                G2 := GetGenerators( hNk );
                if Length( G1 ) = 0 or Length( G2 ) = 0 then 
                    return ZeroMorphism( new_source[ k ], new_range[ k ] );
                fi;
                hMk_ := UnionOfRows( G1 )* KS;
                hNk_ := UnionOfRows( G2 )* KS;
                iMk := GradedPresentationMorphism( GradedFreeLeftPresentation( NrRows( hMk_ ), KS, List( [1..NrRows( hMk_ ) ], i -> -k ) ), hMk_, M );
                iNk := GradedPresentationMorphism( GradedFreeLeftPresentation( NrRows( hNk_ ), KS, List( [1..NrRows( hNk_ ) ], i -> -k ) ), hNk_, N );
                #l := Lift( PreCompose( iMk, f ), iNk );
                Assert( 4, IsMonomorphism( iNk ) );
                l := LiftAlongMonomorphism( iNk, PreCompose( iMk, f ) );
                return GradedPresentationMorphism( new_source[ k ], UnderlyingMatrix( l ) * S, new_range[ k ] );
                end, 1 );

        return CochainMorphism( new_source, new_range, mors );
        end );

    return L;

end );

##
InstallMethod( CastelnuovoMumfordRegularity,
                [ IsCapCategoryObject and IsGradedLeftOrRightPresentation ],
    function( M )
    return CastelnuovoMumfordRegularity( AsPresentationInHomalg( M ) );
end );

##
InstallMethod( CastelnuovoMumfordRegularity,
                [ IsCapCategoryObject and IsCochainComplex ],
    function( C )
    local reg;
    reg := Maximum( List( [ ActiveLowerBound( C ) + 1 .. ActiveUpperBound( C ) - 1 ], 
                        i -> i + CastelnuovoMumfordRegularity( C[ i ] ) ) );
    return Int( String( reg ) );
end );

##
InstallMethod( TateResolution, 
                [ IsGradedLeftOrRightPresentation ],
    function( M )
    local cat, hM, diff, C, r_M;
    cat := GradedLeftPresentations( KoszulDualRing( UnderlyingHomalgRing( M ) ) );
    hM := AsPresentationInHomalg( M );
    r_M := CastelnuovoMumfordRegularity( M );

    #homalg may return wrong answer if I use (i,i+1) when i=r_M.
    diff := MapLazy( IntegersList, function( i )
        if i = r_M then
            return AsPresentationMorphismInCAP( CertainMorphism( TateResolution( hM, i - 1, i + 1 ), i ) );
        else
            return AsPresentationMorphismInCAP( CertainMorphism( TateResolution( hM, i, i + 1 ), i ) );
        fi;
        end, 1 );
    C := CochainComplex( cat , diff );
    SetCastelnuovoMumfordRegularity( C, r_M );
    return C;
end );

##
InstallMethod( TateResolution,
                [ IsGradedLeftOrRightPresentationMorphism ],
    function( phi )
    local R, M, N, r_M, r_N, r, tM, tN, RR, RR_phi, mors;
    R := UnderlyingHomalgRing( phi );
    M := Source( phi );
    N := Range( phi );
    r_M := CastelnuovoMumfordRegularity( M );
    r_N := CastelnuovoMumfordRegularity( N );
    r := Maximum( r_M, r_N );

    tM := TateResolution( M );
    tN := TateResolution( N );

    RR := RFunctor( R );
    RR_phi := ApplyFunctor( RR, phi );
    
    mors := MapLazy( IntegersList, 
                function( i )
                if i > r then
                    return RR_phi[ i ];
                else
                    return Lift( PreCompose( tM^i, mors[ i + 1 ] ), tN^i );
                fi;
                end, 1 );
    return CochainMorphism( tM, tN, mors );
end );

InstallMethod( TateFunctor,
	[ IsHomalgGradedRing ],
    function( S )
    local T, name;
    name := Concatenation( "Tate 'functor' from ", Name( GradedLeftPresentations( S ) ), " to ", 
    Name( CochainComplexCategory( GradedLeftPresentations( KoszulDualRing( S ) ) ) ) );
    T := CapFunctor( name, GradedLeftPresentations( S ), CochainComplexCategory( GradedLeftPresentations( KoszulDualRing( S ) ) ) );
    AddObjectFunction( T, TateResolution );
    AddMorphismFunction( T, function( s, phi, r ) return TateResolution( phi ); end );
    return T;
end );

InstallMethod( TateFunctorForCochains,
    [ IsHomalgGradedRing ],
    function( S )
    local A, lp_cat_ext, R, ChR, cochains_sym, cochains_ext, T;
    A := KoszulDualRing( S );
    lp_cat_ext := GradedLeftPresentations( A );
    R := RFunctor( S );
    ChR := ExtendFunctorToCochainComplexCategoryFunctor( R );
    cochains_sym := CochainComplexCategory( GradedLeftPresentations( S ) );
    cochains_ext := CochainComplexCategory( GradedLeftPresentations( A ) );
    T := CapFunctor( "to be named", cochains_sym, cochains_ext );
    AddObjectFunction( T,
        function( C )
        local reg, ChR_C, B, syz, proj_syz, diffs, Tot;
        reg := CastelnuovoMumfordRegularity( C );
        ChR_C := ApplyFunctor( ChR, C );
        B := CohomologicalBicomplex( ChR_C );
        Tot := TotalComplex( B );
        syz := Source( CyclesAt( Tot, reg ) );
        proj_syz := ProjectiveResolution( syz );
        diffs := MapLazy( IntegersList, 
            function( i )
            if i >= reg then
                return Tot^i;
            elif i = reg - 1 then
                return PreCompose( 
                    EpimorphismFromSomeProjectiveObject( syz ),
                    CyclesAt( Tot, reg ) );
            else
                return proj_syz^( i - reg + 1 );
            fi; end, 1 );
        return CochainComplex( lp_cat_ext, diffs );
    end );

    AddMorphismFunction( T,
        function( new_source, phi, new_range )
        local ChR_phi, B, Tot, reg_source, reg_range, reg, mors;
        ChR_phi := ApplyFunctor( ChR, phi );
        B := BicomplexMorphism( ChR_phi );
        Tot := TotalComplexFunctorial( B );
        reg_source := CastelnuovoMumfordRegularity( Source( phi ) );
        reg_range := CastelnuovoMumfordRegularity( Range( phi ) );
        reg := Maximum( reg_source, reg_range );
        mors := MapLazy( IntegersList, 
                function( i )
                if i >= reg then
                    return Tot[ i ];
                else
                    return ProjectiveLift( PreCompose( new_source^i, mors[ i + 1 ] ), new_range^i );
                fi;
                end, 1 );
        return CochainMorphism( new_source, new_range, mors );
        end );
    return T;
end );

InstallMethod( TateSequenceFunctor, 
    [ IsHomalgGradedRing ],
    function( S )
    local A, graded_lp_cat, cochains_graded_lp_cat, name, T;
    A := KoszulDualRing( S );
    graded_lp_cat := GradedLeftPresentations( A );
    cochains_graded_lp_cat := CochainComplexCategory( graded_lp_cat );
    name := Concatenation( "Tate sequence functor from ", Name( graded_lp_cat ), " to ", Name( cochains_graded_lp_cat ) );
    T := CapFunctor( name, graded_lp_cat, cochains_graded_lp_cat );
    AddObjectFunction( T, 
        function( P )
        local p, q, diffs;
        p := ProjectiveResolution( P );
        q := InjectiveResolution( P );
        diffs := MapLazy( IntegersList, function( i )
                                        if i<-1 then
                                            return p^( i + 1 );
                                        elif i = -1 then
                                            return PreCompose( EpimorphismFromSomeProjectiveObject( P ), MonomorphismIntoSomeInjectiveObject( P ) );
                                        else
                                            return q^( i );
                                        fi;
                                        end, 1 );
        return CochainComplex( graded_lp_cat, diffs );
    end );

    AddMorphismFunction( T,
        function( new_source, phi, new_range )
        local source, range, mors; 
        source := Source( phi );
        range := Range( phi );
        mors := MapLazy( IntegersList,  function( i )
                                        local epi_to_range, epi_to_source;
                                        if i < -1 then
                                            return Lift( PreCompose( new_source^i, mors[ i + 1 ] ), new_range^i );
                                        elif i = -1 then
                                            epi_to_source := EpimorphismFromSomeProjectiveObject( source );
                                            epi_to_range := EpimorphismFromSomeProjectiveObject( range );
                                            return ProjectiveLift( PreCompose( epi_to_source, phi ), epi_to_range );
                                        else
                                            return Colift( new_source^( i - 1 ), PreCompose( mors[ i - 1 ], new_range^( i - 1 ) ) );
                                        fi;
                                        end, 1 );
        return CochainMorphism( new_source, new_range, mors );
    end );
    return T;
end );

InstallMethod( TwistFunctorOp,
	[ IsHomalgGradedRing, IsInt ],
	function( S, n )
	local cat, F;
	cat := GradedLeftPresentations( S );
	F := CapFunctor( Concatenation( String( n ), "-twist endofunctor in ", Name( cat ) ), cat, cat );
	AddObjectFunction( F,
		function( M )
		return AsGradedLeftPresentation( UnderlyingMatrix( M ), List( GeneratorDegrees( M ), d -> d - n ) );
		end );
	AddMorphismFunction( F,
		function( source, f, range )
		return GradedPresentationMorphism( source, UnderlyingMatrix( f ), range );
		end );
	return F;
end );

InstallMethod( \[\],
    [ IsGradedLeftOrRightPresentation, IsInt ],
    function( M, n )
    local ring;
    ring := UnderlyingHomalgRing( M );
    return ApplyFunctor( TwistFunctor( ring, n ), M );
end );

InstallMethod( DimensionOfTateCohomology,
        [ IsCochainComplex, IsInt, IsInt ],
    function( T, i, k )
    local cat, n, j, t, degrees;
    cat := UnderlyingCategory( CapCategory( T ) );
    n := Length( IndeterminatesOfExteriorRing( cat!.ring_for_representation_category ) );
    j := i + k;
    t := -n - k;
    degrees := GeneratorDegrees( T[ j ] );
    degrees := List( degrees, i -> Int( String( i ) ) );
    return Length( Positions( degrees, -t ) );
end );

# The output here is stable module that correspondes to O(k) [ the sheafification of S(k) ]
InstallMethod( TwistedStructureBundleOp,
	[ IsHomalgGradedRing, IsInt ],
	function( Sym, k )
	local F;
    	F := GradedFreeLeftPresentation( 1, Sym, [ -k ] );
    	return Source( CyclesAt( TateResolution( F ), 0 ) );
end );

# See Appendix of Vector Bundels over complex projective spaces
InstallMethod( TwistedCotangentBundleOp,
	[ IsHomalgGradedRing, IsInt ],
	function( A, k )
	local n, F, hF, hM, cM, id, i, mat;
	n := Length( IndeterminatesOfExteriorRing( A ) );
    if k < 0 or k > n - 1 then
        Error( Concatenation( "Cotangent bundels are defined only for 0,1,...,", String( n - 1 ) ) );
    fi;
	F := GradedFreeLeftPresentation( 1, A, [ n - k ] );
	hF := AsPresentationInHomalg( F );
	hM := SubmoduleGeneratedByHomogeneousPart( 0, hF );
	hM := UnderlyingObject( hM );
	cM := AsPresentationInCAP( hM );
	mat := UnderlyingMatrix( cM );
	id := HomalgInitialMatrix( NrColumns( mat ), NrColumns( mat ), A );
	for i in [ 1 .. NrColumns( mat ) ] do
		SetMatElm( id, i, NrColumns( mat )-i+1, One(A) );
	od;
	return AsGradedLeftPresentation( mat*id, Reversed( GeneratorDegrees( cM ) ) );
end );

# See chapter 5, Sheaf cohomology and free resolutions over exterior algebra
InstallMethod( KoszulSyzygyModuleOp,
	[ IsHomalgGradedRing, IsInt ],
    function( S, k )
    local ind, K, koszul_resolution, n;
    ind := Reversed( IndeterminatesOfPolynomialRing( S ) );
    K := AsGradedLeftPresentation( HomalgMatrix( ind, S ), [ 0 ] );
    koszul_resolution := ProjectiveResolution( K );
    return CokernelObject( koszul_resolution^( -k - 2 ) );
end );
