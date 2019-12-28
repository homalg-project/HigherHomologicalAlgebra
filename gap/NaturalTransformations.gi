


BindGlobal( "NAT",
  function( collection )
    local HH, TT, C, k, name, nat;
    
    HH := HomFunctorByExceptionalCollection( collection );
    
    TT := TensorFunctorByExceptionalCollection( collection );
    
    C := AsCapCategory( Source( HH ) );
    
    k := CommutativeRingOfLinearCategory( C );
    
    name := "Hom(T,N)⊗T --> N";
    
    nat := NaturalTransformation( name, PreCompose( HH, TT ), IdentityFunctor( C ) );
    
    AddNaturalTransformationFunction( nat,
      function( ht_a, a, id_a )
        local ha, min_gen, positions, vectors, mor;
        
        ha := ApplyFunctor( HH, a );
        
        min_gen := MinimalGeneratingSet( ha );
        
        min_gen := List( min_gen, g -> ElementVectors( g ) );
        
        positions := List( min_gen, g -> PositionProperty( g, v -> not IsZero( v ) ) );
        
        vectors := ListN( min_gen, positions, { g, p } -> AsList( g[ p ] ) );
          
        mor := List( [ 1 .. Size( min_gen ) ], i -> vectors[ i ] * BasisOfExternalHom( UnderlyingCell( collection[ positions[ i ] ] ), a ) );
        
        mor := MorphismBetweenDirectSums( TransposedMat( [ mor ] ) );
        
        return CokernelColift( ht_a!.defining_morphism_of_cokernel_object, mor );
        
    end );
    
    return nat;
  
end );
