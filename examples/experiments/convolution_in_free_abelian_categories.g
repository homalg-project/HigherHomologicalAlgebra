LoadPackage( "Bialgebroids");
LoadPackage( "DerivedCategories" );

##
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

create_vertrex_labels :=
  function( left_bound, horizontal_distance, below_bound, vertical_distance )
    
    return Cartesian(
                [ left_bound .. left_bound + horizontal_distance - 1 ],
                Reversed( [ below_bound .. below_bound + vertical_distance - 1 ] )
              );
end;

create_differentials_of_degree :=
  function( name, vertex_labels, degree )
    local labels, sources, ranges, V, U, p, i;
    
    if degree < 0 then
      Error( "degree must be greater or equal to zero" );
    fi;
    
    labels := [ ];
    sources := [ ];
    ranges := [ ];
    
    for i in [ 1 .. Size( vertex_labels ) ] do
      V := vertex_labels[ i ];
      U := V - [ 1 - degree, degree ];
      p := Position( vertex_labels, U );
      
      if p <> fail then
        
        Add( labels, Concatenation( name, "_", String( V[ 1 ] ), "x", String( V[ 2 ] ), "_", String( degree ) ) );
        
        Add( sources, i );
        
        Add( ranges, p );
        
      fi;
      
    od;
    
    return [ labels, sources, ranges ];
    
end;

create_maps_of_degree :=
  function( vertex_labels, degree )
    local N, labels, sources, ranges, V, U, p, i;
    
    if degree < 0 then
      Error( "degree must be greater or equal to zero" );
    fi;
    
    N := Size( vertex_labels );
    
    labels := [ ];
    sources := [ ];
    ranges := [ ];
    
    for i in [ 1 .. Size( vertex_labels ) ] do
      
      V := vertex_labels[ i ];
      U := V + [ degree, - degree ];
      p := Position( vertex_labels, U );
      
      if p <> fail then
        
        Add( labels, Concatenation( "alpha_", String( V[ 1 ] ), "x", String( V[ 2 ] ), "_", String( degree ) ) );
        
        Add( sources, i );
        
        Add( ranges, N + p );
        
      fi;
      
    od;
    
    return [ labels, sources, ranges ];
    
end;

create_quiver :=
  function( left_bound, horizontal_distance, below_bound, vertical_distance )
    local vertex_labels, N, labels, sources, ranges, degree, maps, diffs, vertex_labels_1, vertex_labels_2, quiver;
    
    vertex_labels := create_vertrex_labels( left_bound, horizontal_distance, below_bound, vertical_distance );
    
    N := Size( vertex_labels );
    
    labels := [ ];
    
    sources := [ ];
    
    ranges := [ ];
    
    degree := 0;
    
    while true do
      
      maps := create_maps_of_degree( vertex_labels, degree );
      
      if IsEmpty( maps[ 1 ] ) and degree > 0 then
        
        break;
        
      fi;
      
      labels := Concatenation( labels, maps[ 1 ] );
      
      sources := Concatenation( sources, maps[ 2 ] );
      
      ranges := Concatenation( ranges, maps[ 3 ] );
      
      degree := degree + 1; 
      
    od;
    
    degree := 0;
    
    while true do
      
      diffs := create_differentials_of_degree( "d", vertex_labels, degree );
      
      if IsEmpty( diffs[ 1 ] ) and degree > 0 then
        
        break;
        
      fi;
      
      labels := Concatenation( labels, diffs[ 1 ] );
      
      sources := Concatenation( sources, diffs[ 2 ] );
      
      ranges := Concatenation( ranges, diffs[ 3 ] );
      
      degree := degree + 1;
      
    od;
    
    degree := 0;
    
    while true do
      
      diffs := create_differentials_of_degree( "c", vertex_labels, degree );
      
      if IsEmpty( diffs[ 1 ] ) and degree > 0 then
        
        break;
        
      fi;
      
      labels := Concatenation( labels, diffs[ 1 ] );
      
      sources := Concatenation( sources, N + diffs[ 2 ] );
      
      ranges := Concatenation( ranges, N + diffs[ 3 ] );
      
      degree := degree + 1;
      
    od;
   
    vertex_labels_1 := List( vertex_labels, v -> Concatenation( "P_", String( v[ 1 ] ), "x", String( v[ 2 ] ) ) );
    
    vertex_labels_2 := List( vertex_labels, v -> Concatenation( "Q_", String( v[ 1 ] ), "x", String( v[ 2 ] ) ) );
    
    vertex_labels := Concatenation( vertex_labels_1, vertex_labels_2 );
    
    quiver := RightQuiver( "quiver", vertex_labels, labels, sources, ranges );
    
    quiver!.maximum_degree := degree - 1;
     
    return quiver;
    
