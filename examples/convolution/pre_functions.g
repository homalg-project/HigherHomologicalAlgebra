ReadPackage( "DerivedCategories", "examples/pre_settings.g" );

create_labels_for_vertices :=
  function( l, r, b, a, names )
    local labels;
    
    labels := Cartesian( [ l .. r ], [ b .. a ] );
    
    return
      Concatenation(
        List( names, name ->
            List( labels,
                i -> 
                  ReplacedString(
                    Concatenation( name, "_", String( i[ 1 ] ), "x", String( i[ 2 ] ) ),
                    "-",
                    "m"
                  )
              )
            )
        );
end;

create_labels_for_01_differentials :=
  function( l, r, b, a, names )
    local indices, labels, u, v, index, N, name;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    labels := [ ]; 
    
    for N in [ 1 .. Size( names ) ] do
      
      for name in names[ N ] do
        
        for index in indices do
          
          u := Position( indices, index );
          
          v := PositionsProperty( indices,
                i -> Sum( index ) - Sum( i ) = 1 and index[ 2 ] - i[ 2 ] in [ 0, 1 ] );
          
          v := List( v, i ->
                  [
                    ReplacedString(
                      Concatenation( name, "_", String( index[ 1 ] ), "x", String( index[ 2 ] ), "_",
                      String( index[ 2 ] - indices[ i ][ 2 ] ) ),
                      "-",
                      "m"
                    ),
                    ( r - l + 1 ) * ( a - b + 1 ) * ( N - 1 ) + u,
                    ( r - l + 1 ) * ( a - b + 1 ) * ( N - 1 ) + i
                  ] );
          
          labels := Concatenation( labels, v );
          
        od;
        
      od;
      
    od;
    
    return TransposedMat( labels );
    
end;

create_labels_for_higher_differentials :=
  function( l, r, b, a, names )
    local N, indices, labels, u, v, index, name;
    
    if Minimum( r - l, a - b ) < 2 then
      return [  [ ], [ ], [ ] ];
    fi;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    labels := [ ]; 
    
    for N in [ 1 .. Size( names ) ] do
      
      for name in names[ N ] do
        
        for index in indices do
          
          u := Position( indices, index );
          
          v := PositionsProperty( indices,
                i -> Sum( index ) - Sum( i ) = 1 and index[ 2 ] - i[ 2 ] > 1 );
          
          v := List( v, i ->
                  [
                    ReplacedString(
                      Concatenation( name, "_", String( index[ 1 ] ), "x", String( index[ 2 ] ), "_", 
                        String( index[ 2 ] - indices[ i ][ 2 ] ) ),
                      "-",
                      "m"
                    ),
                    ( r - l + 1 ) * ( a - b + 1 ) * ( N - 1 ) + u,
                    ( r - l + 1 ) * ( a - b + 1 ) * ( N - 1 ) + i
                  ] );
          
          labels := Concatenation( labels, v );
          
        od;
      
      od;
      
    od;
    
    return TransposedMat( labels );
    
end;

create_labels_for_0_morphisms :=
  function( l, r, b, a, names )
    local indices, labels, current_labels, N, name;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    labels := [ ];
    
    for N in [ 1 .. Size( names ) ] do
      
      for name in names[ N ] do
        
          current_labels :=
                  List( [ 1 .. Size( indices ) ],
                      i -> [  
                          ReplacedString(
                            Concatenation( name, "_", String( indices[ i ][ 1 ] ), "x", String( indices[ i ][ 2 ] ), "_0" ),
                            "-",
                            "m"
                          ),
                          i + ( N - 1 ) * ( r - l + 1 ) * ( a - b + 1 ),
                          i + N * ( r - l + 1 ) * ( a - b + 1 )
                        ]
                  );
          
          labels := Concatenation( labels, current_labels );
          
      od;
        
    od;
    
    return TransposedMat( labels );
    
end;

