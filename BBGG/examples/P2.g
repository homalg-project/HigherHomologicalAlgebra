LoadPackage( "BBGG" );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x,y,z" );
o := TwistedGradedFreeModule( S, 0 );
T := TateResolution( o );
B := BeilinsonReplacement( o );
