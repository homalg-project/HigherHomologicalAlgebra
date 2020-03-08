#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

BindGlobal( "ADD_TRIANGULATED_STRUCUTRE",

function( Ho_C )
    
  SetIsTriangulatedCategory( Ho_C, true );
  
  SetIsTriangulatedCategoryWithShiftAutomorphism( Ho_C, true );

  ## Adding the shift and reverse shift functors
  AddShiftOfObject( Ho_C,
    function( C )
      local twist_functor;
      
      twist_functor := ShiftFunctor( Ho_C, -1 );
    
      return ApplyFunctor( twist_functor, C );
      
  end );

  ##
  AddShiftOfMorphism( Ho_C, 
      function( phi )
        local twist_functor;
        
        twist_functor := ShiftFunctor( Ho_C, -1 );
  
      return ApplyFunctor( twist_functor, phi );
  
  end );
  
  ##
  AddReverseShiftOfObject( Ho_C,
      function( C )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( Ho_C, 1 );
   
        return ApplyFunctor( reverse_twist_functor, C );
  
  end );
  
  ##
  AddReverseShiftOfMorphism( Ho_C,
      function( phi )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( Ho_C, 1 );
      
        return ApplyFunctor( reverse_twist_functor, phi );
  
  end );
  
  ##
  AddIsomorphismIntoShiftOfReverseShift( Ho_C, IdentityMorphism );
  
  AddIsomorphismFromShiftOfReverseShift( Ho_C, IdentityMorphism );
  
  AddIsomorphismIntoReverseShiftOfShift( Ho_C, IdentityMorphism );
  
  AddIsomorphismFromReverseShiftOfShift( Ho_C, IdentityMorphism );
  
  AddConeObject( Ho_C, MappingCone );
  
  AddMorphismIntoConeObjectWithGivenConeObject( Ho_C,
    function( phi, C )
      local cell;
      
      cell := UnderlyingCell( phi );
      
      return NaturalInjectionInMappingCone( cell ) / Ho_C;
      
  end );
  
  AddMorphismFromConeObjectWithGivenConeObject( Ho_C,
    function( phi, C )
      local cell;
      
      cell := UnderlyingCell( phi );
      
      return NaturalProjectionFromMappingCone( cell ) / Ho_C;
      
  end );
 
  ##
  AddCompleteMorphismToStandardExactTriangle( Ho_C,
      function( phi )
        local i, p;
        
        i := NaturalInjectionInMappingCone( phi );
        
        p := NaturalProjectionFromMappingCone( phi );
        
        return CreateStandardExactTriangle( phi, i, p );
      
  end );
  
  ##
  AddCompleteToMorphismOfStandardExactTriangles( Ho_C,
      function( tr1, tr2, phi, psi )
        local tr1_0, tr2_0, phi_, psi_, homotopy_maps, maps, tau;
        
        tr1_0 := UnderlyingCell( tr1^0 );
        
        tr2_0 := UnderlyingCell( tr2^0 );
        
        phi_ := UnderlyingCell( phi );
        
        psi_ := UnderlyingCell( psi );
        
        homotopy_maps := HomotopyMorphisms( PreCompose( tr1^0, psi ) - PreCompose( phi, tr2^0 ) );
        
        maps := MapLazy( IntegersList,
                  function( i )
                    return
                      MorphismBetweenDirectSums(
                        [
                          [ phi_[ i - 1 ], homotopy_maps[ i - 1 ] ],
                          [ ZeroMorphism( Source( psi_ )[ i ], Range( phi_ )[ i - 1 ] ), psi_[ i ] ]
                        ] );
                  end, 1 );
        
        tau := ChainMorphism( 
                UnderlyingCell( tr1[2] ), 
                UnderlyingCell( tr2[2] ),
                maps );
        
        tau := HomotopyCategoryMorphism( Ho_C, tau );
        
        return CreateTrianglesMorphism( tr1, tr2, phi, psi, tau );
  end );
  
  ##
  AddRotationOfStandardExactTriangle( Ho_C,
      function( T )
        local rotation, st_rotation, phi, A, B, maps, tau;
      
        rotation := CreateExactTriangle( T ^ 1, T ^ 2, AdditiveInverse( ShiftOfMorphism( T ^ 0 ) ) );
      
        st_rotation := CompleteMorphismToStandardExactTriangle( rotation ^ 0 );
      
        phi := UnderlyingCell( T ^ 0 );
      
        A := UnderlyingCell( T[ 0 ] );
      
        B := UnderlyingCell( T[ 1 ] );
      
        maps := MapLazy( IntegersList,  
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [
                        AdditiveInverse( phi[ i - 1 ] ),
                        IdentityMorphism( A[ i - 1 ] ),
                        ZeroMorphism( A[ i - 1 ], B[ i ] )
                      ]
                    ] );
                end, 1 );
      
        tau := ChainMorphism( 
                  UnderlyingCell( rotation[ 2 ] ),
                    UnderlyingCell( st_rotation[ 2 ] ), maps
                  );
      
        tau := HomotopyCategoryMorphism( CapCategory( T ^ 0 ), tau );
      
        tau := CreateTrianglesMorphism(
                  rotation, st_rotation, IdentityMorphism( T[ 1 ] ), IdentityMorphism( T[ 2 ] ), tau );
      
        SetIsomorphismIntoStandardExactTriangle( rotation, tau );
      
        maps := MapLazy( IntegersList,
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ ZeroMorphism( B[ i - 1 ], A[ i - 1 ] ) ],
                      [ IdentityMorphism( A[ i - 1 ] ) ],
                      [ ZeroMorphism( B[ i ], A[ i - 1 ] ) ]
                    ] );
                end, 1 );
      
        tau := ChainMorphism( 
                UnderlyingCell( st_rotation[ 2 ] ),
                  UnderlyingCell( rotation[ 2 ] ), maps
                );
      
        tau := HomotopyCategoryMorphism( CapCategory( T ^ 0 ), tau );
      
        tau := CreateTrianglesMorphism(
                  st_rotation, rotation, IdentityMorphism( T[ 1 ] ), IdentityMorphism( T[ 2 ] ), tau );
      
        SetIsomorphismFromStandardExactTriangle( rotation, tau );
      
        return rotation;
        
  end );
  
  ##
  AddReverseRotationOfStandardExactTriangle( Ho_C,
      function( T )
        local rotation, st_rotation, phi, A, B, maps, tau;
      
        rotation := CreateExactTriangle( AdditiveInverse( Shift( T ^ 2, -1 ) ), T ^ 0, T ^ 1 );
      
        st_rotation := CompleteMorphismToStandardExactTriangle( rotation ^ 0 );
      
        phi := UnderlyingCell( T ^ 0 );
      
        A := UnderlyingCell( T[ 0 ] );
      
        B := UnderlyingCell( T[ 1 ] );
      
        maps := MapLazy( IntegersList,  
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ ZeroMorphism( A[ i - 1 ], B[ i ] ) ],
                      [ IdentityMorphism( B[ i ] ) ],
                      [ phi[ i ] ]
                    ] );
                end, 1 );
      
        tau := ChainMorphism( 
                UnderlyingCell( st_rotation[ 2 ] ),
                  UnderlyingCell( rotation[ 2 ] ),
                    maps );
      
        tau := HomotopyCategoryMorphism( CapCategory( T ^ 0 ), tau );
      
        tau := CreateTrianglesMorphism(
                  st_rotation, rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), tau );
      
        SetIsomorphismFromStandardExactTriangle( rotation, tau );
      
        maps := MapLazy( IntegersList,
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
                end, 1 );
      
        tau := ChainMorphism(
                  UnderlyingCell( rotation[ 2 ] ), 
                  UnderlyingCell( st_rotation[ 2 ] ),
                  maps );
      
        tau := HomotopyCategoryMorphism( CapCategory( T ^ 0 ), tau );
      
        tau := CreateTrianglesMorphism(
                  rotation, st_rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), tau );
      
        SetIsomorphismIntoStandardExactTriangle( rotation, tau );
      
        return rotation;
        
  end );

