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
    local cat_lp_ext, cat_lp_sym, cochains, R, KS, n; 

    n := Length( IndeterminatesOfPolynomialRing( S ) );
    KS := KoszulDualRing( S );
    cat_lp_sym := GradedLeftPresentations( S );
    cat_lp_ext := GradedLeftPresentations( KS );
    cochains := CochainComplexCategory( cat_lp_ext );

    R := CapFunctor( "R resolution ", cat_lp_sym, cochains );
    
    AddObjectFunction( R, 
        function( M )
        local hM, diff, d, C;
        hM := AsPresentationInHomalg( M );
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
                function( n )
                local hMn, hNn, hMn_, hNn_, iMn, iNn, l;
                hMn := HomogeneousPartOverCoefficientsRing( n, hM );
                hNn := HomogeneousPartOverCoefficientsRing( n, hN );
                G1 := GetGenerators( hMn );
                G2 := GetGenerators( hNn );
                if Length( G1 ) = 0 or Length( G2 ) = 0 then 
                    return ZeroMorphism( new_source[ n ], new_range[ n ] );
                fi;
                hMn_ := UnionOfRows( G1 )*S;
                hNn_ := UnionOfRows( G2 )*S;
                iMn := GradedPresentationMorphism( GradedFreeLeftPresentation( NrRows( hMn_ ), S, List( [1..NrRows( hMn_ ) ], i -> n ) ), hMn_, M );
                iNn := GradedPresentationMorphism( GradedFreeLeftPresentation( NrRows( hNn_ ), S, List( [1..NrRows( hNn_ ) ], i -> n ) ), hNn_, N );
                l := Lift( PreCompose( iMn, f ), iNn );
                return GradedPresentationMorphism( new_source[ n ], UnderlyingMatrix( l )*KoszulDualRing( S ), new_range[ n ] );
                end, 1 );
        return CochainMorphism( new_source, new_range, mors );
        end );

    return R;
end );

DeclareAttribute( "LFunctor", IsHomalgGradedRing );
InstallMethod( LFunctor, 
            [ IsHomalgGradedRing ],
    function( S )
    local cat_lp_ext, cat_lp_sym, cochains, ind_ext, ind_sym, L, KS, n; 

    n := Length( IndeterminatesOfPolynomialRing( S ) );
    KS := KoszulDualRing( S );
    ind_ext := IndeterminatesOfExteriorRing( KS );
    ind_sym := IndeterminatesOfPolynomialRing( S );
    
    cat_lp_sym := GradedLeftPresentations( S );
    cat_lp_ext := GradedLeftPresentations( KS );
    cochains := CochainComplexCategory( cat_lp_sym );

    L := CapFunctor( "L resolution ", cat_lp_ext, cochains );
    
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
        local M, N, G1, G2, hM, hN, mors;
        M := Source( f );
        N := Range( f );
        hM := AsPresentationInHomalg( M );
        hN := AsPresentationInHomalg( N );
        mors := MapLazy( IntegersList, 
                function( k )
                local hMn, hNn, hMn_, hNn_, iMn, iNn, l;
                hMn := HomogeneousPartOverCoefficientsRing( -k, hM );
                hNn := HomogeneousPartOverCoefficientsRing( -k, hN );
                G1 := GetGenerators( hMn );
                G2 := GetGenerators( hNn );
                if Length( G1 ) = 0 or Length( G2 ) = 0 then 
                    return ZeroMorphism( new_source[ k ], new_range[ k ] );
                fi;
                hMn_ := UnionOfRows( G1 )* KS;
                hNn_ := UnionOfRows( G2 )* KS;
                iMn := GradedPresentationMorphism( GradedFreeLeftPresentation( NrRows( hMn_ ), KS, List( [1..NrRows( hMn_ ) ], i -> -k ) ), hMn_, M );
                iNn := GradedPresentationMorphism( GradedFreeLeftPresentation( NrRows( hNn_ ), KS, List( [1..NrRows( hNn_ ) ], i -> -k ) ), hNn_, N );
                l := Lift( PreCompose( iMn, f ), iNn );
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
InstallMethod( TateResolution, 
                [ IsGradedLeftOrRightPresentation ],
    function( M )
    local cat, hM, diff, C;
    cat := GradedLeftPresentations( KoszulDualRing( UnderlyingHomalgRing( M ) ) );
    hM := AsPresentationInHomalg( M );
    diff := MapLazy( IntegersList, i -> 
        AsPresentationMorphismInCAP( CertainMorphism( TateResolution( hM, i, i + 1 ), i ) ), 1 );
    C := CochainComplex( cat , diff );
    SetCastelnuovoMumfordRegularity( C, CastelnuovoMumfordRegularity( M) );
    return C;
end );

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

    