create_labels_for_higher_morphisms :=
  function( l, r, b, a, names )
    local indices, labels, pos, positions, current_labels, s, N, name, index, p;
    
    if Minimum( r - l, a - b ) < 1 then
      return [  [ ], [ ], [ ] ];
    fi;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    labels := [ ];
    
    for N in [ 1 .. Size( names ) ] do
      
      for name in names[ N ] do
        
        for index in indices do
          
          pos := Position( indices, index );
          
          positions := PositionsProperty( indices, i -> Sum( index ) = Sum( i ) and index[ 2 ] - i[ 2 ] > 0 );
          
          current_labels := [ ];
          
          for p in positions do
            
            s := ReplacedString(
                    Concatenation( name, "_", String( index[1] ), "x", String( index[ 2 ] ), "_", String( index[ 2 ] - indices[ p ][ 2 ] ) ),
                    "-",
                    "m"
                  );
            
            Add( current_labels, [ s, pos + ( N - 1 ) * ( r - l + 1 ) * ( a - b + 1 ), N * ( r - l + 1 ) * ( a - b + 1 ) + p ] );
            
          od;
          
          labels := Concatenation( labels, current_labels );
          
        od;
      
      od;
      
    od;
    
    return TransposedMat( labels );
    
end;

create_labels_for_homotopies :=
  function( l, r, b, a, names )
    local indices, labels, pos, positions, current_labels, s, N, name, index, p;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    labels := [ ];
    
    for N in [ 1 .. Size( names ) ] do
        
      for name in names[ N ] do
        
        for index in indices do
          
          pos := Position( indices, index );
              
          positions := PositionsProperty( indices, i -> Sum( index ) + 1 = Sum( i ) and index[ 2 ] - i[ 2 ] >= 0 );
              
          current_labels := [ ];
          
          for p in positions do
            
            s := ReplacedString(
                    Concatenation( name, "_", String( index[1] ), "x", String( index[ 2 ] ), "_", String( index[ 2 ] - indices[ p ][ 2 ] ) ),
                    "-",
                    "m"
                  );
                
            Add( current_labels, [ s, pos + ( N - 1 ) * ( r - l + 1 ) * ( a - b + 1 ), N * ( r - l + 1 ) * ( a - b + 1 ) + p ] );
            
          od;
          
          labels := Concatenation( labels, current_labels );
          
        od;
      
      od;
      
    od;
    
    return TransposedMat( labels );
    
end;

differentials_relations :=
  function( A, l, r, b, a, 01_diff_names, higher_diff_names )
    local indices, relations, pos, current_index, degree, positions_of_relevant_indices, current_relation, name, x, y, N, higher_diff_name, index, p;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    relations := [ ];
    
    for N in [ 1 .. Size( 01_diff_names ) ] do
      
      for higher_diff_name in higher_diff_names[ N ] do
        
        for index in indices do
          
          pos := PositionsProperty( indices, 
                      i -> Sum( index ) - Sum( i ) = 2 and index[ 2 ] - i[ 2 ] >= 0
                    );
          
          for p in pos do
            
            current_index := indices[ p ];
            
            degree := index[ 2 ] - current_index[ 2 ];
                    
            positions_of_relevant_indices :=
              PositionsProperty( indices,
                i -> Sum( index ) - Sum( i ) = 1 and index[ 2 ] - i[ 2 ] in [ 0 .. degree ]
                  );
            
            current_relation := Zero( A );

            for p in positions_of_relevant_indices do
              
              if index[ 2 ] - indices[p][ 2 ] in [ 0, 1 ] then
                name := 01_diff_names[ N ];
              else
                name := higher_diff_name;
              fi;
              
              x := Concatenation(
                    name,
                    "_",
                    String( index[ 1 ] ),
                    "x",
                    String( index[ 2 ] ),
                    "_",
                    String( index[ 2 ] - indices[p][ 2 ] )
                  );
              
              x := ReplacedString( x, "-", "m" );
              
              if indices[ p ][ 2 ] - current_index[ 2 ] in [ 0, 1 ] then
                name := 01_diff_names[ N ];
              else
                name := higher_diff_name;
              fi;
             
              y := Concatenation(
                    name,
                    "_",
                    String( indices[ p ][ 1 ] ),
                    "x",
                    String( indices[ p ][ 2 ] ),
                    "_",
                    String( indices[ p ][ 2 ] - current_index[ 2 ] )
                  );
              
              y := ReplacedString( y, "-", "m" );
              
              current_relation := current_relation + A.(x) * A.(y);
              
            od;
            
            Add( relations, current_relation );
            
          od;
            
        od;
      
      od;
      
    od;
    
    return Set( relations );
    
