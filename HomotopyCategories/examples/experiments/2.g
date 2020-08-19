LoadPackage( "HomotopyCategories" );
SET_SPECIAL_SETTINGS();

objects := [ "A0", "A1", "A2", "A3", "B0", "B1", "B2" ];
maps :=
  [ 
    [ "dA_0", 1, 2 ],
    [ "dA_1", 2, 3 ],
    [ "dA_2", 3, 4 ],
    [ "dB_0", 5, 6 ],
    [ "dB_1", 6, 7 ],
    [ "phi0", 1, 5 ],
    [ "phi1", 2, 6 ],
    [ "phi2", 3, 7 ],
  ];

pre_rels :=
  [
    [ "dA_0*dA_1", "hA_0_2" ],
    [ "dA_1*dA_2", "hA_1_2" ],
    [ "dB_0*dB_1", "hB_0_2" ],
    [ "dA_0*phi1-phi0*dB_0", "hphi_0_1" ],
    [ "dA_1*phi2-phi1*dB_1", "hphi_1_1" ]
  ];
   
other_rels :=
  [
    [
      [ "BasisOfExternalHom(Shift(A0,1),A3)[1]",  "hA_0_3" ],
      [ "BasisOfExternalHom(Shift(A0,1),B2)[1]",  "hphi_0_2" ],
    ]
  ];
  
oid := AlgebroidOfDiagramInHomotopyCategory( objects, maps, [ -4, 4 ], pre_rels, other_rels );
Aoid := AdditiveClosure( oid );
Ho := HomotopyCategory( Aoid, true );
HoHo := HomotopyCategory( Ho, true );
