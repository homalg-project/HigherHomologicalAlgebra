ENHANCE_HOMALG_RING_WITH_RANDOM_FUNCTIONS :=
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

AddRandomMethodsToRows := function( category )
  local R;
  
  R := category!.UnderlyingRing;
  
  ENHANCE_HOMALG_RING_WITH_RANDOM_FUNCTIONS( R );
  
  ##
  AddRandomObjectByList( category,
    function( category, L )
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
      
      return CategoryOfRowsObject( Random( L ), category ); 
      
    end );
  
  ##
  AddRandomMorphismWithFixedSourceByList( category,
    function( a, L )
      local r, mat, b;
      
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
     
      r := Random( L );
      
      mat := R!.random_matrix_func( RankOfObject( a ), r );
      
      b := CategoryOfRowsObject( r, category );
      
      return CategoryOfRowsMorphism( a, mat, b );
      
      end );
  
  ##
  AddRandomMorphismWithFixedRangeByList( category,
    function( b, L )
      local r, mat, a;
      
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
     
      r := Random( L );
      
      mat := R!.random_matrix_func( r, RankOfObject( b ) );
      
      a := CategoryOfRowsObject( r, category );
      
      return CategoryOfRowsMorphism( a, mat, b );
      
      end );
  
  ##
  AddRandomMorphismWithFixedSourceAndRangeByList( category,
    function( a, b, L )
      local mat;
      
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
      
      mat := R!.random_matrix_func( RankOfObject( a ), RankOfObject( b ) );
      
      return CategoryOfRowsMorphism( a, mat, b );
      
      end );
  ##
  AddRandomMorphismByList( category,
    function( category, L )
      local r1, r2, a, b, mat;
      
      if Length( L ) = 0 then
        Error();
      fi;
      
      if not ForAll( L, IsPosInt ) then
        Error();
      fi;
      
      r1 := Random( L );
      
      r2 := Random( L );
      
      a := CategoryOfRowsObject( r1, category );

      b := CategoryOfRowsObject( r2, category );

      mat := R!.random_matrix_func( r1, r2 );
      
      return CategoryOfRowsMorphism( a, mat, b );
      
    end );
  
end;
