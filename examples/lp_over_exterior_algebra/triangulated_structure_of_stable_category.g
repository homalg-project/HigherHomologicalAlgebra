LoadPackage( "TriangulatedCategories" );
ReadPackage( "StableCategoriesForCAP", "/examples/lp_over_exterior_algebra/stable_cat_of_lp_over_exterior_algebra.g" );


BindGlobal( "COMPUTE_TRIANGULATED_STRUCTURE_OF_A_STABLE_CAT_OF_A_FROBENIUS_CATEGORY", 

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

# Schanuel isomorphism
#           f1        g1 
#        A ----> I1 -----> B1
#
#
#        A ----> I2 -----> B2
#           f2        g2
#
#        SchanuelsIsomorphism : I2 𐌈 B1 ----> I1 𐌈 B2
# In the stable category,  B1 ------> I2 𐌈 B1 -------> I1 𐌈 B2 -------> B2 is also supposed to be isomorphism.

AddIsomorphismIntoShiftOfReverseShift( stable_cat, 
               
    function( stable_obj )
    local obj, conf_obj, S_obj, P_obj, conf_S_obj, IS_obj, TS_obj, injection_obj, projection_TS_obj, mor;
    
    obj := UnderlyingUnstableObject( stable_obj );
    
    conf_obj := FitIntoConflationUsingExactProjectiveObject( obj );
    
    S_obj := ObjectAt( conf_obj, 0 );
    
    P_obj := ObjectAt( conf_obj, 1 );
    
    conf_S_obj := FitIntoConflationUsingExactInjectiveObject( S_obj );
    
    IS_obj := ObjectAt( conf_S_obj, 1 );
    
    TS_obj := ObjectAt( conf_S_obj, 2 );
    
    injection_obj  := InjectionOfCofactorOfDirectSum( [ IS_obj, obj ], 2 );
    
    # SchanuelsIsomorphism : IS_obj 𐌈 obj ----> P_obj 𐌈 TS_obj
    
    mor := SchanuelsIsomorphism( conf_obj, conf_S_obj, "left" );
    
    projection_TS_obj := ProjectionInFactorOfDirectSum( [ P_obj, TS_obj ], 2 );
    
    return AsStableMorphism( PreCompose( [ injection_obj, mor, projection_TS_obj ] ) );
    
end );
    

AddIsomorphismFromShiftOfReverseShift( stable_cat, 
    
    function( stable_obj )
    local obj, conf_obj, S_obj, P_obj, conf_S_obj, IS_obj, TS_obj, injection_TS_obj, projection_obj, mor;
    
    obj := UnderlyingUnstableObject( stable_obj );
    
    conf_obj := FitIntoConflationUsingExactProjectiveObject( obj );
    
    S_obj := ObjectAt( conf_obj, 0 );
    
    P_obj := ObjectAt( conf_obj, 1 );
    
    conf_S_obj := FitIntoConflationUsingExactInjectiveObject( S_obj );
    
    IS_obj := ObjectAt( conf_S_obj, 1 );
    
    TS_obj := ObjectAt( conf_S_obj, 2 );
    
    injection_TS_obj  := InjectionOfCofactorOfDirectSum( [ P_obj, TS_obj ], 2 );
    
    # SchanuelsIsomorphism : P_obj 𐌈 TS_obj ----> IS_obj 𐌈 obj
    
    mor := Inverse( SchanuelsIsomorphism( conf_obj, conf_S_obj, "left" ) );
    
    projection_obj := ProjectionInFactorOfDirectSum( [ IS_obj, obj ], 2 );
    
    return AsStableMorphism( PreCompose( [ injection_TS_obj, mor, projection_obj ] ) );
    
end );

#           f1        g1 
#        A1 ----> P1 -----> B
#
#
#        A2 ----> P2 -----> B
#           f2        g2
#
#        SchanuelsIsomorphism : A1 𐌈 P2 ----> A2 𐌈 P1
# In the stable category,  A1 ------> A1 𐌈 P2 ----> A2 𐌈 P1 -------> A2 is also supposed to be isomorphism.

AddIsomorphismIntoReverseShiftOfShift( stable_cat, 
    
    function( stable_obj )
    local obj, conf_obj, T_obj, I_obj, conf_T_obj, PT_obj, ST_obj, injection_obj, projection_ST_obj, mor;
    
    obj := UnderlyingUnstableObject( stable_obj );
    
    conf_obj := FitIntoConflationUsingExactInjectiveObject( obj );
    
    I_obj := ObjectAt( conf_obj, 1 );
    
    T_obj := ObjectAt( conf_obj, 2 );
    
    conf_T_obj := FitIntoConflationUsingExactProjectiveObject( T_obj );
    
    ST_obj := ObjectAt( conf_T_obj, 0 );

    PT_obj := ObjectAt( conf_T_obj, 1 );
    
    injection_obj  := InjectionOfCofactorOfDirectSum( [ obj, PT_obj ], 1 );
    
    # SchanuelsIsomorphism : obj 𐌈 PT_obj ----> ST_obj 𐌈 I_obj
    
    mor := SchanuelsIsomorphism( conf_obj, conf_T_obj, "right" );
    
    projection_ST_obj := ProjectionInFactorOfDirectSum( [ ST_obj, I_obj ], 1 );
    
    return AsStableMorphism( PreCompose( [ injection_obj, mor, projection_ST_obj ] ) );
    
end );

AddIsomorphismFromReverseShiftOfShift( stable_cat, 
               
    function( stable_obj )
    local obj, conf_obj, T_obj, I_obj, conf_T_obj, PT_obj, ST_obj, injection_ST_obj, projection_obj, mor;
    
    obj := UnderlyingUnstableObject( stable_obj );
    
    conf_obj := FitIntoConflationUsingExactInjectiveObject( obj );
    
    I_obj := ObjectAt( conf_obj, 1 );
    
    T_obj := ObjectAt( conf_obj, 2 );
    
    conf_T_obj := FitIntoConflationUsingExactProjectiveObject( T_obj );
    
    ST_obj := ObjectAt( conf_T_obj, 0 );

    PT_obj := ObjectAt( conf_T_obj, 1 );
    
    injection_ST_obj := InjectionOfCofactorOfDirectSum( [ ST_obj, I_obj ], 1 );

    # SchanuelsIsomorphism :  ST_obj 𐌈 I_obj----> obj 𐌈 PT_obj
    mor := Inverse( SchanuelsIsomorphism( conf_obj, conf_T_obj, "right" ) );
    
    projection_obj  := ProjectionInFactorOfDirectSum( [ obj, PT_obj ], 1 );

    return AsStableMorphism( PreCompose( [ injection_ST_obj, mor, projection_obj ] ) );
    
end );

# Standard triangles are of the form  
#       A -------> B -------> C ----------> T( A )
# where  C = PushoutObject( B, I ) where A ----> I ----> T( A ) is a conflation.

# Adding TR1, 
# It states that every morphism f: A ---> B can be completed to an exact triangle.

#           mor
#       A -------> B
#       |
#   inf |
#       V
#      I(A)        C
#       |
#       |------------> T(A)

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
                       [ MorphismAt( conf_A, 1 ), ZeroMorphism( B, ObjectAt( conf_A, 2 ) ) ] );
    
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
  
