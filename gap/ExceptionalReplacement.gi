#############################################################################
##
##  DerivedCategories: Derived categories for abelian categories
##
##  Copyright 2020, Kamal Saleh, University of Siegen
##
##  Exceptional Resolutions
##
#############################################################################

##
InstallMethod( MorphismFromExceptionalObjectAsList,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local C, H, H_a, min_gen, positions, vectors, positions_of_non_zeros, mor;
    
    C := AmbientCategory( collection );
    
    if not IsIdenticalObj( CapCategory( a ), C ) then
      
      Error( "The object should belong to the ambient category of the exceptional collection!\n" );
      
    fi;
    
    if HasIsZeroForObjects( a ) and IsZeroForObjects( a ) then
      
      return [ ];
      
    fi;
    
    H := HomFunctor( collection );
    
    H_a := ApplyFunctor( H, a );
    
    min_gen := MinimalGeneratingSet( H_a );
    
    if IsEmpty( min_gen ) then
      
      return [ ];
      
    fi;
    
    min_gen := List( min_gen, g -> ElementVectors( g ) );
    
    positions := List( min_gen, g -> PositionProperty( g, v -> not IsZero( v ) ) );
    
    vectors := ListN( min_gen, positions, { g, p } -> AsList( g[ p ] ) );
    
    positions_of_non_zeros := List( vectors, v -> PositionsProperty( v, e -> not IsZero( e ) ) );
    
    return List( [ 1 .. Size( min_gen ) ],
      i -> vectors[ i ]{ positions_of_non_zeros[ i ] } *
              BasisOfExternalHom(
                UnderlyingCell( collection[ positions[ i ] ] ), a )
                  { positions_of_non_zeros[ i ] }
          );
    
end );

##
InstallMethod( MorphismFromExceptionalObject,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local m;
    
    m := MorphismFromExceptionalObjectAsList( a, collection );
    
    if IsEmpty( m ) then
      
      return UniversalMorphismFromZeroObject( a );
      
    else
      
      return MorphismBetweenDirectSums( TransposedMat( [ m ] ) );
      
    fi;
     
end );

##
InstallMethod( MorphismBetweenExceptionalObjects,
          [ IsHomotopyCategoryMorphism, IsExceptionalCollection ],
  function( alpha, collection )
    local H, H_alpha, D, full, I, J, m;
    
    H := HomFunctor( collection );
    
    H_alpha := ApplyFunctor( H, alpha );
    
    D := CategoryOfQuiverRepresentationsOverOppositeAlgebra( collection );
    
    full := FullSubcategoryGeneratedByProjectiveObjects( D );
    
    I := EquivalenceFromFullSubcategoryGeneratedByProjectiveObjectsIntoAdditiveClosureOfIndecProjectiveObjects( D );
    
    J := IsomorphismFromFullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra( collection );
    
    J := ExtendFunctorToAdditiveClosureOfSource( J );
    
    m := MorphismBetweenProjectiveChainResolutions( H_alpha );
    
    return ApplyFunctor( PreCompose( I, J ), m[ 0 ] / full );
    
end );

# If T & a are two perfect complexes, then
# Hom(T,a) <> 0 only if l_T - u_a <= 0 and u_T - l_a >= 0.
InstallMethod( CandidatesForExceptionalShift,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local C, T, u_T, l_T, u_a, l_a;
     
    C := AmbientCategory( collection );
    
    if not IsHomotopyCategory( C ) then
      
      Error( "The ambient category of the exceptional collection should be a homotopy category!\n" );
      
    fi;
       
    T := TiltingObject( collection );
    
    u_T := ActiveUpperBound( T );
    
    l_T := ActiveLowerBound( T );
    
    u_a := ActiveUpperBound( a );
    
    l_a := ActiveLowerBound( a );
    
    return [ l_T - u_a .. u_T - l_a ];
    
end );

