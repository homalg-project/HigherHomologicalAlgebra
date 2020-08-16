#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

BindGlobal( "ADD_FUNCTIONS_FOR_TRIANGULATED_OPERATIONS",

function( Ho_C )
  local complex_cat, N;
  
  SetFilterObj( Ho_C, IsTriangulatedCategory );
  
  complex_cat := UnderlyingCategory( Ho_C );
  
  if IsChainComplexCategory( complex_cat ) then
    N := -1;
  else
    N := 1;
  fi;
  
  ## Adding the shift and reverse shift functors
  AddShiftOnObject( Ho_C,
    function( C )
      local F;
      
      F := ShiftFunctor( Ho_C, N );
      
      return ApplyFunctor( F, C );
      
  end );
  
  ##
  AddShiftOnMorphismWithGivenObjects( Ho_C,
    function( s, phi, r )
      local F;
      
      F := ShiftFunctor( Ho_C, N );
      
      return ApplyFunctor( F, phi );
      
  end );
  
  ##
  AddInverseShiftOnObject( Ho_C,
      function( C )
        local F;
        
        F := ShiftFunctor( Ho_C, -N );
   
        return ApplyFunctor( F, C );
  
  end );
  
  ##
  AddInverseShiftOnMorphismWithGivenObjects( Ho_C,
      function( s, phi, r )
        local F;
        
        F := ShiftFunctor( Ho_C, -N );
      
        return ApplyFunctor( F, phi );
  
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
     function( s, alpha, mu, nu, beta, r )
       local homotopy_maps, maps;
       
       homotopy_maps := HomotopyMorphisms( PreCompose( alpha, nu ) - PreCompose( mu, beta ) );
       
       maps := AsZFunction(
                 function( i )
                   return
                     MorphismBetweenDirectSums(
                      [
                        [
                          mu[ i + N ],
                          homotopy_maps[ i + N ]
                        ],
                        [
                          ZeroMorphism( Source( nu )[ i ], Range( mu )[ i + N ] ),
                          nu[ i ]
                        ]
                      ] );
                 end );
                 
       return HomotopyCategoryMorphism( s, r, maps );
       
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
                        AdditiveInverse( alpha[ i + N ] ),
                        IdentityMorphism( A[ i + N ] ),
                        ZeroMorphism( A[ i + N ], B[ i ] )
                      ]
                    ] );
                end );
                
      return HomotopyCategoryMorphism( s, maps, r );
      
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
                      [ ZeroMorphism( B[ i + N ], A[ i + N ] ) ],
                      [ IdentityMorphism( A[ i + N ] ) ],
                      [ ZeroMorphism( B[ i ], A[ i + N ] ) ]
                    ] );
                    
                end );
       
      return HomotopyCategoryMorphism( s, maps, r );
      
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
                        ZeroMorphism( B[ i ], A[ i + N ] ),
                        IdentityMorphism( B[ i ] ),
                        ZeroMorphism( B[ i ], A[ i ] )
                      ]
                    ] );
                end );
                
      return HomotopyCategoryMorphism( s, maps, r );
        
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
                        [ ZeroMorphism( A[ i + N ], B[ i ] ) ],
                        [ IdentityMorphism( B[ i ] ) ],
                        [ alpha[ i ] ]
                      ] );
                end );
                
      return HomotopyCategoryMorphism( s, maps, r );
        
  end );
  
  ## Can be derived, but here is a direct implementation    
  ##
  AddDomainMorphismByOctahedralAxiomWithGivenObjects( Ho_C,
    function( s, alpha, beta, gamma, r )
      local A, id_A;
      
      A := Source( alpha );
      
      id_A := IdentityMorphism( A );
      
      return MorphismBetweenStandardConeObjectsWithGivenObjects( s, alpha, id_A, beta, gamma, r );
      
  end );
  
  ##
  AddMorphismIntoConeObjectByOctahedralAxiomWithGivenObjects( Ho_C,
    function( s, alpha, beta, gamma, r )
      local A, B, C, h, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      C := Range( beta );
      
      h := HomotopyMorphisms( PreCompose( alpha, beta ) - gamma );
      
      maps := AsZFunction(
                i -> MorphismBetweenDirectSums(
                  [
                    [
                      alpha[ i + N ],
                      -h[ i + N ]
                    ],
                    [
                      ZeroMorphism( C[ i ], B[ i + N ] ),
                      IdentityMorphism( C[ i ] )
                    ],
                  ]
                )
              );
              
      return HomotopyCategoryMorphism( s, maps, r );
       
  end );
  
  ## Can be derived, but here is a direct implementation
  ##
  AddMorphismFromConeObjectByOctahedralAxiomWithGivenObjects( Ho_C,
    function( s, alpha, beta, gamma, r )
      local A, B, C, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      C := Range( beta );
      
      maps := AsZFunction(
                i -> MorphismBetweenDirectSums(
                  [
                    [ 
                      ZeroMorphism( B[ i + N ], A[ i + 2 * N ] ),
                      IdentityMorphism( B[ i + N ] )
                    ],
                    [
                      ZeroMorphism( C[ i ], A[ i + 2 * N ]  ),
                      ZeroMorphism( C[ i ], B[ i + N ] )
                    ],
                  ]
                ) 
              );
              
      return HomotopyCategoryMorphism( s, maps, r );
      
  end );
  
  ##
  AddWitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects( Ho_C,
    function( s, alpha, beta, gamma, r )
      local A, B, C, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      C := Range( beta );
     
      maps := AsZFunction(
                i -> MorphismBetweenDirectSums(
                  [
                    [
                      ZeroMorphism( B[ i + N ], A[ i + 2 * N ] ),
                      IdentityMorphism( B[ i + N ] ),
                      ZeroMorphism( B[ i + N ], A[ i + N ] ),
                      ZeroMorphism( B[ i + N ], C[ i ] )
                    ],
                    [
                      ZeroMorphism( C[ i ] , A[ i + 2 * N ] ),
                      ZeroMorphism( C[ i ], B[ i + N ] ),
                      ZeroMorphism( C[ i ], A[ i + N ] ),
                      IdentityMorphism( C[ i ] )
                    ]
                  ]
                )
              );
              
      return HomotopyCategoryMorphism( s, maps, r );
      
  end );

  ##
  AddWitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( Ho_C,
    function( s, alpha, beta, gamma, r )
      local A, B, C, h, maps;
      
      A := Source( alpha );
      
      B := Range( alpha );
      
      C := Range( beta );
      
      h := HomotopyMorphisms( PreCompose( alpha, beta ) - gamma );
      
      maps := AsZFunction(
                i -> MorphismBetweenDirectSums(
                  [
                    [
                      ZeroMorphism( A[ i + 2 * N ], B[ i + N ] ),
                      ZeroMorphism( A[ i + 2 * N ], C[ i ] )
                    ],
                    [
                      IdentityMorphism( B[ i + N ] ),
                      ZeroMorphism( B[ i + N ], C[ i ] )
                    ],
                    [
                      alpha[ i + N ],
                      -h[ i + N ]
                    ],
                    [
                      ZeroMorphism( C[ i ], B[ i + N ] ),
                      IdentityMorphism( C[ i ] )
                    ]
                  ]
                )
              );
              
      return HomotopyCategoryMorphism( s, maps, r );
      
  end );
  
