LoadPackage( "ModulePresentations" );


##
## Random methods
##
RANDOM_OBJECT :=
  function( category, L, left_or_right )
    local homalg_ring, mat;
    
    homalg_ring := category!.ring_for_representation_category;
    
    if Length( L ) <> 2 then
      
      Error( "The list should have two entries" );
    
    fi;
    
    if not ForAll( L, l -> IsInt( l ) ) then
      
      Error( "The entries of the list should be integers" );
    
    fi;
    
    if ForAll( L, l -> l < 0 ) then
      
      return fail;
    
    fi;
    
    mat := homalg_ring!.random_matrix_func( L[ 1 ], L[ 2 ] );
    
    if left_or_right = "left" then
      
      return AsLeftPresentation( mat );
    
    else
      
      return AsRightPresentation( mat );
    
    fi;
    
end;

##
## Interpretation of n:
## The number of rows and colms of the matrix of the object is less or equal to n.
ADD_RANDOM_OBJECT :=

  function( category, left_or_right )
    
    AddRandomObjectByInteger( category,
      
      function( C, n )
        
        if n < 0 then
          
          return fail;
        
        fi;
        
        if left_or_right = "left" then
          
          return RANDOM_OBJECT( C, [ Random( [ Int( n/2 ) .. Int( 3*n/2 ) ] ), n ], "left" );
        
        else
          
          return RANDOM_OBJECT( C, [ n, Random( [ Int( n/2 ) .. Int( 3*n/2 ) ] ) ], "right" );
        
        fi;
      
      end );
    
end;

##
## Interpretation of n:
## The number of relations of the range of the created random morphism is n.
ADD_RANDOM_MORPHISM_WITH_FIXED_SOURCE_LEFT :=
    function( category )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      
      AddRandomMorphismWithFixedSourceByInteger( category,
        function( M, n )
          local m, y, syz, x, u, U, e;
          
          if n < 0 then
            
            return fail;
          
          fi;
          
          m := UnderlyingMatrix( M );
          
          y := homalg_ring!.random_matrix_func( NrRows( m ), n );
          
          syz := SyzygiesOfColumns( UnionOfColumns( m, y ) );
          
          syz := syz * homalg_ring!.random_matrix_func( NrCols( syz ), Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ) );
          
          x := CertainRows( syz, [ 1 .. NrCols( m ) ] );
          
          u := CertainRows( syz, [ NrCols( m ) + 1 .. NrRows( syz ) ] );
          
          U := AsLeftPresentation( u );
          
          return PresentationMorphism( M, x, U );
    
        end );
    
end;

##
## Interpretation of n:
## The number of generators of the source of the created random morphism is n.
ADD_RANDOM_MORPHISM_WITH_FIXED_RANGE_LEFT :=
    function( category )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      
      
      AddRandomMorphismWithFixedRangeByInteger( category,
        function( U, n )
          local u, x, syz, m, M, e;
          
          if n < 0 then
            
            return fail;
          
          fi;
          
          if n = 0 then
            
            return UniversalMorphismFromZeroObject( U );
          
          fi;
          
          u := UnderlyingMatrix( U );
          
          x := homalg_ring!.random_matrix_func( n, NrCols( u ) );
          
          syz := SyzygiesOfRows( UnionOfRows( x, u ) );
          
          syz := homalg_ring!.random_matrix_func( Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ), NrRows( syz ) ) * syz;
          
          m := CertainColumns( syz, [ 1 .. NrRows( x ) ] );
          
          M := AsLeftPresentation( m );
          
          return PresentationMorphism( M, x, U );
    
      end ); 
    
end;

##
ADD_RANDOM_MORPHISM_WITH_FIXED_SOURCE_RIGHT :=
    function( category )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      
      AddRandomMorphismWithFixedSourceByInteger( category,
        function( U, n )
          local u, x, syz, e, m, M, y;
          
          if n < 0 then
            
            return fail;
          
          fi;
          
          u := UnderlyingMatrix( U );
          
          x := homalg_ring!.random_matrix_func( n, NrCols( u ) );
          
          syz := SyzygiesOfRows( UnionOfRows( x, u ) );
          
          syz := homalg_ring!.random_matrix_func( Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ), NrRows( syz ) ) * syz;
          
          m := CertainColumns( syz, [ 1 .. NrRows( x ) ] );
          
          M := AsRightPresentation( m );
          
          y := CertainColumns( syz, [ NrRows( x ) + 1 .. NrCols( syz ) ] );
          
          # Now: m*x + y*u = 0
          return PresentationMorphism( U, y, M );
    
    end ); 
    
end;

##
ADD_RANDOM_MORPHISM_WITH_FIXED_RANGE_RIGHT := 
    function( category )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      
      AddRandomMorphismWithFixedRangeByInteger( category,
        function( M, n )
          local m, y, syz, e, u, U;
          
          if n < 0 then
            
            return fail;
          
          fi;
          
          if n = 0 then
            
            return UniversalMorphismFromZeroObject( M );
          
          fi;
          
          m := UnderlyingMatrix( M );
          
          y := homalg_ring!.random_matrix_func( NrRows( m ), n );
          
          syz := SyzygiesOfColumns( UnionOfColumns( m, y ) );
          
          syz := syz * homalg_ring!.random_matrix_func( NrCols( syz  ), Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ) );
          
          u := CertainRows( syz, [ NrCols( m ) + 1 .. NrRows( syz ) ] );
          
          U := AsRightPresentation( u );
          
          return PresentationMorphism( U, y, M );
      
     end );
    
