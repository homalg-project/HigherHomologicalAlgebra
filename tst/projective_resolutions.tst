gap> cat := LeftPresentations( R );
Category of left presentations of Q[x,y,z]
gap> a := AsLeftPresentation( HomalgMatrix( "[ [ x ], [ y ], [ z ] ]", 3, 1, R ) );
<An object in Category of left presentations of Q[x,y,z]>
gap> chain_a := StalkCochainComplex( a, 0 );
<A bounded object in Cochain complexes category over Category of left presentations of Q[x,y,z] with active l\
ower bound -1 and active upper bound 1>
gap> pr_res_a := ProjectiveResolution( a, true );
<A bounded object in Cochain complexes category over Category of left presentations of Q[x,y,z] with active l\
ower bound -4 and active upper bound 1>
gap> pr_res_chain_a := ProjectiveResolution( chain_a, true );
<A bounded object in Cochain complexes category over Category of left presentations of Q[x,y,z] with active l\
ower bound -4 and active upper bound 1>
gap> ActiveUpperBound( pr_res_a ) = ActiveUpperBound( pr_res_chain_a );
true
gap> ActiveLowerBound( pr_res_a ) = ActiveLowerBound( pr_res_chain_a );
true
gap> relations := [ "x^2 + y^2 - z"/R ];
[ x^2+y^2-z ]
gap> R_ := R/relations;
Q[x,y,z]/( x^2+y^2-z )
gap> b := AsLeftPresentation( HomalgMatrix( "[ [ x ], [ y ], [ z ] ]", 3, 1, R_ ) );
<An object in Category of left presentations of Q[x,y,z]/( x^2+y^2-z )>
gap> cochain_b := StalkCochainComplex( b, 0 );
<A bounded object in Cochain complexes category over Category of left presentations of Q[x,y,z]/( x^2+y^2-z )\
 with active lower bound -1 and active upper bound 1>
gap> pr_res_b := ProjectiveResolution( b, true );
<A bounded object in Cochain complexes category over Category of left presentations of Q[x,y,z]/( x^2+y^2-z )\
 with active lower bound -3 and active upper bound 1>
gap> pr_res_cochain_b := ProjectiveResolution( cochain_b, true );
<A bounded object in Cochain complexes category over Category of left presentations of Q[x,y,z]/( x^2+y^2-z )\
 with active lower bound -3 and active upper bound 1>
gap> ActiveUpperBound( pr_res_b ) = ActiveUpperBound( pr_res_cochain_b );
true
gap> ActiveLowerBound( pr_res_b ) = ActiveLowerBound( pr_res_cochain_b );
true