AddCompleteToMorphismOfCanonicalExactTriangles( stable_cat, 
  
    function( tr1, tr2, phi_, psi_ )
    local phi, psi, f1, f2, g2, lambda, u1, u2, beta,
    phi1, alpha2, mor, factorization;
    
    phi := UnderlyingUnstableMorphism( phi_ );

    psi := UnderlyingUnstableMorphism( psi_ );

    f1 := UnderlyingUnstableMorphism( MorphismAt( tr1, 0 ) );
    
    f2 := UnderlyingUnstableMorphism( MorphismAt( tr2, 0 ) );
    
    g2 := UnderlyingUnstableMorphism( MorphismAt( tr2, 1 ) );
   
    # since all morphisms in first square commute, it follows that the morphism:
    
    lambda := PreCompose( phi, f2 ) - PreCompose( f1, psi );
       
    # is zero in the stable category, and hence factors through an injective object. Using univeral property of 
    # injective objects we can assume that the morphism should also factor through I, that was used to
    # construct tr1.
         
    factorization := FactorizationThroughExactInjective( lambda );

    u1 := InflationIntoSomeExactInjectiveObject( UnderlyingUnstableObject( ObjectAt( tr1, 0 ) ) );

    if IsEqualForMorphisms( u1, factorization[ 1 ] ) then
        beta := factorization[ 2 ];
    else 
        beta := PreCompose( ExactInjectiveColift( u1, factorization[ 1 ] ), factorization[ 2 ] );
    fi;

    u2 := InflationIntoSomeExactInjectiveObject( UnderlyingUnstableObject( ObjectAt( tr2, 0 ) ) );

    phi1 := ExactInjectiveColift( u1, PreCompose( phi, u2 ) );

    alpha2 := InjectionOfCofactorOfExactPushout( [ u2, f2 ], 1 );

    mor := UniversalMorphismFromExactPushout( [ u1, f1 ], 
            [ AdditionForMorphisms( PreCompose( phi1, alpha2 ), AdditiveInverse( PreCompose( beta, g2 ) ) ), PreCompose( psi, g2 ) ] ); 
    
    return CreateTrianglesMorphism( tr1, tr2, phi_, psi_, AsStableMorphism( mor ) );

end );

