#
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
##  NaturalTransformations
##
#############################################################################

##
InstallMethod( UnitOfTensorHomAdjunction,
          [ IsExceptionalCollection ],
  function( collection )
    local full, ambient_cat, HH, TT, D, k, name, nat;
    
    full := DefiningFullSubcategory( collection );
    
    ambient_cat := AmbientCategory( full );
   
    if not ( HasIsAbelianCategory( ambient_cat ) and IsAbelianCategory( ambient_cat ) ) then
      
      TryNextMethod( );
      
    fi;
   
    HH := HomFunctor( collection );
    
    TT := TensorFunctor( collection );
    
    D := SourceOfFunctor( TT );
    
    k := CommutativeRingOfLinearCategory( D );
    
    name := "Id -> Hom(T, -⊗_{End T} T)";
    
    nat := NaturalTransformation( name, IdentityFunctor( D ), PreCompose( TT, HH ) );
    
    AddNaturalTransformationFunction( nat,
      function( id_r, r, th_r )
        local pr, pr_summands, tr, defining_morphism, coker_epi, a, min_gen, positions, htr, vec_spaces, zero_vectors, maps, e, map, i;
        
        pr := SomeProjectiveObject( r );
        
        pr_summands := UnderlyingProjectiveSummands( pr );
        
        tr := ApplyFunctor( TT, r );
         
        defining_morphism := tr!.embedded_defining_morphism_of_cokernel_object;
        
        coker_epi := CokernelProjection( defining_morphism );
        
        a := ObjectList( Range( tr!.defining_morphism_of_cokernel_object ) );
        
        a := List( a, UnderlyingCell );
        
        a := List( [ 1 .. Size( a ) ], i -> InjectionOfCofactorOfDirectSum( a, i ) );
        
        a := List( a, i -> PreCompose( i, coker_epi ) );
        
        a := List( a, CoefficientsOfMorphism );
        
        min_gen := MinimalGeneratingSet( r );
        
        min_gen := List( min_gen, g -> ElementVectors( g ) );
        
        positions := List( min_gen, g -> PositionProperty( g, v -> not IsZero( v ) ) );
               
        htr := ApplyFunctor( HH, tr );
        
        vec_spaces := VectorSpacesOfRepresentation( htr );
        
        zero_vectors := List( vec_spaces, Zero );
        
        maps := [ ];
 
        for i in [ 1 .. Size( min_gen ) ] do
          
          if IsZero( a[ i ] ) then
            
            Add( maps, ZeroMorphism( pr_summands[ i ], htr ) );
            
          else
            
            e := ShallowCopy( zero_vectors );
            
            e[ positions[ i ] ] := Vector( vec_spaces[ positions[ i ] ], a[ i ] );
            
            Add( maps, HomFromProjective( QuiverRepresentationElementNC( htr, e ), htr ) );
          
          fi;
          
        od;
        
        map := MorphismBetweenDirectSums( pr, TransposedMat( [ maps ] ), htr );
        
        return ColiftAlongEpimorphism( EpimorphismFromSomeProjectiveObject( r ), map );
        
    end );
    
    return nat;
    
end );

##
InstallMethod( CounitOfTensorHomAdjunction,
          [ IsExceptionalCollection ],
  function( collection )
    local full, ambient_cat, HH, TT, C, k, name, nat;
    
    full := DefiningFullSubcategory( collection );
    
    ambient_cat := AmbientCategory( full );
    
    if not ( HasIsAbelianCategory( ambient_cat ) and IsAbelianCategory( ambient_cat ) ) then
      
      TryNextMethod( );
      
    fi;
    
    HH := HomFunctor( collection );
    
    TT := TensorFunctor( collection );
    
    C := SourceOfFunctor( HH );
    
    k := CommutativeRingOfLinearCategory( C );
    
    name := "Hom(T,-) ⊗_{End T} T --> Id";
    
    nat := NaturalTransformation( name, PreCompose( HH, TT ), IdentityFunctor( C ) );
    
    AddNaturalTransformationFunction( nat,
      function( ht_a, a, id_a )
        local ha, min_gen, positions, vectors, positions_of_non_zeros, mor;
        
        ha := ApplyFunctor( HH, a );
        
        min_gen := MinimalGeneratingSet( ha );
        
        if IsEmpty( min_gen ) then
          
          return ZeroMorphism( ht_a, id_a );
          
        fi;
        
        min_gen := List( min_gen, g -> ElementVectors( g ) );
        
        positions := List( min_gen, g -> PositionProperty( g, v -> not IsZero( v ) ) );
        
        vectors := ListN( min_gen, positions, { g, p } -> AsList( g[ p ] ) );
        
        positions_of_non_zeros := List( vectors, v -> PositionsProperty( v, e -> not IsZero( e ) ) );
        
        mor := List( [ 1 .. Size( min_gen ) ],
          i -> vectors[ i ]{ positions_of_non_zeros[ i ] } * 
                  BasisOfExternalHom(
                    UnderlyingCell( collection[ positions[ i ] ] ), a )
                      { positions_of_non_zeros[ i ] }
              );
        
        mor := MorphismBetweenDirectSums( TransposedMat( [ mor ] ) );
        
        return CokernelColift( ht_a!.embedded_defining_morphism_of_cokernel_object, mor );
        
      end );
    
    return nat;
  
end );

