
## ReadPackage( "FrobeniusCategoriesForCAP", "examples/LeftPreOfExtAlgAsFrobCategory.gi" );


LoadPackage( "ModulePresentations" );
LoadPackage( "FrobeniusCategoriesForCap" );

R := KoszulDualRing( HomalgFieldOfRationalsInSingular()*"x,y" );

category := LeftPresentations( R:FinalizeCategory := false );

TurnAbelianCategoryToExactCategory( category );

############################################
##
## Giving the category Frobenius structure
##
###########################################

SetIsFrobeniusCategory( category, true );

AddFitIntoConflationUsingProjectiveObject( category, function( obj )
                                                     
                                                         return ConflationOfDeflation( AsDeflation( CoverByFreeModule( obj ) ) );
                                                         
                                                     end );

AddFitIntoConflationUsingInjectiveObject( category, function( obj )
                                                    local ring, dual, nat, dual_obj, free_cover, dual_free_cover, obj_to_double_dual_obj, embedding;
                                                    
                                                    ring := UnderlyingHomalgRing( obj );
                                                    
                                                    dual := FunctorDualForLeftPresentations( ring );
                                                    
                                                    nat  := NaturalTransformationFromIdentityToDoubleDualForLeftPresentations( ring );
                                                    
                                                    dual_obj := ApplyFunctor( dual, obj );
                                                    
                                                    free_cover := CoverByFreeModule( dual_obj );
                                                    
                                                    dual_free_cover := ApplyFunctor( dual, free_cover );
                                                    
                                                    obj_to_double_dual_obj := ApplyNaturalTransformation( nat, obj );
                                                    
                                                    embedding := PreCompose( obj_to_double_dual_obj, dual_free_cover );
                                                    
                                                    return ConflationOfInflation( AsInflation( embedding ) );
                                                    
                                                    end );

# InjectiveColift can be derived from Colift, hence I will only add a method for Colift.

AddColift( category, 

    function( morphism_1, morphism_2 )
    local N, M, A, B, I, B_over_M, zero_mat, A_over_zero, sol, XX;
    #                 rxs
    #                I
    #                ꓥ
    #         vxs    | nxs 
    #       ?X      (A) 
    #                |
    #                |
    #    uxv    nxv   mxn
    #   M <----(B)-- N
    #
    #
    # We need to solve the system
    #     B*X + Y*I = A
    #     M*X + Z*I = 0
    # i.e.,
    #        [ B ]            [ Y ]        [ A ]
    #        [   ] * X   +    [   ] * I =  [   ]
    #        [ M ]            [ Z ]        [ 0 ]
    #
    # the function is supposed to return X as a ( well defined ) morphism from M to I.
    
    I := UnderlyingMatrix( Range( morphism_2 ) );
    
    N := UnderlyingMatrix( Source( morphism_1 ) );
    
    M := UnderlyingMatrix( Range( morphism_1 ) );
    
    B := UnderlyingMatrix( morphism_1 );
    
    A := UnderlyingMatrix( morphism_2 );
    
    B_over_M := UnionOfRows( B, M );
    
    zero_mat := HomalgZeroMatrix( NrRows( M ), NrColumns( I ), R );
    
    A_over_zero := UnionOfRows( A, zero_mat );

    sol := SolveTwoSidedEquationOverExteriorAlgebra( B_over_M, I, A_over_zero );
    
    if sol= fail then 
    
       return fail;
       
    else 
    
       return PresentationMorphism( Range( morphism_1 ), sol[ 1 ], Range( morphism_2 ) );
       
    fi;
    
    end );
    
    
   # ProjectiveLift can be derived by Lift
   
