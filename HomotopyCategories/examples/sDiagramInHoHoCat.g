LoadPackage( "HomotopyCategories" );
SET_SPECIAL_SETTINGS();

N := 5; # Nr ob objects in each object in HoHo
l := -4; # the position of the lower bound
bounds := [ l, l+N+1 ];
labels_of_objects := [ "A", "B" ];
labels_of_morphisms := [ [ "phi", "A", "B" ] ];

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

oid := CallFuncList( CREATE_ALGEBROID_OF_DIAGRAM, [ [ "Am4", "Am3", "Am2", "Am1", "A0", "Bm4", "Bm3", "Bm2", "Bm1", "B0" ], 
  [ [ "dA_m4", "Am4", "Am3" ], [ "dA_m3", "Am3", "Am2" ], [ "dA_m2", "Am2", "Am1" ], [ "dA_m1", "Am1", "A0" ], 
      [ "dB_m4", "Bm4", "Bm3" ], [ "dB_m3", "Bm3", "Bm2" ], [ "dB_m2", "Bm2", "Bm1" ], [ "dB_m1", "Bm1", "B0" ], 
      [ "phim4", "Am4", "Bm4" ], [ "phim3", "Am3", "Bm3" ], [ "phim2", "Am2", "Bm2" ], [ "phim1", "Am1", "Bm1" ], 
      [ "phi0", "A0", "B0" ] ], [ -4, 2 ], 
  [ "h_Am4_2_m3:Am4_m3->Am2_m4", "h_Am4_2_m2:Am4_m2->Am2_m3", "h_Am4_2_m1:Am4_m1->Am2_m2", 
      "h_Am4_2_0:Am4_0->Am2_m1", "h_Am4_2_1:Am4_1->Am2_0", "h_Am4_2_2:Am4_2->Am2_1", "h_Am3_2_m3:Am3_m3->Am1_m4", 
      "h_Am3_2_m2:Am3_m2->Am1_m3", "h_Am3_2_m1:Am3_m1->Am1_m2", "h_Am3_2_0:Am3_0->Am1_m1", 
      "h_Am3_2_1:Am3_1->Am1_0", "h_Am3_2_2:Am3_2->Am1_1", "h_Am2_2_m3:Am2_m3->A0_m4", "h_Am2_2_m2:Am2_m2->A0_m3", 
      "h_Am2_2_m1:Am2_m1->A0_m2", "h_Am2_2_0:Am2_0->A0_m1", "h_Am2_2_1:Am2_1->A0_0", "h_Am2_2_2:Am2_2->A0_1", 
      "h_Bm4_2_m3:Bm4_m3->Bm2_m4", "h_Bm4_2_m2:Bm4_m2->Bm2_m3", "h_Bm4_2_m1:Bm4_m1->Bm2_m2", 
      "h_Bm4_2_0:Bm4_0->Bm2_m1", "h_Bm4_2_1:Bm4_1->Bm2_0", "h_Bm4_2_2:Bm4_2->Bm2_1", "h_Bm3_2_m3:Bm3_m3->Bm1_m4", 
      "h_Bm3_2_m2:Bm3_m2->Bm1_m3", "h_Bm3_2_m1:Bm3_m1->Bm1_m2", "h_Bm3_2_0:Bm3_0->Bm1_m1", 
      "h_Bm3_2_1:Bm3_1->Bm1_0", "h_Bm3_2_2:Bm3_2->Bm1_1", "h_Bm2_2_m3:Bm2_m3->B0_m4", "h_Bm2_2_m2:Bm2_m2->B0_m3", 
      "h_Bm2_2_m1:Bm2_m1->B0_m2", "h_Bm2_2_0:Bm2_0->B0_m1", "h_Bm2_2_1:Bm2_1->B0_0", "h_Bm2_2_2:Bm2_2->B0_1", 
      "h_phim4_1_m3:Am4_m3->Bm3_m4", "h_phim4_1_m2:Am4_m2->Bm3_m3", "h_phim4_1_m1:Am4_m1->Bm3_m2", 
      "h_phim4_1_0:Am4_0->Bm3_m1", "h_phim4_1_1:Am4_1->Bm3_0", "h_phim4_1_2:Am4_2->Bm3_1", 
      "h_phim3_1_m3:Am3_m3->Bm2_m4", "h_phim3_1_m2:Am3_m2->Bm2_m3", "h_phim3_1_m1:Am3_m1->Bm2_m2", 
      "h_phim3_1_0:Am3_0->Bm2_m1", "h_phim3_1_1:Am3_1->Bm2_0", "h_phim3_1_2:Am3_2->Bm2_1", 
      "h_phim2_1_m3:Am2_m3->Bm1_m4", "h_phim2_1_m2:Am2_m2->Bm1_m3", "h_phim2_1_m1:Am2_m1->Bm1_m2", 
      "h_phim2_1_0:Am2_0->Bm1_m1", "h_phim2_1_1:Am2_1->Bm1_0", "h_phim2_1_2:Am2_2->Bm1_1", 
      "h_phim1_1_m3:Am1_m3->B0_m4", "h_phim1_1_m2:Am1_m2->B0_m3", "h_phim1_1_m1:Am1_m1->B0_m2", 
      "h_phim1_1_0:Am1_0->B0_m1", "h_phim1_1_1:Am1_1->B0_0", "h_phim1_1_2:Am1_2->B0_1", 
      "h_Am4_3_m3:Am4_m2->Am1_m4", "h_Am4_3_m2:Am4_m1->Am1_m3", "h_Am4_3_m1:Am4_0->Am1_m2", 
      "h_Am4_3_0:Am4_1->Am1_m1", "h_Am4_3_1:Am4_2->Am1_0", "h_Am3_3_m3:Am3_m2->A0_m4", "h_Am3_3_m2:Am3_m1->A0_m3", 
      "h_Am3_3_m1:Am3_0->A0_m2", "h_Am3_3_0:Am3_1->A0_m1", "h_Am3_3_1:Am3_2->A0_0", "h_Bm4_3_m3:Bm4_m2->Bm1_m4", 
      "h_Bm4_3_m2:Bm4_m1->Bm1_m3", "h_Bm4_3_m1:Bm4_0->Bm1_m2", "h_Bm4_3_0:Bm4_1->Bm1_m1", "h_Bm4_3_1:Bm4_2->Bm1_0",
      "h_Bm3_3_m3:Bm3_m2->B0_m4", "h_Bm3_3_m2:Bm3_m1->B0_m3", "h_Bm3_3_m1:Bm3_0->B0_m2", "h_Bm3_3_0:Bm3_1->B0_m1", 
      "h_Bm3_3_1:Bm3_2->B0_0", "h_Am4_4_m3:Am4_m1->A0_m4", "h_Am4_4_m2:Am4_0->A0_m3", "h_Am4_4_m1:Am4_1->A0_m2", 
      "h_Am4_4_0:Am4_2->A0_m1", "h_Bm4_4_m3:Bm4_m1->B0_m4", "h_Bm4_4_m2:Bm4_0->B0_m3", "h_Bm4_4_m1:Bm4_1->B0_m2", 
      "h_Bm4_4_0:Bm4_2->B0_m1", "h_phim4_2_m3:Am4_m2->Bm2_m4", "h_phim4_2_m2:Am4_m1->Bm2_m3", 
      "h_phim4_2_m1:Am4_0->Bm2_m2", "h_phim4_2_0:Am4_1->Bm2_m1", "h_phim4_2_1:Am4_2->Bm2_0", 
      "h_phim3_2_m3:Am3_m2->Bm1_m4", "h_phim3_2_m2:Am3_m1->Bm1_m3", "h_phim3_2_m1:Am3_0->Bm1_m2", 
      "h_phim3_2_0:Am3_1->Bm1_m1", "h_phim3_2_1:Am3_2->Bm1_0", "h_phim2_2_m3:Am2_m2->B0_m4", 
      "h_phim2_2_m2:Am2_m1->B0_m3", "h_phim2_2_m1:Am2_0->B0_m2", "h_phim2_2_0:Am2_1->B0_m1", 
      "h_phim2_2_1:Am2_2->B0_0", "h_phim4_3_m3:Am4_m1->Bm1_m4", "h_phim4_3_m2:Am4_0->Bm1_m3", 
      "h_phim4_3_m1:Am4_1->Bm1_m2", "h_phim4_3_0:Am4_2->Bm1_m1", "h_phim3_3_m3:Am3_m1->B0_m4", 
      "h_phim3_3_m2:Am3_0->B0_m3", "h_phim3_3_m1:Am3_1->B0_m2", "h_phim3_3_0:Am3_2->B0_m1", 
      "h_phim4_4_m3:Am4_0->B0_m4", "h_phim4_4_m2:Am4_1->B0_m3", "h_phim4_4_m1:Am4_2->B0_m2" ], 
  [ "1*(dA_m4_m4*dA_m3_m4)-(1*(dAm4_m4)*h_Am4_2_m3)", 
      "1*(dA_m4_m3*dA_m3_m3)-(1*(dAm4_m3)*h_Am4_2_m2+h_Am4_2_m3*1*(dAm2_m4))", 
      "1*(dA_m4_m2*dA_m3_m2)-(1*(dAm4_m2)*h_Am4_2_m1+h_Am4_2_m2*1*(dAm2_m3))", 
      "1*(dA_m4_m1*dA_m3_m1)-(1*(dAm4_m1)*h_Am4_2_0+h_Am4_2_m1*1*(dAm2_m2))", 
      "1*(dA_m4_0*dA_m3_0)-(1*(dAm4_0)*h_Am4_2_1+h_Am4_2_0*1*(dAm2_m1))", 
      "1*(dA_m4_1*dA_m3_1)-(1*(dAm4_1)*h_Am4_2_2+h_Am4_2_1*1*(dAm2_0))", 
      "1*(dA_m4_2*dA_m3_2)-(h_Am4_2_2*1*(dAm2_1))", "1*(dA_m3_m4*dA_m2_m4)-(1*(dAm3_m4)*h_Am3_2_m3)", 
      "1*(dA_m3_m3*dA_m2_m3)-(1*(dAm3_m3)*h_Am3_2_m2+h_Am3_2_m3*1*(dAm1_m4))", 
      "1*(dA_m3_m2*dA_m2_m2)-(1*(dAm3_m2)*h_Am3_2_m1+h_Am3_2_m2*1*(dAm1_m3))", 
      "1*(dA_m3_m1*dA_m2_m1)-(1*(dAm3_m1)*h_Am3_2_0+h_Am3_2_m1*1*(dAm1_m2))", 
      "1*(dA_m3_0*dA_m2_0)-(1*(dAm3_0)*h_Am3_2_1+h_Am3_2_0*1*(dAm1_m1))", 
      "1*(dA_m3_1*dA_m2_1)-(1*(dAm3_1)*h_Am3_2_2+h_Am3_2_1*1*(dAm1_0))", 
      "1*(dA_m3_2*dA_m2_2)-(h_Am3_2_2*1*(dAm1_1))", "1*(dA_m2_m4*dA_m1_m4)-(1*(dAm2_m4)*h_Am2_2_m3)", 
      "1*(dA_m2_m3*dA_m1_m3)-(1*(dAm2_m3)*h_Am2_2_m2+h_Am2_2_m3*1*(dA0_m4))", 
      "1*(dA_m2_m2*dA_m1_m2)-(1*(dAm2_m2)*h_Am2_2_m1+h_Am2_2_m2*1*(dA0_m3))", 
      "1*(dA_m2_m1*dA_m1_m1)-(1*(dAm2_m1)*h_Am2_2_0+h_Am2_2_m1*1*(dA0_m2))", 
      "1*(dA_m2_0*dA_m1_0)-(1*(dAm2_0)*h_Am2_2_1+h_Am2_2_0*1*(dA0_m1))", 
      "1*(dA_m2_1*dA_m1_1)-(1*(dAm2_1)*h_Am2_2_2+h_Am2_2_1*1*(dA0_0))", "1*(dA_m2_2*dA_m1_2)-(h_Am2_2_2*1*(dA0_1))"
        , "1*(dB_m4_m4*dB_m3_m4)-(1*(dBm4_m4)*h_Bm4_2_m3)", 
      "1*(dB_m4_m3*dB_m3_m3)-(1*(dBm4_m3)*h_Bm4_2_m2+h_Bm4_2_m3*1*(dBm2_m4))", 
      "1*(dB_m4_m2*dB_m3_m2)-(1*(dBm4_m2)*h_Bm4_2_m1+h_Bm4_2_m2*1*(dBm2_m3))", 
      "1*(dB_m4_m1*dB_m3_m1)-(1*(dBm4_m1)*h_Bm4_2_0+h_Bm4_2_m1*1*(dBm2_m2))", 
      "1*(dB_m4_0*dB_m3_0)-(1*(dBm4_0)*h_Bm4_2_1+h_Bm4_2_0*1*(dBm2_m1))", 
      "1*(dB_m4_1*dB_m3_1)-(1*(dBm4_1)*h_Bm4_2_2+h_Bm4_2_1*1*(dBm2_0))", 
      "1*(dB_m4_2*dB_m3_2)-(h_Bm4_2_2*1*(dBm2_1))", "1*(dB_m3_m4*dB_m2_m4)-(1*(dBm3_m4)*h_Bm3_2_m3)", 
      "1*(dB_m3_m3*dB_m2_m3)-(1*(dBm3_m3)*h_Bm3_2_m2+h_Bm3_2_m3*1*(dBm1_m4))", 
      "1*(dB_m3_m2*dB_m2_m2)-(1*(dBm3_m2)*h_Bm3_2_m1+h_Bm3_2_m2*1*(dBm1_m3))", 
      "1*(dB_m3_m1*dB_m2_m1)-(1*(dBm3_m1)*h_Bm3_2_0+h_Bm3_2_m1*1*(dBm1_m2))", 
      "1*(dB_m3_0*dB_m2_0)-(1*(dBm3_0)*h_Bm3_2_1+h_Bm3_2_0*1*(dBm1_m1))", 
      "1*(dB_m3_1*dB_m2_1)-(1*(dBm3_1)*h_Bm3_2_2+h_Bm3_2_1*1*(dBm1_0))", 
      "1*(dB_m3_2*dB_m2_2)-(h_Bm3_2_2*1*(dBm1_1))", "1*(dB_m2_m4*dB_m1_m4)-(1*(dBm2_m4)*h_Bm2_2_m3)", 
      "1*(dB_m2_m3*dB_m1_m3)-(1*(dBm2_m3)*h_Bm2_2_m2+h_Bm2_2_m3*1*(dB0_m4))", 
      "1*(dB_m2_m2*dB_m1_m2)-(1*(dBm2_m2)*h_Bm2_2_m1+h_Bm2_2_m2*1*(dB0_m3))", 
      "1*(dB_m2_m1*dB_m1_m1)-(1*(dBm2_m1)*h_Bm2_2_0+h_Bm2_2_m1*1*(dB0_m2))", 
      "1*(dB_m2_0*dB_m1_0)-(1*(dBm2_0)*h_Bm2_2_1+h_Bm2_2_0*1*(dB0_m1))", 
      "1*(dB_m2_1*dB_m1_1)-(1*(dBm2_1)*h_Bm2_2_2+h_Bm2_2_1*1*(dB0_0))", "1*(dB_m2_2*dB_m1_2)-(h_Bm2_2_2*1*(dB0_1))"
        , "-1*(phim4_m4*dB_m4_m4) + 1*(dA_m4_m4*phim3_m4)-(1*(dAm4_m4)*h_phim4_1_m3)", 
      "-1*(phim4_m3*dB_m4_m3) + 1*(dA_m4_m3*phim3_m3)-(1*(dAm4_m3)*h_phim4_1_m2+h_phim4_1_m3*1*(dBm3_m4))", 
      "-1*(phim4_m2*dB_m4_m2) + 1*(dA_m4_m2*phim3_m2)-(1*(dAm4_m2)*h_phim4_1_m1+h_phim4_1_m2*1*(dBm3_m3))", 
      "-1*(phim4_m1*dB_m4_m1) + 1*(dA_m4_m1*phim3_m1)-(1*(dAm4_m1)*h_phim4_1_0+h_phim4_1_m1*1*(dBm3_m2))", 
      "-1*(phim4_0*dB_m4_0) + 1*(dA_m4_0*phim3_0)-(1*(dAm4_0)*h_phim4_1_1+h_phim4_1_0*1*(dBm3_m1))", 
      "-1*(phim4_1*dB_m4_1) + 1*(dA_m4_1*phim3_1)-(1*(dAm4_1)*h_phim4_1_2+h_phim4_1_1*1*(dBm3_0))", 
      "-1*(phim4_2*dB_m4_2) + 1*(dA_m4_2*phim3_2)-(h_phim4_1_2*1*(dBm3_1))", 
      "-1*(phim3_m4*dB_m3_m4) + 1*(dA_m3_m4*phim2_m4)-(1*(dAm3_m4)*h_phim3_1_m3)", 
      "-1*(phim3_m3*dB_m3_m3) + 1*(dA_m3_m3*phim2_m3)-(1*(dAm3_m3)*h_phim3_1_m2+h_phim3_1_m3*1*(dBm2_m4))", 
      "-1*(phim3_m2*dB_m3_m2) + 1*(dA_m3_m2*phim2_m2)-(1*(dAm3_m2)*h_phim3_1_m1+h_phim3_1_m2*1*(dBm2_m3))", 
      "-1*(phim3_m1*dB_m3_m1) + 1*(dA_m3_m1*phim2_m1)-(1*(dAm3_m1)*h_phim3_1_0+h_phim3_1_m1*1*(dBm2_m2))", 
      "-1*(phim3_0*dB_m3_0) + 1*(dA_m3_0*phim2_0)-(1*(dAm3_0)*h_phim3_1_1+h_phim3_1_0*1*(dBm2_m1))", 
      "-1*(phim3_1*dB_m3_1) + 1*(dA_m3_1*phim2_1)-(1*(dAm3_1)*h_phim3_1_2+h_phim3_1_1*1*(dBm2_0))", 
      "-1*(phim3_2*dB_m3_2) + 1*(dA_m3_2*phim2_2)-(h_phim3_1_2*1*(dBm2_1))", 
      "-1*(phim2_m4*dB_m2_m4) + 1*(dA_m2_m4*phim1_m4)-(1*(dAm2_m4)*h_phim2_1_m3)", 
      "-1*(phim2_m3*dB_m2_m3) + 1*(dA_m2_m3*phim1_m3)-(1*(dAm2_m3)*h_phim2_1_m2+h_phim2_1_m3*1*(dBm1_m4))", 
      "-1*(phim2_m2*dB_m2_m2) + 1*(dA_m2_m2*phim1_m2)-(1*(dAm2_m2)*h_phim2_1_m1+h_phim2_1_m2*1*(dBm1_m3))", 
      "-1*(phim2_m1*dB_m2_m1) + 1*(dA_m2_m1*phim1_m1)-(1*(dAm2_m1)*h_phim2_1_0+h_phim2_1_m1*1*(dBm1_m2))", 
      "-1*(phim2_0*dB_m2_0) + 1*(dA_m2_0*phim1_0)-(1*(dAm2_0)*h_phim2_1_1+h_phim2_1_0*1*(dBm1_m1))", 
      "-1*(phim2_1*dB_m2_1) + 1*(dA_m2_1*phim1_1)-(1*(dAm2_1)*h_phim2_1_2+h_phim2_1_1*1*(dBm1_0))", 
      "-1*(phim2_2*dB_m2_2) + 1*(dA_m2_2*phim1_2)-(h_phim2_1_2*1*(dBm1_1))", 
      "-1*(phim1_m4*dB_m1_m4) + 1*(dA_m1_m4*phi0_m4)-(1*(dAm1_m4)*h_phim1_1_m3)", 
      "-1*(phim1_m3*dB_m1_m3) + 1*(dA_m1_m3*phi0_m3)-(1*(dAm1_m3)*h_phim1_1_m2+h_phim1_1_m3*1*(dB0_m4))", 
      "-1*(phim1_m2*dB_m1_m2) + 1*(dA_m1_m2*phi0_m2)-(1*(dAm1_m2)*h_phim1_1_m1+h_phim1_1_m2*1*(dB0_m3))", 
      "-1*(phim1_m1*dB_m1_m1) + 1*(dA_m1_m1*phi0_m1)-(1*(dAm1_m1)*h_phim1_1_0+h_phim1_1_m1*1*(dB0_m2))", 
      "-1*(phim1_0*dB_m1_0) + 1*(dA_m1_0*phi0_0)-(1*(dAm1_0)*h_phim1_1_1+h_phim1_1_0*1*(dB0_m1))", 
      "-1*(phim1_1*dB_m1_1) + 1*(dA_m1_1*phi0_1)-(1*(dAm1_1)*h_phim1_1_2+h_phim1_1_1*1*(dB0_0))", 
      "-1*(phim1_2*dB_m1_2) + 1*(dA_m1_2*phi0_2)-(h_phim1_1_2*1*(dB0_1))", 
      "1*(h_Am4_2_m3*dA_m2_m4) - 1*(dA_m4_m3*h_Am3_2_m3)-(-1*(dAm4_m3)*h_Am4_3_m3)", 
      "1*(h_Am4_2_m2*dA_m2_m3) - 1*(dA_m4_m2*h_Am3_2_m2)-(-1*(dAm4_m2)*h_Am4_3_m2+h_Am4_3_m3*1*(dAm1_m4))", 
      "1*(h_Am4_2_m1*dA_m2_m2) - 1*(dA_m4_m1*h_Am3_2_m1)-(-1*(dAm4_m1)*h_Am4_3_m1+h_Am4_3_m2*1*(dAm1_m3))", 
      "1*(h_Am4_2_0*dA_m2_m1) - 1*(dA_m4_0*h_Am3_2_0)-(-1*(dAm4_0)*h_Am4_3_0+h_Am4_3_m1*1*(dAm1_m2))", 
      "1*(h_Am4_2_1*dA_m2_0) - 1*(dA_m4_1*h_Am3_2_1)-(-1*(dAm4_1)*h_Am4_3_1+h_Am4_3_0*1*(dAm1_m1))", 
      "1*(h_Am4_2_2*dA_m2_1) - 1*(dA_m4_2*h_Am3_2_2)-(h_Am4_3_1*1*(dAm1_0))", 
      "1*(h_Am3_2_m3*dA_m1_m4) - 1*(dA_m3_m3*h_Am2_2_m3)-(-1*(dAm3_m3)*h_Am3_3_m3)", 
      "1*(h_Am3_2_m2*dA_m1_m3) - 1*(dA_m3_m2*h_Am2_2_m2)-(-1*(dAm3_m2)*h_Am3_3_m2+h_Am3_3_m3*1*(dA0_m4))", 
      "1*(h_Am3_2_m1*dA_m1_m2) - 1*(dA_m3_m1*h_Am2_2_m1)-(-1*(dAm3_m1)*h_Am3_3_m1+h_Am3_3_m2*1*(dA0_m3))", 
      "1*(h_Am3_2_0*dA_m1_m1) - 1*(dA_m3_0*h_Am2_2_0)-(-1*(dAm3_0)*h_Am3_3_0+h_Am3_3_m1*1*(dA0_m2))", 
      "1*(h_Am3_2_1*dA_m1_0) - 1*(dA_m3_1*h_Am2_2_1)-(-1*(dAm3_1)*h_Am3_3_1+h_Am3_3_0*1*(dA0_m1))", 
      "1*(h_Am3_2_2*dA_m1_1) - 1*(dA_m3_2*h_Am2_2_2)-(h_Am3_3_1*1*(dA0_0))", 
      "1*(h_Bm4_2_m3*dB_m2_m4) - 1*(dB_m4_m3*h_Bm3_2_m3)-(-1*(dBm4_m3)*h_Bm4_3_m3)", 
      "1*(h_Bm4_2_m2*dB_m2_m3) - 1*(dB_m4_m2*h_Bm3_2_m2)-(-1*(dBm4_m2)*h_Bm4_3_m2+h_Bm4_3_m3*1*(dBm1_m4))", 
      "1*(h_Bm4_2_m1*dB_m2_m2) - 1*(dB_m4_m1*h_Bm3_2_m1)-(-1*(dBm4_m1)*h_Bm4_3_m1+h_Bm4_3_m2*1*(dBm1_m3))", 
      "1*(h_Bm4_2_0*dB_m2_m1) - 1*(dB_m4_0*h_Bm3_2_0)-(-1*(dBm4_0)*h_Bm4_3_0+h_Bm4_3_m1*1*(dBm1_m2))", 
      "1*(h_Bm4_2_1*dB_m2_0) - 1*(dB_m4_1*h_Bm3_2_1)-(-1*(dBm4_1)*h_Bm4_3_1+h_Bm4_3_0*1*(dBm1_m1))", 
      "1*(h_Bm4_2_2*dB_m2_1) - 1*(dB_m4_2*h_Bm3_2_2)-(h_Bm4_3_1*1*(dBm1_0))", 
      "1*(h_Bm3_2_m3*dB_m1_m4) - 1*(dB_m3_m3*h_Bm2_2_m3)-(-1*(dBm3_m3)*h_Bm3_3_m3)", 
      "1*(h_Bm3_2_m2*dB_m1_m3) - 1*(dB_m3_m2*h_Bm2_2_m2)-(-1*(dBm3_m2)*h_Bm3_3_m2+h_Bm3_3_m3*1*(dB0_m4))", 
      "1*(h_Bm3_2_m1*dB_m1_m2) - 1*(dB_m3_m1*h_Bm2_2_m1)-(-1*(dBm3_m1)*h_Bm3_3_m1+h_Bm3_3_m2*1*(dB0_m3))", 
      "1*(h_Bm3_2_0*dB_m1_m1) - 1*(dB_m3_0*h_Bm2_2_0)-(-1*(dBm3_0)*h_Bm3_3_0+h_Bm3_3_m1*1*(dB0_m2))", 
      "1*(h_Bm3_2_1*dB_m1_0) - 1*(dB_m3_1*h_Bm2_2_1)-(-1*(dBm3_1)*h_Bm3_3_1+h_Bm3_3_0*1*(dB0_m1))", 
      "1*(h_Bm3_2_2*dB_m1_1) - 1*(dB_m3_2*h_Bm2_2_2)-(h_Bm3_3_1*1*(dB0_0))", 
      "1*(h_Am4_3_m3*dA_m1_m4) - 1*(h_Am4_2_m2*h_Am2_2_m3) + 1*(dA_m4_m2*h_Am3_3_m3)-(1*(dAm4_m2)*h_Am4_4_m3)", 
      "1*(h_Am4_3_m2*dA_m1_m3) - 1*(h_Am4_2_m1*h_Am2_2_m2) + 1*(dA_m4_m1*h_Am3_3_m2)-(1*(dAm4_m1)*h_Am4_4_m2+h_Am4_\
4_m3*1*(dA0_m4))", 
      "1*(h_Am4_3_m1*dA_m1_m2) - 1*(h_Am4_2_0*h_Am2_2_m1) + 1*(dA_m4_0*h_Am3_3_m1)-(1*(dAm4_0)*h_Am4_4_m1+h_Am4_4_m\
2*1*(dA0_m3))", 
      "1*(h_Am4_3_0*dA_m1_m1) - 1*(h_Am4_2_1*h_Am2_2_0) + 1*(dA_m4_1*h_Am3_3_0)-(1*(dAm4_1)*h_Am4_4_0+h_Am4_4_m1*1*\
(dA0_m2))", "1*(h_Am4_3_1*dA_m1_0) - 1*(h_Am4_2_2*h_Am2_2_1) + 1*(dA_m4_2*h_Am3_3_1)-(h_Am4_4_0*1*(dA0_m1))", 
      "1*(h_Bm4_3_m3*dB_m1_m4) - 1*(h_Bm4_2_m2*h_Bm2_2_m3) + 1*(dB_m4_m2*h_Bm3_3_m3)-(1*(dBm4_m2)*h_Bm4_4_m3)", 
      "1*(h_Bm4_3_m2*dB_m1_m3) - 1*(h_Bm4_2_m1*h_Bm2_2_m2) + 1*(dB_m4_m1*h_Bm3_3_m2)-(1*(dBm4_m1)*h_Bm4_4_m2+h_Bm4_\
4_m3*1*(dB0_m4))", 
      "1*(h_Bm4_3_m1*dB_m1_m2) - 1*(h_Bm4_2_0*h_Bm2_2_m1) + 1*(dB_m4_0*h_Bm3_3_m1)-(1*(dBm4_0)*h_Bm4_4_m1+h_Bm4_4_m\
2*1*(dB0_m3))", 
      "1*(h_Bm4_3_0*dB_m1_m1) - 1*(h_Bm4_2_1*h_Bm2_2_0) + 1*(dB_m4_1*h_Bm3_3_0)-(1*(dBm4_1)*h_Bm4_4_0+h_Bm4_4_m1*1*\
(dB0_m2))", "1*(h_Bm4_3_1*dB_m1_0) - 1*(h_Bm4_2_2*h_Bm2_2_1) + 1*(dB_m4_2*h_Bm3_3_1)-(h_Bm4_4_0*1*(dB0_m1))", 
      "1*(h_phim4_1_m3*dB_m3_m4) - 1*(h_Am4_2_m3*phim2_m4) + 1*(phim4_m3*h_Bm4_2_m3) + 1*(dA_m4_m3*h_phim3_1_m3)-(-\
1*(dAm4_m3)*h_phim4_2_m3)", 
      "1*(h_phim4_1_m2*dB_m3_m3) - 1*(h_Am4_2_m2*phim2_m3) + 1*(phim4_m2*h_Bm4_2_m2) + 1*(dA_m4_m2*h_phim3_1_m2)-(-\
1*(dAm4_m2)*h_phim4_2_m2+h_phim4_2_m3*1*(dBm2_m4))", 
      "1*(h_phim4_1_m1*dB_m3_m2) - 1*(h_Am4_2_m1*phim2_m2) + 1*(phim4_m1*h_Bm4_2_m1) + 1*(dA_m4_m1*h_phim3_1_m1)-(-\
1*(dAm4_m1)*h_phim4_2_m1+h_phim4_2_m2*1*(dBm2_m3))", 
      "1*(h_phim4_1_0*dB_m3_m1) - 1*(h_Am4_2_0*phim2_m1) + 1*(phim4_0*h_Bm4_2_0) + 1*(dA_m4_0*h_phim3_1_0)-(-1*(dAm\
4_0)*h_phim4_2_0+h_phim4_2_m1*1*(dBm2_m2))", 
      "1*(h_phim4_1_1*dB_m3_0) - 1*(h_Am4_2_1*phim2_0) + 1*(phim4_1*h_Bm4_2_1) + 1*(dA_m4_1*h_phim3_1_1)-(-1*(dAm4_\
1)*h_phim4_2_1+h_phim4_2_0*1*(dBm2_m1))", 
      "1*(h_phim4_1_2*dB_m3_1) - 1*(h_Am4_2_2*phim2_1) + 1*(phim4_2*h_Bm4_2_2) + 1*(dA_m4_2*h_phim3_1_2)-(h_phim4_2\
_1*1*(dBm2_0))", 
      "1*(h_phim3_1_m3*dB_m2_m4) - 1*(h_Am3_2_m3*phim1_m4) + 1*(phim3_m3*h_Bm3_2_m3) + 1*(dA_m3_m3*h_phim2_1_m3)-(-\
1*(dAm3_m3)*h_phim3_2_m3)", 
      "1*(h_phim3_1_m2*dB_m2_m3) - 1*(h_Am3_2_m2*phim1_m3) + 1*(phim3_m2*h_Bm3_2_m2) + 1*(dA_m3_m2*h_phim2_1_m2)-(-\
1*(dAm3_m2)*h_phim3_2_m2+h_phim3_2_m3*1*(dBm1_m4))", 
      "1*(h_phim3_1_m1*dB_m2_m2) - 1*(h_Am3_2_m1*phim1_m2) + 1*(phim3_m1*h_Bm3_2_m1) + 1*(dA_m3_m1*h_phim2_1_m1)-(-\
1*(dAm3_m1)*h_phim3_2_m1+h_phim3_2_m2*1*(dBm1_m3))", 
      "1*(h_phim3_1_0*dB_m2_m1) - 1*(h_Am3_2_0*phim1_m1) + 1*(phim3_0*h_Bm3_2_0) + 1*(dA_m3_0*h_phim2_1_0)-(-1*(dAm\
3_0)*h_phim3_2_0+h_phim3_2_m1*1*(dBm1_m2))", 
      "1*(h_phim3_1_1*dB_m2_0) - 1*(h_Am3_2_1*phim1_0) + 1*(phim3_1*h_Bm3_2_1) + 1*(dA_m3_1*h_phim2_1_1)-(-1*(dAm3_\
1)*h_phim3_2_1+h_phim3_2_0*1*(dBm1_m1))", 
      "1*(h_phim3_1_2*dB_m2_1) - 1*(h_Am3_2_2*phim1_1) + 1*(phim3_2*h_Bm3_2_2) + 1*(dA_m3_2*h_phim2_1_2)-(h_phim3_2\
_1*1*(dBm1_0))", 
      "1*(h_phim2_1_m3*dB_m1_m4) - 1*(h_Am2_2_m3*phi0_m4) + 1*(phim2_m3*h_Bm2_2_m3) + 1*(dA_m2_m3*h_phim1_1_m3)-(-1\
*(dAm2_m3)*h_phim2_2_m3)", 
      "1*(h_phim2_1_m2*dB_m1_m3) - 1*(h_Am2_2_m2*phi0_m3) + 1*(phim2_m2*h_Bm2_2_m2) + 1*(dA_m2_m2*h_phim1_1_m2)-(-1\
*(dAm2_m2)*h_phim2_2_m2+h_phim2_2_m3*1*(dB0_m4))", 
      "1*(h_phim2_1_m1*dB_m1_m2) - 1*(h_Am2_2_m1*phi0_m2) + 1*(phim2_m1*h_Bm2_2_m1) + 1*(dA_m2_m1*h_phim1_1_m1)-(-1\
*(dAm2_m1)*h_phim2_2_m1+h_phim2_2_m2*1*(dB0_m3))", 
      "1*(h_phim2_1_0*dB_m1_m1) - 1*(h_Am2_2_0*phi0_m1) + 1*(phim2_0*h_Bm2_2_0) + 1*(dA_m2_0*h_phim1_1_0)-(-1*(dAm2\
_0)*h_phim2_2_0+h_phim2_2_m1*1*(dB0_m2))", 
      "1*(h_phim2_1_1*dB_m1_0) - 1*(h_Am2_2_1*phi0_0) + 1*(phim2_1*h_Bm2_2_1) + 1*(dA_m2_1*h_phim1_1_1)-(-1*(dAm2_1\
)*h_phim2_2_1+h_phim2_2_0*1*(dB0_m1))", 
      "1*(h_phim2_1_2*dB_m1_1) - 1*(h_Am2_2_2*phi0_1) + 1*(phim2_2*h_Bm2_2_2) + 1*(dA_m2_2*h_phim1_1_2)-(h_phim2_2_\
1*1*(dB0_0))", 
      "1*(h_phim4_2_m3*dB_m2_m4) + 1*(h_Am4_3_m3*phim1_m4) - 1*(h_phim4_1_m2*h_Bm3_2_m3) - 1*(h_Am4_2_m2*h_phim2_1_\
m3) - 1*(phim4_m2*h_Bm4_3_m3) - 1*(dA_m4_m2*h_phim3_2_m3)-(1*(dAm4_m2)*h_phim4_3_m3)", 
      "1*(h_phim4_2_m2*dB_m2_m3) + 1*(h_Am4_3_m2*phim1_m3) - 1*(h_phim4_1_m1*h_Bm3_2_m2) - 1*(h_Am4_2_m1*h_phim2_1_\
m2) - 1*(phim4_m1*h_Bm4_3_m2) - 1*(dA_m4_m1*h_phim3_2_m2)-(1*(dAm4_m1)*h_phim4_3_m2+h_phim4_3_m3*1*(dBm1_m4))", 
      "1*(h_phim4_2_m1*dB_m2_m2) + 1*(h_Am4_3_m1*phim1_m2) - 1*(h_phim4_1_0*h_Bm3_2_m1) - 1*(h_Am4_2_0*h_phim2_1_m1\
) - 1*(phim4_0*h_Bm4_3_m1) - 1*(dA_m4_0*h_phim3_2_m1)-(1*(dAm4_0)*h_phim4_3_m1+h_phim4_3_m2*1*(dBm1_m3))", 
      "1*(h_phim4_2_0*dB_m2_m1) + 1*(h_Am4_3_0*phim1_m1) - 1*(h_phim4_1_1*h_Bm3_2_0) - 1*(h_Am4_2_1*h_phim2_1_0) - \
1*(phim4_1*h_Bm4_3_0) - 1*(dA_m4_1*h_phim3_2_0)-(1*(dAm4_1)*h_phim4_3_0+h_phim4_3_m1*1*(dBm1_m2))", 
      "1*(h_phim4_2_1*dB_m2_0) + 1*(h_Am4_3_1*phim1_0) - 1*(h_phim4_1_2*h_Bm3_2_1) - 1*(h_Am4_2_2*h_phim2_1_1) - 1*\
(phim4_2*h_Bm4_3_1) - 1*(dA_m4_2*h_phim3_2_1)-(h_phim4_3_0*1*(dBm1_m1))", 
      "1*(h_phim3_2_m3*dB_m1_m4) + 1*(h_Am3_3_m3*phi0_m4) - 1*(h_phim3_1_m2*h_Bm2_2_m3) - 1*(h_Am3_2_m2*h_phim1_1_m\
3) - 1*(phim3_m2*h_Bm3_3_m3) - 1*(dA_m3_m2*h_phim2_2_m3)-(1*(dAm3_m2)*h_phim3_3_m3)", 
      "1*(h_phim3_2_m2*dB_m1_m3) + 1*(h_Am3_3_m2*phi0_m3) - 1*(h_phim3_1_m1*h_Bm2_2_m2) - 1*(h_Am3_2_m1*h_phim1_1_m\
2) - 1*(phim3_m1*h_Bm3_3_m2) - 1*(dA_m3_m1*h_phim2_2_m2)-(1*(dAm3_m1)*h_phim3_3_m2+h_phim3_3_m3*1*(dB0_m4))", 
      "1*(h_phim3_2_m1*dB_m1_m2) + 1*(h_Am3_3_m1*phi0_m2) - 1*(h_phim3_1_0*h_Bm2_2_m1) - 1*(h_Am3_2_0*h_phim1_1_m1)\
 - 1*(phim3_0*h_Bm3_3_m1) - 1*(dA_m3_0*h_phim2_2_m1)-(1*(dAm3_0)*h_phim3_3_m1+h_phim3_3_m2*1*(dB0_m3))", 
      "1*(h_phim3_2_0*dB_m1_m1) + 1*(h_Am3_3_0*phi0_m1) - 1*(h_phim3_1_1*h_Bm2_2_0) - 1*(h_Am3_2_1*h_phim1_1_0) - 1\
*(phim3_1*h_Bm3_3_0) - 1*(dA_m3_1*h_phim2_2_0)-(1*(dAm3_1)*h_phim3_3_0+h_phim3_3_m1*1*(dB0_m2))", 
      "1*(h_phim3_2_1*dB_m1_0) + 1*(h_Am3_3_1*phi0_0) - 1*(h_phim3_1_2*h_Bm2_2_1) - 1*(h_Am3_2_2*h_phim1_1_1) - 1*(\
phim3_2*h_Bm3_3_1) - 1*(dA_m3_2*h_phim2_2_1)-(h_phim3_3_0*1*(dB0_m1))", 
      "1*(h_phim4_3_m3*dB_m1_m4) - 1*(h_phim4_2_m2*h_Bm2_2_m3) - 1*(h_Am4_4_m3*phi0_m4) + 1*(h_Am4_3_m2*h_phim1_1_m\
3) + 1*(h_phim4_1_m1*h_Bm3_3_m3) + 1*(h_Am4_2_m1*h_phim2_2_m3) + 1*(phim4_m1*h_Bm4_4_m3) + 1*(dA_m4_m1*h_phim3_3_m3\
)-(-1*(dAm4_m1)*h_phim4_4_m3)", 
      "1*(h_phim4_3_m2*dB_m1_m3) - 1*(h_phim4_2_m1*h_Bm2_2_m2) - 1*(h_Am4_4_m2*phi0_m3) + 1*(h_Am4_3_m1*h_phim1_1_m\
2) + 1*(h_phim4_1_0*h_Bm3_3_m2) + 1*(h_Am4_2_0*h_phim2_2_m2) + 1*(phim4_0*h_Bm4_4_m2) + 1*(dA_m4_0*h_phim3_3_m2)-(-\
1*(dAm4_0)*h_phim4_4_m2+h_phim4_4_m3*1*(dB0_m4))", 
      "1*(h_phim4_3_m1*dB_m1_m2) - 1*(h_phim4_2_0*h_Bm2_2_m1) - 1*(h_Am4_4_m1*phi0_m2) + 1*(h_Am4_3_0*h_phim1_1_m1)\
 + 1*(h_phim4_1_1*h_Bm3_3_m1) + 1*(h_Am4_2_1*h_phim2_2_m1) + 1*(phim4_1*h_Bm4_4_m1) + 1*(dA_m4_1*h_phim3_3_m1)-(-1*\
(dAm4_1)*h_phim4_4_m1+h_phim4_4_m2*1*(dB0_m3))", 
      "1*(h_phim4_3_0*dB_m1_m1) - 1*(h_phim4_2_1*h_Bm2_2_0) - 1*(h_Am4_4_0*phi0_m1) + 1*(h_Am4_3_1*h_phim1_1_0) + 1\
*(h_phim4_1_2*h_Bm3_3_0) + 1*(h_Am4_2_2*h_phim2_2_0) + 1*(phim4_2*h_Bm4_4_0) + 1*(dA_m4_2*h_phim3_3_0)-(h_phim4_4_m\
1*1*(dB0_m2))" ], true ] );

Aoid := AdditiveClosure( oid );
Ho := HomotopyCategory( Aoid, true );
HoHo := HomotopyCategory( Ho, true );

for label_of_object in labels_of_objects do
  
  m := List( [ l .. l + N-2 ], i -> _StRiNg( Concatenation( "d", label_of_object, "_", String( i ) ) ) );
  
  BindGlobal( label_of_object, HomotopyCategoryObject( HoHo, List( m, ValueGlobal ), l ) );
  
od;

for label_of_morphism in labels_of_morphisms do
  
  m := List( [ l .. l + N-1 ], i -> _StRiNg( Concatenation( label_of_morphism[ 1 ], String( i ) ) ) );
  
  BindGlobal( label_of_morphism[ 1 ], HomotopyCategoryMorphism( ValueGlobal( label_of_morphism[ 2 ] ), ValueGlobal( label_of_morphism[ 3 ] ), List( m, ValueGlobal ), l ) );
  
od;

