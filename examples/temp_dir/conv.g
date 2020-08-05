LoadPackage( "HomotopyCategories" );
ReadPackage( "DerivedCategories", "examples/pre_settings.g" );

N := 3;
bounds := [ 0, N+2 ];
labels_of_objects := [ "A", "B" ];
labels_of_morphisms := [ [ "alpha", "A", "B" ] ];

objects := [ ];
maps := [ ];
pre_rels := [ ];
other_rels := List( [ 1 .. N - 2 ], i -> [ ] );

for label_of_object in labels_of_objects do
  
  objects := Concatenation( objects, List( [ 0 .. N ], i -> Concatenation( label_of_object, String( i ) ) ) );
  
  maps := Concatenation( maps, List( [ 0 .. N - 1 ], 
            i -> [ 
                  Concatenation( "d", label_of_object, "_", String( i ) ),
                  Concatenation( label_of_object, String( i ) ),
                  Concatenation( label_of_object, String( i + 1) )
                 ]
          ) );
  
  pre_rels := Concatenation( pre_rels, List( [ 0 .. N - 2 ], 
            i -> [ 
                  Concatenation( "PreCompose( d", label_of_object, "_", String( i ), ", d", label_of_object, "_", String( i + 1 ), " )" ),
                  Concatenation( "h_", label_of_object, String( i ), "_2" )
                 ]
          ) );
  
  other_rels := ListN( other_rels,
      List( [ 1 .. N - 2 ], shift ->
        List( [ 0 .. N - shift - 2 ], i ->
          [
            Concatenation(
                "BasisOfExternalHom( Shift( ", label_of_object, String( i ), ",",
                String( shift), " ), ", label_of_object, String( i+shift+2 ), " )[ 1 ]"
              ), 
            Concatenation( "h_", label_of_object, String( i ), "_", String( shift+2 ) )
          ]
        ) ), Concatenation );

od;

for label_of_morphism in labels_of_morphisms do
  
   maps := Concatenation( maps, List( [ 0 .. N ], 
            i -> [ 
                  Concatenation( label_of_morphism[ 1 ], String( i ) ),
                  Concatenation( label_of_morphism[ 2 ], String( i ) ),
                  Concatenation( label_of_morphism[ 3 ], String( i ) )
                 ]
          ) );
   
   pre_rels := Concatenation( pre_rels, List( [ 0 .. N - 1 ], 
            i -> [ 
                  Concatenation(
                    "PreCompose( d", label_of_morphism[ 2 ], "_", String( i ), ", ", label_of_morphism[ 1 ], String( i + 1 ), " )",
                    "-",
                    "PreCompose( ", label_of_morphism[ 1 ], String( i ), ", ", "d", label_of_morphism[ 3 ], "_", String( i ) , " )"
                  ),
                  Concatenation( "h_", label_of_morphism[ 1 ], String( i ), "_1" )
                 ]
          ) );
   
   other_rels := Concatenation( other_rels,
      List( [ 1 .. N - 1 ], shift ->
        List( [ 0 .. N - shift - 1 ], i ->
          [
            Concatenation(
                "BasisOfExternalHom( Shift( ", label_of_morphism[ 2 ], String( i ), ",",
                String( shift), " ), ", label_of_morphism[ 3 ], String( i+shift+1 ), " )[ 1 ]"
              ), 
            Concatenation( "h_", label_of_morphism[ 1 ], String( i ), "_", String( shift+1 ) )
          ]
        ) ) );
  

od;

AlgebroidOfDiagramInHomotopyCategory( objects, maps, bounds, pre_rels, other_rels );
Ho := HomotopyCategory( CapCategory( A0 ), true );

for label_of_object in labels_of_objects do
  
  m := List( [ 0 .. N - 1 ], i -> Concatenation( "d", label_of_object, "_", String( i ) ) );
  
  BindGlobal( label_of_object, HomotopyCategoryObject( Ho, List( m, ValueGlobal ), 0 ) );
  
od;

for label_of_morphism in labels_of_morphisms do
  
  m := List( [ 0 .. N ], i -> Concatenation( label_of_morphism[ 1 ], String( i ) ) );
  
  BindGlobal( label_of_morphism[ 1 ], HomotopyCategoryMorphism( ValueGlobal( label_of_morphism[ 2 ] ), ValueGlobal( label_of_morphism[ 3 ] ), List( m, ValueGlobal ), 0 ) );
  
od;

