ReadPackage( "DerivedCategories", "examples/pre_settings.g" );

create_labels_for_vertices_chains :=
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

create_labels_for_01_differentials_chains :=
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

create_labels_for_higher_differentials_chains :=
  function( l, r, b, a, names )
    local N, indices, labels, u, v, index, name;
    
    if IsEmpty( names ) or Minimum( r - l, a - b ) < 2 then
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

create_labels_for_0_morphisms_chains :=
  function( l, r, b, a, names )
    local indices, labels, current_labels, N, name;
    
    if IsEmpty( names ) then
      return [ [ ], [ ], [ ] ];
    fi;
    
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

create_labels_for_higher_morphisms_chains :=
  function( l, r, b, a, names )
    local indices, labels, pos, positions, current_labels, s, N, name, index, p;
    
    if IsEmpty( names ) or Minimum( r - l, a - b ) < 1 then
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

create_labels_for_homotopies_chains :=
  function( l, r, b, a, names )
    local indices, labels, pos, positions, current_labels, s, N, name, index, p;
    
    if IsEmpty( names ) then
      return [ [ ], [ ], [ ] ];
    fi;

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

differentials_relations_chains :=
  function( A, l, r, b, a, diffs_names )
    local 01_diff_names, higher_diff_names, indices, relations, pos, current_index, degree, positions_of_relevant_indices, current_relation, name, x, y, N, higher_diff_name, index, p;
    
    01_diff_names := diffs_names[ 1 ];
    higher_diff_names := diffs_names[ 2 ];
    
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

morphisms_relations_chains :=
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

homotopies_relations_chains :=
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

create_chain_complexes :=
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

create_chain_morphisms :=
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

CreateHomotopyCategoryByChains :=
  function( field, l, r, b, a, names, complexes, morphisms )
    local vertices_labels, 01_diffs, higher_diffs, 0_morphisms, higher_morphisms, homotopies, diffs, mors, arrows, quiver, A, d_relations, m_relations, h_relations, relations, C, AC;
    
    vertices_labels := create_labels_for_vertices_chains( l, r, b, a, names[ 1 ] );
    
    01_diffs := create_labels_for_01_differentials_chains( l, r, b, a, names[ 2 ] );
    higher_diffs := create_labels_for_higher_differentials_chains( l, r, b, a, names[ 3 ] );
    
    0_morphisms := create_labels_for_0_morphisms_chains( l, r, b, a, names[ 4 ] );
    higher_morphisms := create_labels_for_higher_morphisms_chains( l, r, b, a, names[ 5 ] );
    homotopies := create_labels_for_homotopies_chains( l, r, b, a, names[ 6 ] );

    diffs := ListN( 01_diffs, higher_diffs, Concatenation );
    mors := ListN( 0_morphisms, higher_morphisms, homotopies, Concatenation );
    
    arrows := ListN( diffs, mors, Concatenation );
    
    quiver := RightQuiver( "quiver", vertices_labels, arrows[1], arrows[2], arrows[3] );
    
    A := PathAlgebra( field, quiver );
    
    d_relations := differentials_relations_chains( A, l, r, b, a, names[ 7 ] );
    
    m_relations := morphisms_relations_chains( A, l, r, b, a, names[ 8 ] );
    
    h_relations := homotopies_relations_chains( A, l, r, b, a, names[ 9 ] );

    relations := Concatenation( d_relations, m_relations, h_relations );
    
    A := A / relations;
    
    C := Algebroid( A );
    C!.Name := "algebroid over quiver algebra";
    
    AssignSetOfObjects( C );
    AssignSetOfGeneratingMorphisms( C );
    
    AC := AdditiveClosure( C );
    
    create_chain_complexes( AC, l, r, b, a, complexes );
    create_chain_morphisms( AC, l, r, b, a, morphisms );
    
    return AC;
end;

create_labels_for_vertices_cochains:=
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

