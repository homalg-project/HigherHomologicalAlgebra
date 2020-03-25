LoadPackage( "DerivedC" );


field := HomalgFieldOfRationals( );

vertex_labels := [ "P_0x2", "P_0x1", "P_0x0", "P_1x2", "P_1x1", "P_1x0", "P_2x2", "P_2x1", "P_2x0" ];
arrows_labels := [ "d_1x2_0", "d_1x1_0", "d_1x0_0", "d_2x2_0", "d_2x1_0", "d_2x0_0", "d_0x2_1", "d_0x1_1", "d_1x2_1", 
  "d_1x1_1", "d_2x2_1", "d_2x1_1", "f_0x2_2", "f_1x2_2", "g_0x2_2", "g_1x2_2", "s_0x2_2x0" ];
sources := [ 4, 5, 6, 7, 8, 9, 1, 2, 4, 5, 7, 8, 1, 4, 1, 4, 1 ];
ranges :=  [ 1, 2, 3, 4, 5, 6, 2, 3, 5, 6, 8, 9, 6, 9, 6, 9, 9 ];

quiver := RightQuiver( "q", vertex_labels, arrows_labels, sources, ranges );

A := PathAlgebra( field, quiver );

A := A / [
  A.f_0x2_2*A.d_1x0_0 + A.d_0x2_1*A.d_0x1_1,
  A.g_0x2_2*A.d_1x0_0 + A.d_0x2_1*A.d_0x1_1, 
  A.d_2x2_1*A.d_2x1_1 + A.d_2x2_0*A.f_1x2_2, 
  A.d_2x2_1*A.d_2x1_1 + A.d_2x2_0*A.g_1x2_2,
  A.f_1x2_2*A.d_2x0_0 + A.d_1x2_1*A.d_1x1_1 + A.d_1x2_0*A.f_0x2_2,
  A.g_1x2_2*A.d_2x0_0 + A.d_1x2_1*A.d_1x1_1 + A.d_1x2_0*A.g_0x2_2,
  A.d_1x2_1*A.d_1x1_0 + A.d_1x2_0*A.d_0x2_1, 
  A.d_1x1_1*A.d_1x0_0 + A.d_1x1_0*A.d_0x1_1, 
  A.d_2x2_1*A.d_2x1_0 + A.d_2x2_0*A.d_1x2_1,
  A.d_2x1_1*A.d_2x0_0 + A.d_2x1_0*A.d_1x1_1,
  A.d_2x2_0*A.d_1x2_0,
  A.d_2x1_0*A.d_1x1_0,
  A.d_2x0_0*A.d_1x0_0,
  A.g_0x2_2 - A.f_0x2_2 - A.s_0x2_2x0 * A.d_2x0_0,
  A.g_1x2_2 - A.f_1x2_2 - A.d_1x2_0 * A.s_0x2_2x0,
  A.s_0x2_2x0 * A.d_2x0_0
  ];
  
C := Algebroid( A );
AssignSetOfObjects( C );
AssignSetOfGeneratingMorphisms( C );

AC := AdditiveClosure( C );

c_2 := HomotopyCategoryObject( [ d_1x2_0/AC, d_2x2_0/AC ], 1 );
c_1 := HomotopyCategoryObject( [ d_1x1_0/AC, d_2x1_0/AC ], 1 );
c_0 := HomotopyCategoryObject( [ d_1x0_0/AC, d_2x0_0/AC ], 1 );

d_2 := HomotopyCategoryMorphism( c_2, c_1, [ d_0x2_1/AC, -d_1x2_1/AC, d_2x2_1/AC ], 0 );
d_1 := HomotopyCategoryMorphism( c_1, c_0, [ d_0x1_1/AC, -d_1x1_1/AC, d_2x1_1/AC ], 0 );

c := ChainComplex( [ d_1, d_2 ], 1 );

conv_c_4 := [ [ d_2x2_0, -d_2x2_1 ] ]/AC;
conv_c_3 := [ [ d_1x2_0, d_1x2_1, -f_1x2_2 ], [ ZeroMorphism(P_2x1,P_0x2), -d_2x1_0, d_2x1_1 ] ]/AC;
conv_c_2 := [ [ -d_0x2_1, -f_0x2_2 ], [-d_1x1_0, -d_1x1_1], [ZeroMorphism(P_2x0,P_0x1), d_2x0_0] ]/AC;
conv_c_1 := [ [ d_0x1_1 ], [ d_1x0_0 ] ]/AC;

conv_1 := HomotopyCategoryObject( [ conv_c_1, conv_c_2, conv_c_3, conv_c_4 ], 1 );

conv_c_4 := [ [ d_2x2_0, -d_2x2_1 ] ]/AC;
conv_c_3 := [ [ d_1x2_0, d_1x2_1, -g_1x2_2 ], [ ZeroMorphism(P_2x1,P_0x2), -d_2x1_0, d_2x1_1 ] ]/AC;
conv_c_2 := [ [ -d_0x2_1, -g_0x2_2 ], [-d_1x1_0, -d_1x1_1], [ZeroMorphism(P_2x0,P_0x1), d_2x0_0] ]/AC;
conv_c_1 := [ [ d_0x1_1 ], [ d_1x0_0 ] ]/AC;

conv_2 := HomotopyCategoryObject( [ conv_c_1, conv_c_2, conv_c_3, conv_c_4 ], 1 );