end;

morphisms_relations :=
  function( A, l, r, b, a, names )
    local indices, relations, positions, current_index, degree, positions_for_left_side, left_side, diff_name, x, morphism_name, y, positions_for_right_side, right_side, name, index, p, u;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    relations := [ ];
    
    for name in names do
      
      for index in indices do
        
        positions := PositionsProperty( indices, i -> Sum( index ) - Sum( i ) = 1 and index[ 2 ] - i[ 2 ] >= 0 );
        
        for p in positions do
          
          current_index := indices[ p ];
          
          degree := index[ 2 ] - current_index[ 2 ];
          
          positions_for_left_side :=
            PositionsProperty( indices, i -> Sum( index ) - Sum( i ) = 1 and index[ 2 ] - i[ 2 ] in [ 0 .. degree ] );
            
          left_side := Zero( A );
          
          for u in positions_for_left_side do
            
            if index[ 2 ] - indices[ u ][ 2 ] in [ 0, 1 ] then
              diff_name := name[ 1 ];
            else
              diff_name := name[ 2 ];
            fi;
            
            x := Concatenation(
                      diff_name,
                      "_",
                      String( index[ 1 ] ),
                      "x",
                      String( index[ 2 ] ),
                      "_",
                      String( index[ 2 ] - indices[ u ][ 2 ] )
                    );
            
            x := ReplacedString( x, "-", "m" );
            
            if indices[ u ][ 2 ] - current_index[ 2 ] = 0 then
              morphism_name := name[ 3 ];
            else
              morphism_name := name[ 4 ];
            fi;
            
            y := Concatenation(
                      morphism_name,
                      "_",
                      String( indices[ u ][ 1 ] ),
                      "x",
                      String( indices[ u ][ 2 ] ),
                      "_",
                      String( indices[ u ][ 2 ] - current_index[ 2 ] )
                    );
            
            y := ReplacedString( y, "-", "m" );
            
            left_side := left_side + A.( x ) * A.( y );
            
          od;
          
          positions_for_right_side :=
            PositionsProperty( indices, i -> Sum( index ) - Sum( i ) = 0 and index[ 2 ] - i[ 2 ] in [ 0 .. degree ] );
            
          right_side := Zero( A );
          
          for u in positions_for_right_side do
            
            if index[ 2 ] - indices[ u ][ 2 ] = 0 then
              morphism_name := name[ 3 ];
            else
              morphism_name := name[ 4 ];
            fi;
           
            x := Concatenation(
                      morphism_name,
                      "_",
                      String( index[ 1 ] ),
                      "x",
                      String( index[ 2 ] ),
                      "_",
                      String( index[ 2 ] - indices[ u ][ 2 ] )
                    );
            
            x := ReplacedString( x, "-", "m" );
            
            if indices[ u ][ 2 ] - current_index[ 2 ] in [ 0, 1 ] then
              diff_name := name[5];
            else
              diff_name := name[6];
            fi;
            
            y := Concatenation(
                      diff_name,
                      "_",
                      String( indices[ u ][ 1 ] ),
                      "x",
                      String( indices[ u ][ 2 ] ),
                      "_",
                      String( indices[ u ][ 2 ] - current_index[ 2 ] )
                    );
            
            y := ReplacedString( y, "-", "m" );
            
            right_side := right_side + A.( x ) * A.( y );
            
          od;

          Add( relations, left_side - right_side );
          
        od;
        
      od;
    
    od;
    
    return Set( relations );
   
end;