end;

relations_of_differentials_by_vertex_and_degree :=
  function( A, V, N )
    local quiver, vertex_labels, W, p, degrees, e, U, a, b, degree, label, l;
    
    quiver := QuiverOfAlgebra( A );
    
    if N > quiver!.maximum_degree then
      
      return Zero( A );
      
    fi;
    
    V := Label( V );
    
    V := SplitString( V, "_x" );
    
    label := V[ 1 ];
    
    if label = "P" then
      l := "d";
    elif label = "Q" then
      l := "c";
    fi;
    
    V := V{ [ 2, 3 ] };
    
    V := List( V, Int );
    
    vertex_labels := VertexLabels( quiver ){ [ 1 .. NumberOfVertices( quiver ) / 2 ] };
    
    vertex_labels := List( vertex_labels, v -> SplitString( v, "_x" ){ [ 2, 3 ] } );
    
    vertex_labels := List( vertex_labels, v -> List( v, Int ) );
    
    W := V - [ 2 - N, N ];
    
    p := Position( vertex_labels, W );
    
    if p = fail then
      
      return Zero( A );
      
    fi;
    
    degrees := [ 0 .. N ];
    
    e := Zero( A );
    
    for degree in degrees do
      
      U := V - [ 1 - degree, degree ];
      
      if not U in vertex_labels then
        continue;
      fi;
      
      a := Concatenation( l, "_", String( V[ 1 ] ), "x", String( V[ 2 ] ), "_", String( degree ) );
      
      b := Concatenation( l, "_", String( U[ 1 ] ), "x", String( U[ 2 ] ), "_", String( N - degree ) );
      
      e := e + A.( a ) * A.( b );
      
    od;
    
    return e;
    
end;

relations_of_maps_by_vertex_and_degree :=
  function( A, V, N )
    local quiver, W, vertex_labels, p, degrees, left_side, right_side, U, degree;
    
    quiver := QuiverOfAlgebra( A );
    
    V := Label( V );
    
    V := SplitString( V, "_x" ){ [ 2, 3 ] };
    
    V := List( V, Int );
    
    vertex_labels := VertexLabels( quiver ){ [ 1 .. NumberOfVertices( quiver ) / 2 ] };
    
    vertex_labels := List( vertex_labels, v -> SplitString( v, "_x" ){ [ 2, 3 ] } );
    
    vertex_labels := List( vertex_labels, v -> List( v, Int ) );
       
    degrees := [ 0 .. N ];
    
    left_side := Zero( A );
    
    right_side := Zero( A );
    
    for degree in degrees do
      
      W := V - [ - degree, degree ];
      
      U := W - [ 1 - ( N - degree ), N - degree ];
      
      if W in vertex_labels and U in vertex_labels then
        
        left_side := left_side + 
              A.( Concatenation( "alpha_", String( V[ 1 ] ), "x", String( V[ 2 ] ), "_", String( degree ) ) ) *
                A.( Concatenation( "c_", String( W[ 1 ] ), "x", String( W[ 2 ] ), "_", String( N - degree ) ) );
          
      fi;
      
      U := V - [ 1 - degree, degree ];
      
      W := U - [ - ( N - degree ), N - degree ];
       
      if U in vertex_labels and W in vertex_labels then
        
        right_side := right_side +
                A.( Concatenation( "d_", String( V[ 1 ] ), "x", String( V[ 2 ] ), "_", String( degree ) ) ) *
                A.( Concatenation( "alpha_", String( U[ 1 ] ), "x", String( U[ 2 ] ), "_", String( N - degree ) ) );
        
      fi;
      
    od;
    
    return left_side - right_side;
    
