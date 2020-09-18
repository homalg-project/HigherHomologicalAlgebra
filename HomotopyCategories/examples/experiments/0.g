LoadPackage( "HomotopyCategories" );
SET_SPECIAL_SETTINGS();

create_algebroid :=
function( N, l, bounds, labels_of_objects, labels_of_morphisms )
  local objects, maps, pre_rels, other_rels, oid, Aoid, Ho, HoHo, m, label_of_object, label_of_morphism;

  objects := [ ];
  maps := [ ];
  pre_rels := [ ];
  other_rels := List( [ l + 1 .. l + N-3 ], i -> [ ] );
  
  for label_of_object in labels_of_objects do
    
    objects := Concatenation( objects, List( [ l .. l + N - 1 ], i -> _StRiNg( Concatenation( label_of_object, String( i ) ) ) ) );
    
    maps := Concatenation( maps, List( [ l .. l + N - 2 ], 
              i -> [ 
                    _StRiNg( Concatenation( "d", label_of_object, "_", String( i ) ) ),
                    _StRiNg( Concatenation( label_of_object, String( i ) ) ),
                    _StRiNg( Concatenation( label_of_object, String( i + 1) ) )
                   ]
            ) );
    
    pre_rels := Concatenation( pre_rels, List( [ l .. l + N - 3 ], 
              i -> [ 
                    _StRiNg( Concatenation( "PreCompose( d", label_of_object, "_", String( i ), ", d", label_of_object, "_", String( i + 1 ), " )" ) ),
                    _StRiNg( Concatenation( "h_", label_of_object, String( i ), "_2" ) )
                   ]
            ) );
    
    other_rels := ListN( other_rels,
        List( [ 1 .. N - 3 ], shift ->
          List( [ l .. l + N - shift - 3 ], i ->
            [
              _StRiNg( Concatenation(
                  "BasisOfExternalHom( Shift( ", label_of_object, String( i ), ",",
                  String( shift), " ), ", label_of_object, String( i+shift+2 ), " )[ 1 ]"
                ) ), 
              _StRiNg( Concatenation( "h_", label_of_object, String( i ), "_", String( shift+2 ) ) )
            ]
          ) ), Concatenation );
  
  od;
  
  for label_of_morphism in labels_of_morphisms do
    
     maps := Concatenation( maps, List( [ l .. l + N-1 ], 
              i -> [ 
                    _StRiNg( Concatenation( label_of_morphism[ 1 ], String( i ) ) ),
                    _StRiNg( Concatenation( label_of_morphism[ 2 ], String( i ) ) ),
                    _StRiNg( Concatenation( label_of_morphism[ 3 ], String( i ) ) )
                   ]
            ) );
     
     pre_rels := Concatenation( pre_rels, List( [ l .. l + N-2 ], 
              i -> [ 
                    Concatenation(
                      _StRiNg( Concatenation( "PreCompose( d", label_of_morphism[ 2 ], "_", String( i ), ", ", label_of_morphism[ 1 ], String( i + 1 ), " )" ) ),
                      "-",
                      _StRiNg( Concatenation( "PreCompose( ", label_of_morphism[ 1 ], String( i ), ", ", "d", label_of_morphism[ 3 ], "_", String( i ) , " )" ) )
                    ),
                    _StRiNg( Concatenation( "h_", label_of_morphism[ 1 ], String( i ), "_1" ) )
                   ]
            ) );
     
     other_rels := Concatenation( other_rels,
        List( [ 1 .. N-2 ], shift ->
          List( [ l .. l + N - shift - 2 ], i ->
            [
              _StRiNg( Concatenation(
                  "BasisOfExternalHom( Shift( ", label_of_morphism[ 2 ], String( i ), ",",
                  String( shift), " ), ", label_of_morphism[ 3 ], String( i+shift+1 ), " )[ 1 ]"
                ) ), 
              _StRiNg( Concatenation( "h_", label_of_morphism[ 1 ], String( i ), "_", String( shift+1 ) ) )
            ]
          ) ) );
    
  
  od;
    
  oid := AlgebroidOfDiagramInHomotopyCategory( objects, maps, bounds, pre_rels, other_rels );
  Aoid := AdditiveClosure( oid );
  Ho := HomotopyCategory( Aoid, true );
  HoHo := HomotopyCategory( Ho, true );
  
  for label_of_object in labels_of_objects do
    
    m := List( [ l .. l + N-2 ], i -> _StRiNg( Concatenation( "d", label_of_object, "_", String( i ) ) ) );
    
    MakeReadWriteGlobal( label_of_object );
    
    BindGlobal( label_of_object, HomotopyCategoryObject( HoHo, List( m, ValueGlobal ), l ) );
    
  od;
  
  for label_of_morphism in labels_of_morphisms do
    
    m := List( [ l .. l + N-1 ], i -> _StRiNg( Concatenation( label_of_morphism[ 1 ], String( i ) ) ) );
    
    MakeReadWriteGlobal( label_of_morphism[ 1 ] );
    
    BindGlobal( label_of_morphism[ 1 ], HomotopyCategoryMorphism( ValueGlobal( label_of_morphism[ 2 ] ), ValueGlobal( label_of_morphism[ 3 ] ), List( m, ValueGlobal ), l ) );
    
  od;
  
  return HoHo;
  
end;

N := 4; # Nr ob objects in each object in HoHo
l := 6; # the position of the lower bound
bounds := [ l, l+N+1 ];
labels_of_objects := [ "A", "B" ];
labels_of_morphisms := [ [ "phi", "A", "B" ] ];
HoHo := create_algebroid( N, l, bounds, labels_of_objects, labels_of_morphisms );

