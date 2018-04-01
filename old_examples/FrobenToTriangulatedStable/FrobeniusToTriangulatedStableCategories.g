

BindGlobal( "COMPUTE_TRIANGULATED_STRUCTURE_OF_A_stable_cat_OF_A_FROBENIUS_CATEGORY", 

    function( stable_cat )
    
    # Here we start computing the triangulated structure
    
    # Adding the shift of objects method 
    
    # We fit the object obj into a conflation using injective object:   obj --------> I --------> M
    # Then we define ShiftOfObject( obj ) := M

SetIsTriangulatedCategory( stable_cat, true );

AddShiftOfObject( stable_cat, 
    function( stable_obj )
    local obj, conf;
    
    obj := UnderlyingUnstableObject( stable_obj );
    
    conf := FitIntoConflationUsingExactInjectiveObject( obj );
    
    return AsStableObject( ObjectAt( conf, 2 ) );
    
    end );
   
   # Adding the shift of morphisms method
   
   # Remember : That I is injective object when every morphism f : X → I factors through every mono X → Y.
   # the complement morphism is InjectiveColift( mono, f ).
   
   # mor: A -----> B
   
   #  conf_A:     A -------> I(A) ------> T(A)
   #              |           |             |
   #          mor |      mor1 |             | mor2
   #              V           V             V
   #  conf_B:     B -------> I(B) ------> T(B)
   
AddShiftOfMorphism( stable_cat, 
    function( stable_mor )
    local A, B, conf_A, conf_B, mor, mor1, mor2;
    
    mor := UnderlyingUnstableMorphism( stable_mor );
    
    A := Source( mor );
    
    B := Range( mor );
    
    conf_A := FitIntoConflationUsingExactInjectiveObject( A );
    
    conf_B := FitIntoConflationUsingExactInjectiveObject( B );
    
    mor1 := ExactInjectiveColift( MorphismAt( conf_A, 0 ) , PreCompose( mor, MorphismAt( conf_B, 0 ) ) );
    
    mor2 :=  CokernelColift( MorphismAt( conf_A, 0 ), PreCompose( mor1, MorphismAt( conf_B, 1 ) ) );
    
    return AsStableMorphism( mor2 );
    
    end );
                                     
   
    # Adding the reverse shift of objects method 
    
    # We fit the given object obj into a conflation using projective object:  M --------> P --------> obj.
    # Then we define ReverseShiftOfObject( obj ) := M
   
AddReverseShiftOfObject( stable_cat, 
    function( stable_obj )
    local obj, conf;
    
    obj := UnderlyingUnstableObject( stable_obj );
    
    conf := FitIntoConflationUsingExactProjectiveObject( obj );
    
    return AsStableObject( ObjectAt( conf, 0 ) );
    
    end );
                                             
   
   # Adding the  reverse shift of morphisms method
   
   # Remember : That P is projective object when every morphism f : P → X factors through every epi Y → X.
   # the complement morphism is ProjectiveLift( f, epi ).
   
   # mor0: A -----> B
   
   #  conf_A:    S(A) -------> P(A) --------> A
   #              |             |             |
   #         mor2 |        mor1 |             | mor
   #              V             V             V
   #  conf_B:    S(B) -------> P(B) --------> B
   
AddReverseShiftOfMorphism( stable_cat, 
    function( stable_mor )
    local A, B, conf_A, conf_B, mor, mor1, mor2;

    mor := UnderlyingUnstableMorphism( stable_mor );
    
    A := Source( mor );
    
    B := Range( mor );
    
    conf_A := FitIntoConflationUsingExactProjectiveObject( A );
    
    conf_B := FitIntoConflationUsingExactProjectiveObject( B );
    
    mor1 := ExactProjectiveLift( PreCompose( MorphismAt( conf_A, 1 ), mor ), MorphismAt( conf_B, 1 ) );
    
    mor2 := KernelLift( MorphismAt( conf_B, 1 ), PreCompose( MorphismAt( conf_A, 0 ), mor1 ) );
    
    return AsStableMorphism( mor2 );
    
    end );
                                       
# \begin{tikzcd}
# conf(obj): & S(obj) \arrow[r, "inf1"] \arrow[d, "inf2"'] & P(obj) \arrow[r] \arrow[d] \arrow[rd] \arrow[dd, dotted, bend left] & obj &  & obj \arrow[d, "inj_{obj}"'] & IS(obj) \arrow[ld, "inj_{S(obj)}"] \\
#  & I(S(obj)) \arrow[d] \arrow[r, "u1"'] \arrow[rr, dotted, bend right] \arrow[rd] \arrow[rrrrru, "=", bend left] & Push \arrow[r, "h1", dashed] \arrow[d, "h2"', dashed] \arrow[l, "v1"', bend right] \arrow[rrr, "\alpha"', bend right=49] & obj \arrow[rru, "="] &  & IS(obj)+obj \arrow[lll, "\alpha^{-1}", bend left=60] &  \\
#  & TS(obj) & TS(obj) &  &  &  & 
# \end{tikzcd}
AddIsomorphismIntoShiftOfReverseShift( stable_cat, 
               
    function( stable_obj )
    local obj, conf_obj, S_obj, conf_S_obj, TS_obj, inf1, inf2, h1, h2, mor, u1, v1, I_S_obj, 
    injection_obj, injection_I_S_obj, inverse_alpha, inverse_h1, alpha; 
    
    obj := UnderlyingUnstableObject( stable_obj );
    
    conf_obj := FitIntoConflationUsingExactProjectiveObject( obj );
    
    S_obj := ObjectAt( conf_obj, 0 );
    
    conf_S_obj := FitIntoConflationUsingExactInjectiveObject( S_obj );
    
    TS_obj := ObjectAt( conf_S_obj, 2 );
    
    inf1 := MorphismAt( conf_obj, 0 );
    
    inf2 := MorphismAt( conf_S_obj, 0 );
    
    h1 := UniversalMorphismFromExactPushout( [ inf1, inf2 ], [ MorphismAt( conf_obj, 1 ), ZeroMorphism( ObjectAt( conf_S_obj, 1 ), obj ) ] );
    
    h2 := UniversalMorphismFromExactPushout( [ inf1, inf2 ], [ ZeroMorphism( ObjectAt( conf_obj, 1 ), TS_obj ), MorphismAt( conf_S_obj, 1 ) ] );
    
    u1 := InjectionOfCofactorOfExactPushout( [ inf1, inf2 ], 2 );
    
    I_S_obj := ObjectAt( conf_S_obj, 1 );
    
    injection_I_S_obj := InjectionOfCofactorOfDirectSum( [ I_S_obj, obj ], 1 );
    
    injection_obj  := InjectionOfCofactorOfDirectSum( [ I_S_obj, obj ], 2 );
    
    v1 := ExactInjectiveColift( u1, IdentityMorphism( I_S_obj ) );
    
    alpha := PreCompose( v1, injection_I_S_obj ) + PreCompose( h1, injection_obj );
    
    inverse_alpha := Inverse( alpha );
    
    inverse_h1 := PreCompose( injection_obj, inverse_alpha );
    
    mor := AdditiveInverseForMorphisms( PreCompose( inverse_h1, h2 ) );
    
    return AsStableMorphism( mor );
    
    end );
    

  # Standard triangles are of the form  
  #       A -------> B -------> C ----------> T( A )
  # where  C = PushoutObject( B, I ) where A ----> I ----> T( A ) is a conflation.
  
  # Adding TR1, 
  # It states that every morphism f: A ---> B can be completed to an exact triangle.
  
AddCompleteMorphismToCanonicalExactTriangle( stable_cat,
         
    function( stable_mor )
    local mor, A, B, conf_A, inf, mor1, mor2;
    
    mor := UnderlyingUnstableMorphism( stable_mor );
    
    A := Source( mor );
                        
    B := Range( mor );
                        
    conf_A := FitIntoConflationUsingExactInjectiveObject( A );                             
    
    inf := MorphismAt( conf_A, 0);
    
    mor1 := InjectionOfCofactorOfExactPushout( [ inf, mor ], 2 );
    
    mor2 := UniversalMorphismFromExactPushout( 
                       [ inf, mor ], 
                       [ MorphismAt( conf_A, 1 ), ZeroMorphism( Range( mor ), ObjectAt( conf_A, 2 ) ) ] );
    
    return CreateCanonicalExactTriangle( stable_mor,
                                AsStableMorphism( mor1 ),
                                AsStableMorphism( mor2 ) );
    end );

         
  # Adding TR3
  # Input is two triangles tr1, tr2 and two morphisms u, v such that vf1 = g1u.
  #
  #             f1_              g1_              h1_
  # tr1  :  A1 ---------> B1 ----------> C1 ------------> T( A1 )
  #         |             |              |                |
  #    phi_ |        psi_ |              | ?              | T( phi_ )
  #         V             V              V                V
  # tr2  :  A2 ---------> B2-----------> C2 ------------> T( A2 )
  #             f2_             g2_               h2_
  #
  # Output is theta: C1 ---> C2 such that the diagram is commutative
  
  AddCompleteToMorphismOfExactTriangles( stable_cat, 
  
       function( tr1, tr2, phi_, psi_ )
       local f1_, f2_, g2_, f2_after_phi_minus_psi_after_f1_, u1, beta,
       u2, phi, phi1, f2, alpha2, f1, g2, psi, mor;
       
       f1_ := tr1!.morphism1;
       
       f2_ := tr2!.morphism1;
       
       g2_ := tr2!.morphism2;
       
       # since all morphisms in first square commute, it follows that the morphism:
       
       f2_after_phi_minus_psi_after_f1_ := UnderlyingMorphismOfTheStableMorphism( PreCompose( phi_, f2_ ) - PreCompose( f1_, psi_ ) );
       
       # is zero in the stable category, and hence factors through an injective object. Using univeral property of 
       # injective objects we can assume that the morphism should also factor through I, that was used to
       # construct tr1.
       
       u1 := Genesis( UnderlyingObjectOfTheStableObject( tr1!.object3 ) )!.PushoutObjectInducedByStructureOfExactCategory[ 1 ];
       
       # There is beutifull mathematical theory behind this.
       beta := Colift( u1, f2_after_phi_minus_psi_after_f1_ );
       
       u2 := Genesis( UnderlyingObjectOfTheStableObject( tr2!.object3 ) )!.PushoutObjectInducedByStructureOfExactCategory[ 1 ];
       
       phi := UnderlyingMorphismOfTheStableMorphism( phi_ );
       
       phi1 := InjectiveColift( u1, PreCompose( phi, u2 ) );
       
       f2 := UnderlyingMorphismOfTheStableMorphism( f2_ );
       
       alpha2 := InjectionsOfPushoutInducedByStructureOfExactCategory( u2, f2 )[ 1 ];
       
       f1 := UnderlyingMorphismOfTheStableMorphism( f1_ );
       
       g2 := UnderlyingMorphismOfTheStableMorphism( g2_ );
       
       psi := UnderlyingMorphismOfTheStableMorphism( psi_ );
       
       mor := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ u1, f1 ], 
                                                               [ PreCompose(beta, g2 ) + PreCompose( phi1, alpha2 ), PreCompose( psi, g2 ) ] ); 
       return AsStableCategoryMorphism( stable_cat, mor );
       
       end );
     
     ###
     AddOctohedralAxiom( stable_cat, 
     
        function( f_, g_ )
        local f, g, h_, h, A, B, C, tr_f_, tr_h_, D, conf_D, f1, B_to_I_D, conf_B_to_I_D, w, I1, B1, push_object_to_B1, conf_B, I, TB, iso, B1_TB, tr_g_,
        u_A, alpha, gamma, h1, u_D, pi_D, TD, injections, beta, g1, D_F, F_E, E_TD, tr;
        
        f := UnderlyingMorphismOfTheStableMorphism( f_ );
        
        g := UnderlyingMorphismOfTheStableMorphism( g_ );
        
        h_ := PreCompose( f_, g_ );
        
        h := UnderlyingMorphismOfTheStableMorphism( h_ );
        
        A := Source( f );
        
        B := Range( f );
        
        C := Range( g );
        
        tr_f_ := CompleteMorphismToExactTriangle( f_ );
        
        u_A := FitIntoConflationUsingInjectiveObject( A )!.morphism1;
        
        alpha :=  InjectionsOfPushoutInducedByStructureOfExactCategory( AsInflation( u_A ), f )[ 1 ];
        
        f1 := UnderlyingMorphismOfTheStableMorphism( tr_f_!.morphism2 );
        
        tr_h_ := CompleteMorphismToExactTriangle( h_ );
        
        gamma := InjectionsOfPushoutInducedByStructureOfExactCategory( AsInflation( u_A ), h )[ 1 ];
        
        h1 := UnderlyingMorphismOfTheStableMorphism( tr_h_!.morphism2 );
        
        D := UnderlyingObjectOfTheStableObject( tr_f_!.object3 );
        
        conf_D := FitIntoConflationUsingInjectiveObject( D );
        
        u_D := conf_D!.morphism1;
        
        pi_D := conf_D!.morphism2;
        
        TD := conf_D!.object3;
        
        B_to_I_D := PreCompose( f1, u_D );
        
        conf_B_to_I_D := ConflationOfInflation( AsInflation( B_to_I_D ) );
        
        injections := InjectionsOfPushoutInducedByStructureOfExactCategory( B_to_I_D, g );
        
        beta := injections[ 1 ];
        
        g1 := injections[ 2 ];
        
        I1 := conf_B_to_I_D!.object2;
        
        B1 := conf_B_to_I_D!.object3;
        
        push_object_to_B1 := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ B_to_I_D, g ], 
                 [conf_B_to_I_D!.morphism2, ZeroMorphism( C, B1 ) ] );
        
        conf_B := FitIntoConflationUsingInjectiveObject( B );
        
        I := conf_B!.object2;
        
        TB := conf_B!.object3;
        
        iso := SchanuelsIsomorphism(  conf_B_to_I_D, conf_B );
        
        B1_TB := AdditiveInverseForMorphisms( PreCompose( [ InjectionOfCofactorOfDirectSum( [ I, B1 ], 2), 
                               iso,
                               ProjectionInFactorOfDirectSum( [ I1, TB ], 2 ) ] ) );
                               
        tr_g_ := CreateExactTriangle( g_,
                                     AsStableCategoryMorphism( stable_cat,  g1 ),
                                     AsStableCategoryMorphism( stable_cat, PreCompose( push_object_to_B1, B1_TB ) ) );
        
        D_F := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ u_A, f ], [ gamma, PreCompose( g, h1 ) ] );
        
        F_E := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ u_A, h ], [ PreCompose( [ alpha, u_D, beta ] ), g1 ] );
        
        E_TD := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ B_to_I_D, g ], [ pi_D, ZeroMorphism( C, TD ) ] );
        
        tr := CreateExactTriangle( AsStableCategoryMorphism( stable_cat, D_F ),
                                     AsStableCategoryMorphism( stable_cat,  F_E ),
                                     AsStableCategoryMorphism( stable_cat, E_TD ) );
        
        return [ tr_f_, tr_g_, tr_h_, tr ];
        end );
    
    SetIsTriangulatedCategory( stable_cat, true );
    
    return stable_cat;
    
end );