end;

quiver_algebra :=
  function( field, left_bound, horizontal_distance, below_bound, vertical_distance )
    local quiver, A, N, vertices, relations, rel, V, i;
    
    quiver := create_quiver( left_bound, horizontal_distance, below_bound, vertical_distance );
    
    A := PathAlgebra( field, quiver );
    
    N := quiver!.maximum_degree;
    
    vertices := Vertices( quiver );
    
    relations := [ ];
    
    for V in vertices do
      
      for i in [ 0 .. N ] do
        
        rel := relations_of_differentials_by_vertex_and_degree( A, V, i );
        
        if not IsZero( rel ) then
          
          Add( relations, rel );
          
        fi;
        
      od;
      
    od;
    
    for V in vertices{ [ 1 .. NumberOfVertices( quiver ) / 2 ] } do
      
      for i in [ 0 .. N ] do
        
        rel := relations_of_maps_by_vertex_and_degree( A, V, i );
        
        if not IsZero( rel ) then
          
          Add( relations, rel );
          
        fi;
        
      od;
      
    od;
   
    return A / relations;
    
end;

############################### start #############################################

field := HomalgFieldOfRationals( );

horizontal_distance := 6;
vertical_distance := 6;
below_bound := 0;
left_bound := 0;

A := quiver_algebra( field, left_bound, horizontal_distance, below_bound, vertical_distance );;
Aoid := Algebroid( A );;
SetIsProjective( DistinguishedObjectOfHomomorphismStructure( Aoid ), true );;
add_Aoid := AdditiveClosure( Aoid );;
adelman := AdelmanCategory( add_Aoid );;
Ch_adelman := ChainComplexCategory( adelman );
Ho_adelman := HomotopyCategory( adelman );

##
ob := SetOfObjects( Aoid );
for o in ob do
  s := LabelAsString( UnderlyingVertex( o ) );
  s := ReplacedString( s, "-", "m" );
  BindGlobal( s, o/add_Aoid/adelman );
od;

#P_2x0;
#Q_2x0;

##
gm := SetOfGeneratingMorphisms( Aoid );;
for m in gm do
  s := LabelAsString( Paths( Representative( UnderlyingQuiverAlgebraElement( m ) ) )[ 1 ] );
  s := ReplacedString( s, "-", "m" );
  BindGlobal( s, m/add_Aoid/adelman );
od;

#alpha_2x5_0
#d_2x5_0
#c_2x5_0

##
for i in [ below_bound .. below_bound + vertical_distance - 1 ] do
  current_diffs := [ ];
  for j in [ left_bound + 1 .. left_bound + horizontal_distance - 1 ] do
    s := Concatenation( "d_", String( j ), "x", String( i ), "_0" );
    s := ReplacedString( s, "-", "m" );
    Add( current_diffs, ValueGlobal( s ) );
  od;
  s := Concatenation( "C_", String( i ) );
  if not IsEmpty( current_diffs ) then
    BindGlobal( s, ChainComplex( current_diffs, left_bound + 1 ) );
  else
    BindGlobal( s, StalkChainComplex( ValueGlobal( Concatenation( "P_", String( below_bound ), "x", String( i ) ) ), below_bound ) );
  fi;
od;

#C_0;

