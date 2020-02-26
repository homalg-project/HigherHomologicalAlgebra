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
InstallMethod( ExceptionalCoverIntoCertainShift,
          [ IsCapCategoryObject, IsInt, IsExceptionalCollection ],
  function( a, N, collection )
    local C, H, H_a, min_gen, positions, vectors, positions_of_non_zeros, mor;
    
    C := AmbientCategory( collection );
    
    if not IsIdenticalObj( CapCategory( a ), C ) then
      
      Error( "The object should belong to the ambient category of the exceptional collection!\n" );
      
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
          [ IsCapCategoryObject, IsExceptionalCollection ],
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
          
          Info( InfoDerivedCategories, 2, "It seems that the object is zero :)" );
          
          return 0; # or any other integer
          
        else
        
          N := N - 1;
          
        fi;
        
      fi;
      
    od;
    
    return N;
    
end );

