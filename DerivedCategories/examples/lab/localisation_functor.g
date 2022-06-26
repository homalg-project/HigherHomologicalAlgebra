
LoadPackage( "DerivedCategories" );
SetSpecialSettings(); # optional: compare performance!

k := HomalgFieldOfRationals();;
Q := RightQuiver( "q(4)[a:4->2,b:2->1,c:4->3,d:3->1]" );;
kQ := PathAlgebra( k, Q );;
rel := [ kQ.a*kQ.b - kQ.c*kQ.d ];;
A := kQ / rel;;
A_op := OppositeAlgebra( A );

A_op_oid := Algebroid( A_op );
AA_op_oid := AdditiveClosure( A_op_oid );
QRows_A_op := QuiverRows( A_op );
QReps_A := CategoryOfQuiverRepresentations( A );

K_QRows_A_op := HomotopyCategory( QRows_A_op );
K_QReps_A := HomotopyCategory( QReps_A );

I :=PreCompose(
        LocalizationFunctorByProjectiveObjects( K_QReps_A ),
        ExtendFunctorToHomotopyCategories(
          PreCompose(
            [
              DecompositionFunctorOfProjectiveQuiverRepresentations( QReps_A ),
              ExtendFunctorToAdditiveClosures(
                InverseOfYonedaIsomorphismOntoFullSubcategoryOfCategoryOfQuiverRepresentations( A_op_oid )
              ),
              IsomorphismOntoQuiverRows( AA_op_oid )
            ]
          )
        )
      );

a := RandomObject( K_QReps_A, 3 );
Ia := I( a );
Show( Ia );

# creating cells in QReps_A

dim_S := [ 2, 3, 1, 1 ]; # correspond to Vertices(Q);
mats_S := # correspond to Arrows( Q );
  [
    MatrixByRows( k, [ 1, 3 ], [ [  0,  0,  0 ] ] ),
    MatrixByRows( k, [ 3, 2 ], [ [  0,  0 ], [  1,  0 ], [  0,  1 ] ] ),
    MatrixByRows( k, [ 1, 1 ], [ [  1 ] ] ),
    MatrixByRows( k, [ 1, 2 ], [ [  0,  0 ] ] )
  ];

S := QuiverRepresentation( A, dim_S, mats_S );

dim_R := [ 4, 3, 0, 2 ];
mats_R :=
  [
    MatrixByRows( k, [ 2, 3 ], [ [  0,  0,  0 ], [ 0, 1, 0 ] ] ),
    MatrixByRows( k, [ 3, 4 ], [ [ 1, 0, 0, 0 ], [  0, 0, 0, 0 ], [  0, 0, 0, 1 ] ] ),
    MatrixByRows( k, [ 2, 0 ], [ [ ], [ ] ] ),
    MatrixByRows( k, [ 0, 4 ], [ ] )
  ];
  
R := QuiverRepresentation( A, dim_R, mats_R );

mats_phi :=
  [
    MatrixByRows( k, [ 2, 4 ], [ [  1,  0,  0, 1 ], [ 1, 0, 0, 1 ] ] ),
    MatrixByRows( k, [ 3, 3 ], [ [ 0, 1, 0 ], [  1, 1, 1 ], [  1, 1, 1 ] ] ),
    MatrixByRows( k, [ 1, 0 ], [ [ ] ] ),
    MatrixByRows( k, [ 1, 2 ], [ [ 1, 0 ] ] )
  ];

phi := QuiverRepresentationHomomorphism( S, R, mats_phi );

a := HomotopyCategoryObject( [ CokernelProjection( phi ), phi, KernelEmbedding( phi ) ], 1 );
IsWellDefined( a );
HomologySupport( a );
