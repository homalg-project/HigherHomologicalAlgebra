m := HomalgMatrix( "[ [ x0^5 ], [ x1^3 ] ]", 2, 1, S );
%
M := AsGradedLeftPresentation( m, [ 0 ] );
%
O := GradedFreeLeftPresentation(1, S, [ 0 ] );
%
O_plus_M := DirectSum( O, M );
%
Display( M );
%
Display( O );
%
Display( O_plus_M );
%
T := TateFunctor( S );
%
TM := ApplyFunctor( T, M );
%
TO := ApplyFunctor( T, O );
%
TO_plus_M := ApplyFunctor( T, O_plus_M );
%
syz_TM_0 := Source( CyclesAt( TM, 0 ) );
%
syz_TO_0 := Source( CyclesAt( TO, 0 ) );
%
syz_TO_plus_M_0 := Source( CyclesAt( TO_plus_M, 0 ) );
%
syz_TM_0 := AsStableObject( syz_TM_0 );
%
syz_TO_0 := AsStableObject( syz_TO_0 );
%
syz_TO_plus_M_0 := AsStableObject( syz_TO_plus_M_0 );
%
Display( syz_TM_0 );
%
Display( syz_TO_0 );
%
Display( syz_TO_plus_M_0 );

