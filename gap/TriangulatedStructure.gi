#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

BindGlobal( "ADD_FUNCTIONS_FOR_TRIANGULATED_OPERATIONS",

function( Ho_C )
    
  SetFilterObj( Ho_C, IsTriangulatedCategory );

  ## Adding the shift and reverse shift functors
  AddShiftOnObject( Ho_C,
    function( C )
      local twist_functor;
      
      twist_functor := ShiftFunctor( Ho_C, -1 );
    
      return ApplyFunctor( twist_functor, C );
      
  end );

  ##
  AddShiftOnMorphismWithGivenObjects( Ho_C,
      function( s, phi, r )
        local twist_functor;
        
        twist_functor := ShiftFunctor( Ho_C, -1 );
  
      return ApplyFunctor( twist_functor, phi );
  
  end );
  
  ##
  AddInverseShiftOnObject( Ho_C,
      function( C )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( Ho_C, 1 );
   
        return ApplyFunctor( reverse_twist_functor, C );
  
  end );
  
  ##
  AddInverseShiftOnMorphismWithGivenObjects( Ho_C,
      function( s, phi, r )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( Ho_C, 1 );
      
        return ApplyFunctor( reverse_twist_functor, phi );
  
  end );
  
  ##
  AddIsomorphismOntoShiftOfInverseShift( Ho_C, IdentityMorphism );
  
  AddIsomorphismFromShiftOfInverseShift( Ho_C, IdentityMorphism );
  
  AddIsomorphismOntoInverseShiftOfShift( Ho_C, IdentityMorphism );
  
  AddIsomorphismFromInverseShiftOfShift( Ho_C, IdentityMorphism );
  
  AddStandardConeObject( Ho_C,
    alpha -> MappingCone( UnderlyingCell( alpha ) ) / Ho_C
  );
  
  AddMorphismIntoStandardConeObjectWithGivenStandardConeObject( Ho_C,
    function( alpha, st_cone )
      local cell;
      
      cell := UnderlyingCell( alpha );
      
      return NaturalInjectionInMappingCone( cell ) / Ho_C;
      
  end );
  
  AddMorphismIntoStandardConeObject( Ho_C,
    function( alpha )
      local cell;
      
      cell := UnderlyingCell( alpha );
      
      return NaturalInjectionInMappingCone( cell ) / Ho_C;
      
  end );
 
  AddMorphismFromStandardConeObjectWithGivenStandardConeObject( Ho_C,
    function( alpha, st_cone )
      local cell;
      
      cell := UnderlyingCell( alpha );
      
      return NaturalProjectionFromMappingCone( cell ) / Ho_C;
      
  end );
  
  AddMorphismFromStandardConeObject( Ho_C,
    function( alpha )
      local cell;
      
      cell := UnderlyingCell( alpha );
      
      return NaturalProjectionFromMappingCone( cell ) / Ho_C;
      
  end );

#    A ----- alpha ----> B ----------> Cone( alpha ) -----> Shift A
#    |                   |                |                 |
#    | mu                | nu             |                 | Shift( mu, 1 )
#    |                   |                |                 |
#    v                   v                v                 v
#    A' ---- beta -----> B' ---------> Cone( beta  ) -----> Shift A'

  ##
  AddMorphismBetweenStandardConeObjectsWithGivenObjects( Ho_C,
     function( cone_alpha, alpha, mu, nu, beta, cone_beta )
       local homotopy_maps, maps;
       
       homotopy_maps := HomotopyMorphisms( PreCompose( alpha, nu ) - PreCompose( mu, beta ) );
       
       maps := AsZFunction(
                 function( i )
                   return
                     MorphismBetweenDirectSums(
                       [
                         [ mu[ i - 1 ]                                            , homotopy_maps[ i - 1 ] ],
                         [ ZeroMorphism( Source( nu )[ i ], Range( mu )[ i - 1 ] ), nu[ i ]                ]
                       ] );
                 end );
       
       return HomotopyCategoryMorphism( cone_alpha, cone_beta, maps );
       
  end );
  
  ##
  AddWitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects( Ho_C,
    function( s, alpha, r )
      local A, B, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      maps := AsZFunction(  
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [
                        AdditiveInverse( alpha[ i - 1 ] ),
                        IdentityMorphism( A[ i - 1 ] ),
                        ZeroMorphism( A[ i - 1 ], B[ i ] )
                      ]
                    ] );
                end );
      
      return HomotopyCategoryMorphism( s, r, maps );
      
  end );

  ##
  AddWitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects( Ho_C,
    function( s, alpha, r )
      local A, B, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      maps := AsZFunction(
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ ZeroMorphism( B[ i - 1 ], A[ i - 1 ] ) ],
                      [ IdentityMorphism( A[ i - 1 ] ) ],
                      [ ZeroMorphism( B[ i ], A[ i - 1 ] ) ]
                    ] );
                    
                end );
       
      return HomotopyCategoryMorphism( s, r, maps );
      
  end );
  
  ##
  AddWitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( Ho_C,
    function( s, alpha, r )
      local A, B, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      maps := AsZFunction(
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ 
                        ZeroMorphism( B[ i ], A[ i - 1 ] ),
                        IdentityMorphism( B[ i ] ),
                        ZeroMorphism( B[ i ], A[ i ] )
                      ]
                    ] );
                end );
                
      return HomotopyCategoryMorphism( s, r, maps );
        
  end );

  ##
  AddWitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( Ho_C,
    function( s, alpha, r )
      local A, B, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
     
      maps := AsZFunction(
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ ZeroMorphism( A[ i - 1 ], B[ i ] ) ],
                      [ IdentityMorphism( B[ i ] ) ],
                      [ alpha[ i ] ]
                    ] );
                end );
      
      return HomotopyCategoryMorphism( s, r, maps );
        
  end );
      
  ##
  AddDomainMorphismByOctahedralAxiom( Ho_C,
    function( alpha, beta )
      local mu, alpha_beta;
      
      mu := IdentityMorphism( Source( alpha ) );
      
      alpha_beta := PreCompose( alpha, beta );
      
      return MorphismBetweenStandardConeObjects( alpha, mu, beta, alpha_beta );
      
  end );
  
  ##
  AddMorphismIntoConeObjectByOctahedralAxiom( Ho_C,
    function( alpha, beta )
      local A, B, C, v, cone, cone_beta;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      C := Range( beta );
      
      v := AsZFunction(
            n -> MorphismBetweenDirectSums(
                  [
                    [ alpha[ n - 1 ], ZeroMorphism( A[ n - 1 ], C[ n ] ) ],
                    [ ZeroMorphism( C[ n ], B[ n - 1 ] ), IdentityMorphism( C[ n ] ) ],
                  ]
                ) );
      
      cone := StandardConeObject( PreCompose( alpha, beta ) );
      
      cone_beta := StandardConeObject( beta );
      
      return HomotopyCategoryMorphism( cone, cone_beta, v );
     
  end );
  
  ##
  AddMorphismFromConeObjectByOctahedralAxiom( Ho_C,
    function( alpha, beta )
      local A, B, C, w, cone_beta, shifted_cone_alpha;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      C := Range( beta );
      
      w := AsZFunction(
            n -> MorphismBetweenDirectSums(
                  [
                    [ ZeroMorphism( B[ n - 1 ], A[ n - 2 ] ), IdentityMorphism( B[ n - 1 ] ) ],
                    [ ZeroMorphism( C[ n ], A[ n - 2 ]  ), ZeroMorphism( C[ n ], B[ n - 1 ] ) ],
                  ]
                ) );
                
      cone_beta := StandardConeObject( beta );
      
      shifted_cone_alpha := ShiftOnObject( StandardConeObject( alpha ) );
      
      return HomotopyCategoryMorphism( cone_beta, shifted_cone_alpha, w );
      
  end );
  
  ##
  AddWitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects( Ho_C,
    function( s, alpha, beta, r )
      local A, B, C, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      C := Range( beta );
     
      maps := AsZFunction(
            n -> MorphismBetweenDirectSums(
                  [  
                    [ ZeroMorphism( B[ n - 1 ], A[ n - 2 ] ), IdentityMorphism( B[ n - 1 ] )    , ZeroMorphism( B[ n - 1 ], A[ n - 1 ] ), ZeroMorphism( B[ n - 1 ], C[ n ] )  ],
                    [ ZeroMorphism( C[ n ] , A[ n - 2 ] )   , ZeroMorphism( C[ n ], B[ n - 1 ] ), ZeroMorphism( C[ n ], A[ n - 1 ] )    , IdentityMorphism( C[ n ] )          ]
                  ]
              ) );
      
      return HomotopyCategoryMorphism( s, r, maps );
          
  end );

  ##
  AddWitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( Ho_C,
    function( s, alpha, beta, r )
      local A, B, C, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      C := Range( beta );
           
      maps := AsZFunction(
            n -> MorphismBetweenDirectSums(
                  [  
                    [ ZeroMorphism( A[ n - 2 ] , B[ n - 1 ] ) , ZeroMorphism( A[ n - 2 ], C[ n ] ) ],
                    [ IdentityMorphism( B[ n - 1 ] )          , ZeroMorphism( B[ n -1 ], C[ n ] )  ],
                    [ alpha[ n - 1 ], ZeroMorphism( A[ n - 1 ], C[ n ] )                           ],
                    [ ZeroMorphism( C[ n ], B[ n - 1 ] )      , IdentityMorphism( C[ n ] )         ]
                  ]
              ) );
      
      return HomotopyCategoryMorphism( s, r, maps );
          
  end );
  
end );