AddRotationOfCanonicalExactTriangle( stable_cat,
    function( tr )
    local rot, crot, a, b, psi, iso, teta, i, p;

    rot := CreateExactTriangle( tr^1, tr^2, AdditiveInverse( ShiftOfMorphism( tr^0 ) ) );
    crot := CompleteMorphismToCanonicalExactTriangle( tr^1 );
    a := FitIntoConflationUsingExactInjectiveObject( UnderlyingUnstableObject( tr[ 0 ] ) );
    b := FitIntoConflationUsingExactInjectiveObject( UnderlyingUnstableObject( tr[ 1 ] ) );
    
    psi := UniversalMorphismFromExactPushout( 
                [ a^0, UnderlyingUnstableMorphism( tr^0 ) ], 
                [ ExactInjectiveColift( a^0, PreCompose( UnderlyingUnstableMorphism( tr^0 ), b^0) ), b^0 ] );
    
    #The stable category of frobenius category is triangulated Cody Holdaway & Kevin Zatloukal page 16.
    iso := UniversalMorphismFromExactPushout( [ b^0, UnderlyingUnstableMorphism( tr^1 ) ], 
                                                [
                                                    InjectionOfCofactorOfDirectSum( [ b[1], UnderlyingUnstableObject( tr[3] ) ], 1 ),
                                                    MorphismBetweenDirectSums( [ [ psi, UnderlyingUnstableMorphism( tr^2 ) ] ] )
                                                ] );
    teta := MorphismBetweenDirectSums( [ [ b^1 ],[ AdditiveInverse( UnderlyingUnstableMorphism( ShiftOfMorphism( tr^0 ) ) ) ] ] );
    
    if not IsCongruentForMorphisms( PreCompose( Inverse( iso ), UnderlyingUnstableMorphism( crot^2 ) ), teta ) then
        Error( "Something unexpected happened!" );
    fi;

    i := AsStableMorphism( PreCompose( InjectionOfCofactorOfDirectSum( [ b[1], UnderlyingUnstableObject( tr[3] ) ], 2 ), Inverse( iso ) ) );
    p := AsStableMorphism( PreCompose( iso, ProjectionInFactorOfDirectSum( [ b[1], UnderlyingUnstableObject( tr[3] ) ], 2 ) ) );

    i := CreateTrianglesMorphism( rot, crot, IdentityMorphism( rot[ 0 ] ), IdentityMorphism( rot[ 1 ] ), i );
    p := CreateTrianglesMorphism( crot, rot, IdentityMorphism( rot[ 0 ] ), IdentityMorphism( rot[ 1 ] ), p );
    
    SetIsomorphismIntoCanonicalExactTriangle( rot, i );
    SetIsomorphismFromCanonicalExactTriangle( rot, p );
    
    return rot;

end );


###
#      AddOctohedralAxiom( stable_cat, 
     
#         function( f_, g_ )
#         local f, g, h_, h, A, B, C, tr_f_, tr_h_, D, conf_D, f1, B_to_I_D, conf_B_to_I_D, w, I1, B1, push_object_to_B1, conf_B, I, TB, iso, B1_TB, tr_g_,
#         u_A, alpha, gamma, h1, u_D, pi_D, TD, injections, beta, g1, D_F, F_E, E_TD, tr;
        
#         f := UnderlyingMorphismOfTheStableMorphism( f_ );
        
#         g := UnderlyingMorphismOfTheStableMorphism( g_ );
        
#         h_ := PreCompose( f_, g_ );
        
#         h := UnderlyingMorphismOfTheStableMorphism( h_ );
        
#         A := Source( f );
        
#         B := Range( f );
        
#         C := Range( g );
        
#         tr_f_ := CompleteMorphismToExactTriangle( f_ );
        
#         u_A := FitIntoConflationUsingInjectiveObject( A )!.morphism1;
        
#         alpha :=  InjectionsOfPushoutInducedByStructureOfExactCategory( AsInflation( u_A ), f )[ 1 ];
        
