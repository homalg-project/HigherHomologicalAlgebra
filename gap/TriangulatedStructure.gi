#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

BindGlobal( "ADD_FUNCTIONS_FOR_TRIANGULATED_OPERATIONS",

function( Ho_C )
  local complex_cat, index_shift;
  
  SetFilterObj( Ho_C, IsTriangulatedCategory );
  
  complex_cat := UnderlyingCategory( Ho_C );
  
  if IsChainComplexCategory( complex_cat ) then
    index_shift := -1;
  else
    index_shift := 1;
  fi;
  
  ## Adding the shift and reverse shift functors
  AddShiftOnObject( Ho_C,
    function( C )
      local twist_functor;
      
      twist_functor := ShiftFunctor( Ho_C, index_shift );
    
      return ApplyFunctor( twist_functor, C );
      
  end );

  ##
  AddShiftOnMorphismWithGivenObjects( Ho_C,
      function( s, phi, r )
        local twist_functor;
        
        twist_functor := ShiftFunctor( Ho_C, index_shift );
  
      return ApplyFunctor( twist_functor, phi );
  
  end );
  
  ##
  AddInverseShiftOnObject( Ho_C,
      function( C )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( Ho_C, -index_shift );
   
        return ApplyFunctor( reverse_twist_functor, C );
  
  end );
  
  ##
  AddInverseShiftOnMorphismWithGivenObjects( Ho_C,
      function( s, phi, r )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( Ho_C, -index_shift );
      
        return ApplyFunctor( reverse_twist_functor, phi );
  
  end );
  
  ##
  AddIsomorphismOntoShiftOfInverseShiftWithGivenObject( Ho_C, { a, b } -> IdentityMorphism( a ) );
  
  AddIsomorphismFromShiftOfInverseShiftWithGivenObject( Ho_C, { a, b } -> IdentityMorphism( a ) );
  
  AddIsomorphismOntoInverseShiftOfShiftWithGivenObject( Ho_C, { a, b } -> IdentityMorphism( a ) );
  
  AddIsomorphismFromInverseShiftOfShiftWithGivenObject( Ho_C, { a, b } -> IdentityMorphism( a ) );
  
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
                         [ mu[ i + index_shift ]                                            , homotopy_maps[ i + index_shift ] ],
                         [ ZeroMorphism( Source( nu )[ i ], Range( mu )[ i + index_shift ] ), nu[ i ]                          ]
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
                        AdditiveInverse( alpha[ i + index_shift ] ),
                        IdentityMorphism( A[ i + index_shift ] ),
                        ZeroMorphism( A[ i + index_shift ], B[ i ] )
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
                      [ ZeroMorphism( B[ i + index_shift ], A[ i + index_shift ] ) ],
                      [ IdentityMorphism( A[ i + index_shift ] ) ],
                      [ ZeroMorphism( B[ i ], A[ i + index_shift ] ) ]
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
                        ZeroMorphism( B[ i ], A[ i + index_shift ] ),
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
                      [ ZeroMorphism( A[ i + index_shift ], B[ i ] ) ],
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
                    [ alpha[ n + index_shift ], ZeroMorphism( A[ n + index_shift ], C[ n ] ) ],
                    [ ZeroMorphism( C[ n ], B[ n + index_shift ] ), IdentityMorphism( C[ n ] ) ],
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
                    [ ZeroMorphism( B[ n + index_shift ], A[ n + 2 * index_shift ] ), IdentityMorphism( B[ n + index_shift ] ) ],
                    [ ZeroMorphism( C[ n ], A[ n + 2 * index_shift ]  ), ZeroMorphism( C[ n ], B[ n + index_shift ] ) ],
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
                    [ ZeroMorphism( B[ n + index_shift ], A[ n + 2 * index_shift ] ), IdentityMorphism( B[ n + index_shift ] )    , ZeroMorphism( B[ n + index_shift ], A[ n + index_shift ] ), ZeroMorphism( B[ n + index_shift ], C[ n ] )  ],
                    [ ZeroMorphism( C[ n ] , A[ n + 2 * index_shift ] )   , ZeroMorphism( C[ n ], B[ n + index_shift ] ), ZeroMorphism( C[ n ], A[ n + index_shift ] )    , IdentityMorphism( C[ n ] )          ]
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
                    [ ZeroMorphism( A[ n + 2 * index_shift ] , B[ n + index_shift ] ) , ZeroMorphism( A[ n + 2 * index_shift ], C[ n ] ) ],
                    [ IdentityMorphism( B[ n + index_shift ] )          , ZeroMorphism( B[ n + index_shift ], C[ n ] )  ],
                    [ alpha[ n + index_shift ], ZeroMorphism( A[ n + index_shift ], C[ n ] )                           ],
                    [ ZeroMorphism( C[ n ], B[ n + index_shift ] )      , IdentityMorphism( C[ n ] )         ]
                  ]
              ) );
      
      return HomotopyCategoryMorphism( s, r, maps );
          
  end );
  
end );

##
InstallMethod( IsomorphismOntoShiftOfInverseShift,
          [ IsHomotopyCategoryObject ],
  { a } -> IdentityMorphism( a )
);

##
InstallMethod( IsomorphismFromShiftOfInverseShift,
          [ IsHomotopyCategoryObject ],
  { a } -> IdentityMorphism( a )
);

##
InstallMethod( IsomorphismOntoInverseShiftOfShift,
          [ IsHomotopyCategoryObject ],
  { a } -> IdentityMorphism( a )
);

##
InstallMethod( IsomorphismFromInverseShiftOfShift,
          [ IsHomotopyCategoryObject ],
  { a } -> IdentityMorphism( a )
);
