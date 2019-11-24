
BindGlobal( "ADD_TRIANGULATED_STRUCUTRE",

function( homotopy_category )
    
  SetIsTriangulatedCategory( homotopy_category, true );
  
  SetIsTriangulatedCategoryWithShiftAutomorphism( homotopy_category, true );

  ## Adding the shift and reverse shift functors
  AddShiftOfObject( homotopy_category,
    function( C )
      local twist_functor;
      
      twist_functor := ShiftFunctor( homotopy_category, -1 );
    
      return ApplyFunctor( twist_functor, C );
      
  end );

  ##
  AddShiftOfMorphism( homotopy_category, 
      function( phi )
        local twist_functor;
        
        twist_functor := ShiftFunctor( homotopy_category, -1 );
  
      return ApplyFunctor( twist_functor, phi );
  
  end );
  
  ##
  AddReverseShiftOfObject( homotopy_category,
      function( C )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( homotopy_category, 1 );
   
        return ApplyFunctor( reverse_twist_functor, C );
  
  end );
  
  ##
  AddReverseShiftOfMorphism( homotopy_category,
      function( phi )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( homotopy_category, 1 );
      
        return ApplyFunctor( reverse_twist_functor, phi );
  
  end );
  
  ##
  AddIsomorphismIntoShiftOfReverseShift( homotopy_category,
      function( C )
  
        return IdentityMorphism( C );
  
  end );
  
  AddIsomorphismFromShiftOfReverseShift( homotopy_category,
      function( C )
        
        return IdentityMorphism( C );
      
  end );
  
  AddIsomorphismIntoReverseShiftOfShift( homotopy_category,
      function( C )
      
        return IdentityMorphism( C );
  
  end );
  
  AddIsomorphismFromReverseShiftOfShift( homotopy_category,
      function( C )
        
        return IdentityMorphism( C );
  
  end );
  
  AddConeObject( homotopy_category, MappingCone );
  
  ##
  AddCompleteMorphismToStandardExactTriangle( homotopy_category,
      function( phi )
        local i, p;
        
        i := NaturalInjectionInMappingCone( phi );
        
        p := NaturalProjectionFromMappingCone( phi );
        
        return CreateStandardExactTriangle( phi, i, p );
      
  end );
  
  ##
  AddCompleteToMorphismOfStandardExactTriangles( homotopy_category,
      function( tr1, tr2, phi, psi )
        local tr1_0, tr2_0, phi_, psi_, s, maps, tau;
        
        tr1_0 := UnderlyingCell( tr1^0 );
        
        tr2_0 := UnderlyingCell( tr2^0 );
        
        phi_ := UnderlyingCell( phi );
        
        psi_ := UnderlyingCell( psi );
        
        s := HomotopyMorphisms( PreCompose( tr1^0, psi ) - PreCompose( phi, tr2^0 ) );
        
        maps := MapLazy( IntegersList,
                  function( i )
                    return
                      MorphismBetweenDirectSums(
                        [
                          [ phi_[ i - 1 ], s[ i - 1 ] ],
                          [ ZeroMorphism( Source( psi_ )[ i ], Range( phi_ )[ i - 1 ] ), psi_[ i ] ]
                        ] );
                  end, 1 );
        tau := ChainMorphism( 
                UnderlyingCell( tr1[2] ), 
                UnderlyingCell( tr2[2] ),
                maps );
        
        tau := HomotopyCategoryMorphism( homotopy_category, tau );
        
        return CreateTrianglesMorphism( tr1, tr2, phi, psi, tau );
  end );
  
  ##
  AddRotationOfStandardExactTriangle( homotopy_category,
      function( tr )
        local rot, standard_rot, f, X, Y, maps, tau;
      
        rot := CreateExactTriangle( tr^1, tr^2, AdditiveInverse( ShiftOfMorphism( tr^0 ) ) );
      
        standard_rot := CompleteMorphismToStandardExactTriangle( tr^1 );
      
        f := UnderlyingCell( tr^0 );
      
        X := UnderlyingCell( tr[ 0 ] );
      
        Y := UnderlyingCell( tr[ 1 ] );
      
        maps := MapLazy( IntegersList,  
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ AdditiveInverse( f[ i - 1 ] ),
                          IdentityMorphism( X[ i - 1 ] ),
                            ZeroMorphism( X[ i - 1 ], Y[ i ] ) ]
                    ] );
                end, 1 );
      
        tau := ChainMorphism( 
              UnderlyingCell( rot[ 2 ] ),
                UnderlyingCell( standard_rot[ 2 ] ), maps );
      
        tau := HomotopyCategoryMorphism( homotopy_category, tau );
      
        tau := CreateTrianglesMorphism(
                  rot, standard_rot, IdentityMorphism( tr[ 1 ] ), IdentityMorphism( tr[ 2 ] ), tau );
      
        SetIsomorphismIntoStandardExactTriangle( rot, tau );
      
        maps := MapLazy( IntegersList,
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ ZeroMorphism( Y[ i - 1 ], X[ i - 1 ] ) ],
                        [ IdentityMorphism( X[ i - 1 ] )         ], 
                          [ ZeroMorphism( Y[ i ], X[ i - 1 ] )     ]
                    ] );
                end, 1 );
      
        tau := ChainMorphism( 
              UnderlyingCell( standard_rot[ 2 ] ),
              UnderlyingCell( rot[ 2 ] ), maps );
      
        tau := HomotopyCategoryMorphism( homotopy_category, tau );
      
        tau := CreateTrianglesMorphism(
                  standard_rot, rot, IdentityMorphism( tr[ 1 ] ), IdentityMorphism( tr[ 2 ] ), tau );
      
        SetIsomorphismFromStandardExactTriangle( rot, tau );
      
        return rot;
        
  end );

#AddOctahedralAxiom( homotopy_category,
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
#    t1 := HomotopyCategoryMorphism( homotopy_category, t1 );
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
#    t2 := HomotopyCategoryMorphism( homotopy_category, t2 );
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
#    i := HomotopyCategoryMorphism( homotopy_category, i );
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
#    j := HomotopyCategoryMorphism( homotopy_category, j );
#    j := CreateTrianglesMorphism( standard_tr, tr, IdentityMorphism( tr[0] ), IdentityMorphism( tr[1] ), j );
#
#    SetIsomorphismIntoStandardExactTriangle( tr, i );
#    SetIsomorphismFromStandardExactTriangle( tr, j );
#    
#    return tr;
#
#end );

end );

