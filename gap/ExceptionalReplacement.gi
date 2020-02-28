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
InstallMethod( MorphismFromSomeExceptionalObject,
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
    
    H_a := H( a );
    
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

# If T & a are two perfect complexes, then
# Hom(T,a) <> 0 only if l_T - u_a <= 0 and u_T - l_a >= 0.
##
InstallMethodWithCache( ExceptionalShift,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local C, objects, T, u_T, l_T, u_a, l_a, N, shift_of_a;
    
    C := AmbientCategory( collection );
    
    if not IsHomotopyCategory( C ) then
      
      Error( "The ambient category of the exceptional collection should be a homotopy category!\n" );
      
    fi;
    
    objects := UnderlyingObjects( collection );
    
    objects := List( objects, UnderlyingCell );
    
    T := TiltingObject( collection );
    
    u_T := ActiveUpperBound( T );
    
    l_T := ActiveLowerBound( T );
    
    u_a := ActiveUpperBound( a );
    
    l_a := ActiveLowerBound( a );
    
    N := u_T - l_a;
    
    while N >= l_T - u_a do
      
      shift_of_a := Shift( a, N );
      
      if ForAny( objects, e -> not IsZeroForObjects( HomStructure( e, shift_of_a ) ) ) then
        
        return N;
        
      else
        
        if N = l_T - u_a then
          
          Assert( 3, IsZeroForObjects( a ) );
          
          SetIsZeroForObjects( a, true );
          
          return 0;
          
        else
        
          N := N - 1;
          
        fi;
        
      fi;
      
    od;
    
    return N;
    
end );

##
InstallMethod( EXCEPTIONAL_REPLACEMENT,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local C, N, maps, diffs, res;
    
    C := CapCategory( a );
    
    N := ExceptionalShift( a, collection );
    
    maps := MapLazy( IntegersList,
              function( i )
                local alpha, beta, alpha_as_list, beta_as_list, c, k, sources;
                
                if i < -N then
                  
                  alpha := UniversalMorphismFromZeroObject( ZeroObject( C ) );
                  
                  beta := UniversalMorphismIntoZeroObject( Range( maps[ i + 1 ][ 1 ] ) );
                  
                  return [ alpha, beta, [ ], [ ] ];
                 
                elif i = -N then
                  
                  c := Shift( a, N );
                  
                else
                  
                  c := Source( maps[ i - 1 ][ 2 ] );
                  
                fi;
                
                alpha_as_list := MorphismFromSomeExceptionalObject( c, collection );
                
                sources := List( alpha_as_list, Source );
                
                if not IsEmpty( alpha_as_list ) then
                  
                  alpha := MorphismBetweenDirectSums( TransposedMat( [ alpha_as_list ] ) );
                  
                else
                  
                  alpha := UniversalMorphismFromZeroObject( c );
                  
                fi;
                
                beta := AdditiveInverse( Shift( MorphismFromConeObject( alpha ), -1 ) );
                
                beta_as_list := [ ];
                
                for k in [ 1 .. Size( alpha_as_list ) ] do
                  
                  Add( beta_as_list, PreCompose( beta, ProjectionInFactorOfDirectSum( sources, k ) ) );
                  
                od;
                
                return [ alpha, beta, alpha_as_list, beta_as_list ];
                
              end, 1 );
    
    maps!.shift := N;
    
    return maps;
    
end );

##
InstallMethodWithCache( ExceptionalReplacement,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local defining_category, additive_closure, homotopy_category, maps, N, diffs, res;
    
    defining_category := DefiningFullSubcategory( collection );
    
    additive_closure := AdditiveClosure( collection );
    
    homotopy_category := HomotopyCategory( collection );
    
    maps := EXCEPTIONAL_REPLACEMENT( a, collection );
    
    N := maps!.shift;
    
    diffs := MapLazy( IntegersList,
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
        
    end, 1 );

    res := ChainComplex( additive_closure, diffs ) / homotopy_category;
    
    SetLowerBound( res, -N );
    
    return res;

end );

##
InstallMethod( ExceptionalReplacement,
          [ IsHomotopyCategoryObject, IsExceptionalCollection, IsBool ],
  function( a, collection, bool )
    local C, r, u, zero;
    
    C := CapCategory( a );
    
    zero := ZeroObject( AdditiveClosure( collection ) );
    
    r := ExceptionalReplacement( a, collection );
    
    u := ActiveLowerBound( r );
    
    while bool do
      
      if IsEqualForObjects( r[ u ], zero ) then
        
        SetUpperBound( r, u - 1 );
        
        return r;
        
      else
        
        u := u + 1;
        
      fi;
      
    od;
    
    return r;
    
end );

