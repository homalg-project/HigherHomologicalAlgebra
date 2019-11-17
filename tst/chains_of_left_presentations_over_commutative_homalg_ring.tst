gap> cat := LeftPresentations( S : FinalizeCategory := false );;
gap> ADD_RANDOM_METHODS_TO_MODULE_PRESENTATIONS( cat, "left" );;
gap> chains := ChainComplexCategory( cat );;
gap> M := AsLeftPresentation( HomalgMatrix( "x,y,z,t", 4, 1, S ) );;
gap> N := AsLeftPresentation( HomalgMatrix( "x-y,y+t,z+x,t^2", 4, 1, S ) );;
gap> while true do
>  phi := RandomMorphismWithFixedSourceAndRange( M, N, 4 ); 
>  if not IsZero( phi ) then   
>    break;   
>  fi; 
> od;;
gap> tau := MorphismBetweenProjectiveResolutions( phi, true );;
gap> q_source := QuasiIsomorphismFromProjectiveResolution( Source( tau ), true );;
gap> q_range := QuasiIsomorphismFromProjectiveResolution( Range( tau ), true );;
gap> gamma := MorphismBetweenProjectiveResolutions( tau, true );;
gap> IsWellDefined( tau );
true
gap> IsWellDefined( q_source );
true
gap> IsWellDefined( q_range );
true
gap> IsWellDefined( gamma );
true
gap> IsCongruentForMorphisms( PreCompose( gamma, q_range ), PreCompose( q_source, tau ) );
true
