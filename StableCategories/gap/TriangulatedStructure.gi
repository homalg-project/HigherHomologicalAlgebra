# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# Implementations
#

BindGlobal( "ADD_TRIANGULATED_STRUCTURE",
  
  function( stable_cat )
    
    SetFilterObj( stable_cat, IsTriangulatedCategory );
    
    ##
    AddShiftOnObject( stable_cat,
      function( A )
        local iota, shift_A;
        
        A := UnderlyingCell( A );
        
        iota := InflationIntoSomeExactInjectiveObject( A );
        
        shift_A := ExactCokernelObject( iota );
        
        return StableCategoryObject( stable_cat, shift_A );
        
    end );
    
    ##
    AddShiftOnMorphismWithGivenObjects( stable_cat,
      function( shift_s, phi, shift_r )
        local iota_1, iota_2, nu;
        
        phi := UnderlyingCell( phi );
        
        iota_1 := InflationIntoSomeExactInjectiveObject( Source( phi ) );
        
        iota_2 := InflationIntoSomeExactInjectiveObject( Range( phi ) );
        
        nu := ExactInjectiveColift( iota_1, PreCompose( phi, iota_2 ) );
        
        nu := ExactCokernelObjectFunctorial( iota_1, nu, iota_2 );
        
        return StableCategoryMorphism( shift_s, nu, shift_r );
        
    end );
     
    ##
    AddInverseShiftOnObject( stable_cat,
      function( A )
        local pi, K;
        
        A := UnderlyingCell( A );
        
        pi := DeflationFromSomeExactProjectiveObject( A );
        
        K := ExactKernelObject( pi );
        
        return StableCategoryObject( stable_cat, K );
        
    end );
    
    ##
    AddInverseShiftOnMorphismWithGivenObjects( stable_cat,
      function( i_shift_s, phi, i_shift_r )
        local pi_1, pi_2, mu;
        
        phi := UnderlyingCell( phi );
        
        pi_1 := DeflationFromSomeExactProjectiveObject( Source( phi ) );
        
        pi_2 := DeflationFromSomeExactProjectiveObject( Range( phi ) );
        
        mu := ExactProjectiveLift( PreCompose( pi_1, phi ), pi_2 );
        
        mu := ExactKernelObjectFunctorial( pi_1, mu, pi_2 );
        
        return StableCategoryMorphism( i_shift_s, mu, i_shift_r );
        
    end );
    
    ##
    AddUnitIsomorphismWithGivenObject( stable_cat,
      
      function( A, shift_of_ishift_A )
        local cell_A, pi_1, iota_1, iota_2, pi_2, m, i, p;
        
        cell_A := UnderlyingCell( A );
        
        pi_1 := DeflationFromSomeExactProjectiveObject( cell_A );
        
        iota_1 := ExactKernelEmbedding( pi_1 );
        
        iota_2 := InflationIntoSomeExactInjectiveObject( Source( iota_1 ) );
        
        pi_2 := ExactCokernelProjection( iota_2 );
        
        m := SchanuelsIsomorphismByInflationsIntoSomeExactInjectiveObjects( iota_1, pi_1, iota_2, pi_2 );
        
        i  := InjectionOfCofactorOfDirectSum( [ Source( pi_2 ), Range( pi_1 ) ], 2 );
        
        p := ProjectionInFactorOfDirectSum( [ Source( pi_1 ), Range( pi_2 ) ], 2 );
        
        return StableCategoryMorphism( A, PreCompose( [ i, m, p ] ), shift_of_ishift_A );
        
    end );
    
    ##
    AddInverseOfUnitIsomorphismWithGivenObject( stable_cat,
      
      function( A, shift_of_ishift_A )
        local cell_A, pi_1, iota_1, iota_2, pi_2, m, i, p;
        
        cell_A := UnderlyingCell( A );
        
        pi_1 := DeflationFromSomeExactProjectiveObject( cell_A );
        
        iota_1 := ExactKernelEmbedding( pi_1 );
        
        iota_2 := InflationIntoSomeExactInjectiveObject( Source( iota_1 ) );
        
        pi_2 := ExactCokernelProjection( iota_2 );
                
        m := SchanuelsIsomorphismByInflationsIntoSomeExactInjectiveObjects( iota_2, pi_2, iota_1, pi_1 );
        
        i := InjectionOfCofactorOfDirectSum( [ Source( pi_1 ), Range( pi_2 ) ], 2 );
        
        p  := ProjectionInFactorOfDirectSum( [ Source( pi_2 ), Range( pi_1 ) ], 2 );
        
        return StableCategoryMorphism( shift_of_ishift_A, PreCompose( [ i, m, p ] ), A );
        
    end );

    ##
    AddCounitIsomorphismWithGivenObject( stable_cat,
      
      function( A, ishift_of_shift_A )
        local shift_A, i_eta_A, iota_1, pi_1, iota_2, pi_2, i;
        
        shift_A := ShiftOnObject( A );
        
        i_eta_A := InverseOfUnitIsomorphism( shift_A );
        
        i_eta_A := UnderlyingCell( i_eta_A );
        
        iota_1 := InflationIntoSomeExactInjectiveObject( UnderlyingCell( ishift_of_shift_A ) );
        
        pi_1 := ExactCokernelProjection( iota_1 );
        
        iota_2 := InflationIntoSomeExactInjectiveObject( UnderlyingCell( A ) );
        
        pi_2 := ExactCokernelProjection( iota_2 );
        
        i := ExactProjectiveLift( PreCompose( pi_1, i_eta_A ), pi_2 );
        
        i := LiftAlongInflation( iota_2, PreCompose( iota_1, i ) );
        
        return StableCategoryMorphism( ishift_of_shift_A, i, A );
        
    end );

    ##
    AddInverseOfCounitIsomorphismWithGivenObject( stable_cat,
      
      function( A, ishift_of_shift_A )
        local shift_A, eta_A, iota_1, pi_1, iota_2, pi_2, i;
        
        shift_A := ShiftOnObject( A );
        
        eta_A := UnitIsomorphism( shift_A );
        
        eta_A := UnderlyingCell( eta_A );
        
        iota_1 := InflationIntoSomeExactInjectiveObject( UnderlyingCell( ishift_of_shift_A ) );
        
        pi_1 := ExactCokernelProjection( iota_1 );
        
        iota_2 := InflationIntoSomeExactInjectiveObject( UnderlyingCell( A ) );
        
        pi_2 := ExactCokernelProjection( iota_2 );
        
        i := ExactProjectiveLift( PreCompose( pi_2, eta_A ), pi_1 );
        
        i := LiftAlongInflation( iota_1, PreCompose( iota_2, i ) );
        
        return StableCategoryMorphism( A, i, ishift_of_shift_A );
        
    end );
    
    ##
    AddStandardConeObject( stable_cat,
      function( alpha )
        local iota, cone;
        
        alpha := UnderlyingCell( alpha );
        
        iota := InflationIntoSomeExactInjectiveObject( Source( alpha ) );
        
        cone := ExactPushout( iota, alpha );
        
        return StableCategoryObject( stable_cat, cone );
        
    end );
    
    ##
    AddMorphismToStandardConeObjectWithGivenStandardConeObject( stable_cat,
      function( alpha, cone )
        local B, iota, q_B;
        
        B := Range( alpha );
        
        alpha := UnderlyingCell( alpha );
        
        iota := InflationIntoSomeExactInjectiveObject( Source( alpha ) );
        
        q_B := InjectionOfSecondCofactorOfExactPushout( iota, alpha );
        
        return StableCategoryMorphism( B, q_B, cone );
        
    end );
    
    ##
    AddMorphismFromStandardConeObjectWithGivenStandardConeObject( stable_cat,
      function( alpha, cone )
        local iota, pi, u, shift_A;
        
        alpha := UnderlyingCell( alpha );
        
        iota := InflationIntoSomeExactInjectiveObject( Source( alpha ) );
        
        pi := ExactCokernelProjection( iota );
        
        u := UniversalMorphismFromExactPushout(
                      iota,
                      alpha,
                      pi,
                      ZeroMorphism( Range( alpha ), Range( pi ) )
                  );
        
        shift_A := StableCategoryObject( stable_cat, Range( u ) );
        
        return StableCategoryMorphism( cone, u, shift_A );
        
    end );
    
    ##
    AddMorphismBetweenStandardConeObjectsWithGivenObjects( stable_cat,
      
      function( cone_alpha, alpha, u, v, beta, cone_beta )
        local i_beta, z, iota_1, b, iota_2, c, i;
        
        i_beta := MorphismToStandardConeObject( beta );
        
        i_beta := UnderlyingCell( i_beta );
        
        u := UnderlyingCell( u );
        
        v := UnderlyingCell( v );
        
        alpha := UnderlyingCell( alpha );
        
        beta := UnderlyingCell( beta);
        
        z :=  PreCompose( alpha, v ) - PreCompose( u, beta );
        
        iota_1 := InflationIntoSomeExactInjectiveObject( Source( u ) );
        
        b := ColiftAlongInflationIntoSomeExactInjectiveObject( z );
        
        iota_2 := InflationIntoSomeExactInjectiveObject( Range( u ) );
        
        c := ExactInjectiveColift( iota_1, PreCompose( u, iota_2 ) );
        
        i := InjectionOfFirstCofactorOfExactPushout( iota_2, beta );
        
        u := UniversalMorphismFromExactPushout(
                    iota_1,
                    alpha,
                    AdditionForMorphisms(
                        PreCompose( c, i ),
                        PreCompose( b, i_beta )
                    ),
                    PreCompose( v, i_beta )
                  );
        
        return StableCategoryMorphism( cone_alpha, u, cone_beta );
        
    end );

    ##
    AddWitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects( stable_cat,
      
      function( shift_A, alpha, cone_i_alpha )
        local i_alpha, p_alpha, cell_alpha, iota_1, pi_1, iota_2, pi_2, psi, u, t, f;
        
        i_alpha := MorphismToStandardConeObject( alpha );
        
        i_alpha := UnderlyingCell( i_alpha );
         
        p_alpha := MorphismFromStandardConeObject( alpha );
        
        p_alpha := UnderlyingCell( p_alpha );
        
        cell_alpha := UnderlyingCell( alpha );
        
        iota_1 := InflationIntoSomeExactInjectiveObject( Source( cell_alpha ) );
        
        pi_1 := ExactCokernelProjection( iota_1 );
        
        iota_2 := InflationIntoSomeExactInjectiveObject( Range( cell_alpha ) );
        
        pi_2 := ExactCokernelProjection( iota_2 );
        
        psi := UniversalMorphismFromExactPushout(
                      iota_1,
                      cell_alpha,
                      ColiftingMorphism( cell_alpha ),
                      iota_2
                   );
        
        u := UniversalMorphismFromExactPushout(
                    iota_2,
                    i_alpha,
                    InjectionOfCofactorOfDirectSum(
                        [ Range( iota_2 ), Range( p_alpha ) ],
                        1
                      ),
                    MorphismBetweenDirectSums(
                        [ [ psi, p_alpha ] ]
                      )
                );
        
        t := PreCompose(
                  InjectionOfCofactorOfDirectSum( [ Range( iota_2 ), Range( p_alpha ) ], 2 ),
                  InverseForMorphisms( u )
                );
        
        f := PreCompose(
                  u,
                  ProjectionInFactorOfDirectSum( [ Range( iota_2 ), Range( p_alpha ) ], 2 )
                );
        
        SetWitnessIsomorphismFromStandardConeObjectByRotationAxiom( alpha, StableCategoryMorphism( cone_i_alpha, f, shift_A ) );
        
        return StableCategoryMorphism( shift_A, t, cone_i_alpha );
        
    end );
    
    ##
    AddWitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects( stable_cat,
      
      function( cone_i_alpha, alpha, shift_A )
        local w;
        
        w := WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects( shift_A, alpha, cone_i_alpha );
        
        return WitnessIsomorphismFromStandardConeObjectByRotationAxiom( alpha );
        
    end );
        
    ##
    AddDomainMorphismByOctahedralAxiomWithGivenObjects( stable_cat,
      function( cone_f, f, g, h, cone_h )
        local iota_h, i_A, theta, gamma, u;
        
        iota_h := MorphismToStandardConeObject( h );
        
        iota_h := UnderlyingCell( iota_h );
        
        f := UnderlyingCell( f );
        
        g := UnderlyingCell( g );
       
        h := UnderlyingCell( h );
        
        i_A := InflationIntoSomeExactInjectiveObject( Source( f ) );
                
        theta := ColiftAlongInflationIntoSomeExactInjectiveObject( PreCompose( f, g ) - h ); 
        
        gamma := InjectionOfFirstCofactorOfExactPushout( i_A, h );
        
        u := UniversalMorphismFromExactPushout(
                    i_A,
                    f,
                    gamma + PreCompose( theta, iota_h ),
                    PreCompose( g, iota_h )
              );
        
        return StableCategoryMorphism( cone_f, u, cone_h );
        
    end );
    
    AddMorphismToConeObjectByOctahedralAxiomWithGivenObjects( stable_cat,
      function( cone_h, f, g, h, cone_g )
        local iota_g, theta, i_A, i_B, i_f, lambda, u;
        
        iota_g := MorphismToStandardConeObject( g );
        
        iota_g := UnderlyingCell( iota_g );
        
        f := UnderlyingCell( f );
        
        g := UnderlyingCell( g );
       
        h := UnderlyingCell( h );
        
        theta := ColiftAlongInflationIntoSomeExactInjectiveObject( PreCompose( f, g ) - h );
        
        i_A := InflationIntoSomeExactInjectiveObject( Source( f ) );
        
        i_B := InflationIntoSomeExactInjectiveObject( Range( f ) );
        
        i_f := ExactInjectiveColift(
                      i_A,
                      PreCompose( f, i_B )
                    );
        
        lambda := InjectionOfFirstCofactorOfExactPushout( i_B, g );
        
        u := UniversalMorphismFromExactPushout(
                 i_A,
                 h,
                 PreCompose( i_f, lambda ) - PreCompose( theta, iota_g ),
                 iota_g
              );
        
        return StableCategoryMorphism( cone_h, u, cone_g );
        
    end );
    
    ##
    AddMorphismFromConeObjectByOctahedralAxiomWithGivenObjects( stable_cat,
      function( cone_g, f, g, h, shift_cone_f )
        local cone_f, iota_f, A, B, C, i_A, i_B, i_cone_f, p_cone_f, mu, u;
        
        cone_f := StandardConeObject( f );
        
        cone_f := UnderlyingCell( cone_f );
        
        iota_f := MorphismToStandardConeObject( f );
        
        iota_f := UnderlyingCell( iota_f );
               
        f := UnderlyingCell( f );
        
        g := UnderlyingCell( g );
       
        A := Source( f );
        
        B := Range( f );
        
        C := Range( g );

        i_A := InflationIntoSomeExactInjectiveObject( A );
        
        i_B := InflationIntoSomeExactInjectiveObject( B );
        
        i_cone_f := InflationIntoSomeExactInjectiveObject( cone_f );
        
        p_cone_f := ExactCokernelProjection( i_cone_f );
        
        mu := ExactInjectiveColift(
                  i_B,
                  PreCompose( iota_f, i_cone_f )
                );
        
        u := UniversalMorphismFromExactPushout(
                  i_B,
                  g,
                  PreCompose( mu, p_cone_f ),
                  ZeroMorphism( C, UnderlyingCell( shift_cone_f ) )
                );
        
        return StableCategoryMorphism( cone_g, u, shift_cone_f );
        
    end );
    
    ##
    AddWitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects( stable_cat,
      function( cone_g, f, g, h, cone_u )
        local u, cone_f, i_cone_f, iota_f, iota_h, B, i_B, xi, mu, m, n, iso, eta;
        
        u := DomainMorphismByOctahedralAxiom( f, g, h );
        
        u := UnderlyingCell( u );

        cone_f := StandardConeObject( f );
        
        cone_f := UnderlyingCell( cone_f );
        
        i_cone_f := InflationIntoSomeExactInjectiveObject( cone_f );
        
        iota_f := MorphismToStandardConeObject( f );
        
        iota_f := UnderlyingCell( iota_f );
        
        iota_h := MorphismToStandardConeObject( h );
        
        iota_h := UnderlyingCell( iota_h );
        
        f := UnderlyingCell( f );
        
        g := UnderlyingCell( g );
        
        B := Range( f );
        
        i_B := InflationIntoSomeExactInjectiveObject( B );
         
        xi := InjectionOfFirstCofactorOfExactPushout( i_cone_f, u );
        
        mu := ExactInjectiveColift(
                  i_B,
                  PreCompose( iota_f, i_cone_f )
              );
        
        m := PreCompose( mu, xi );
        
        eta := InjectionOfSecondCofactorOfExactPushout( i_cone_f, u );
        
        n := PreCompose( [ iota_h, eta ] );
        
        iso := UniversalMorphismFromExactPushout( i_B, g, m, n );
        
        return StableCategoryMorphism( cone_g, iso, cone_u );
        
    end );
    
#    ##
#    AddWitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( stable_cat,
#      function( cone_u, f, g, h, cone_g )
#        local u, v, cone_f, i_cone_f, iota_f, B, i_B, lambda, mu, m, iso;
#        
#        u := DomainMorphismByOctahedralAxiom( f, g, h );
#        
#        u := UnderlyingCell( u );
#
#        v := MorphismToConeObjectByOctahedralAxiom( f, g, h );
#        
#        v := UnderlyingCell( v );
#        
#        cone_f := StandardConeObject( f );
#        
#        cone_f := UnderlyingCell( cone_f );
#        
#        i_cone_f := InflationIntoSomeExactInjectiveObject( cone_f );
#        
#        iota_f := MorphismToStandardConeObject( f );
#        
#        iota_f := UnderlyingCell( iota_f );
#        
#        f := UnderlyingCell( f );
#        
#        g := UnderlyingCell( g );
#        
#        B := Range( f );
#        
#        i_B := InflationIntoSomeExactInjectiveObject( B );
#         
#        lambda := InjectionOfFirstCofactorOfExactPushout( i_B, g );
#        
#        mu := ExactInjectiveColift(
#                  PreCompose( iota_f, i_cone_f ),
#                  i_B
#              );
#        
#        m := PreCompose( mu, lambda );
#         
#        iso := UniversalMorphismFromExactPushout( i_cone_f, u, m, v );
#        
#        return StableCategoryMorphism( cone_u, iso, cone_g );
#        
#    end );
   
end );