##
InstallMethod( UnitOfConvolutionReplacementAdjunction,
          [ IsExceptionalCollection ],
          
  function( collection )
    local ambient_cat, F, G, name, nat;
    
    ambient_cat := AmbientCategory( collection );
    
    F := ConvolutionFunctor( collection );
    
    G := ReplacementFunctor( collection );
    
    name := "Id( - ) -> Rep( Conv( - ) )";
    
    nat := NaturalTransformation( name, IdentityFunctor( ambient_cat ), PostCompose( G, F ) );
    
    AddNaturalTransformationFunction( nat,
      ReturnNothing # It must be similar to counit, it must use the octahedral axiom!
    );
   
    return;
    
end );

##
InstallMethod( CounitOfConvolutionReplacementAdjunction,
          [ IsExceptionalCollection ],
          
  function( collection )
    local ambient_cat, F, G, name, nat;
    
    ambient_cat := AmbientCategory( collection );
    
    F := ConvolutionFunctor( collection );
    
    G := ReplacementFunctor( collection );
    
    name := "Conv( Rep( - ) ) --> Id( - )";
    
    nat := NaturalTransformation( name, PreCompose( G, F ), IdentityFunctor( ambient_cat ) );
    
    AddNaturalTransformationFunction( nat,
    
      { F_o_G_A, A, id_A } -> COMPUTE_ISOMORPHISM( A, collection )
    );
    
    return nat;
    
end );
    
