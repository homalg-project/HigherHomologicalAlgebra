
#! @Chapter Examples and Tests

#! @Section Homotopy Category of the Freyd Category over a polynomial ring

#! @Example
LoadPackage( "ModulePresentations", false );
#! true
LoadPackage( "HomotopyCategories", false );
#! true
HOMALG_IO.show_banners := false;;
QQ := HomalgFieldOfRationalsInSingular( );
#! Q
QQ_xy := QQ["x, y"];
#! Q[x,y]
QQ_xy_mod := LeftPresentations( QQ_xy );
#! Category of left presentations of Q[x,y]
K_QQ_xy_mod := HomotopyCategoryByCochains( QQ_xy_mod );
#! Homotopy category by cochains( Category of left presentations of Q[x,y] )
m := HomalgMatrix("[[0,0,25*y+9,30,0,0,7*y], [0,0,0,0,24*x,0,20*y], [0,0,0,0,0,24,0], [0,0,29*x+27*y+10,0,0,0,0], [0,0,0,0,34,0,0], [0,0,0,0,0,0,0], [0,0,0,33*y,4*y+12,0,42], [0,20*x+34,0,0,0,0,0], [0,0,0,43*x,0,0,24*y], [0,0,0,0,0,0,0]]", 10, 7, QQ_xy );
#! <A 10 x 7 matrix over an external ring>
n := HomalgMatrix("[[0,0,25*y+9], [0,0,725*x+7], [0,10*x+17,0]]", 3, 3, QQ_xy );
#! <A 3 x 3 matrix over an external ring>
M := AsLeftPresentation( QQ_xy_mod, m );
#! <An object in Category of left presentations of Q[x,y]>
Display( M );
#! 0,0,      25*y+9,      30,  0,     0, 7*y, 
#! 0,0,      0,           0,   24*x,  0, 20*y,
#! 0,0,      0,           0,   0,     24,0,   
#! 0,0,      29*x+27*y+10,0,   0,     0, 0,   
#! 0,0,      0,           0,   34,    0, 0,   
#! 0,0,      0,           0,   0,     0, 0,   
#! 0,0,      0,           33*y,4*y+12,0, 42,  
#! 0,20*x+34,0,           0,   0,     0, 0,   
#! 0,0,      0,           43*x,0,     0, 24*y,
#! 0,0,      0,           0,   0,     0, 0    
#! 
#! An object in Category of left presentations of Q[x,y]
IsZero( M );
#! false
IsProjective( M );
#! false
N := AsLeftPresentation( QQ_xy_mod, n );
#! <An object in Category of left presentations of Q[x,y]>
Display( N );
#! 0,0,      25*y+9, 
#! 0,0,      725*x+7,
#! 0,10*x+17,0       
#!
#! An object in Category of left presentations of Q[x,y]
a := HomalgMatrix( "[[1,0,0], [0,1,0], [0,0,1], [0,0,-5/6*y-3/10], [0,0,0], [0,0,0], [0,0,0]]", 7, 3, QQ_xy );
#! <A 7 x 3 matrix over an external ring>
alpha := PresentationMorphism( M, a, N );
#! <A morphism in Category of left presentations of Q[x,y]>
Display( alpha );
#! 1,0,0,
#! 0,1,0,
#! 0,0,1,
#! 0,0,-5/6*y-3/10,
#! 0,0,0,
#! 0,0,0,
#! 0,0,0
#!
#! A morphism in Category of left presentations of Q[x,y]
IsIsomorphism( alpha );
#! true
M := CreateComplex( K_QQ_xy_mod, [ MorphismIntoZeroObject( M ) ], 0 );
#! <An object in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ 0 .. 1 ]>
ObjectsSupport( M );
#! [ 0 ]
ObjectAt( M, 0 );
#! <An object in Category of left presentations of Q[x,y]>
DifferentialAt( M, 0 );
#! <A zero, split epimorphism in Category of left presentations of Q[x,y]>
N := CreateComplex( K_QQ_xy_mod, [ MorphismIntoZeroObject( N ) ], 0 );
#! <An object in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ 0 .. 1 ]>
ObjectsSupport( N );
#! [ 0 ]
alpha := CreateComplexMorphism( K_QQ_xy_mod, M, [ alpha ], 0, N );
#! <A morphism in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ 0 .. 1 ]>
p_M := ProjectiveResolution( M, true );
#! <An object in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -3 .. 1 ]>
q_M := QuasiIsomorphismFromProjectiveResolution( M, true );
#! <A morphism in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -3 .. 1 ]>
p_N := ProjectiveResolution( N, true );
#! <An object in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -2 .. 1 ]>
q_N := QuasiIsomorphismFromProjectiveResolution( N, true );
#! <A morphism in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -2 .. 1 ]>
p_alpha := MorphismBetweenProjectiveResolutions( alpha, true );
#! <A morphism in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -3 .. 1 ]>
IsIsomorphism( p_alpha );
#! true
MorphismAt( p_alpha, 0 );
#! <A morphism in Category of left presentations of Q[x,y]>
PreCompose( p_alpha, q_N ) = PreCompose(q_M, alpha );
#! true
cone_q_M := StandardConeObject( q_M );
#! <An object in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -4 .. 1 ]>
CohomologySupport( cone_q_M ); # quasi-iso <-> cone is acyclic
#! [ ]
iota_q_M := MorphismIntoStandardConeObject( q_M );
#! <A morphism in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -4 .. 1 ]>
Display( iota_q_M );
#!
#! == 1 =======================
#! (an empty 0 x 0 matrix)
#! 
#! A zero, isomorphism in Category of left presentations of Q[x,y]
#! 
#! == 0 =======================
#! 1,0,0,0,0,0,0,
#! 0,1,0,0,0,0,0,
#! 0,0,1,0,0,0,0,
#! 0,0,0,1,0,0,0,
#! 0,0,0,0,1,0,0,
#! 0,0,0,0,0,1,0,
#! 0,0,0,0,0,0,1 
#! 
#! A morphism in Category of left presentations of Q[x,y]
#! 
#! == -1 =======================
#! (an empty 0 x 7 matrix)
#! 
#! A zero, split monomorphism in Category of left presentations of Q[x,y]
#! 
#! == -2 =======================
#! (an empty 0 x 8 matrix)
#! 
#! A zero, split monomorphism in Category of left presentations of Q[x,y]
#! 
#! == -3 =======================
#! (an empty 0 x 3 matrix)
#! 
#! A zero, split monomorphism in Category of left presentations of Q[x,y]
#! 
#! == -4 =======================
#! (an empty 0 x 1 matrix)
#! 
#! A zero, split monomorphism in Category of left presentations of Q[x,y]
#! 
#! 
#! A morphism in Homotopy category by cochains( Category of left presentations of Q[x,y] ) defined by the above data
#! 
IsWellDefined( iota_q_M );
#! true
pi_q_M := MorphismFromStandardConeObject( q_M );
#! <A morphism in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -4 .. 1 ]>
Display( pi_q_M );
#! == 1 =======================
#! (an empty 0 x 0 matrix)
#! 
#! A zero, isomorphism in Category of left presentations of Q[x,y]
#! 
#! == 0 =======================
#! (an empty 7 x 0 matrix)
#! 
#! A morphism in Category of left presentations of Q[x,y]
#! 
#! == -1 =======================
#! 1,0,0,0,0,0,0,
#! 0,1,0,0,0,0,0,
#! 0,0,1,0,0,0,0,
#! 0,0,0,1,0,0,0,
#! 0,0,0,0,1,0,0,
#! 0,0,0,0,0,1,0,
#! 0,0,0,0,0,0,1 
#! 
#! A morphism in Category of left presentations of Q[x,y]
#! 
#! == -2 =======================
#! 1,0,0,0,0,0,0,0,
#! 0,1,0,0,0,0,0,0,
#! 0,0,1,0,0,0,0,0,
#! 0,0,0,1,0,0,0,0,
#! 0,0,0,0,1,0,0,0,
#! 0,0,0,0,0,1,0,0,
#! 0,0,0,0,0,0,1,0,
#! 0,0,0,0,0,0,0,1 
#! 
#! A morphism in Category of left presentations of Q[x,y]
#! 
#! == -3 =======================
#! 1,0,0,
#! 0,1,0,
#! 0,0,1 
#! 
#! A morphism in Category of left presentations of Q[x,y]
#! 
#! == -4 =======================
#! 1
#! 
#! A morphism in Category of left presentations of Q[x,y]
#! 
#! 
#! A morphism in Homotopy category by cochains( Category of left presentations of Q[x,y] ) defined by the above data
nu := MorphismBetweenStandardConeObjects(q_M, p_alpha, alpha, q_N);
#! <A morphism in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -4 .. 1 ]>
IsWellDefined( nu );
#! true
IsZero( nu );
#! false
IsIsomorphism( nu );
#! true
ShiftOfObjectByInteger( p_M, 2 );
#! <An object in Homotopy category by cochains( Category of left presentations of Q[x,y] ) supported on the interval [ -5 .. -1 ]>
#! @EndExample