homotopies_relations :=
  function( A, l, r, b, a, names )
    local indices, relations, positions, current_index, degree, m_names, morphisms, rel, positions_for_left_side, diff_name, x, y, positions_for_right_side, name, index, p, u;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    relations := [ ];
    
    for name in names do
      
      for index in indices do
        
        positions := PositionsProperty( indices, k -> Sum( index ) = Sum( k ) and index[ 2 ] - k[ 2 ] >= 0 );
        
        for p in positions do
          
          current_index := indices[ p ];
          
          degree := index[ 2 ] - current_index[ 2 ];
          
          if degree = 0 then
            m_names := name[ 3 ];
          else
            m_names := name[ 4 ];
          fi;
          
          morphisms :=
            List( m_names,
              m_name -> A. ( ReplacedString(
                            Concatenation(
                            m_name,
                            "_",
                            String( index[ 1 ] ),
                            "x",
                            String( index[ 2 ] ),
                            "_",
                            String( degree )
                            ),
                            "-",
                            "m" )
                        )
                );
          
          if Size( morphisms ) = 1 then
            rel := morphisms[ 1 ];
          elif Size( morphisms ) = 2 then
            rel := morphisms[ 1 ] - morphisms[ 2 ];
          else
            Error( "bad input!\n" );
          fi;
          
          positions_for_left_side :=
              PositionsProperty( indices, i -> Sum( index ) - 1 = Sum( i ) and index[ 2 ] - i[ 2 ] in [ 0 .. degree ] );
            
          for u in positions_for_left_side do
            
            if index[ 2 ] - indices[ u ][ 2 ] in [ 0, 1 ] then
              diff_name := name[ 1 ];
            else
              diff_name := name[ 2 ];
            fi;
            
            x := Concatenation(
                    diff_name,
                    "_",
                    String( index[ 1 ] ),
                    "x",
                    String( index[ 2 ] ),
                    "_",
                    String( index[ 2 ] - indices[ u ][ 2 ] )
                  );
                  
            x := ReplacedString( x, "-", "m" );
            
            y := Concatenation(
                    name[ 5 ],
                    "_",
                    String( indices[ u ][ 1 ] ),
                    "x",
                    String( indices[ u ][ 2 ] ),
                    "_",
                    String( indices[ u ][ 2 ] - current_index[ 2 ] )
                  );
                  
            y := ReplacedString( y, "-", "m" );
            
            rel := rel + A.( x ) * A.( y );
            
          od;
          
          positions_for_right_side :=
              PositionsProperty( indices, i -> Sum( index ) + 1 = Sum( i ) and index[ 2 ] - i[ 2 ] in [ 0 .. degree ] );
              
          for u in positions_for_right_side do
          
            x := Concatenation(
                    name[ 5 ],
                    "_",
                    String( index[ 1 ] ),
                    "x",
                    String( index[ 2 ] ),
                    "_",
                    String( index[ 2 ] - indices[ u ][ 2 ] )
                  );
                   
            x := ReplacedString( x, "-", "m" );
            
            if indices[ u ][ 2 ] - current_index[ 2 ] in [ 0, 1 ] then
              diff_name := name[ 6 ];
            else
              diff_name := name[ 7 ];
            fi;
            
            y := Concatenation(
                    diff_name,
                    "_",
                    String( indices[ u ][ 1 ] ),
                    "x",
                    String( indices[ u ][ 2 ] ),
                    "_",
                    String( indices[ u ][ 2 ] - current_index[ 2 ] )
                  );
            
            y := ReplacedString( y, "-", "m" );
            
            rel := rel + A.( x ) * A.( y );
            
          od;
          
          Add( relations, rel );
          
        od;
        
      od;
      
    od;
    
    return Set( relations );
    
end;

create_complexes :=
  function( AC, l, r, b, a, names )
    local indices, diffs, complexes, maps, name;
    
    indices := List( [ b .. a ], i -> Cartesian( [ l + 1 .. r ], [ i ] ) );
    
    for name in names do
      
      diffs := List( indices,
                row -> List( row,
                  i -> ValueGlobal( ReplacedString(
                          Concatenation( name[ 1 ], "_", String( i[ 1 ] ), "x", String( i[ 2 ] ), "_0" ),
                          "-",
                          "m"
                          ) ) / AC
                        )
                  );
      
      complexes := ListN( [ b .. a ], diffs,
        function( i, diff )
          local s;
          s := ReplacedString(
                  Concatenation( name[ 2 ], "_", String( i ) ), "-", "m"
                );
          
          Print( "Setting a global variable: ", s, "\n" );

          BindGlobal( s, HomotopyCategoryObject( diff, l + 1 ) );
          return ValueGlobal( s );
        end );
      
      maps := List( [ b + 1 .. a ], i -> Cartesian( [ l .. r ], [ i ] ) );
      
      maps := List( maps,
                row -> List( row,
                  i -> (-1) ^ Sum( i ) * ValueGlobal( ReplacedString(
                          Concatenation( name[ 1 ], "_", String( i[ 1 ] ), "x", String( i[ 2 ] ), "_1" ),
                          "-",
                          "m"
                          ) ) / AC
                        )
                  );
      
      maps := ListN( [  b + 1 .. a ], maps,
              function( i, map )
                local p, s;
                
                p := Position( [ b + 1 .. a ], i );
                
                s := ReplacedString(
                        Concatenation( "d", name[ 2 ], "_", String( i ) ), "-", "m"
                      );
                
                Print( "Setting a global variable: ", s, "\n" );
                
                BindGlobal( s, HomotopyCategoryMorphism( complexes[ p + 1 ], complexes[ p ], map, l ) );
                
                return ValueGlobal( s );
                
              end );
   
      Print( "Setting a global variable: ", name[ 2 ], "\n" );

      BindGlobal( name[ 2 ], ChainComplex( maps,  b + 1 ) );
   
   od;
   
