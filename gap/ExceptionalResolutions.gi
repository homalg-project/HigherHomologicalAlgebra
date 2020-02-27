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
InstallMethod( MorphismFromSomeExceptionalObjectIntoCertainShift,
          [ IsHomotopyCategoryObject, IsInt, IsExceptionalCollection ],
  function( a, N, collection )
    local C, H, H_a, min_gen, positions, vectors, positions_of_non_zeros, mor;
    
    C := AmbientCategory( collection );
    
    if not IsIdenticalObj( CapCategory( a ), C ) then
      
      Error( "The object should belong to the ambient category of the exceptional collection!\n" );
      
    fi;
    
    if HasIsZeroForObjects( a ) and IsZeroForObjects( a ) then
      
      mor := UniversalMorphismFromZeroObject( Shift( a, N ) );
      
      # In case the logic is switched off
      SetIsZeroForObjects( Source( mor ), true );
      
      SetIsZeroForObjects( Range( mor ), true );
      
      return mor;
      
    fi;
    
    H := HomFunctor( collection );
    
    a := Shift( a, N );
    
    H_a := H( a );
    
    min_gen := MinimalGeneratingSet( H_a );
    
    if IsEmpty( min_gen ) then
      
      return UniversalMorphismFromZeroObject( a );
      
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
    
    return MorphismBetweenDirectSums( TransposedMat( [ mor ] ) );
    
end );

# If T & a are two perfect complexes, then
# Hom(T,a) <> 0 only if l_T - u_a <= 0 and u_T - l_a >= 0.
##
InstallMethod( ExceptionalShift,
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
InstallMethod( MorphismFromSomeExceptionalObject,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local N;
    
    N := ExceptionalShift( a, collection );
    
    return MorphismFromSomeExceptionalObjectIntoCertainShift( a, N, collection );
    
end );

##
InstallMethod( ExceptionalResolution,
          [ IsHomotopyCategoryObject, IsExceptionalCollection ],
  function( a, collection )
    local C, N, maps, diffs, res;
    
    C := CapCategory( a );
    
    N := ExceptionalShift( a, collection );
    
    maps := MapLazy( IntegersList,
              function( i )
                local alpha, beta, c;
                
                if i = -N then
                  
                  c := Shift( a, N );
                  
                elif i > -N then
                
                  c := Source( maps[ i - 1 ][ 2 ] );
                  
                else
                  
                  c := ZeroObject( C );
                  
                  SetIsZeroForObjects( c, true );
                  
                fi;
                
                if ExceptionalShift( c, collection ) <> 0 then
                  
                  Error( "Something unexpected happend!\n" );
                  
                fi;
                
                alpha := MorphismFromSomeExceptionalObjectIntoCertainShift( c, 0, collection );
                
                if HasIsZeroForObjects( c ) and IsZeroForObjects( c ) then
                   
                  beta := Shift( UniversalMorphismFromZeroObject( Source( alpha ) ), -1 );
                  
                  # In case the logic is switched off
                  SetIsZeroForObjects( Source( beta ), true );
                  
                else
                  
                  beta := Shift( MorphismFromConeObject( alpha ), -1 );
                  
                fi;
                 
                return [ alpha, beta ];
                
              end, 1 );
    
    diffs := MapLazy( IntegersList, i -> PreCompose( maps[ i ][ 1 ], maps[ i - 1 ][ 2 ] ), 1 );
    
    res := ChainComplex( C, diffs );
    
    SetLowerBound( res, -N );
    
    return res;
    
end );

##
InstallMethod( ExceptionalResolution,
          [ IsHomotopyCategoryObject, IsExceptionalCollection, IsBool ],
  function( a, collection, bool )
    local C, res, u, zero;
    
    C := CapCategory( a );
    
    zero := ZeroObject( C );
    
    res := ExceptionalResolution( a, collection );
    
    u := ActiveLowerBound( res );
    
    while bool do
      
      if IsEqualForObjects( res[ u ], zero ) then
        
        SetUpperBound( res, u - 1 );
        
        return res;
        
      else
        
        u := u + 1;
        
      fi;
      
    od;
    
    return res;
    
end );