#         f1 := UnderlyingMorphismOfTheStableMorphism( tr_f_!.morphism2 );
        
#         tr_h_ := CompleteMorphismToExactTriangle( h_ );
        
#         gamma := InjectionsOfPushoutInducedByStructureOfExactCategory( AsInflation( u_A ), h )[ 1 ];
        
#         h1 := UnderlyingMorphismOfTheStableMorphism( tr_h_!.morphism2 );
        
#         D := UnderlyingObjectOfTheStableObject( tr_f_!.object3 );
        
#         conf_D := FitIntoConflationUsingInjectiveObject( D );
        
#         u_D := conf_D!.morphism1;
        
#         pi_D := conf_D!.morphism2;
        
#         TD := conf_D!.object3;
        
#         B_to_I_D := PreCompose( f1, u_D );
        
#         conf_B_to_I_D := ConflationOfInflation( AsInflation( B_to_I_D ) );
        
#         injections := InjectionsOfPushoutInducedByStructureOfExactCategory( B_to_I_D, g );
        
#         beta := injections[ 1 ];
        
#         g1 := injections[ 2 ];
        
#         I1 := conf_B_to_I_D!.object2;
        
#         B1 := conf_B_to_I_D!.object3;
        
#         push_object_to_B1 := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ B_to_I_D, g ], 
#                  [conf_B_to_I_D!.morphism2, ZeroMorphism( C, B1 ) ] );
        
#         conf_B := FitIntoConflationUsingInjectiveObject( B );
        
#         I := conf_B!.object2;
        
#         TB := conf_B!.object3;
        
#         iso := SchanuelsIsomorphism(  conf_B_to_I_D, conf_B );
        
#         B1_TB := AdditiveInverseForMorphisms( PreCompose( [ InjectionOfCofactorOfDirectSum( [ I, B1 ], 2), 
#                                iso,
#                                ProjectionInFactorOfDirectSum( [ I1, TB ], 2 ) ] ) );
                               
#         tr_g_ := CreateExactTriangle( g_,
#                                      AsStableCategoryMorphism( stable_cat,  g1 ),
#                                      AsStableCategoryMorphism( stable_cat, PreCompose( push_object_to_B1, B1_TB ) ) );
        
#         D_F := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ u_A, f ], [ gamma, PreCompose( g, h1 ) ] );
        
#         F_E := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ u_A, h ], [ PreCompose( [ alpha, u_D, beta ] ), g1 ] );
        
#         E_TD := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ B_to_I_D, g ], [ pi_D, ZeroMorphism( C, TD ) ] );
        
#         tr := CreateExactTriangle( AsStableCategoryMorphism( stable_cat, D_F ),
#                                      AsStableCategoryMorphism( stable_cat,  F_E ),
#                                      AsStableCategoryMorphism( stable_cat, E_TD ) );
        
#         return [ tr_f_, tr_g_, tr_h_, tr ];
#         end );
        
    return stable_cat;
    
end );



R := KoszulDualRing( HomalgFieldOfRationalsInSingular()*"x,y" );
cat := LeftPresentations( R: FinalizeCategory := false );
ADD_METHODS_TO_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( cat );
TurnAbelianCategoryToExactCategory( cat );
SetIsFrobeniusCategory( cat, true );
Finalize( cat );

SetTestFunctionForStableCategories(cat, CanBeFactoredThroughExactProjective );
stable_cat := StableCategory( cat );
ADD_METHODS_TO_STABLE_CAT_OF_LEFT_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( stable_cat );
COMPUTE_TRIANGULATED_STRUCTURE_OF_A_STABLE_CAT_OF_A_FROBENIUS_CATEGORY( stable_cat);
Finalize( stable_cat );

m := HomalgMatrix( "[ [ e1, e0, e1, e1*e0, e0-e1 ], [ 0, 1, e1*e0, 0, -4*e1 ], [ e1+e0, 0, 1, e1*e0-e1, 0 ] ]", 3, 5, R);
m := AsLeftPresentation( m );
M := AsStableObject( m );
n := HomalgMatrix( "[ [ e1*e0, e0-e1 ], [ 1, e0 ], [ e1*e0, e1*e0-e0 ] ]", 3, 2, R);
n := AsLeftPresentation( n );
N := AsStableObject( n );
quit;

