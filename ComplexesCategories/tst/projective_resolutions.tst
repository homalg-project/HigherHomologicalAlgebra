gap> cat := LeftPresentations( R );
Category of left presentations of Q[x,y,z]
gap> a := AsLeftPresentation( HomalgMatrix( "[ [ x ], [ y ], [ z ] ]", 3, 1, R ) );
<An object in Category of left presentations of Q[x,y,z]>
gap> chain_a := StalkCochainComplex( a, 0 );;
gap> pr_res_a := ProjectiveResolution( a, true );;
gap> pr_res_chain_a := ProjectiveResolution( chain_a, true );;
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
gap> cochain_b := StalkCochainComplex( b, 0 );;
gap> pr_res_b := ProjectiveResolution( b, true );;
gap> pr_res_cochain_b := ProjectiveResolution( cochain_b, true );;
gap> ActiveUpperBound( pr_res_b ) = ActiveUpperBound( pr_res_cochain_b );
true
gap> ActiveLowerBound( pr_res_b ) = ActiveLowerBound( pr_res_cochain_b );
true
