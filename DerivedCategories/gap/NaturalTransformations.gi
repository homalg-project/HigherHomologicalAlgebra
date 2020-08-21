#############################################################################
##
## DerivedCategories: Derived categories for abelian categories
##
## Copyright 2020, Kamal Saleh, University of Siegen
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
InstallMethod( COMPUTE_ISOMORPHISM,
        [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local N, iota;
    
    N := ExceptionalShift( a, collection );
    
    iota := Shift( COMPUTE_STANDARD_ISOMORPHISM( Shift( a, N ), collection ), -N );
    
    Assert( 0, IsEqualForObjects( Source( iota ), PreCompose( ReplacementFunctor( collection ), ConvolutionFunctor( collection ) )( a ) ) );
    
    return iota;
    
end );

##
InstallMethodWithCache( COMPUTE_STANDARD_ISOMORPHISM,
        [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local I, data, r, H, z_func, func;
    
    if not IsIdenticalObj( CapCategory( a ), AmbientCategory( collection ) ) then
      
      Error( "Wrong input" );
      
    fi;
    
    I := EmbeddingFunctorFromHomotopyCategory( collection );
    
    data := EXCEPTIONAL_REPLACEMENT_DATA( a, collection );
    
    r := UnderlyingCell( I( ExceptionalReplacement( a, collection, true ) ) );
    
    H := CapCategory( r );
    
    z_func := VoidZFunction( );
    
    func :=
      function( n )
        local t_n, st_t_n, shift_st_t_n, t_0, st_t_0, U, j_n, st_j_n, shift_st_j_n, t;
        
        if n < 1 then
          
          return true;
          
        elif n = 1 then
          
          t_n := data[ n ][ 1 ];
          st_t_n := StandardExactTriangle( t_n );
          shift_st_t_n := Shift( st_t_n, n - 1 );
          
          t_0 := data[ n - 1 ][ 1 ];
          st_t_0 := StandardExactTriangle( t_0 );
          U := InverseRotation( st_t_0, true );
          
          j_n := BackwardPostnikovSystemAt( r, n - 1 ) ^ n;
          st_j_n := StandardExactTriangle( j_n );
          shift_st_j_n := Shift( st_j_n, n - 1 );
          
          Assert( 4, IsCongruentForMorphisms( PreCompose( shift_st_t_n^0, U^0 ), shift_st_j_n^0 ) );
          
          return [ shift_st_t_n, U, shift_st_j_n ];
          
        elif n <= ActiveUpperBound( r ) + 1 then
          
          t_n := data[ n ][ 1 ];
          st_t_n := StandardExactTriangle( t_n );
          shift_st_t_n := Shift( st_t_n, n - 1 );
          
          t := z_func[ n - 1 ];
          
          U := ExactTriangleByOctahedralAxiom( t[ 1 ], t[ 2 ], t[ 3 ], true );
          
          j_n := BackwardPostnikovSystemAt( r, n - 1 ) ^ n;
          st_j_n := StandardExactTriangle( j_n );
          shift_st_j_n := Shift( st_j_n, n - 1 );
          
          Assert( 4, IsCongruentForMorphisms(
                          PreCompose( [ shift_st_t_n^0, U^0, t[ 3 ]^2 ] ),
                          PreCompose( shift_st_j_n^0, t[ 3 ]^2 )
                        ) );
          
          return [ shift_st_t_n, U, shift_st_j_n ];
          
        else
          
          return true;
          
        fi;
        
      end;
      
    SetUnderlyingFunction( z_func, func );
    
    return z_func[ ActiveUpperBound( r ) + 1 ][ 2 ]^1;
    
end );