end;

create_morphisms :=
  function( AC, l, r, b, a, names )
    local indices, all_maps, sources, ranges, maps, name;
    
    indices := List( [ b .. a ], i -> Cartesian( [ l .. r ], [ i ] ) );
    
    for name in names do
      
      all_maps := List( indices, row ->
                List( row, map ->
                  ValueGlobal(
                    ReplacedString(
                      Concatenation( name[ 3 ], "_", String( map[ 1 ] ), "x", String( map[ 2 ] ), "_0" ),
                      "-",
                      "m"
                    )
                  ) / AC
                )
              );
      
      sources := List( [ b .. a ], i -> ValueGlobal( ReplacedString( Concatenation( name[ 1 ], "_", String( i ) ), "-", "m" ) ) );
      
      ranges := List( [ b .. a ], i -> ValueGlobal( ReplacedString( Concatenation( name[ 2 ], "_", String( i ) ), "-", "m" ) ) );
      
      maps := List( [ b .. a ],
                function( i )
                  local s, p;
                  p := Position( [ b .. a ], i );
                  s := ReplacedString( Concatenation( name[ 3 ], "_", String( i ) ), "-", "m" ); 
                  Print( "Setting a global variable: ", s, "\n" );
                  BindGlobal( s, HomotopyCategoryMorphism( sources[ p ], ranges[ p ], all_maps[ p ], l ) );
                  return ValueGlobal( s );
                end );
      
      Print( "Setting a global variable: ", name[ 3 ], "\n" );
      BindGlobal( name[ 3 ], ChainMorphism( ValueGlobal( name[ 1 ] ), ValueGlobal( name[ 2 ] ), maps, b ) );
    
    od;
    
end;

hack_algebroid_morphism :=
  function( f, y, z )
    local e, p, c;
    e := UnderlyingQuiverAlgebraElement( f );
    if IsZero( e ) then
      return f;
    fi;
    e := Representative( e );
    p := Paths( e );
    if Size( p ) <> 1 then
      Error( "not expected input!" );
    fi;
    c := Coefficients( e );
    return c[ 1 ] * ValueGlobal( ReplacedString( String( p[ 1 ] ), y, z ) );
end;

hack_additive_closure_morphism :=
  function( F, y, z )
    local AC, m;
    AC := CapCategory( F );
    m := MorphismMatrix( F );
    m := List( m, row -> List( row, f -> hack_algebroid_morphism( f, y, z ) ) );
    return AdditiveClosureMorphism( Source( F ), m, Range( F ) );
end;

hack_object_in_homotopy_category :=
  function( C, y, z )
    local l, u, diffs; 
    l := ActiveLowerBound( C );
    u := ActiveUpperBound( C );
    diffs := List( [ l + 1 .. u ], i -> hack_additive_closure_morphism( C ^ i, y, z ) );
    return HomotopyCategoryObject( diffs, l + 1 );
end;

hack_morphism_in_homotopy_category :=
  function( F, y, z )
    local l, u, maps;
    l := ActiveLowerBound( F );
    u := ActiveUpperBound( F );
    maps := List( [ l .. u ], i -> hack_additive_closure_morphism( F[ i ], y, z ) );
    return HomotopyCategoryMorphism( Source( F ), Range( F ), maps, l );
end;