AddLift( category, 

   function( morphism_1, morphism_2 )
   local P, N, M, A, B, l, basis_indices, Q, R_B, R_N, L_P, R_M, L_id_s, L_P_mod, 
    A_deco, A_deco_list, A_deco_list_vec, A_vec, mat1, mat2, A_vec_over_zero_vec, mat, sol, XX, XX_, X_, s, v;
   
    #                 rxs
    #                P
    #                |
    #         sxv    | sxn 
    #        X      (A) 
    #                |
    #                V
    #    uxv    vxn   mxn
    #   M ----(B)--> N
    #
    #
    # We need to solve the system
    #     X*B + Y*N = A
    #     P*X + Z*M = 0
    # the function is supposed to return X as a ( well defined ) morphism from P to M.
    
    P := UnderlyingMatrix( Source( morphism_1 ) );
    
    N := UnderlyingMatrix( Range(  morphism_1 ) );
    
    M := UnderlyingMatrix( Source( morphism_2 ) );
    
    A := UnderlyingMatrix( morphism_1 );
    
    B := UnderlyingMatrix( morphism_2 );
   
    l := Length( IndeterminatesOfExteriorRing( R ) );
    
    basis_indices := MyList( l-1 );
    
    Q := CoefficientsRing( R ); 

    R_B := UnionOfRows( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, B ) ), HomalgIdentityMatrix( NrRows( A ), Q ) ) ) );

    R_N := UnionOfRows( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, N ) ), HomalgIdentityMatrix( NrRows( A ), Q ) ) ) );    

    L_P := UnionOfRows( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrColumns( M ), Q ), Q*FLeft( u, P ) ) ) );

    R_M := UnionOfRows( List( basis_indices, u-> KroneckerMat( Involution( Q*FRight( u, M ) ), HomalgIdentityMatrix( NrRows( P ), Q ) ) ) );

    L_id_s := UnionOfRows( List( basis_indices, u-> KroneckerMat( HomalgIdentityMatrix( NrRows( B ), Q ), Q*FLeft( u, HomalgIdentityMatrix( NrRows( A ), R ) ) ) ) );

    L_P_mod := L_P* Involution( L_id_s );

    A_deco := DecompositionOfHomalgMat( A );
   
    A_deco_list := List( A_deco, i-> i[ 2 ] );

    A_deco_list_vec := List( A_deco_list, mat -> UnionOfRows( List( [ 1..NrColumns( A ) ], i-> CertainColumns( mat, [ i ] ) ) ) );

    A_vec := Q*UnionOfRows( A_deco_list_vec );
    
    
    # Now we should have 
    #   R_B     * vec( X ) + R_N * vec( Y )                  = vec_A
    #   L_P_mod * vec( X ) +                + R_M * vec( Z ) = zero
    
    # or  [   R_B    R_N     0  ]      [  vec( X ) ]        [ vec_A ]
    #     [                     ]  *   [  vec( Y ) ]   =    [       ]
    #     [ L_P_mod  0      R_M ]      [  vec( Z ) ]        [   0   ]
    #
    # in the underlying field Q
    
    
    mat1 := UnionOfColumns( [ R_B, R_N, HomalgZeroMatrix( NrRows( A )*NrColumns( A )*2^l, NrRows( M )*NrRows( P )*2^l, Q ) ] );
    
    mat2 := UnionOfColumns( [ L_P_mod, HomalgZeroMatrix( NrRows( P )*NrColumns( M )*2^l, NrRows( N )*NrColumns( P )*2^l, Q ), R_M ] );
    
    mat := UnionOfRows( mat1, mat2 );
     
    A_vec_over_zero_vec := UnionOfRows( A_vec, HomalgZeroMatrix( NrColumns( M )*NrRows( P )*2^l, 1, Q ) );

    sol := LeftDivide( mat, A_vec_over_zero_vec );
    
    if sol = fail then 
      
      return fail;
     
    fi;
    
    s := NrColumns( P );
    
    v := NrColumns( M );
    
    XX := CertainRows( sol, [ 1 .. s*v*2^l ] );
    
    XX_ := UnionOfColumns( List( [ 1 .. v*2^l ], i -> CertainRows( XX, [ ( i - 1 )*s + 1 .. i*s ] ) ) );

    X_ := Sum( List( [ 1..2^l ], i-> ( R * CertainColumns( XX_, [ ( i - 1 )*v + 1 .. i*v ] ) )* RingElement( basis_indices[ i ], R ) ) );

    return PresentationMorphism( Source( morphism_1 ), X_, Source( morphism_2 ) );
    
end );
    
AddIsProjective( category, function( obj )
                            local cover, lift; 
                            
                            # If the number of rows of the matrix is zero then the module is free, hence projective.
                              
                            if NrRows( UnderlyingMatrix( obj ) ) = 0 then 
                            
                              return true;
                              
                            fi;
                            
                            cover := CoverByFreeModule( obj );
                            
                            lift := Lift( IdentityMorphism( obj ), cover );
                            
                            if lift = fail then 
                            
                               return false;
                              
                            fi; 
                            
                            return true;
                            
                            end );
 
AddIsInjective( category, function( obj )
                           
                           return IsProjective( obj );
                           
                           end );
                        
Finalize( category );

#################################################
##
## Constructing the stable category 
##
#################################################

##
membership_test_function := 
        
        function( mor )
        
        local underlying_mor, M, N, A, sol, m;
        
        underlying_mor := UnderlyingMorphismOfTheStableMorphism( mor );
        
        if HasIsZero( underlying_mor ) and IsZero( underlying_mor ) then 
        
          return true;
          
        fi;
           
        M := UnderlyingMatrix( Source( mor ) );

        N := UnderlyingMatrix( Range( mor ) );
        
        # in this case M, N are free modules.
        if NrRows( M )= 0 or NrRows( N )= 0 then 
        
           return true; 
           
        fi;
        
        m := SyzygiesOfColumns( M );
        
        A := UnderlyingMatrix( mor );
        
        sol := SolveTwoSidedEquationOverExteriorAlgebra( m, N, A );
        
        if sol = fail then 
        
           return false;
           
        fi;
           
        return true;
       
        end;
       
stable_category := StableCategory( category, membership_test_function :FinalizeStableCategory := false );

############################################################
##
## Giving the stable the structure of triangulated category
##
###########################################################


COMPUTE_TRIANGULATED_STRUCTURE_OF_A_STABLE_CATEGORY_OF_A_FROBENIUS_CATEGORY( stable_category );

Finalize( stable_category );


## Demo 

