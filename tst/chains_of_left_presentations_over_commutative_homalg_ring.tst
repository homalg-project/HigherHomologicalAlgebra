gap> cat := LeftPresentations( R : FinalizeCategory := false );;
gap> ADD_RANDOM_METHODS_TO_MODULE_PRESENTATIONS( cat, "left" );;
gap> chains := ChainComplexCategory( cat );;
gap> C := RANDOM_CHAIN_COMPLEX( ChainComplexCategory( cat ), -10, 10, 2 );;
gap> p := ProjectiveResolution( C, true );;
gap> IsWellDefined(p);
true
gap> q := QuasiIsomorphismFromProjectiveResolution(C);;
gap> IsQuasiIsomorphism(q);
true