##
InstallMethodWithCache( ExceptionalShift,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local E, I, shift_of_a, N;
     
    E := UnderlyingObjects( collection );
    
    E := List( E, UnderlyingCell );
    
    I := CandidatesForExceptionalShift( a, collection );
    
    for N in Reversed( I ) do
      
      shift_of_a := Shift( a, N );
      
      if ForAny( E, e -> not IsZeroForObjects( HomStructure( e, shift_of_a ) ) ) then
        
        return N;
        
      fi;
      
    od;
    
    return -infinity;
    
end );

##
InstallMethodWithCache( EXCEPTIONAL_REPLACEMENT_DATA,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local C, N, maps, diffs, res;
    
    C := CapCategory( a );
    
    N := ExceptionalShift( a, collection );
    
    maps := AsZFunction(
              function( i )
                local alpha, beta, alpha_as_list, beta_as_list, c, k, sources;
                
                if i < -N then
                  
                  alpha := UniversalMorphismFromZeroObject( Shift( a, -i ) ); # or ZeroObject( C )
                  
                  beta := UniversalMorphismIntoZeroObject( Range( maps[ i + 1 ][ 1 ] ) );
                  
                  return [ alpha, beta, [ ], [ ] ];
                 
                elif i = -N then
                  
                  c := Shift( a, N );
                  
                else
                  
                  c := Source( maps[ i - 1 ][ 2 ] );
                  
                fi;
                
                alpha_as_list := MorphismFromExceptionalObjectAsList( c, collection );
                
                sources := List( alpha_as_list, Source );
                
                if not IsEmpty( alpha_as_list ) then
                  
                  alpha := MorphismBetweenDirectSums( TransposedMat( [ alpha_as_list ] ) );
                  
                else
                  
                  alpha := UniversalMorphismFromZeroObject( c );
                  
                fi;
                
                beta := DomainMorphismByInverseRotationAxiom( alpha );
                
                beta_as_list := [ ];
                
                for k in [ 1 .. Size( alpha_as_list ) ] do
                  
                  Add( beta_as_list, PreCompose( beta, ProjectionInFactorOfDirectSum( sources, k ) ) );
                  
                od;
                
                return [ alpha, beta, alpha_as_list, beta_as_list ];
                
              end );
    
    maps!.shift := N;
    
    return maps;
    
end );

##
InstallMethod( EXCEPTIONAL_REPLACEMENT_DATA,
          [ IsHomotopyCategoryMorphism, IsExceptionalCollection ],
  function( phi, collection )
    local C, A, U, a, N_a, b, N_b, N, rep_a, rep_b, maps;
    
    C := CapCategory( phi );
    
    A := AdditiveClosure( collection );
    
    U := EmbeddingFunctorFromAdditiveClosure( collection );
    
    a := Source( phi );
    
    N_a := ExceptionalShift( a, collection );
    
    b := Range( phi );
    
    N_b := ExceptionalShift( b, collection );
    
    N := Maximum( N_a, N_b );
    
    rep_a := EXCEPTIONAL_REPLACEMENT_DATA( a, collection );
    
    rep_b := EXCEPTIONAL_REPLACEMENT_DATA( b, collection );
    
    maps := AsZFunction(
              function( i )
                local psi, eta;
                
                if i < -N then
                 
                  psi := Shift( phi, i );
                  
                  eta := UniversalMorphismIntoZeroObject( ZeroObject( A ) );
                  
                  return [ psi, eta ];
                  
                elif i = -N then
                  
                  psi := Shift( phi, N );
                  
                  eta := MorphismBetweenExceptionalObjects( psi, collection );
                  
                  return [ psi, eta ];
                  
                else
                   
                  psi := MorphismBetweenStandardConeObjects(
                            rep_a[ i - 1 ][ 1 ], 
                            ApplyFunctor( U, maps[ i - 1 ][ 2 ] ),
                            maps[ i - 1 ][ 1 ],
                            rep_b[ i - 1 ][ 1 ]
                          );
                  
                  psi := Shift( psi, -1 );
                  
                  eta := MorphismBetweenExceptionalObjects( psi, collection );
                  
                  return [ psi, eta ];
                  
                fi;
                
            end );
    
    return maps;
    
end );

