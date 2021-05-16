# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
##  Exceptional Resolutions
##
#############################################################################

##
InstallMethodWithCache( CandidatesForExceptionalShifts,
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local ambient_cat, T, u_T, l_T, u_A, l_A;
     
    ambient_cat := AmbientCategory( collection );
    
    if not IsHomotopyCategory( ambient_cat ) then
      
      Error( "The ambient category of the exceptional collection should be A homotopy category!\n" );
      
    fi;
    
    T := TiltingObject( collection );
    
    u_T := ActiveUpperBound( T );
    
    l_T := ActiveLowerBound( T );
    
    u_A := ActiveUpperBound( A );
    
    l_A := ActiveLowerBound( A );
    
    if IsChainComplex( UnderlyingCell( A ) ) then
      
      return [ l_T - u_A .. u_T - l_A ];
      
    else
      
      return [ l_A - u_T .. u_A - l_T ];
      
    fi;
    
end );

##
InstallMethodWithCache( ExceptionalShifts,
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local E, I;
     
    E := List( UnderlyingObjects( collection ), UnderlyingCell );
    
    I := CandidatesForExceptionalShifts( A, collection );
    
    I := Filtered( I, N -> ForAny( E, e -> not IsZeroForObjects( HomStructure( e, Shift( A, N ) ) ) ) );
    
    return I;
    
end );

##
InstallMethodWithCache( MinimalExceptionalShift,
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local E, I, N;
    
    E := List( UnderlyingObjects( collection ), UnderlyingCell );
    
    I := CandidatesForExceptionalShifts( A, collection );
    
    for N in I do
      
      if ForAny( E, e -> not IsZeroForObjects( HomStructure( e, Shift( A, N ) ) ) ) then
        
        return N;
        
      fi;
      
    od;
    
    return infinity;
    
end );

##
InstallMethodWithCache( MaximalExceptionalShift,
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local E, I, N;
    
    E := List( UnderlyingObjects( collection ), UnderlyingCell );
    
    I := CandidatesForExceptionalShifts( A, collection );
    
    for N in Reversed( I ) do
      
      if ForAny( E, e -> not IsZeroForObjects( HomStructure( e, Shift( A, N ) ) ) ) then
        
        return N;
        
      fi;
      
    od;
    
    return -infinity;
    
end );

##
InstallMethodWithCache( MorphismFromExceptionalObjectAsList,
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local ambient_cat, H, H_A, min_gen, positions, vectors, positions_of_non_zeros;
    
    ambient_cat := AmbientCategory( collection );
    
    if not IsIdenticalObj( CapCategory( A ), ambient_cat ) then
      
      Error( "The object should belong to the ambient category of the exceptional collection!\n" );
      
    fi;
    
    if HasIsZeroForObjects( A ) and IsZeroForObjects( A ) then
      
      return [ ];
      
    fi;
    
    H := HomFunctor( collection );
    
    H_A := ApplyFunctor( H, A );
    
    min_gen := MinimalGeneratingSet( H_A );
    
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
                UnderlyingCell( collection[ positions[ i ] ] ), A )
                  { positions_of_non_zeros[ i ] }
          );
          
end );

##
InstallMethodWithCache( MorphismFromExceptionalObject,
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local m;
    
    m := MorphismFromExceptionalObjectAsList( A, collection );
    
    if IsEmpty( m ) then
      
      return UniversalMorphismFromZeroObject( A );
      
    else
      
      return MorphismBetweenDirectSums( TransposedMat( [ m ] ) );
      
    fi;
     
end );

