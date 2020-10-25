gap> EnhancePackage( "LinearAlgebraForCAP" );
true
gap> Q := HomalgFieldOfRationals( );;
gap> mCat := MatrixCategory(Q);;
gap> chains := ChainComplexCategory( mCat );;
gap> alpha := RandomMorphism( chains, 3 );;
gap> s := QuasiIsomorphismFromProjectiveResolution( Source( alpha ), true );;
gap> r := QuasiIsomorphismFromProjectiveResolution( Range( alpha ), true );;
gap> p_alpha := MorphismBetweenProjectiveResolutions( alpha, true );;
gap> IsCongruentForMorphisms( PreCompose( p_alpha, r ), PreCompose( s, alpha ) );
true
gap> s := QuasiIsomorphismIntoInjectiveResolution( Source( alpha ) );;
gap> r := QuasiIsomorphismIntoInjectiveResolution( Range( alpha ) );;
gap> i_alpha := MorphismBetweenInjectiveResolutions( alpha, true );;
gap> IsCongruentForMorphisms( PreCompose( alpha, r ), PreCompose( s, i_alpha ) );
true
