# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# Implementations
#
BindGlobal( "ADD_TRIANGULATED_STRUCTURE",
  
  function( stable_cat )
    
    SetFilterObj( stable_cat, IsTriangulatedCategory );

    AddShiftOnObject( stable_cat,
      function( a )
        local inf, def;
        
        a := UnderlyingCell( a );
        
        inf := InflationIntoSomeExactInjectiveObject( a );
        
        def := CompleteInflationToConflation( inf );
        
        return StableCategoryObject( stable_cat, Range( def ) );
        
    end );
      
    AddShiftOnMorphismWithGivenObjects( stable_cat,
      function( sigma_s, phi, sigma_r )
        local inf1, inf2, m;
        
        phi := UnderlyingCell( phi );
        
        inf1 := InflationIntoSomeExactInjectiveObject( Source( phi ) );
        
        inf2 := InflationIntoSomeExactInjectiveObject( Range( phi ) );
        
        m := ExactInjectiveColift( inf1, PreCompose( phi, inf2 ) );
        
        m := CokernelObjectFunctorial( inf1, m, inf2 );
        
        return StableCategoryMorphism( sigma_s, m, sigma_r );
        
    end );
      
    AddInverseShiftOnObject( stable_cat,
      function( a )
        local def, inf;
        
        a := UnderlyingCell( a );
        
        def := DeflationFromSomeExactProjectiveObject( a );
        
        inf := CompleteDeflationToConflation( def );
        
        return StableCategoryObject( stable_cat, Source( inf ) );
        
    end );
        
    AddInverseShiftOnMorphismWithGivenObjects( stable_cat,
      function( i_sigma_s, phi, i_sigma_r )
        local def1, def2, m;
        
        phi := UnderlyingCell( phi );
        
        def1 := DeflationFromSomeExactProjectiveObject( Source( phi ) );
        
        def2 := DeflationFromSomeExactProjectiveObject( Range( phi ) );
        
        m := ExactProjectiveLift( PreCompose( def1, phi ), def2 );
        
        m := KernelObjectFunctorial( def1, m, def2 );
        
        return StableCategoryMorphism( i_sigma_s, m, i_sigma_r );
        
    end );

    ##
    AddUnitIsomorphismWithGivenObject( stable_cat,
      
      function( _a_, shift_of_ishift_a )
        local a, def_1, inf_1, inf_2, def_2, m, i, p;
        
        a := UnderlyingCell( _a_ );
        
        def_1 := DeflationFromSomeExactProjectiveObject( a );
        
        inf_1 := CompleteDeflationToConflation( def_1 );
        
        inf_2 := InflationIntoSomeExactInjectiveObject( Source( inf_1 ) );
        
        def_2 := CompleteInflationToConflation( inf_2 );
                
        m := SchanuelsIsomorphism( inf_1, def_1, inf_2, def_2, "left" );
        
        i  := InjectionOfCofactorOfDirectSum( [ Source( def_2 ), Range( def_1 ) ], 2 );
        
        p := ProjectionInFactorOfDirectSum( [ Source( def_1 ), Range( def_2 ) ], 2 );
        
        return StableCategoryMorphism( _a_, PreCompose( [ i, m, p ] ), shift_of_ishift_a );
        
    end );
    
    ##
    AddInverseOfUnitIsomorphismWithGivenObject( stable_cat,
      
      function( _a_, shift_of_ishift_a )
        local a, def_1, inf_1, inf_2, def_2, m, i, p;
        
        a := UnderlyingCell( _a_ );
        
        def_1 := DeflationFromSomeExactProjectiveObject( a );
        
        inf_1 := CompleteDeflationToConflation( def_1 );
        
        inf_2 := InflationIntoSomeExactInjectiveObject( Source( inf_1 ) );
        
        def_2 := CompleteInflationToConflation( inf_2 );
                
        m := InverseForMorphisms( SchanuelsIsomorphism( inf_1, def_1, inf_2, def_2, "left" ) );
        
        i := InjectionOfCofactorOfDirectSum( [ Source( def_1 ), Range( def_2 ) ], 2 );
        
        p  := ProjectionInFactorOfDirectSum( [ Source( def_2 ), Range( def_1 ) ], 2 );
        
        return StableCategoryMorphism( shift_of_ishift_a, PreCompose( [ i, m, p ] ), _a_ );
        
    end );

    ##
    AddCounitIsomorphismWithGivenObject( stable_cat,
      
      function( _a_, ishift_of_shift_a )
        local shift_a, i_eta_a, inf_1, def_1, inf_2, def_2, i;
        
        shift_a := ShiftOnObject( _a_ );
        i_eta_a := InverseOfUnitIsomorphism( shift_a );
        i_eta_a := UnderlyingCell( i_eta_a );
        
        inf_1 := InflationIntoSomeExactInjectiveObject( UnderlyingCell( ishift_of_shift_a ) );
        def_1 := CompleteInflationToConflation( inf_1 );
        
        inf_2 := InflationIntoSomeExactInjectiveObject( UnderlyingCell( _a_ ) );
        def_2 := CompleteInflationToConflation( inf_2 );
        
        i := ExactProjectiveLift( PreCompose( def_1, i_eta_a ), def_2 );
        i := LiftAlongInflation( inf_2, PreCompose( inf_1, i ) );
        
        return StableCategoryMorphism( ishift_of_shift_a, i, _a_ );
        
    end );

    ##
    AddInverseOfCounitIsomorphismWithGivenObject( stable_cat,
      
      function( _a_, ishift_of_shift_a )
        local shift_a, eta_a, inf_1, def_1, inf_2, def_2, i;
        
        shift_a := ShiftOnObject( _a_ );
        
        eta_a := UnitIsomorphism( shift_a );
        eta_a := UnderlyingCell( eta_a );
        
        inf_1 := InflationIntoSomeExactInjectiveObject( UnderlyingCell( ishift_of_shift_a ) );
        def_1 := CompleteInflationToConflation( inf_1 );
        
        inf_2 := InflationIntoSomeExactInjectiveObject( UnderlyingCell( _a_ ) );
        def_2 := CompleteInflationToConflation( inf_2 );
        
        i := ExactProjectiveLift( PreCompose( def_2, eta_a ), def_1 );
        i := LiftAlongInflation( inf_1, PreCompose( inf_2, i ) );
        
        return StableCategoryMorphism( _a_, i, ishift_of_shift_a );
                
    end );
  
    ##
    AddStandardConeObject( stable_cat,
      function( alpha )
        local inf;
        
        alpha := UnderlyingCell( alpha );
        
        inf := InflationIntoSomeExactInjectiveObject( Source( alpha ) );
        
        return StableCategoryObject( stable_cat, ExactPushout( inf, alpha ) );
        
    end );
    
    ##
    AddMorphismToStandardConeObjectWithGivenStandardConeObject( stable_cat,
      function( alpha, r )
        local s, inf, m;
        
        s := Range( alpha );
        
        alpha := UnderlyingCell( alpha );
        
        inf := InflationIntoSomeExactInjectiveObject( Source( alpha ) );
        
        m := InjectionOfCofactorOfExactPushout( inf, alpha, 2 );
        
        return StableCategoryMorphism( s, m, r );
        
    end );

    ##
    AddMorphismFromStandardConeObjectWithGivenStandardConeObject( stable_cat,
      function( alpha, s )
        local inf, def, m, r;
        
        alpha := UnderlyingCell( alpha );
        
        inf := InflationIntoSomeExactInjectiveObject( Source( alpha ) );
        
        def := CompleteInflationToConflation( inf );
        
        m := UniversalMorphismFromExactPushout(
                      inf,
                      alpha,
                      def,
                      ZeroMorphism( Range( alpha ), Range( def ) )
                  );
        
        r := StableCategoryObject( stable_cat, Range( m ) );
        
        return StableCategoryMorphism( s, m, r );
        
    end );

    ##
    AddMorphismBetweenStandardConeObjectsWithGivenObjects( stable_cat,
      
      function( s, alpha, u, v, beta, r )
        local i_beta, z, inf_1, b, inf_2, l, i, m;
        
        i_beta := MorphismToStandardConeObject( beta );
        
        i_beta := UnderlyingCell( i_beta );
        
        u := UnderlyingCell( u );
        
        v := UnderlyingCell( v );
        
        alpha := UnderlyingCell( alpha );
        
        beta := UnderlyingCell( beta);
        
        z :=  PreCompose( alpha, v ) - PreCompose( u, beta );
        
        inf_1 := InflationIntoSomeExactInjectiveObject( Source( u ) );
        
        b := ColiftAlongInflationIntoSomeExactInjectiveObject( z );
        
        inf_2 := InflationIntoSomeExactInjectiveObject( Range( u ) );
        
        l := ExactInjectiveColift( inf_1, PreCompose( u, inf_2 ) );
        
        i := InjectionOfCofactorOfExactPushout( inf_2, beta, 1 );
        
        m := UniversalMorphismFromExactPushout(
                    inf_1,
                    alpha,
                    AdditionForMorphisms(
                        PreCompose( l, i ),
                        PreCompose( b, i_beta )
                    ),
                    PreCompose( v, i_beta )
                  );
        
        return StableCategoryMorphism( s, m, r );
        
    end );

##
AddWitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects( stable_cat,
  
  function( s, alpha, r )
    local i_alpha, p_alpha, c_alpha, inf_1, def_1, inf_2, def_2, psi, u, t, f;
     
    i_alpha := UnderlyingCell( MorphismToStandardConeObject( alpha ) );
    p_alpha := UnderlyingCell( MorphismFromStandardConeObject( alpha ) );
    
    c_alpha := UnderlyingCell( alpha );
    
    inf_1 := InflationIntoSomeExactInjectiveObject( Source( c_alpha ) );
    def_1 := CompleteInflationToConflation( inf_1 );
    
    inf_2 := InflationIntoSomeExactInjectiveObject( Range( c_alpha ) );
    def_2 := CompleteInflationToConflation( inf_2 );
    
    psi := UniversalMorphismFromExactPushout( 
                  inf_1,
                  c_alpha,
                  ColiftingMorphism( c_alpha ),
                  inf_2
               );
    
    u := UniversalMorphismFromExactPushout(
                inf_2,
                i_alpha, 
                InjectionOfCofactorOfDirectSum( [ Range( inf_2 ), Range( p_alpha ) ], 1 ),
                MorphismBetweenDirectSums( [ [ psi, p_alpha ] ] )
            );
    
    t := PreCompose(
              InjectionOfCofactorOfDirectSum( [ Range( inf_2 ), Range( p_alpha ) ], 2 ),
              InverseForMorphisms( u )
            );
    
    f := PreCompose(
              u,
              ProjectionInFactorOfDirectSum( [ Range( inf_2 ), Range( p_alpha ) ], 2 )
            );
    
    SetWitnessIsomorphismFromStandardConeObjectByRotationAxiom( alpha, StableCategoryMorphism( r, f, s ) );
    
    return StableCategoryMorphism( s, t, r );
    
end );

##
AddWitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects( stable_cat,
  
  function( s, alpha, r )
    local w;
    
    w := WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects( r, alpha, s );
    
    return WitnessIsomorphismFromStandardConeObjectByRotationAxiom( alpha );
    
end );

##
AddWitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( stable_cat,
  
  function( s, alpha, r )
    local A, counit_A, p_alpha, beta, lambda, inf, u, v, t;
    
    A := Source( alpha );
    counit_A := CounitIsomorphism( A ); 
    
    p_alpha := MorphismFromStandardConeObject( alpha );
    
    alpha := UnderlyingCell( alpha );
    A := UnderlyingCell( A );
    
    beta := PreCompose( AdditiveInverse( InverseShiftOnMorphism( p_alpha ) ), counit_A );
    beta := UnderlyingCell( beta );
    
    lambda := ColiftAlongInflationIntoSomeExactInjectiveObject( PreCompose( beta, alpha ) );
    
    inf := InflationIntoSomeExactInjectiveObject( Source( beta ) );
    
    u := MorphismBetweenDirectSums( [ [ ZeroMorphism( Range( inf ), Range( inf ) ), lambda ] ] );
    v := MorphismBetweenDirectSums( [ [ ZeroMorphism( A, Range( inf ) ),  alpha ] ] );
    
    t := UniversalMorphismFromExactPushout( inf, beta, u, v );
    
end );

##
AddWitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( stable_cat,
  
  function( s, alpha, r )
    local w;
    
    w := WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( r, alpha, s );
    
    return WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiom( alpha );
    
end );


#
#
####
#AddOctahedralAxiom( stable_cat, 
#    
#    function( sf, sg )
#    local sh, f, g, h, A, B, C, tf, u_A, alpha, f1, th, gamma, h1, D, conf_D, u_D, pi_D, TD, B_to_I_D, conf_B_to_I_D, beta, g1, I_D, B1, push_object_to_B1, conf_B,
#    I_B, T_B, u_B, beta_B, g_B, v_from, v_to, ctr_g_, iso, B1_TB, tr_g_, test1, test2, j, j1, u, u_, tr, E_TD, can_j, v;
#    sh := PreCompose( sf, sg );
#    f := UnderlyingCell( sf );
#    g := UnderlyingCell( sg );
#    h := UnderlyingCell( sh );
#    A := Source( f );
#    B := Range( f );
#    C := Range( g );
#
#    tf := StandardExactTriangle( sf );
#    u_A := InflationIntoSomeExactInjectiveObject( A )^0;
#    alpha :=  InjectionOfCofactorOfExactPushout( [ u_A, f ], 1);
#    f1 := UnderlyingCell( tf^1 );
#
#    th := StandardExactTriangle( sh );
#    gamma := InjectionOfCofactorOfExactPushout( [ u_A, h ] , 1 );
#    h1 := UnderlyingCell( th^1 );
#
#    D := UnderlyingCell( tf[ 2 ] );
#    conf_D := InflationIntoSomeExactInjectiveObject( D );
#    u_D := conf_D^0;
#    pi_D := conf_D^1;
#    TD := conf_D[ 2 ];
#
#    B_to_I_D := PreCompose( f1, u_D );
#    conf_B_to_I_D := ConflationOfInflation( B_to_I_D );
#    beta := InjectionOfCofactorOfExactPushout( [ B_to_I_D, g ], 1 );
#    g1 := InjectionOfCofactorOfExactPushout( [ B_to_I_D, g ], 2 );
#
#    I_D := conf_B_to_I_D[ 1 ];
#    B1 := conf_B_to_I_D[ 2 ];
#
#    push_object_to_B1 := UniversalMorphismFromExactPushout( [ B_to_I_D, g ], [ conf_B_to_I_D^1, ZeroMorphism( C, B1 ) ] );
#
#    conf_B := InflationIntoSomeExactInjectiveObject( B );
#    I_B := conf_B[ 1 ];
#    T_B := conf_B[ 2 ];
#    u_B := conf_B^0;
#    beta_B := InjectionOfCofactorOfExactPushout( [ u_B, g ], 1 );
#    g_B := InjectionOfCofactorOfExactPushout( [ u_B, g ], 2 );    
#    v_from := AsStableMorphism( UniversalMorphismFromExactPushout( [ u_B, g ], [ PreCompose( ExactInjectiveColift( u_B, B_to_I_D ), beta ), g1 ] ) );
#    v_to :=   AsStableMorphism( UniversalMorphismFromExactPushout( [ B_to_I_D, g ], [ PreCompose( ExactInjectiveColift( B_to_I_D, u_B ), beta_B ), g_B ] ) );
#    ctr_g_ := StandardExactTriangle( sg );
#
#    iso := SchanuelsIsomorphism(  conf_B_to_I_D, conf_B, "left" );
#    B1_TB := AdditiveInverseForMorphisms( PreCompose( [ InjectionOfCofactorOfDirectSum( [ I_B, B1 ], 2 ), 
#                           iso,
#                           ProjectionInFactorOfDirectSum( [ I_D, T_B ], 2 ) ] ) );
#
#    tr_g_ := CreateExactTriangle( sg,
#                                 AsStableMorphism( g1 ),
#                                 AsStableMorphism(PreCompose( push_object_to_B1, B1_TB ) ) );
#
#    test1 := CreateTrianglesMorphism( ctr_g_, tr_g_, IdentityMorphism( ctr_g_[0]), IdentityMorphism( ctr_g_[1]), v_from );
#    test2 := CreateTrianglesMorphism( tr_g_, ctr_g_, IdentityMorphism( ctr_g_[0]), IdentityMorphism( ctr_g_[1]), v_to );
#
#    j := UniversalMorphismFromExactPushout( [ u_A, f ], [ gamma, PreCompose( g, h1 ) ] );
#    j1 := UniversalMorphismFromExactPushout( [ u_A, h ], [ PreCompose( [ alpha, u_D, beta ] ), g1 ] );
#
#    E_TD := UniversalMorphismFromExactPushout( [ B_to_I_D, g ], [ pi_D, ZeroMorphism( C, TD ) ] );
#    tr := CreateExactTriangle( AsStableMorphism( j ),
#                                 PreCompose( AsStableMorphism( j1 ), v_to ),
#                                 PreCompose( v_from, AsStableMorphism( E_TD ) ) );
#    u := AsStableMorphism( UniversalMorphismFromExactPushout( [ u_D, j ], [ beta, j1 ] ) );
#    u_ := AsStableMorphism( UniversalMorphismFromExactPushout( [ B_to_I_D, g ], 
#                        [ InjectionOfCofactorOfExactPushout( [ u_D, j ], 1 ), PreCompose( h1, InjectionOfCofactorOfExactPushout( [ u_D, j ], 2 ) )  ] ) );
#    can_j := StandardExactTriangle( AsStableMorphism( j ) );
#    SetIsomorphismFromStandardExactTriangle( tr, CreateTrianglesMorphism( can_j, tr, IdentityMorphism( tr[0] ), IdentityMorphism( tr[1] ), PreCompose(u, v_to) ) );
#    SetIsomorphismIntoStandardExactTriangle( tr, CreateTrianglesMorphism( tr, can_j, IdentityMorphism( tr[0] ), IdentityMorphism( tr[1] ), PreCompose(v_from, u_ ) ) );
#
#    return tr; 
#    end );
    
end );