##
for i in [ below_bound + 1 .. below_bound + vertical_distance - 1 ] do
  current_maps := [ ];
  for j in [ left_bound .. left_bound + horizontal_distance - 1 ] do
    s := Concatenation( "d_", String( j ), "x", String( i ), "_1" );
    s := ReplacedString( s, "-", "m" );
    if ( i + j ) mod 2 = 0 then
      Add( current_maps, ValueGlobal( s ) );
    else
      Add( current_maps, -ValueGlobal( s ) );
    fi;
  od;
  s := Concatenation( "diff_C_", String( i ) );
  BindGlobal( s, ChainMorphism(
                    ValueGlobal( Concatenation( "C_", String( i ) ) ),
                    ValueGlobal( Concatenation( "C_", String( i - 1 ) ) ),
                    current_maps, left_bound
                              ) / Ho_adelman
                    );
od;

#diff_C_0

diffs_C := List( [ below_bound + 1 .. below_bound + vertical_distance - 1 ],
            i -> ValueGlobal( Concatenation( "diff_C_", String( i ) ) )
          );

##
for i in [ below_bound .. below_bound + vertical_distance - 1 ] do
  current_diffs := [ ];
  for j in [ left_bound + 1 .. left_bound + horizontal_distance - 1 ] do
    s := Concatenation( "c_", String( j ), "x", String( i ), "_0" );
    s := ReplacedString( s, "-", "m" );
    Add( current_diffs, ValueGlobal( s ) );
  od;
  s := Concatenation( "B_", String( i ) );
  if not IsEmpty( current_diffs ) then
    BindGlobal( s, ChainComplex( current_diffs, left_bound + 1 ) );
  else
    BindGlobal( s, StalkChainComplex( ValueGlobal( Concatenation( "Q_", String( below_bound ), "x", String( i ) ) ), below_bound ) );
  fi;
od;

##
for i in [ below_bound + 1 .. below_bound + vertical_distance - 1 ] do
  current_maps := [ ];
  for j in [ left_bound .. left_bound + horizontal_distance - 1 ] do
    s := Concatenation( "c_", String( j ), "x", String( i ), "_1" );
    s := ReplacedString( s, "-", "m" );
    if ( i + j ) mod 2 = 0 then
      Add( current_maps, ValueGlobal( s ) );
    else
      Add( current_maps, -ValueGlobal( s ) );
    fi;
  od;
  s := Concatenation( "diff_B_", String( i ) );
  BindGlobal( s, ChainMorphism(
                    ValueGlobal( Concatenation( "B_", String( i ) ) ),
                    ValueGlobal( Concatenation( "B_", String( i - 1 ) ) ),
                    current_maps, left_bound
                              ) / Ho_adelman
                    );
od;

diffs_B := List( [ below_bound + 1 .. below_bound + vertical_distance - 1 ],
            i -> ValueGlobal( Concatenation( "diff_B_", String( i ) ) )
          );

##
for i in [ below_bound .. below_bound + vertical_distance - 1 ] do
  current_maps := [ ];
  for j in [ left_bound .. left_bound + horizontal_distance - 1 ] do
    s := Concatenation( "alpha_", String( j ), "x", String( i ), "_0" );
    s := ReplacedString( s, "-", "m" );
    Add( current_maps, ValueGlobal( s ) );
  od;
  s := Concatenation( "alpha_", String( i ) );
  BindGlobal( s, ChainMorphism(
                    ValueGlobal( Concatenation( "C_", String( i ) ) ),
                    ValueGlobal( Concatenation( "B_", String( i ) ) ),
                    current_maps, left_bound
                              ) / Ho_adelman
                    );
od;

alpha_maps := List( [ below_bound .. below_bound + vertical_distance - 1 ],
            i -> ValueGlobal( Concatenation( "alpha_", String( i ) ) )
          );

C := ChainComplex( diffs_C, below_bound + 1 );
B := ChainComplex( diffs_B, below_bound + 1 );
alpha := ChainMorphism( C, B, alpha_maps, below_bound );

quit;
conv_alpha := Convolution( alpha );