M := HomalgMatrix( "[ [ e0, e1 ] ]", 1,2, R );
# <A 1 x 2 matrix over an external ring>
M := AsLeftPresentation( M );
# <An object in Category of left presentations of Q{e0,e1,e2}>
 M_ := AsStableCategoryObject( stable_category, M );
# <An object in the stable category of Category of left presentations of Q{e0,e1,e2}>
Display( M_ );              
# An object in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying object
# e0,e1
# 
# An object in Category of left presentations of Q{e0,e1,e2}
T := ShiftFunctor( stable_category );
# Shift functor in The stable category of Category of left presentations of Q{e0,e1,e2}
S := ReverseShiftFunctor( stable_category );
# Shift functor in The stable category of Category of left presentations of Q{e0,e1,e2}
TM_ := ApplyFunctor( T, M_ );
# <An object in the stable category of Category of left presentations of Q{e0,e1,e2}>
Display( TM_ );
# An object in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying object
# 0, e0,e1,
# e1,0, e0 
# 
# An object in Category of left presentations of Q{e0,e1,e2}
STM_ := ApplyFunctor( S, TM_ );
# <An object in the stable category of Category of left presentations of Q{e0,e1,e2}>
Display( STM_ );
# An object in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying object
# e1,e0,0, 0, 
# 0, 0, e0,e1,
# 0, e1,0, e0 
# 
# An object in Category of left presentations of Q{e0,e1,e2}
Id_ST := NaturalIsomorphismFromIdentityToShiftAfterReverseShiftFunctor( stable_category );
# Autoequivalence from identity functor to Shift after ReverseShift functor in The stable category of Category of left presentations of Q{e0,e1,e2}
iso := ApplyNaturalTransformation( Id_ST, M_ );
# <A morphism in the stable category of Category of left presentations of Q{e0,e1,e2}>
Display( iso );
# A morphism in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying morphism
# 0,1,
# 1,0 
# 
# A morphism in Category of left presentations of Q{e0,e1,e2}
Id_M_ := IdentityMorphism( M_ );
# <A morphism in the stable category of Category of left presentations of Q{e0,e1,e2}>
Tr := CompleteMorphismToExactTriangle( Id_M_ );
# < An exact triangle in The stable category of Category of left presentations of Q{e0,e1,e2} >
Display( Tr );
# object1 --(morphism1)--> object2 --(morphism2)--> object3 --(morphism3)--> ShiftOfObject( object1 )
# 
# 
# object1 is
# An object in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying object
# e0,e1
# 
# An object in Category of left presentations of Q{e0,e1,e2}
# 
# 
# morphism1 is 
# A morphism in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying morphism
# 1,0,
# 0,1 
# 
# An identity morphism in Category of left presentations of Q{e0,e1,e2}
# 
# 
# object2 is
# An object in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying object
# e0,e1
# 
# An object in Category of left presentations of Q{e0,e1,e2}
# 
# 
# morphism2 is 
# A morphism in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying morphism
# 0,0,0,1,0,
# 0,0,0,0,1 
# 
# A monomorphism in Category of left presentations of Q{e0,e1,e2}
# 
# 
# object3 is
# An object in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying object
# 0, e0,e1,-1,0, 
# e1,0, e0,0, -1,
# 0, 0, 0, e0,e1 
# 
# An object in Category of left presentations of Q{e0,e1,e2}
# 
# 
# morphism3 is 
# A morphism in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying morphism
# 1,0,0,
# 0,1,0,
# 0,0,1,
# 0,0,0,
# 0,0,0 
# 
# A morphism in Category of left presentations of Q{e0,e1,e2}
# 
# 
# ShiftOfObject( object1 ) is 
# An object in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying object
# 0, e0,e1,
# e1,0, e0 
# 
# An object in Category of left presentations of Q{e0,e1,e2}
id1 := IdentityMorphism( Tr!.object1 );
# <A morphism in the stable category of Category of left presentations of Q{e0,e1,e2}>
id2 := IdentityMorphism( Tr!.object2 );
# <A morphism in the stable category of Category of left presentations of Q{e0,e1,e2}>
mor := CompleteToMorphismOfExactTriangles( Tr, Tr, id1, id2 );
# <A morphism in the stable category of Category of left presentations of Q{e0,e1,e2}>
Display( mor );
# A morphism in the stable category of Category of left presentations of Q{e0,e1,e2} with underlying morphism
# 1,0,0,0,0,
# 0,1,0,0,0,
# 0,0,1,0,0,
# 0,0,0,1,0,
# 0,0,0,0,1 
# 
# A morphism in Category of left presentations of Q{e0,e1,e2}
OctohedralAxiom( Id_M_, Id_M_ );
# [ < An exact triangle in The stable category of Category of left presentations of Q{e0,e1,e2} >, 
#   < An exact triangle in The stable category of Category of left presentations of Q{e0,e1,e2} >, 
#   < An exact triangle in The stable category of Category of left presentations of Q{e0,e1,e2} >, 
#   < An exact triangle in The stable category of Category of left presentations of Q{e0,e1,e2} > ]