compute := function( f_, g_ )
local f, g, h_, h, A, B, C, tr_f_, tr_h_, D, conf_D, f1, B_to_I_D, conf_B_to_I_D, w, I1, B1, push_object_to_B1, conf_B, I, TB, iso, B1_TB, tr_g_,
    u_A, alpha, gamma, h1, u_D, pi_D, TD, injections, beta, g1, D_F, F_E, E_TD, tr;
    h_ := PreCompose( f_, g_ );
    f := UnderlyingUnstableMorphism( f_ );
    g := UnderlyingUnstableMorphism( g_ );
    h := UnderlyingUnstableMorphism( h_ );
    A := Source( f );
    B := Range( f );
    C := Range( g );
    
    tr_f_ := CompleteMorphismToCanonicalExactTriangle( f_ );
    u_A := FitIntoConflationUsingExactInjectiveObject( A )^0;
    alpha :=  InjectionOfCofactorOfExactPushout( [ u_A, f ], 1);
    f1 := UnderlyingUnstableMorphism( tr_f_^1 );
    
    tr_h_ := CompleteMorphismToCanonicalExactTriangle( h_ );
    gamma := InjectionOfCofactorOfExactPushout( [ u_A, h ] , 1 );
    h1 := UnderlyingUnstableMorphism( tr_h_^1 );
    
    D := UnderlyingUnstableObject( tr_f_[ 2 ] );
    conf_D := FitIntoConflationUsingExactInjectiveObject( D );
    u_D := conf_D^0;
    pi_D := conf_D^1;
    TD := conf_D[ 2 ];
    
    B_to_I_D := PreCompose( f1, u_D );
    conf_B_to_I_D := ConflationOfInflation( B_to_I_D );
    beta := InjectionOfCofactorOfExactPushout( [ B_to_I_D, g ], 1 );
    g1 := InjectionOfCofactorOfExactPushout( [ B_to_I_D, g ], 2 );

    I_D := conf_B_to_I_D[ 1 ];
    B1 := conf_B_to_I_D[ 2 ];

    push_object_to_B1 := UniversalMorphismFromExactPushout( [ B_to_I_D, g ], [ conf_B_to_I_D^1, ZeroMorphism( C, B1 ) ] );

    conf_B := FitIntoConflationUsingExactInjectiveObject( B );
    I_B := conf_B[ 1 ];
    T_B := conf_B[ 2 ];
    u_B := conf_B^0;
    v := UniversalMorphismFromExactPushout( [ u_B, g ], [ PreCompose( ExactInjectiveColift( u_B, B_to_I_D ), beta ), g1 ] );

    iso := SchanuelsIsomorphism(  conf_B_to_I_D, conf_B, "left" );
    B1_TB := AdditiveInverseForMorphisms( PreCompose( [ InjectionOfCofactorOfDirectSum( [ I_B, B1 ], 2 ), 
                           iso,
                           ProjectionInFactorOfDirectSum( [ I_D, T_B ], 2 ) ] ) );

    tr_g_ := CreateExactTriangle( g_,
                                 AsStableMorphism( g1 ),
                                 AsStableMorphism(PreCompose( push_object_to_B1, B1_TB ) ) );
    
    j := UniversalMorphismFromExactPushout( [ u_A, f ], [ gamma, PreCompose( g, h1 ) ] );
    j1 := UniversalMorphismFromExactPushout( [ u_A, h ], [ PreCompose( [ alpha, u_D, beta ] ), g1 ] );
    
    E_TD := UniversalMorphismFromExactPushout( [ B_to_I_D, g ], [ pi_D, ZeroMorphism( C, TD ) ] );
    tr := CreateExactTriangle( AsStableMorphism( j ),
                                 AsStableMorphism( j1 ),
                                 AsStableMorphism( E_TD ) );
    u := AsStableMorphism( UniversalMorphismFromExactPushout( [ u_D, j ], [ beta, j1 ] ) );
    can_j := CompleteMorphismToCanonicalExactTriangle( AsStableMorphism( j ) );
    SetIsomorphismFromCanonicalExactTriangle( tr, CreateTrianglesMorphism( can_j, tr, IdentityMorphism( tr[0] ), IdentityMorphism( tr[1] ), u ) );
    SetIsomorphismIntoCanonicalExactTriangle( tr, CreateTrianglesMorphism( tr, can_j, IdentityMorphism( tr[0] ), IdentityMorphism( tr[1] ), Inverse( u ) ) );
    
    return; 
end;

hom_basis := basis_of_external_hom( M, N );
random := List( [ 1..Length( hom_basis ) ], i-> Random( [ -i..i ] ) );;
f := Sum( [ 1..Length( hom_basis ) ], i -> random[ i ] * hom_basis[ i ] );
compute_coefficients( hom_basis, f );

