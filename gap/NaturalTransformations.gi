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
    
    D := AsCapCategory( Source( TT ) );
    
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
    
    C := AsCapCategory( Source( HH ) );
    
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

#######################
# a, collection
# I := EmbeddingFunctorFromHomotopyCategory( collection );
# rep_a := ReplacementFunctor( collection )( a );
# rep_a := UnderlyingCell( I( rep_a ) );
# gamma_rep_a := { rep_a, i }-> BackwardConvolution( rep_a, i - 1 ) ^ ( i + 1 );
# for i>-1
# Range( gamma_rep_a( rep_a, i ) )
#   = Shift( BackwardConvolution( BrutalTruncationAbove( rep_a, i + 1 ) ), -i );
# triangle_rep_a := {rep_a,i} -> ExactTriangle( gamma_rep_a( rep_a, i ) );
# for i>-1
# triangle_rep_a(rep_a,i)[0]=rep_a[i+1];
# i > 0;; t := triangle_rep_a( rep_a, i );
# shift_t := ExactTriangle( (-1)^(i-1) * Shift( t^0, i-1 ), Shift( t^1, i-1 ), Shift( t^2, i-1 ) );

BindGlobal( "NATURAL",
  function( a, collection )
    local I, N, data, rep_a, z_func, func;
    
    I := EmbeddingFunctorFromHomotopyCategory( collection );
    
    N := ExceptionalShift( a, collection );
    
    if N <> 0 then
      
      Error( "??" );
      
    fi;
    
    data := EXCEPTIONAL_REPLACEMENT_DATA( a, collection );
    
    rep_a := I( ExceptionalReplacement( a, collection, true ) );
    
    rep_a := UnderlyingCell( rep_a ); 
    
    ### creating the first exact triangle
    z_func := VoidZFunction( ); 
    
    func :=
      function( n )
        local alpha_n, t_alpha_n, shift_t_alpha_n, triangle, gamma_n, t_gamma_n, shift_t_gamma_n, t, lambda_n, iota_lambda_n, pi_lambda, shift_t_lambda_n;
        
        if n < N + 1 then
          
          return true;
          
        elif n =  N + 1 then
        
          alpha_n := data[ n ][ 1 ];
          t_alpha_n := StandardExactTriangle( alpha_n );
          shift_t_alpha_n := Shift( t_alpha_n, n - 1 );
          
          triangle := InverseRotation( StandardExactTriangle( data[ n - 1 ][ 1 ] ), true );
          
          gamma_n := BackwardConvolution( rep_a, n - 2 ) ^ n;
          t_gamma_n := StandardExactTriangle( gamma_n );
          shift_t_gamma_n := Shift( t_gamma_n, n - 1 );
          
          return [ shift_t_alpha_n, triangle, shift_t_gamma_n ];
          
        else
    
          alpha_n := data[ n ][ 1 ];
          t_alpha_n := StandardExactTriangle( alpha_n );
          shift_t_alpha_n := Shift( t_alpha_n, n - 1 );
          
          t := z_func[ n - 1 ];
          
          t := ExactTriangleByOctahedralAxiom( t[ 1 ], t[ 2 ], t[ 3 ], true );
          
          gamma_n := BackwardConvolution( rep_a, n - 2 ) ^ n;
          t_gamma_n := StandardExactTriangle( gamma_n );
          shift_t_gamma_n := Shift( t_gamma_n, n - 1 );
          
          lambda_n := ChainMorphism( StalkChainComplex( rep_a[ n ], n - 1 ), BrutalTruncationAbove( rep_a, n ), [ rep_a^n ], n - 1 );
          iota_lambda_n := NaturalInjectionInMappingCone( lambda_n );
          pi_lambda := NaturalProjectionFromMappingCone( lambda_n );
          shift_t_lambda_n := ExactTriangle( Convolution( lambda_n ), Convolution( iota_lambda_n ), Convolution( pi_lambda ) );
          
          return [ shift_t_alpha_n, t, shift_t_gamma_n ];
        
        fi;
      
      end;
      
    SetUnderlyingFunction( z_func, func );
    
    
end );