#AddOctahedralAxiom( Ho_C,
#    function( f_, g_ )
#    local h_, f, g, h, X, Y, Z, t0, t1, t2, t, tf_, th_, tr, i, j, standard_tr;
#    h_ := PreCompose( f_, g_ );
#    f := UnderlyingReplacement( f_ );
#    g := UnderlyingReplacement( g_ );
#    h := UnderlyingReplacement( h_ );
#    X := Source( f );
#    Y := Range( f );
#    Z := Range( g );
#
#    tf_ := CompleteMorphismToStandardExactTriangle( f_ );
#    th_ := CompleteMorphismToStandardExactTriangle( h_ );
#
#    t := CompleteToMorphismOfStandardExactTriangles( tf_, th_, IdentityMorphism( Source( f_ ) ), g_ );
#    t0 := t[ 2 ];
#
#    t1 := MapLazy( IntegersList, 
#            function( i ) 
#                return MorphismBetweenDirectSums(
#                    [
#                        [ f[ i - 1 ], ZeroMorphism( X[ i - 1 ], Z[ i ] )],
#                        [ ZeroMorphism( Z[ i ], Y[ i - 1 ] ), IdentityMorphism( Z[ i ] ) ]
#                    ]
#                );
#            end, 1 );
#    t1 := ChainMorphism( MappingCone( h ), MappingCone( g ), t1 );
#    t1 := HomotopyCategoryMorphism( Ho_C, t1 );
#
#    t2 := MapLazy( IntegersList, 
#            function( i ) 
#                return MorphismBetweenDirectSums(
#                    [
#                        [ ZeroMorphism( Y[ i - 1 ], X[ i - 2 ] ), IdentityMorphism( Y[ i - 1 ] ) ],
#                        [ ZeroMorphism( Z[ i ], X[ i - 2 ] ), ZeroMorphism( Z[ i ], Y[ i - 1 ] ) ]
#                    ]
#                );
#            end, 1 );
#    t2 := ChainMorphism( MappingCone( g ), ShiftLazy( MappingCone( f ), -1 ), t2 );
#    t2 := HomotopyCategoryMorphism( Ho_C, t2 );
#
#
#    tr := CreateExactTriangle( t0, t1, t2 );
#
#    standard_tr := CompleteMorphismToStandardExactTriangle( t0 );
#
#    i := MapLazy( IntegersList, 
#            function( i )
#            return MorphismBetweenDirectSums( 
#                [
#                    [ ZeroMorphism( Y[i-1], X[i-2] ), IdentityMorphism( Y[i-1] ), ZeroMorphism( Y[i-1], X[i-1] ), ZeroMorphism( Y[i-1], Z[i] ) ],
#                    [ ZeroMorphism( Z[i], X[i-2] ), ZeroMorphism( Z[i], Y[i-1] ), ZeroMorphism( Z[i], X[i-1] ), IdentityMorphism( Z[i] ) ] 
#                ]
#            );
#            end, 1 );
#    i := ChainMorphism( MappingCone( g ), MappingCone( UnderlyingMor( t0 ) ), i );
#    i := HomotopyCategoryMorphism( Ho_C, i );
#    i := CreateTrianglesMorphism( tr, standard_tr, IdentityMorphism( tr[0] ), IdentityMorphism( tr[1] ), i );
#
#    j := MapLazy( IntegersList, 
#            function( i )
#            return MorphismBetweenDirectSums( 
#                [
#                    [  ZeroMorphism( X[i-2], Y[i-1] ), ZeroMorphism(  X[i-2], Z[i] ) ],
#                    [  IdentityMorphism( Y[i-1] ),     ZeroMorphism(  Y[i-1], Z[i] ) ],
#                    [  f[i-1], ZeroMorphism(  X[i-1], Z[i] ) ],
#                    [  ZeroMorphism( Z[i], Y[i-1]   ), IdentityMorphism( Z[i] ) ] 
#                ]
#            );
#            end, 1 );
#    
#    j := ChainMorphism( MappingCone( UnderlyingMor( t0 ) ), MappingCone( g ), j );
#    j := HomotopyCategoryMorphism( Ho_C, j );
#    j := CreateTrianglesMorphism( standard_tr, tr, IdentityMorphism( tr[0] ), IdentityMorphism( tr[1] ), j );
#
#    SetIsomorphismIntoStandardExactTriangle( tr, i );
#    SetIsomorphismFromStandardExactTriangle( tr, j );
#    
#    return tr;
#
#end );

end );

