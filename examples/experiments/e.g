ReadPackage( "DerivedCategories", "examples/convolution/clean_pre_functions.g" );

field := HomalgFieldOfRationals( );

q := RightQuiver( "quiver(A1,A2,B1,B2,C1,C2,D1,D2)[a:A1->A2,b:B1->B2,c:C1->C2,d:D1->D2,ab1:A1->B1,ab2:A2->B2,cd1:C1->D1,cd2:C2->D2,ac1:A1->C1,ac2:A2->C2,bd1:B1->D1,bd2:B2->D2,x:A2->D1,y:A2->D1]" );

kQ := PathAlgebra( field, q );

rel := [
        kQ.a*kQ.ac2-kQ.ac1*kQ.c, kQ.a*kQ.ab2-kQ.ab1*kQ.b, kQ.b*kQ.bd2-kQ.bd1*kQ.d, kQ.c*kQ.cd2-kQ.cd1*kQ.d,
        -kQ.ac1*kQ.cd1 + kQ.ab1*kQ.bd1-kQ.a*kQ.x, -kQ.ac2*kQ.cd2 + kQ.ab2*kQ.bd2-kQ.x*kQ.d,
        -kQ.ac1*kQ.cd1 + kQ.ab1*kQ.bd1-kQ.a*kQ.y, -kQ.ac2*kQ.cd2 + kQ.ab2*kQ.bd2-kQ.y*kQ.d
       ];
       
A := kQ / rel;
algebroid := Algebroid( A );;
AssignSetOfObjects( algebroid );;
AssignSetOfGeneratingMorphisms( algebroid );;
algebroid_oplus := AdditiveClosure( algebroid );;
Ho := HomotopyCategory( algebroid_oplus, true );;
A := HomotopyCategoryObject( Ho, [ a / algebroid_oplus ], 0 );;
B := HomotopyCategoryObject( Ho, [ b / algebroid_oplus ], 0 );;
C := HomotopyCategoryObject( Ho, [ c / algebroid_oplus ], 0 );;
D := HomotopyCategoryObject( Ho, [ d / algebroid_oplus ], 0 );;
ab := HomotopyCategoryMorphism( A, B, [ ab1/algebroid_oplus, ab2/algebroid_oplus ], 0 );;
cd := HomotopyCategoryMorphism( C, D, [ cd1/algebroid_oplus, cd2/algebroid_oplus ], 0 );;
ac := HomotopyCategoryMorphism( A, C, [ ac1/algebroid_oplus, ac2/algebroid_oplus ], 0 );;
bd := HomotopyCategoryMorphism( B, D, [ bd1/algebroid_oplus, bd2/algebroid_oplus ], 0 );;

st_ab := StandardExactTriangle( ab );
st_cd := StandardExactTriangle( cd );
m := MorphismOfExactTriangles( st_ab, ac, bd, st_cd );