##
InstallMethod( COMPUTE_ISOMORPHISM,
        [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local N, iota;
    
    N := MaximalExceptionalShift( a, collection );
    
    iota := Shift( COMPUTE_STANDARD_ISOMORPHISM( Shift( a, N ), collection ), -N );
    
    Assert( 2, IsEqualForObjects( Source( iota ), PreCompose( ReplacementFunctor( collection ), ConvolutionFunctor( collection ) )( a ) ) );
    
    return iota;
    
end );

##
InstallMethodWithCache( COMPUTE_STANDARD_ISOMORPHISM,
        [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( A, collection )
    local ambient_cat, complexes_cat, I, data, R, z_func, func;
    
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if not IsChainComplexCategory( complexes_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    if not IsIdenticalObj( CapCategory( A ), ambient_cat ) then
      
      Error( "The object should belong to the ambient category of the exceptional collection!\n" );
      
    fi;
    
    I := EmbeddingFunctorFromHomotopyCategory( collection );
    
    data := ExceptionalReplacementData( A, collection );
    
    R := UnderlyingCell( I( ExceptionalReplacement( A, collection, true ) ) );
    
    complexes_cat := CapCategory( R );
    
    z_func := VoidZFunction( );
    
    func :=
      function( n )
        local r_1, st_r_1, r_0, st_r_0, U, j_1, st_j_1, r_n, st_r_n, shift_st_r_n, t, j_n, st_j_n, shift_st_j_n;
        
        if n < 1 then
          
          return true;
          
        elif n = 1 then
          
          r_1 := data[ n ][ 1 ];
          st_r_1 := StandardExactTriangle( r_1 );
          
          r_0 := data[ n - 1 ][ 1 ];
          st_r_0 := StandardExactTriangle( r_0 );
          U := ExactTriangle(
                  Shift( st_r_0^2, -1 ),
                  st_r_0^0,
                  AdditiveInverseForMorphisms( st_r_0^1 )
                );
          
          j_1 := BackwardPostnikovSystemAt( R, n - 1 ) ^ n;
          st_j_1 := StandardExactTriangle( j_1 );
          
          Assert( 2, IsCongruentForMorphisms( PreCompose( st_r_1^0, U^0 ), st_j_1^0 ) );
          
          return [ st_r_1, U, st_j_1 ];
          
        elif n <= ActiveUpperBound( R ) + 1 then
          
          r_n := data[ n ][ 1 ];
          st_r_n := StandardExactTriangle( r_n );
          shift_st_r_n := Shift( st_r_n, n - 1 );
          
          t := z_func[ n - 1 ];
          
          U := ExactTriangleByOctahedralAxiom( t[ 1 ], t[ 2 ], t[ 3 ], true );
          
          j_n := BackwardPostnikovSystemAt( R, n - 1 ) ^ n;
          st_j_n := StandardExactTriangle( j_n );
          shift_st_j_n := Shift( st_j_n, n - 1 );
          
          Assert( 2, IsCongruentForMorphisms(
                          PreCompose( [ shift_st_r_n^0, U^0, t[ 3 ]^2 ] ),
                          PreCompose( shift_st_j_n^0, t[ 3 ]^2 )
                        ) );
          
          return [ shift_st_r_n, U, shift_st_j_n ];
          
        else
          
          return true;
          
        fi;
        
      end;
      
    SetUnderlyingFunction( z_func, func );
    
    return z_func[ ActiveUpperBound( R ) + 1 ][ 2 ]^1;
    
end );

##
InstallMethodWithCache( COMPUTE_STANDARD_ISOMORPHISM,
        [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( A, collection )
    local ambient_cat, complexes_cat, I, data, R, z_func, func;
    
    ambient_cat := AmbientCategory( collection );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if not IsCochainComplexCategory( complexes_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    if not IsIdenticalObj( CapCategory( A ), ambient_cat ) then
      
      Error( "The object should belong to the ambient category of the exceptional collection!\n" );
      
    fi;
    
    I := EmbeddingFunctorFromHomotopyCategory( collection );
    
    data := ExceptionalReplacementData( A, collection );
    
    R := UnderlyingCell( I( ExceptionalReplacement( A, collection, true ) ) );
    
    complexes_cat := CapCategory( R );
    
    z_func := VoidZFunction( );
    
    func :=
      function( n )
        local r_m1, st_r_m1, r_0, st_r_0, U, j_m1, st_j_m1, r_n, st_r_n, shift_st_r_n, t, j_n, st_j_n, shift_st_j_n;
        
        if n > -1 then
          
          return true;
          
        elif n = -1 then
          
          r_m1 := data[ n ][ 1 ];
          st_r_m1 := StandardExactTriangle( r_m1 );
          
          r_0 := data[ n + 1 ][ 1 ];
          st_r_0 := StandardExactTriangle( r_0 );
          U := ExactTriangle(
                  Shift( st_r_0^2, -1 ),
                  st_r_0^0,
                  AdditiveInverseForMorphisms( st_r_0^1 )
                );
          
          j_m1 := BackwardPostnikovSystemAt( R, n + 1 ) ^ n;
          st_j_m1 := StandardExactTriangle( j_m1 );
          
          Assert( 2, IsCongruentForMorphisms( PreCompose( st_r_m1^0, U^0 ), st_j_m1^0 ) );
          
          return [ st_r_m1, U, st_j_m1 ];
          
        elif n >= ActiveLowerBound( R ) - 1 then
          
          r_n := data[ n ][ 1 ];
          st_r_n := StandardExactTriangle( r_n );
          shift_st_r_n := Shift( st_r_n, - n - 1 );
          
          t := z_func[ n + 1 ];
          
          U := ExactTriangleByOctahedralAxiom( t[ 1 ], t[ 2 ], t[ 3 ], true );
          
          j_n := BackwardPostnikovSystemAt( R, n + 1 ) ^ n;
          st_j_n := StandardExactTriangle( j_n );
          shift_st_j_n := Shift( st_j_n, -n - 1 );
          
          Assert( 2, IsCongruentForMorphisms(
                          PreCompose( [ shift_st_r_n^0, U^0, t[ 3 ]^2 ] ),
                          PreCompose( shift_st_j_n^0, t[ 3 ]^2 )
                        ) );
          
          return [ shift_st_r_n, U, shift_st_j_n ];
          
        else
          
          return true;
          
        fi;
        
      end;
      
    SetUnderlyingFunction( z_func, func );
    
    return z_func[ ActiveLowerBound( R ) - 1 ][ 2 ]^1;
    
end );
