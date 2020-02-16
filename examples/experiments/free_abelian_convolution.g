LoadPackage( "Bialgebroids");

create_vertrex_labels :=
  function( left_bound, horizontal_distance, below_bound, vertical_distance )
    
    return Cartesian( 
                [ left_bound .. left_bound + horizontal_distance - 1 ],
                Reversed( [ below_bound .. below_bound + vertical_distance - 1 ] )
              );
end;

create_differentials_of_degree :=
  function( vertex_labels, degree )
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
        
        Add( labels, Concatenation( "d_", String( V[ 1 ] ), "x", String( V[ 2 ] ), "_", String( degree ) ) );
        
        Add( sources, i );
        
        Add( ranges, p );
        
      fi;
      
    od;
    
    return [ labels, sources, ranges ];
    
end;

create_quiver :=
  function( left_bound, horizontal_distance, below_bound, vertical_distance )
    local vertex_labels, labels, sources, ranges, degree, diffs, quiver;
    
    vertex_labels := create_vertrex_labels( left_bound, horizontal_distance, below_bound, vertical_distance );
    
    labels := [ ];
    
    sources := [ ];
    
    ranges := [ ];
    
    degree := 0;
    
    while true do
      
      diffs := create_differentials_of_degree( vertex_labels, degree );
      
      if IsEmpty( diffs[ 1 ] ) then
        
        break;
        
      fi;
      
      labels := Concatenation( labels, diffs[ 1 ] );
      
      sources := Concatenation( sources, diffs[ 2 ] );
      
      ranges := Concatenation( ranges, diffs[ 3 ] );
      
      degree := degree + 1;
      
    od;
    
    quiver := RightQuiver( "quiver", vertex_labels, labels, sources, ranges );
    
    quiver!.maximum_degree := degree - 1;
    
    return quiver;
    
end;

relation_by_vertex_of_given_degree :=
  function( A, V, N )
    local quiver, vertex_labels, W, p, degrees, e, U, a, b, degree;
    
    quiver := QuiverOfAlgebra( A );
    
    if N > quiver!.maximum_degree then
      
      return Zero( A );
      
    fi;
    
    V := Label( V );
    
    vertex_labels := VertexLabels( quiver );
    
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
      
      a := Concatenation( "d_", String( V[ 1 ] ), "x", String( V[ 2 ] ), "_", String( degree ) );
      
      b := Concatenation( "d_", String( U[ 1 ] ), "x", String( U[ 2 ] ), "_", String( N - degree ) );
      
      e := e + A.(a) * A.(b);
      
    od;
    
    return e;
  
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
        
        rel := relation_by_vertex_of_given_degree( A, V, i );
        
        if not IsZero( rel ) then
          
          Add( relations, rel );
          
        fi;
        
      od;
      
    od;
    
    return A / relations;
  
end;


############################### start #############################################

field := HomalgFieldOfRationals( );

horizontal_distance := 5;
vertical_distance := 6;
below_bound := 0;
left_bound := -2;

A := quiver_algebra( field, left_bound, horizontal_distance, below_bound, vertical_distance );;
Aoid := Algebroid( A );;
SetIsProjective( DistinguishedObjectOfHomomorphismStructure( Aoid ), true );;
add_Aoid := AdditiveClosure( Aoid );;
adelman := AdelmanCategory( add_Aoid );;
ob := SetOfObjects( Aoid );
for o in ob do
  s := LabelAsString( UnderlyingVertex( o ) );
  s := ReplacedString( s, "-", "m" );
  BindGlobal( s, o/add_Aoid/adelman );
od;
gm := SetOfGeneratingMorphisms( Aoid );;
for m in gm do
  s := LabelAsString( Paths( Representative( UnderlyingQuiverAlgebraElement( m ) ) )[ 1 ] );
  s := ReplacedString( s, "-", "m" );
  BindGlobal( s, m/add_Aoid/adelman );
od;

m2x5;
2x0;

Ch_adelman := ChainComplexCategory( adelman );
Ho_adelman := HomotopyCategory( adelman );