create_labels_for_01_differentials_cochains:=
  function( l, r, b, a, names )
    local indices, labels, u, v, index, N, name;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    labels := [ ]; 
    
    for N in [ 1 .. Size( names ) ] do
      
      for name in names[ N ] do
        
        for index in indices do
          
          u := Position( indices, index );
          
          v := PositionsProperty( indices,
                i -> Sum( index ) - Sum( i ) = -1 and -index[ 2 ] + i[ 2 ] in [ 0, 1 ] );
          
          v := List( v, i ->
                  [
                    ReplacedString(
                      Concatenation( name, "_", String( index[ 1 ] ), "x", String( index[ 2 ] ), "_",
                      String( -index[ 2 ] + indices[ i ][ 2 ] ) ),
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

create_labels_for_higher_differentials_cochains:=
  function( l, r, b, a, names )
    local N, indices, labels, u, v, index, name;
    
    if IsEmpty( names ) or Minimum( r - l, a - b ) < 2 then
      return [  [ ], [ ], [ ] ];
    fi;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    labels := [ ]; 
    
    for N in [ 1 .. Size( names ) ] do
      
      for name in names[ N ] do
        
        for index in indices do
          
          u := Position( indices, index );
          
          v := PositionsProperty( indices,
                i -> Sum( index ) - Sum( i ) = -1 and -index[ 2 ] + i[ 2 ] > 1 );
          
          v := List( v, i ->
                  [
                    ReplacedString(
                      Concatenation( name, "_", String( index[ 1 ] ), "x", String( index[ 2 ] ), "_", 
                        String( -index[ 2 ] + indices[ i ][ 2 ] ) ),
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

create_labels_for_0_morphisms_cochains:=
  function( l, r, b, a, names )
    local indices, labels, current_labels, N, name;
    
    if IsEmpty( names ) then
      return [ [ ], [ ], [ ] ];
    fi;
    
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

create_labels_for_higher_morphisms_cochains:=
  function( l, r, b, a, names )
    local indices, labels, pos, positions, current_labels, s, N, name, index, p;
    
    if IsEmpty( names ) or Minimum( r - l, a - b ) < 1 then
      return [  [ ], [ ], [ ] ];
    fi;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    labels := [ ];
    
    for N in [ 1 .. Size( names ) ] do
      
      for name in names[ N ] do
        
        for index in indices do
          
          pos := Position( indices, index );
          
          positions := PositionsProperty( indices, i -> Sum( index ) = Sum( i ) and -index[ 2 ] + i[ 2 ] > 0 );
          
          current_labels := [ ];
          
          for p in positions do
            
            s := ReplacedString(
                    Concatenation( name, "_", String( index[1] ), "x", String( index[ 2 ] ), "_", String( -index[ 2 ] + indices[ p ][ 2 ] ) ),
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

create_labels_for_homotopies_cochains:=
  function( l, r, b, a, names )
    local indices, labels, pos, positions, current_labels, s, N, name, index, p;
    
    if IsEmpty( names ) then
      return [ [ ], [ ], [ ] ];
    fi;

    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    labels := [ ];
    
    for N in [ 1 .. Size( names ) ] do
        
      for name in names[ N ] do
        
        for index in indices do
          
          pos := Position( indices, index );
              
          positions := PositionsProperty( indices, i -> -Sum( i ) + Sum( index ) = 1 and -index[ 2 ] + i[ 2 ] >= 0 );
              
          current_labels := [ ];
          
          for p in positions do
            
            s := ReplacedString(
                    Concatenation( name, "_", String( index[1] ), "x", String( index[ 2 ] ), "_", String( -index[ 2 ] + indices[ p ][ 2 ] ) ),
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

differentials_relations_cochains :=
  function( A, l, r, b, a, diffs_names )
    local 01_diff_names, higher_diff_names, indices, relations, pos, current_index, degree, positions_of_relevant_indices, current_relation, name, x, y, N, higher_diff_name, index, p;
    
    01_diff_names := diffs_names[ 1 ];
    higher_diff_names := diffs_names[ 2 ];
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    relations := [ ];
    
    for N in [ 1 .. Size( 01_diff_names ) ] do
      
      for higher_diff_name in higher_diff_names[ N ] do
        
        for index in indices do
          
          pos := PositionsProperty( indices, 
                      i -> -Sum( index ) + Sum( i ) = 2 and -index[ 2 ] + i[ 2 ] >= 0
                    );
          
          for p in pos do
            
            current_index := indices[ p ];
            
            degree := -index[ 2 ] + current_index[ 2 ];
                    
            positions_of_relevant_indices :=
              PositionsProperty( indices,
                i -> -Sum( index ) + Sum( i ) = 1 and -index[ 2 ] + i[ 2 ] in [ 0 .. degree ]
                  );
            
            current_relation := Zero( A );

            for p in positions_of_relevant_indices do
              
              if -index[ 2 ] + indices[p][ 2 ] in [ 0, 1 ] then
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
                    String( -index[ 2 ] + indices[p][ 2 ] )
                  );
              
              x := ReplacedString( x, "-", "m" );
              
              if -indices[ p ][ 2 ] + current_index[ 2 ] in [ 0, 1 ] then
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
                    String( -indices[ p ][ 2 ] + current_index[ 2 ] )
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

morphisms_relations_cochains :=
  function( A, l, r, b, a, names )
    local indices, relations, positions, current_index, degree, positions_for_left_side, left_side, diff_name, x, morphism_name, y, positions_for_right_side, right_side, name, index, p, u;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    relations := [ ];
    
    for name in names do
      
      for index in indices do
        
        positions := PositionsProperty( indices, i -> -Sum( index ) + Sum( i ) = 1 and -index[ 2 ] + i[ 2 ] >= 0 );
        
        for p in positions do
          
          current_index := indices[ p ];
          
          degree := -index[ 2 ] + current_index[ 2 ];
          
          positions_for_left_side :=
            PositionsProperty( indices, i -> -Sum( index ) + Sum( i ) = 1 and -index[ 2 ] + i[ 2 ] in [ 0 .. degree ] );
            
          left_side := Zero( A );
          
          for u in positions_for_left_side do
            
            if -index[ 2 ] + indices[ u ][ 2 ] in [ 0, 1 ] then
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
                      String( -index[ 2 ] + indices[ u ][ 2 ] )
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
                      String( -indices[ u ][ 2 ] + current_index[ 2 ] )
                    );
            
            y := ReplacedString( y, "-", "m" );
            
            left_side := left_side + A.( x ) * A.( y );
            
          od;
          
          positions_for_right_side :=
            PositionsProperty( indices, i -> Sum( index ) - Sum( i ) = 0 and -index[ 2 ] + i[ 2 ] in [ 0 .. degree ] );
            
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
                      String( -index[ 2 ] + indices[ u ][ 2 ] )
                    );
            
            x := ReplacedString( x, "-", "m" );
            
            if -indices[ u ][ 2 ] + current_index[ 2 ] in [ 0, 1 ] then
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
                      String( -indices[ u ][ 2 ] + current_index[ 2 ] )
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

homotopies_relations_cochains:=
  function( A, l, r, b, a, names )
    local indices, relations, positions, current_index, degree, m_names, morphisms, rel, positions_for_left_side, diff_name, x, y, positions_for_right_side, name, index, p, u;
    
    indices := Cartesian( [ l .. r ], [ b .. a ] );
    
    relations := [ ];
    
    for name in names do
      
      for index in indices do
        
        positions := PositionsProperty( indices, k -> Sum( index ) = Sum( k ) and -index[ 2 ] + k[ 2 ] >= 0 );
        
        for p in positions do
          
          current_index := indices[ p ];
          
          degree := -index[ 2 ] + current_index[ 2 ];
          
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
              PositionsProperty( indices, i -> -Sum( index ) + Sum( i ) = 1 and -index[ 2 ] + i[ 2 ] in [ 0 .. degree ] );
            
          for u in positions_for_left_side do
            
            if -index[ 2 ] + indices[ u ][ 2 ] in [ 0, 1 ] then
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
                    String( -index[ 2 ] + indices[ u ][ 2 ] )
                  );
                  
            x := ReplacedString( x, "-", "m" );
            
            y := Concatenation(
                    name[ 5 ],
                    "_",
                    String( indices[ u ][ 1 ] ),
                    "x",
                    String( indices[ u ][ 2 ] ),
                    "_",
                    String( -indices[ u ][ 2 ] + current_index[ 2 ] )
                  );
                  
            y := ReplacedString( y, "-", "m" );
            
            rel := rel + A.( x ) * A.( y );
            
          od;
          
          positions_for_right_side :=
              PositionsProperty( indices, i -> -Sum( i ) + Sum( index ) = 1 and -index[ 2 ] + i[ 2 ] in [ 0 .. degree ] );
              
          for u in positions_for_right_side do
          
            x := Concatenation(
                    name[ 5 ],
                    "_",
                    String( index[ 1 ] ),
                    "x",
                    String( index[ 2 ] ),
                    "_",
                    String( -index[ 2 ] + indices[ u ][ 2 ] )
                  );
                   
            x := ReplacedString( x, "-", "m" );
            
            if -indices[ u ][ 2 ] + current_index[ 2 ] in [ 0, 1 ] then
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
                    String( -indices[ u ][ 2 ] + current_index[ 2 ] )
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

create_complexes:=
  function( AC, l, r, b, a, names )
    local Ho, indices, diffs, complexes, maps, name;
    
    Ho := HomotopyCategory( AC, true );
    indices := List( [ b .. a ], i -> Cartesian( [ l .. r - 1 ], [ i ] ) );
    
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

          BindGlobal( s, HomotopyCategoryObject( Ho, diff, l ) );
          return ValueGlobal( s );
        end );
      
      maps := List( [ b .. a - 1 ], i -> Cartesian( [ l .. r ], [ i ] ) );
      
      maps := List( maps,
                row -> List( row,
                  i -> (-1) ^ Sum( i ) * ValueGlobal( ReplacedString(
                          Concatenation( name[ 1 ], "_", String( i[ 1 ] ), "x", String( i[ 2 ] ), "_1" ),
                          "-",
                          "m"
                          ) ) / AC
                        )
                  );
      
      maps := ListN( [  b .. a - 1 ], maps,
              function( i, map )
                local p, s;
                
                p := Position( [ b .. a - 1 ], i );
                
                s := ReplacedString(
                        Concatenation( "d", name[ 2 ], "_", String( i ) ), "-", "m"
                      );
                
                Print( "Setting a global variable: ", s, "\n" );
                
                BindGlobal( s, HomotopyCategoryMorphism( complexes[ p ], complexes[ p + 1 ], map, l ) );
                
                return ValueGlobal( s );
                
              end );
   
      Print( "Setting a global variable: ", name[ 2 ], "\n" );

      BindGlobal( name[ 2 ], CochainComplex( maps,  b ) );
   
   od;
   
end;

create_morphisms:=
  function( AC, l, r, b, a, names )
    local Ho, indices, all_maps, sources, ranges, maps, name;
    
    Ho := HomotopyCategory( AC, true );
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
      BindGlobal( name[ 3 ], CochainMorphism( ValueGlobal( name[ 1 ] ), ValueGlobal( name[ 2 ] ), maps, b ) );
    
    od;
    
end;

CreateHomotopyCategoryByCochains :=
  function( field, l, r, b, a, names, complexes, morphisms )
    local vertices_labels, 01_diffs, higher_diffs, 0_morphisms, higher_morphisms, homotopies, diffs, mors, arrows, quiver, A, d_relations, m_relations, h_relations, relations, C, AC;
    
    vertices_labels := create_labels_for_vertices_cochains( l, r, b, a, names[ 1 ] );
    
    01_diffs := create_labels_for_01_differentials_cochains( l, r, b, a, names[ 2 ] );
    higher_diffs := create_labels_for_higher_differentials_cochains( l, r, b, a, names[ 3 ] );
    
    0_morphisms := create_labels_for_0_morphisms_cochains( l, r, b, a, names[ 4 ] );
    higher_morphisms := create_labels_for_higher_morphisms_cochains( l, r, b, a, names[ 5 ] );
    homotopies := create_labels_for_homotopies_cochains( l, r, b, a, names[ 6 ] );

    diffs := ListN( 01_diffs, higher_diffs, Concatenation );
    mors := ListN( 0_morphisms, higher_morphisms, homotopies, Concatenation );
    
    arrows := ListN( diffs, mors, Concatenation );
    
    quiver := RightQuiver( "quiver", vertices_labels, arrows[1], arrows[2], arrows[3] );
    
    A := PathAlgebra( field, quiver );
    
    d_relations := differentials_relations_cochains( A, l, r, b, a, names[ 7 ] );
    
    m_relations := morphisms_relations_cochains( A, l, r, b, a, names[ 8 ] );
    
    h_relations := homotopies_relations_cochains( A, l, r, b, a, names[ 9 ] );

    relations := Concatenation( d_relations, m_relations, h_relations );
    
    A := A / relations;
    SetName( A, "Algebra" );;
    
    C := Algebroid( A );
    C!.Name := "Algebroid";
    
    AssignSetOfObjects( C );
    AssignSetOfGeneratingMorphisms( C );
    
    AC := AdditiveClosure( C );
    
    create_complexes( AC, l, r, b, a, complexes );
    create_morphisms( AC, l, r, b, a, morphisms );
    
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
    if IsChainComplex( UnderlyingCell( C ) ) then
      
      diffs := List( [ l + 1 .. u ], i -> hack_additive_closure_morphism( C ^ i, y, z ) );
      return HomotopyCategoryObject( CapCategory( C ), diffs, l + 1 );
      
    else
      
      diffs := List( [ l .. u - 1 ], i -> hack_additive_closure_morphism( C ^ i, y, z ) );
      return HomotopyCategoryObject( CapCategory( C ), diffs, l );
      
    fi;
     
end;

hack_morphism_in_homotopy_category :=
  function( F, y, z )
    local l, u, maps;
    l := ActiveLowerBound( F );
    u := ActiveUpperBound( F );
    maps := List( [ l .. u ], i -> hack_additive_closure_morphism( F[ i ], y, z ) );
    return HomotopyCategoryMorphism( Source( F ), Range( F ), maps, l );
end;

# An example for an output:

if false then
  
  l := -2;
  r := 2;
  b := -2;
  a := 2;
  names :=
    [
      # vertices labels, these are the labels of the grid's
      [ "P", "Q" ],
      
      # 0,1 diffs labels, these are the diffs of degree 0 and 1, they go left and down, in case of chains, and right, up in case of cochains
      [ [ "dP" ], [ "dQ" ] ],
      
      # higher diffs labels, these are higher diffs, i.e., diffs of degree 2 and more, hence the letter "h"
      [ [ "hdP" ], [ "hdQ" ] ],
      
      # 0 morphisms labels, these are the morphisms of degree 0 between two grids
      [ [ "alpha", "beta" ] ],
      
      # higher morphisms labels, these are higher morphisms between two grids
      [ [ "h_alpha", "h_beta" ] ], 
      
      # homotopies that should exists between the two grids
      [
        [ "h" ]
      ],
      
      # differentials relations
      # this means dP will be extended by hdP and similarly for dQ
      [ [ "dP", "dQ" ], [ [ "hdP" ], [ "hdQ" ] ] ],
      
      # morphisms relations
      [
        [ "dP", "hdP", "alpha", "h_alpha", "dQ", "hdQ" ],
        [ "dP", "hdP", "beta",  "h_beta",  "dQ", "hdQ" ]
      ],
      
      # homotopies relations
      [
        [ "dP","hdP", [ "alpha", "beta" ], [ "h_alpha", "h_beta" ], "h", "dQ", "hdQ" ]
      ],
    ];
  
  complexes := [ [ "dP", "P" ], [ "dQ", "Q" ] ];
  morphisms := [ [ "P", "Q", "alpha" ], [ "P", "Q", "beta" ] ];

fi;

