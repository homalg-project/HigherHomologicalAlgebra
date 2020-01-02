#############################################################################
##
## DerivedCategories: Derived categories for abelian categories
##
## Copyright 2020, Kamal Saleh, University of Siegen
##
##  NaturalTransformations
##
#############################################################################



BindGlobal( "CounitOfTensorHomAdjunction",
  function( collection )
    local HH, TT, C, k, name, nat;
    
    HH := HomFunctorByExceptionalCollection( collection );
    
    TT := TensorFunctorByExceptionalCollection( collection );
    
    C := AsCapCategory( Source( HH ) );
    
    k := CommutativeRingOfLinearCategory( C );
    
    name := "-⊗T o Hom(T,-) --> Id";
    
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
                  BasisOfExternalHom( UnderlyingCell( collection[ positions[ i ] ] ), a ){ positions_of_non_zeros[ i ] }
              );
        
        mor := MorphismBetweenDirectSums( TransposedMat( [ mor ] ) );
        
        return CokernelColift( ht_a!.defining_morphism_of_cokernel_object, mor );
        
      end );
    
    return nat;
  
end );