end;

## In this method: we find a random linear combination of random elements in Hom(M,N) with coefficients |n|-powers of random ring elements.
##

ADD_RANDOM_MORPHISM_WITH_FIXED_SOURCE_AND_RANGE :=
    function( category, left_or_right )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      

      AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
        function( M, N, n )
          local H, nr_generators, random_positions, maps;
          
          H := InternalHomOnObjects( M, N );
          
          if left_or_right = "left" then
            
            nr_generators := NrCols( UnderlyingMatrix( H ) );
          
          else
            
            nr_generators := NrRows( UnderlyingMatrix( H ) );
          
          fi;
          
          if nr_generators = 0 then
            
            return ZeroMorphism( M, N );
          
          fi;
          
          random_positions := List( [ 1 .. Random( [ 1 .. nr_generators ] ) ], i -> Random( [ 1 .. nr_generators ] ) );
          
          maps := List( random_positions, p -> StandardGeneratorMorphism( H, p ) );
          
          if left_or_right = "left" then
            
            maps := List( maps, map ->
                    homalg_ring!.random_element_func(  )^AbsInt( n ) * InternalHomToTensorProductAdjunctionMap( M, N, map ) );
          
          else
            
            maps := List( maps, map -> InternalHomToTensorProductAdjunctionMap( M, N, map ) * homalg_ring!.random_element_func(  ) );
          
          fi;
          
          return Sum( maps );
    
        end );
    
end;

##
TRY_TO_ENHANCE_HOMALG_RING_WITH_RANDOM_FUNCTIONS :=
  function( R )
    local random_element_func, random_matrix_func;
    
    if IsBound( R!.random_element_func ) and IsBound( R!.random_matrix_func ) then
      
      return true;
    
    fi;
    
    if ( HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) ) or 
        ( HasIsExteriorRing( R ) and IsExteriorRing( R ) ) then
      
      random_element_func :=
        function(  )
             local ind, n, l1, l2;
             
             ind := Concatenation(  [ One( R ) ], Indeterminates( R ), Indeterminates( R ) );
             
             n := Random( [ 1, 1, 1, 2, 2, 3 ] );
             
             l1 := List( [ 1 .. n ], i -> Product( Random( Combinations( ind, i ) ) ) );
             
             l2 := List( [ 1 .. n ], i -> Random( [ -2, -1, -1, 0, 1, 1, 2 ] ) * One( R ) );
             
             return l1 * l2;
        
        end;
        
      R!.random_element_func := random_element_func;
    
    elif ( HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) ) or
          ( HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) ) then
      
      random_element_func :=
        function( )
          
          return Random( [ -20 .. 20 ] )*One( R );
        
        end;
      
      R!.random_element_func := random_element_func;
    
    elif HasAmbientRing( R ) and IsBound( AmbientRing( R )!.random_element_func ) then
    
      random_element_func :=
        function( )
          
          return AmbientRing( R )!.random_element_func(  )/R;
        
        end;
      
      R!.random_element_func := random_element_func;
     
     fi;
     
     random_matrix_func :=
        function( m, n )
          local L;
          
          if m * n = 0 then
            
            return HomalgZeroMatrix( m, n, R );
          
          else
            
            L := List( [ 1 .. m ], i -> List( [ 1 .. n ], j -> R!.random_element_func(  ) ) );
            
            return HomalgMatrix( L, m, n, R );
          
          fi;
        
        end;
     
     if IsBound( R!.random_element_func ) then
       
       R!.random_matrix_func := random_matrix_func;
       
       return true;
     
     else
       
       return false;
     
     fi;
    
end;


ADD_RANDOM_METHODS_TO_MODULE_PRESENTATIONS := function( category, left_or_right )
  local S;

  S := category!.ring_for_representation_category;
  
  TRY_TO_ENHANCE_HOMALG_RING_WITH_RANDOM_FUNCTIONS( S );
  
  if left_or_right = "left"  then
    
    if IsBound( category!.ring_for_representation_category!.random_element_func ) and 
         IsBound( category!.ring_for_representation_category!.random_matrix_func ) then
      
      ADD_RANDOM_OBJECT( category, "left" );
      
      ADD_RANDOM_MORPHISM_WITH_FIXED_SOURCE_LEFT( category );
      
      ADD_RANDOM_MORPHISM_WITH_FIXED_RANGE_LEFT( category );
      
      if HasIsCommutative( category!.ring_for_representation_category ) and IsCommutative( category!.ring_for_representation_category ) then
        
        ADD_RANDOM_MORPHISM_WITH_FIXED_SOURCE_AND_RANGE( category, "left" );
      
      fi;
    
    fi;
    
  elif left_or_right = "right" then
  
    if IsBound( category!.ring_for_representation_category!.random_element_func ) and
         IsBound( category!.ring_for_representation_category!.random_matrix_func ) then
      
      ADD_RANDOM_OBJECT( category, "right" );
      
      ADD_RANDOM_MORPHISM_WITH_FIXED_SOURCE_RIGHT( category );
      
      ADD_RANDOM_MORPHISM_WITH_FIXED_RANGE_RIGHT( category );
      
      if HasIsCommutative( category!.ring_for_representation_category ) and IsCommutative( category!.ring_for_representation_category ) then
        
        ADD_RANDOM_MORPHISM_WITH_FIXED_SOURCE_AND_RANGE( category, "right" );
      
      fi;
    
    fi;
    
  fi;
  
  Finalize( category );
  
end;