end );

##
InstallMethod( IsomorphismOntoShiftOfInverseShift,
          [ IsHomotopyCategoryObject ],
  a -> IdentityMorphism( a )
);

##
InstallMethod( IsomorphismFromShiftOfInverseShift,
          [ IsHomotopyCategoryObject ],
  a -> IdentityMorphism( a )
);

##
InstallMethod( IsomorphismOntoInverseShiftOfShift,
          [ IsHomotopyCategoryObject ],
  a -> IdentityMorphism( a )
);

##
InstallMethod( IsomorphismFromInverseShiftOfShift,
          [ IsHomotopyCategoryObject ],
  a -> IdentityMorphism( a )
);

# It is true in any triangulated category, but I don't have time for a clean implementation
##
BindGlobal( "3x3LemmaInHomotopyCategory",
  function( f, u, v, g )
    local Ho, N, A, B, C, D, w, t, s, r, maps;
    
    Ho := CapCategory( f );
    
    if IsChainComplexCategory( UnderlyingCategory( Ho ) ) then
      
      N := -1;
      
    else
      
      N := 1;
      
    fi;
    
    A := Source( f );
    
    B := Range( f );
    
    C := Source( g );
    
    D := Range( g );
    
    w := MorphismBetweenStandardConeObjects( f, u, v, g );
    
    t := MorphismBetweenStandardConeObjects( u, f, g, v );
    
    s := StandardConeObject( t );
    
    r := StandardConeObject( w );
    
    maps := AsZFunction(
                i -> MorphismBetweenDirectSums(
                        [
                          [
                            AdditiveInverse( IdentityMorphism( A[ i + 2 * N ] ) ),
                            ZeroMorphism( A[ i + 2 * N ], B[ i + N ]  ),
                            ZeroMorphism( A[ i + 2 * N ], C[ i + N ]  ),
                            ZeroMorphism( A[ i + 2 * N ], D[ i ] )
                          ],
                          [
                            ZeroMorphism( C[ i + N ], A[ i + 2 * N ] ),
                            ZeroMorphism( C[ i + N ], B[ i + N ]  ),
                            IdentityMorphism( C[ i + N ]  ),
                            ZeroMorphism( C[ i + N ], D[ i ] )
                          ],
                          [
                            ZeroMorphism( B[ i + N ], A[ i + 2 * N ] ),
                            IdentityMorphism( B[ i + N ]  ),
                            ZeroMorphism( B[ i + N ], C[ i + N ]  ),
                            ZeroMorphism( B[ i + N ], D[ i ] )
                          ],
                          [
                            ZeroMorphism( D[ i ], A[ i + 2 * N ] ),
                            ZeroMorphism( D[ i ], B[ i + N ]  ),
                            ZeroMorphism( D[ i ], C[ i + N ] ),
                            IdentityMorphism( D[ i ]  )
                          ],
                        ]
                    )
                );
                
    return HomotopyCategoryMorphism( s, maps, r );
    
end );