#    ## The computer suggests this is really a counit, however, I can not prove it. (triangles identities)
#    AddCounitIsomorphismWithGivenObject( stable_cat,
#      
#      function( _a_, ishift_of_shift_a )
#        local a, inf_1, def_1, def_2, inf_2, m, i, p;
#        
#        a := UnderlyingCell( _a_ );
#        
#        inf_1 := InflationIntoSomeExactInjectiveObject( a );
#        
#        def_1 := CompleteInflationToConflation( inf_1 );
#        
#        def_2 := DeflationFromSomeExactProjectiveObject( Range( def_1 ) );
#        
#        inf_2 := CompleteDeflationToConflation( def_2 );
#                
#        m := SchanuelsIsomorphism( inf_2, def_2, inf_1, def_1, "right" );
#        
#        i := InjectionOfCofactorOfDirectSum( [ Source( inf_2 ), Range( inf_1 ) ], 1 );
#        
#        p := ProjectionInFactorOfDirectSum( [ Source( inf_1 ), Range( inf_2 ) ], 1 );
#        
#        return StableCategoryMorphism( ishift_of_shift_a, PreCompose( [ i, m, p ] ), _a_ );
#        
#    end );
#    ##
#    AddInverseOfCounitIsomorphismWithGivenObject( stable_cat,
#      
#      function( _a_, ishift_of_shift_a )
#        local a, inf_1, def_1, def_2, inf_2, m, i, p;
#        
#        a := UnderlyingCell( _a_ );
#        
#        inf_1 := InflationIntoSomeExactInjectiveObject( a );
#        
#        def_1 := CompleteInflationToConflation( inf_1 );
#        
#        def_2 := DeflationFromSomeExactProjectiveObject( Range( def_1 ) );
#        
#        inf_2 := CompleteDeflationToConflation( def_2 );
#        
#        m := InverseForMorphisms( SchanuelsIsomorphism( inf_2, def_2, inf_1, def_1, "right" ) );
#        
#        i := InjectionOfCofactorOfDirectSum( [ Source( inf_1 ), Range( inf_2 ) ], 1 );
#        
#        p := ProjectionInFactorOfDirectSum( [ Source( inf_2 ), Range( inf_1 ) ], 1 );
#        
#        return StableCategoryMorphism( _a_, PreCompose( [ i, m, p ] ), ishift_of_shift_a );
#        
#    end );