##
InstallMethodWithCache( ExceptionalReplacement,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local defining_category, additive_closure, homotopy_category, maps, diffs, res, N;
    
    defining_category := DefiningFullSubcategory( collection );
    
    additive_closure := AdditiveClosure( collection );
    
    homotopy_category := HomotopyCategory( collection );

    maps := EXCEPTIONAL_REPLACEMENT_DATA( a, collection );
    
    diffs := AsZFunction(
              function( i )
                local alpha_as_list, beta_as_list, source, range, matrix;
                
                alpha_as_list := maps[ i ][ 3 ];
                
                beta_as_list := maps[ i - 1 ][ 4 ];
                
                source := List( alpha_as_list, a -> Source( a ) / defining_category );
                
                range := List( beta_as_list, b -> Range( b ) / defining_category );
                
                if IsEmpty( source ) or IsEmpty( range ) then
                   
                  matrix := [ ];
                  
                else
                  
                  matrix := List( alpha_as_list, a -> List( beta_as_list, b -> PreCompose( a, b ) / defining_category ) );
                
                fi;
                
                source := AdditiveClosureObject( source, additive_closure );
                
                range := AdditiveClosureObject( range, additive_closure );
                
                return AdditiveClosureMorphism( source, matrix, range );
                
              end );
    
    res := ChainComplex( additive_closure, diffs ) / homotopy_category;
    
    res!.exceptional_replacement_data := maps;
    
    N := ExceptionalShift( a, collection );
    
    SetLowerBound( res, -N );
    
    return res;

end );

##
InstallMethodWithCache( ExceptionalReplacement,
          [ IsHomotopyCategoryMorphism, IsExceptionalCollection ],
  function( alpha, collection )
    local homotopy_category, rep_a, rep_b, maps, map;
    
    homotopy_category := HomotopyCategory( collection );
    
    rep_a := ExceptionalReplacement( Source( alpha ), collection );
    
    rep_b := ExceptionalReplacement( Range( alpha ), collection );
    
    maps := EXCEPTIONAL_REPLACEMENT_DATA( alpha, collection );
    
    maps := ApplyMap( maps, m -> m[ 2 ] );
    
    map := ChainMorphism( UnderlyingCell( rep_a ), UnderlyingCell( rep_b ), maps ) / homotopy_category;
    
    return map;
    
end );
 
##
InstallMethod( ExceptionalReplacement,
          [ IsHomotopyCategoryObject, IsExceptionalCollection, IsBool ],
  function( a, collection, bool )
    local C, rep_a, data, u, b, I;
    
    C := CapCategory( a );
    
    rep_a := ExceptionalReplacement( a, collection );
    
    data := rep_a!.exceptional_replacement_data;
    
    u := ActiveLowerBound( rep_a );
    
    while bool do
      
      if IsZeroForObjects( rep_a[ u ] ) then
        
        b := Range( data[ u ][ 1 ] );
        
        I := CandidatesForExceptionalShift( b, collection );
        
        if IsEmpty( I ) or
            I[ 1 ] >= 0 or
              ExceptionalShift( b, collection ) = -infinity then
              
          SetUpperBound( rep_a, u - 1 );
          
          return rep_a;
          
        else
          
          u := u + 1;
          
        fi;
        
      else
        
        u := u + 1;
        
      fi;
      
    od;
    
    return rep_a;
    
end );

##
InstallMethod( ExceptionalReplacement,
          [ IsHomotopyCategoryMorphism, IsExceptionalCollection, IsBool ],
  function( alpha, collection, bool )
    local a, b, rep_a, rep_b;
  
    a := Source( alpha );
    
    b := Range( alpha );
    
    rep_a := ExceptionalReplacement( a, collection, bool );
    
    rep_b := ExceptionalReplacement( b, collection, bool );
    
    return ExceptionalReplacement( alpha, collection );
    
end );

