

BindGlobal( "COMPUTE_TRIANGULATED_STRUCTURE_OF_A_STABLE_CATEGORY_OF_A_FROBENIUS_CATEGORY", 

    function( stable_category )
    
    # Here we start computing the triangulated structure
    
    # Adding the shift of objects method 
    
    # We fit the object obj into a conflation using injective object:   obj --------> I --------> M
    # Then we define ShiftOfObject( obj ) := M
   
    AddShiftOfObject( stable_category, function( obj )
                                       local underlying_obj, conf;
                                       
                                       underlying_obj := UnderlyingObjectOfTheStableObject( obj );
                                       
                                       conf := FitIntoConflationUsingInjectiveObject( underlying_obj );
                                       
                                       return AsStableCategoryObject( stable_category, conf!.object3 );
                                       
                                       end );
   
   # Adding the shift of morphisms method
   
   # Remember : That I is injective object when every morphism f : X → I factors through every mono X → Y.
   # the complement morphism is InjectiveColift( mono, f ).
   
   # mor0: A -----> B
   
   #  conf_A:     A -------> I(A) ------> T(A)
   #              |           |             |
   #         mor0 |      mor1 |             | mor2
   #              V           V             V
   #  conf_B:     B -------> I(B) ------> T(B)
   
   AddShiftOfMorphism( stable_category, function( mor )
                                        local A, B, conf_A, conf_B, mor0, mor1, mor2;
                                        
                                        mor0 := UnderlyingMorphismOfTheStableMorphism( mor );
                                        
                                        A := Source( mor0 );
                                        
                                        B := Range( mor0 );
                                        
                                        conf_A := FitIntoConflationUsingInjectiveObject( A );
                                        
                                        conf_B := FitIntoConflationUsingInjectiveObject( B );
                                        
                                        mor1 := InjectiveColift( conf_A!.morphism1 , PreCompose( mor0, conf_B!.morphism1 ) );
                                        
                                        mor2 :=  CokernelColift( conf_A!.morphism1, PreCompose( mor1, conf_B!.morphism2 ) );
                                        
                                        return AsStableCategoryMorphism( stable_category, mor2 );
                                        
                                        end );
                                     
   
    # Adding the reverse shift of objects method 
    
    # We fit the given object obj into a conflation using projective object:  M --------> P --------> obj.
    # Then we define ReverseShiftOfObject( obj ) := M
   
   AddReverseShiftOfObject( stable_category, function( obj )
                                             local underlying_obj, conf;
                                             
                                             underlying_obj := UnderlyingObjectOfTheStableObject( obj );
                                             
                                             conf := FitIntoConflationUsingProjectiveObject( underlying_obj );
                                             
                                             return AsStableCategoryObject( stable_category, conf!.object1 );
                                             
                                             end );
                                             
   
   # Adding the  reverse shift of morphisms method
   
   # Remember : That P is projective object when every morphism f : P → X factors through every epi Y → X.
   # the complement morphism is ProjectiveLift( f, epi ).
   
   # mor0: A -----> B
   
   #  conf_A:    S(A) -------> P(A) --------> A
   #              |             |             |
   #         mor2 |        mor1 |             | mor0
   #              V             V             V
   #  conf_B:    S(B) -------> P(B) --------> B
   
   AddReverseShiftOfMorphism( stable_category, function( mor )
                                        local A, B, conf_A, conf_B, mor0, mor1, mor2;
                                        
                                        mor0 := UnderlyingMorphismOfTheStableMorphism( mor );
                                        
                                        A := Source( mor0 );
                                        
                                        B := Range( mor0 );
                                        
                                        conf_A := FitIntoConflationUsingProjectiveObject( A );
                                        
                                        conf_B := FitIntoConflationUsingProjectiveObject( B );
                                        
                                        mor1 := ProjectiveLift( PreCompose( conf_A!.morphism2, mor0 ), conf_B!.morphism2 );
                                        
                                        mor2 :=  KernelLift( conf_B!.morphism2, PreCompose( conf_A!.morphism1, mor1 ) );
                                        
                                        return AsStableCategoryMorphism( stable_category, mor2 );
                                        
                                        end );
                                       
   AddIsomorphismFromObjectToShiftAfterReverseShiftOfTheObject( stable_category, 
               
               function( A_ )
               local A, conf_A, SA, conf_SA, TSA, inf1, inf2, h1, h2, mor, u1, v1, I_SA, injection_A, injection_SA, inverse_alpha, inverse_h1, alpha; 
               
               A := UnderlyingObjectOfTheStableObject( A_ );
               
               conf_A := FitIntoConflationUsingProjectiveObject( A );
               
               SA := conf_A!.object1;
               
               conf_SA := FitIntoConflationUsingInjectiveObject( SA );
               
               TSA := conf_SA!.object3;
               
               inf1 := conf_A!.morphism1;
               
               inf2 := conf_SA!.morphism1;
               
               h1 := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ inf1, inf2 ], [ conf_A!.morphism2, ZeroMorphism( conf_SA!.object2, A ) ] );
               
               h2 := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ inf1, inf2 ], [ ZeroMorphism( conf_A!.object2, TSA ), conf_SA!.morphism2 ] );
               
               u1 := InjectionsOfPushoutInducedByStructureOfExactCategory( AsInflation( inf1 ), inf2 )[ 2 ];
               
               I_SA := conf_SA!.object2;
               
               injection_SA := InjectionOfCofactorOfDirectSum( [ I_SA, A ], 1 );
               
               injection_A  := InjectionOfCofactorOfDirectSum( [ I_SA, A ], 2 );
               
               v1 := InjectiveColift( u1, IdentityMorphism( I_SA ) );
               
               alpha := PreCompose( v1, injection_SA ) + PreCompose( h1, injection_A );
               
               inverse_alpha := Inverse( alpha );
               
               inverse_h1 := PreCompose( injection_A, inverse_alpha );
               
               mor := AdditiveInverseForMorphisms( PreCompose( inverse_h1, h2 ) );
               
               return AsStableCategoryMorphism( stable_category, mor );
               
               end );
               
    
  # Standard triangles are of the form  
  #       A -------> B -------> C ----------> T( A )
  # where  C = PushoutObject( B, I ) where A ----> I ----> T( A ) is a conflation.
  
  # Adding TR1, 
  # It states that every morphism f: A ---> B can be completed to an exact triangle.
  
  AddCompleteMorphismToExactTriangle( stable_category,
         
         function( mor )
         local underlying_mor, A, B, conf_A, inf, mor1, mor2;
         
         underlying_mor := UnderlyingMorphismOfTheStableMorphism( mor );
         
         A := Source( underlying_mor );
                             
         B := Range( underlying_mor );
                             
         conf_A := FitIntoConflationUsingInjectiveObject( A );                             
         
         inf := conf_A!.morphism1;
         
         mor1 := InjectionsOfPushoutInducedByStructureOfExactCategory( inf, underlying_mor )[ 2 ];
         
         mor2 := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ inf, underlying_mor ], [ conf_A!.morphism2, ZeroMorphism( Range( underlying_mor ), conf_A!.object3 ) ] );
         
         return CreateExactTriangle( mor,
                                     AsStableCategoryMorphism( stable_category, mor1 ),
                                     AsStableCategoryMorphism( stable_category, mor2 ) );
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
  
  AddCompleteToMorphismOfExactTriangles( stable_category, 
  
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
       return AsStableCategoryMorphism( stable_category, mor );
       
       end );
     
     ###
     AddOctohedralAxiom( stable_category, 
     
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
                                     AsStableCategoryMorphism( stable_category,  g1 ),
                                     AsStableCategoryMorphism( stable_category, PreCompose( push_object_to_B1, B1_TB ) ) );
        
        D_F := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ u_A, f ], [ gamma, PreCompose( g, h1 ) ] );
        
        F_E := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ u_A, h ], [ PreCompose( [ alpha, u_D, beta ] ), g1 ] );
        
        E_TD := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ B_to_I_D, g ], [ pi_D, ZeroMorphism( C, TD ) ] );
        
        tr := CreateExactTriangle( AsStableCategoryMorphism( stable_category, D_F ),
                                     AsStableCategoryMorphism( stable_category,  F_E ),
                                     AsStableCategoryMorphism( stable_category, E_TD ) );
        
        return [ tr_f_, tr_g_, tr_h_, tr ];
        end );
    
    SetIsTriangulatedCategory( stable_category, true );
    
    return stable_category;
    
end );