##
InstallMethodWithCache( MorphismBetweenExceptionalObjects,
          [ IsHomotopyCategoryMorphism, IsStrongExceptionalCollection ],
          
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

#
# For Cochains
#

##          -> R_i
##  q^i-1  /      \ r^i
##        /        \
##   X_im1          -> X_i
##
##  [ r_i, q_im1, r_i_list, q_im1_list ];
##
InstallMethodWithCache( ExceptionalReplacementData,
              "for homotopy objects defined by cochains",
         [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local homotopy_cat, complexes_cat, N, data;
    
    homotopy_cat := CapCategory( A );
    
    complexes_cat := UnderlyingCategory( homotopy_cat );
    
    if not IsCochainComplexCategory( complexes_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    N := MaximalExceptionalShift( A, collection );
    
    data := AsZFunction(
              function( i )
                local r_i, r_im1, X_im1, q_im1, X_i, q_i, r_i_list, q_im1_list, s, k;
                
                if i > N then
                  
                  r_i := UniversalMorphismFromZeroObject( Shift( A, i ) );
                  
                  r_im1 := data[ i - 1 ][ 1 ];
                  
                  X_im1 := Range( r_im1 );
                  
                  q_im1 := UniversalMorphismIntoZeroObject( X_im1 );
                  
                  return [ r_i, q_im1, [ ], [ ] ];
                  
                elif i = N then
                  
                  X_i := Shift( A, N );
                  
                else
                  
                  q_i := data[ i + 1 ][ 2 ];
                  
                  X_i := Source( q_i );
                  
                fi;
                
                r_i_list := MorphismFromExceptionalObjectAsList( X_i, collection );
                 
                if not IsEmpty( r_i_list ) then
                  
                  r_i := MorphismBetweenDirectSums( TransposedMat( [ r_i_list ] ) );
                  
                else
                  
                  r_i := UniversalMorphismFromZeroObject( X_i );
                  
                fi;
                
                q_im1 := MorphismFromStandardCoConeObject( r_i );
                
                q_im1_list := [ ];
                
                if not IsEmpty( r_i_list ) then
                  
                  s := List( r_i_list, Source );
                    
                  for k in [ 1 .. Size( r_i_list ) ] do
                    
                    Add( q_im1_list, PreCompose( q_im1, ProjectionInFactorOfDirectSum( s, k ) ) );
                    
                  od;
                  
                fi;
                
                return [ r_i, q_im1, r_i_list, q_im1_list ];
                
              end );
              
    data!.maximal_exceptional_shift := N;
    
    return data;
    
end );


##          -> R_i
##  q^i-1  /      \ r^i
##        /        \
##   X_im1          -> X_i
##
## [ r_i, q_im1, r_i_list, q_im1_list ];
##
InstallMethodWithCache( ExceptionalReplacement,
             "for homotopy objects defined by cochains",
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local ambient_cat, complexes_cat, defining_cat, additive_closure, homotopy_cat, data, diffs, rep_A, N;
    
    ambient_cat := CapCategory( A );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if not IsCochainComplexCategory( complexes_cat ) then
      TryNextMethod( );
    fi;
    
    defining_cat := DefiningFullSubcategory( collection );
    
    additive_closure := AdditiveClosure( collection );
    
    homotopy_cat := HomotopyCategory( collection );

    data := ExceptionalReplacementData( A, collection );
    
    diffs := AsZFunction(
              function( i )
                local r_i_list, q_i_list, s, r, matrix;
                
                r_i_list := data[ i ][ 3 ];
                
                q_i_list := data[ i + 1 ][ 4 ];
                
                s := List( r_i_list, m -> Source( m ) / defining_cat );
                
                r := List( q_i_list, m -> Range( m ) / defining_cat );
                
                if IsEmpty( s ) or IsEmpty( r ) then
                   
                  matrix := [ ];
                  
                else
                  
                  matrix := List( r_i_list, m1 -> List( q_i_list, m2 -> PreCompose( m1, m2 ) / defining_cat ) );
                
                fi;
                
                s := AdditiveClosureObject( s, additive_closure );
                
                r := AdditiveClosureObject( r, additive_closure );
                
                return AdditiveClosureMorphism( s, matrix, r );
                
              end );
              
    rep_A := CochainComplex( additive_closure, diffs ) / homotopy_cat;
    
    rep_A!.exceptional_replacement_data := data;
    
    N := MaximalExceptionalShift( A, collection );
    
    SetUpperBound( rep_A, N );
    
    return rep_A;
    
end );

##
InstallMethodWithCache( ExceptionalReplacement,
            "for homotopy objects defined by chains",
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection, IsBool ],
          
  function( A, collection, bool )
    local ambient_cat, complexes_cat, rep_A, data, l, z, X_l;
    
    ambient_cat := CapCategory( A );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if not IsCochainComplexCategory( complexes_cat ) then
      TryNextMethod( );
    fi;
    
    rep_A := ExceptionalReplacement( A, collection );
    
    data := rep_A!.exceptional_replacement_data;
    
    l := ActiveUpperBound( rep_A );
    
    z := ZeroObject( AdditiveClosure( collection ) );
    
    while bool do
       
      if IsEqualForObjects( rep_A[ l ], z ) then # IsZeroForObjects could be expensive, and in this case they are equivalent
        
        X_l := Range( data[ l ][ 1 ] );
        
        if MaximalExceptionalShift( X_l, collection ) = -infinity then
          
          SetLowerBound( rep_A, l + 1 );
          
          return rep_A;
          
        else
          
          l := l - 1;
          
        fi;
        
      else
        
        l := l - 1;
        
      fi;
      
    od;
    
    return rep_A;
    
end );

##
InstallMethodWithCache( ExceptionalReplacementData,
             "for homotopy morphisms defined by cochain morphisms",
         [ IsHomotopyCategoryMorphism, IsStrongExceptionalCollection ],
         
  function( phi, collection )
    local homotopy_cat, complexes_cat, collection_plus, I, A, N_A, B, N_B, N, rep_A, rep_B, data;
    
    homotopy_cat := CapCategory( phi );
    
    complexes_cat := UnderlyingCategory( homotopy_cat );
    
    if not IsCochainComplexCategory( complexes_cat ) then
        
        TryNextMethod( );
        
    fi;
    
    collection_plus := AdditiveClosure( collection );
    
    I := EmbeddingFunctorFromAdditiveClosure( collection );
    
    A := Source( phi );
    
    N_A := MaximalExceptionalShift( A, collection );
    
    B := Range( phi );
    
    N_B := MaximalExceptionalShift( B, collection );
    
    N := Maximum( N_A, N_B );
    
    rep_A := ExceptionalReplacementData( A, collection );
    
    rep_B := ExceptionalReplacementData( B, collection );
    
    data := AsZFunction(
              function( i )
                local x_i, y_i;
                
                if i > N then
                  
                  x_i := Shift( phi, i );
                  
                  y_i := ZeroObjectFunctorial( homotopy_cat );
                  
                  return [ x_i, y_i ];
                  
                elif i = N then
                  
                  x_i := Shift( phi, i );
                  
                  y_i := MorphismBetweenExceptionalObjects( x_i, collection );
                  
                  return [ x_i, y_i ];
                  
                else
                  
                  x_i := MorphismBetweenStandardCoConeObjects(
                            rep_A[ i + 1 ][ 1 ],
                            I( data[ i + 1 ][ 2 ] ),
                            data[ i + 1 ][ 1 ],
                            rep_B[ i + 1 ][ 1 ]
                          );
                          
                  y_i := MorphismBetweenExceptionalObjects( x_i, collection );
                  
                  return [ x_i, y_i ];
                  
                fi;
                
            end );
            
    return data;
    
end );

#
# For Chains
#


##            R_i <-
##      r^i /       \ q^i+1
##         /         \
##   X_i <-           X_i+1
##
##
## returns  [ r^i, q^i+1, r^i as list, q^i+1 as list ]
##
InstallMethodWithCache( ExceptionalReplacementData,
             "for homotopy objects defined by chains", 
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local homotopy_cat, complexes_cat, N, data;
    
    homotopy_cat := CapCategory( A );
    
    complexes_cat := UnderlyingCategory( homotopy_cat );
    
    if not IsChainComplexCategory( complexes_cat ) then
      
      TryNextMethod( );
      
    fi;
    
    N := MaximalExceptionalShift( A, collection );
    
    data := AsZFunction(
              function( i )
                local r_i, r_ip1, X_ip1, q_ip1, X_i, q_i, r_i_list, q_ip1_list, s, k;
                
                if i < -N then
                  
                  r_i := UniversalMorphismFromZeroObject( Shift( A, -i ) );
                  
                  r_ip1 := data[ i + 1 ][ 1 ];
                  
                  X_ip1 := Range( r_ip1 );
                  
                  q_ip1 := UniversalMorphismIntoZeroObject( X_ip1 );
                  
                  return [ r_i, q_ip1, [ ], [ ] ];
                 
                elif i = -N then
                  
                  X_i := Shift( A, N );
                  
                else
                  
                  q_i := data[ i - 1 ][ 2 ];
                  
                  X_i := Source( q_i );
                  
                fi;
                
                r_i_list := MorphismFromExceptionalObjectAsList( X_i, collection );
                 
                if not IsEmpty( r_i_list ) then
                  
                  r_i := MorphismBetweenDirectSums( TransposedMat( [ r_i_list ] ) );
                  
                else
                  
                  r_i := UniversalMorphismFromZeroObject( X_i );
                  
                fi;
                
                q_ip1 := MorphismFromStandardCoConeObject( r_i );
                
                q_ip1_list := [ ];
                
                if not IsEmpty( r_i_list ) then
                  
                  s := List( r_i_list, Source );
                  
                  for k in [ 1 .. Size( r_i_list ) ] do
                    
                    Add( q_ip1_list, PreCompose( q_ip1, ProjectionInFactorOfDirectSum( s, k ) ) );
                    
                  od;
                
                fi;
                
                return [ r_i, q_ip1, r_i_list, q_ip1_list ];
                
              end );
              
    data!.maximal_exceptional_shift := N;
    
    return data;
    
end );

##            R_i <-
##      r^i /       \ q^i+1
##         /         \
##   X_i <-           X_i+1
##
##
## returns  [ r^i, q^i+1, r^i as list, q^i+1 as list ]
##
##
InstallMethodWithCache( ExceptionalReplacement,
            "for homotopy objects defined by chains",
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection ],
          
  function( A, collection )
    local ambient_cat, complexes_cat, defining_cat, additive_closure, homotopy_cat, data, diffs, rep_A, N;
    
    ambient_cat := CapCategory( A );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if not IsChainComplexCategory( complexes_cat ) then
      TryNextMethod( );
    fi;
    
    defining_cat := DefiningFullSubcategory( collection );
    
    additive_closure := AdditiveClosure( collection );
    
    homotopy_cat := HomotopyCategory( collection );

    data := ExceptionalReplacementData( A, collection );
    
    diffs := AsZFunction(
              function( i )
                local r_i_list, q_i_list, s, r, matrix;
                
                r_i_list := data[ i ][ 3 ];
                
                q_i_list := data[ i - 1 ][ 4 ];
                
                s := List( r_i_list, m -> Source( m ) / defining_cat );
                
                r := List( q_i_list, m -> Range( m ) / defining_cat );
                
                if IsEmpty( s ) or IsEmpty( r ) then
                   
                  matrix := [ ];
                  
                else
                  
                  matrix := List( r_i_list, m1 -> List( q_i_list, m2 -> PreCompose( m1, m2 ) / defining_cat ) );
                
                fi;
                
                s := AdditiveClosureObject( s, additive_closure );
                
                r := AdditiveClosureObject( r, additive_closure );
                
                return AdditiveClosureMorphism( s, matrix, r );
                
              end );
              
    rep_A := ChainComplex( additive_closure, diffs ) / homotopy_cat;
    
    rep_A!.exceptional_replacement_data := data;
    
    N := MaximalExceptionalShift( A, collection );
    
    SetLowerBound( rep_A, -N );
    
    return rep_A;
    
end );

##
InstallMethodWithCache( ExceptionalReplacement,
            "for homotopy objects defined by chains",
          [ IsHomotopyCategoryObject, IsStrongExceptionalCollection, IsBool ],
          
  function( A, collection, bool )
    local ambient_cat, complexes_cat, rep_A, data, u, X_u;
    
    ambient_cat := CapCategory( A );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if not IsChainComplexCategory( complexes_cat ) then
      TryNextMethod( );
    fi;
    
    rep_A := ExceptionalReplacement( A, collection );
    
    data := rep_A!.exceptional_replacement_data;
    
    u := ActiveLowerBound( rep_A );
    
    while bool do
      
      if IsZeroForObjects( rep_A[ u ] ) then
        
        X_u := Range( data[ u ][ 1 ] );
        
        if MaximalExceptionalShift( X_u, collection ) = -infinity then
              
          SetUpperBound( rep_A, u - 1 );
          
          return rep_A;
          
        else
          
          u := u + 1;
          
        fi;
        
      else
        
        u := u + 1;
        
      fi;
      
    od;
    
    return rep_A;
    
end );

##
InstallMethodWithCache( ExceptionalReplacementData,
             "for homotopy morphisms defined by chains",
          [ IsHomotopyCategoryMorphism, IsStrongExceptionalCollection ],
          
  function( phi, collection )
    local homotopy_cat, complexes_cat, collection_plus, I, A, N_A, B, N_B, N, rep_A, rep_B, data;
    
    homotopy_cat := CapCategory( phi );
    
    complexes_cat := UnderlyingCategory( homotopy_cat );
    
    if not IsChainComplexCategory( complexes_cat ) then
        
        TryNextMethod( );
        
    fi;
    
    collection_plus := AdditiveClosure( collection );
    
    I := EmbeddingFunctorFromAdditiveClosure( collection );
    
    A := Source( phi );
    
    N_A := MaximalExceptionalShift( A, collection );
    
    B := Range( phi );
    
    N_B := MaximalExceptionalShift( B, collection );
    
    N := Maximum( N_A, N_B );
    
    rep_A := ExceptionalReplacementData( A, collection );
    
    rep_B := ExceptionalReplacementData( B, collection );
    
    data := AsZFunction(
              function( i )
                local x_i, y_i;
                
                if i < -N then
                  
                  x_i := Shift( phi, -i );
                  
                  y_i := ZeroObjectFunctorial( homotopy_cat );
                  
                  return [ x_i, y_i ];
                  
                elif i = -N then
                  
                  x_i := Shift( phi, -i );
                  
                  y_i := MorphismBetweenExceptionalObjects( x_i, collection );
                  
                  return [ x_i, y_i ];
                  
                else
                  
                  x_i := MorphismBetweenStandardCoConeObjects(
                            rep_A[ i - 1 ][ 1 ],
                            I( data[ i - 1 ][ 2 ] ),
                            data[ i - 1 ][ 1 ],
                            rep_B[ i - 1 ][ 1 ]
                          );
                          
                  y_i := MorphismBetweenExceptionalObjects( x_i, collection );
                  
                  return [ x_i, y_i ];
                  
                fi;
                
            end );
            
    return data;
    
end );

##
InstallMethodWithCache( ExceptionalReplacement,
            "for homotopy morphisms",
          [ IsHomotopyCategoryMorphism, IsStrongExceptionalCollection ],
          
  function( alpha, collection )
    local ambient_cat, complexes_cat, homotopy_cat, rep_A, rep_B, data, maps;
    
    ambient_cat := CapCategory( alpha );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
   
    homotopy_cat := HomotopyCategory( collection );
    
    rep_A := ExceptionalReplacement( Source( alpha ), collection );
    
    rep_B := ExceptionalReplacement( Range( alpha ), collection );
    
    data := ExceptionalReplacementData( alpha, collection );
    
    maps := ApplyMap( data, m -> m[ 2 ] );
    
    return [ rep_A, maps, rep_B ] / homotopy_cat;
    
end );

##
InstallMethodWithCache( ExceptionalReplacement,
            "for homotopy morphisms defined by chain morphisms",
          [ IsHomotopyCategoryMorphism, IsStrongExceptionalCollection ],
  function( alpha, collection )
    local ambient_cat, complexes_cat, homotopy_cat, rep_A, rep_B, data, maps;
    
    ambient_cat := CapCategory( alpha );
    
    complexes_cat := UnderlyingCategory( ambient_cat );
    
    if not IsChainComplexCategory( complexes_cat ) then
        
        TryNextMethod( );
        
    fi;
   
    homotopy_cat := HomotopyCategory( collection );
    
    rep_A := ExceptionalReplacement( Source( alpha ), collection );
    
    rep_B := ExceptionalReplacement( Range( alpha ), collection );
    
    data := ExceptionalReplacementData( alpha, collection );
    
    maps := ApplyMap( data, m -> m[ 2 ] );
    
    return [ rep_A, maps, rep_B ] / homotopy_cat;
    
end );

##
InstallMethodWithCache( ExceptionalReplacement,
          [ IsHomotopyCategoryMorphism, IsStrongExceptionalCollection, IsBool ],
  function( alpha, collection, bool )
    local A, B, rep_A, rep_B;
    
    A := Source( alpha );
    
    B := Range( alpha );
    
    rep_A := ExceptionalReplacement( A, collection, bool );
    
    rep_B := ExceptionalReplacement( B, collection, bool );
    
    return ExceptionalReplacement( alpha, collection );
    
end );

