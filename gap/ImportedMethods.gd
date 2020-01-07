


if false then
  
DeclareAttribute( "ProjectiveResolution", IsHomotopyCategoryObject );
DeclareAttribute( "QuasiIsomorphismFromProjectiveResolution", IsHomotopyCategoryObject );
DeclareAttribute( "MorphismBetweenProjectiveResolutions", IsHomotopyCategoryMorphism );

DeclareOperation( "ProjectiveResolution", [ IsHomotopyCategoryObject, IsBool ] );
DeclareOperation( "QuasiIsomorphismFromProjectiveResolution", [ IsHomotopyCategoryObject, IsBool ] );
DeclareOperation( "MorphismBetweenProjectiveResolutions", [ IsHomotopyCategoryMorphism, IsBool ] );


DeclareAttribute( "InjectiveResolution", IsHomotopyCategoryObject );
DeclareAttribute( "QuasiIsomorphismIntoInjectiveResolution", IsHomotopyCategoryObject );
DeclareAttribute( "MorphismBetweenInjectiveResolutions", IsHomotopyCategoryMorphism );

DeclareOperation( "InjectiveResolution", [ IsHomotopyCategoryObject, IsBool ] );
DeclareOperation( "QuasiIsomorphismIntoInjectiveResolution", [ IsHomotopyCategoryObject, IsBool ] );
DeclareOperation( "MorphismBetweenInjectiveResolutions", [ IsHomotopyCategoryMorphism, IsBool ] );

fi;
