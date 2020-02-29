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

BindGlobal( "CounitOnBaseCategory",
  function( collection )
    local full, ambient_cat, C, B, inc_1, inc_2, Inc, Rep, name, eta, H;
    Error( "not finished" );
    full := DefiningFullSubcategory( collection );
    
    ambient_cat := AmbientCategory( full );
    
    if not IsHomotopyCategory( ambient_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    C := DefiningCategory( ambient_cat );
    
    if not IsAdditiveClosureCategory( C ) then
      
      TryNextMethod( );
      
    fi;
    
    B := UnderlyingCategory( C );
    
    inc_1 := InclusionFunctorInAdditiveClosure( B );
    
    inc_2 := EmbeddingFunctorInHomotopyCategory( C );
    
    Inc := PreCompose( inc_1, inc_2 );
    
    #Rep := ReplacementFunctorOnBaseCategory( collection );
    Rep := 0;
    H := HomFunctor( collection );
    
    name := "Counit natural transformation";
    
    eta := NaturalTransformation( name, Rep, Inc );
    
    AddNaturalTransformationFunction( eta,
      function( rep_a, a, inc_a )
        local H_a, min_gen, positions, vectors, positions_of_non_zeros, mor, alpha;
        
        H_a := ApplyFunctor( H, inc_a );
        
        min_gen := MinimalGeneratingSet( H_a );
        
        if IsEmpty( min_gen ) then
          
          return ZeroMorphism( rep_a, inc_a );
          
        fi;
        
        min_gen := List( min_gen, g -> ElementVectors( g ) );
        
        positions := List( min_gen, g -> PositionProperty( g, v -> not IsZero( v ) ) );
        
        vectors := ListN( min_gen, positions, { g, p } -> AsList( g[ p ] ) );
        
        positions_of_non_zeros := List( vectors, v -> PositionsProperty( v, e -> not IsZero( e ) ) );
        
        mor := List( [ 1 .. Size( min_gen ) ],
          i -> vectors[ i ]{ positions_of_non_zeros[ i ] } * 
                  BasisOfExternalHom(
                    UnderlyingCell( collection[ positions[ i ] ] ), inc_a )
                      { positions_of_non_zeros[ i ] }
              );
        
        mor := MorphismBetweenDirectSums( TransposedMat( [ mor ] ) );
        
        alpha := rep_a!.UnderlyingMorphismForMappingCone;
         
        return MappingConeColift( alpha, mor );
                
      end );
    
    return eta;
     
end );

