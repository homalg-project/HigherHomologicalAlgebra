

##
InstallOtherMethod( ProjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> ProjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
InstallOtherMethod( ProjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    { a, bool } -> ProjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
InstallOtherMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
InstallOtherMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    { a, bool } -> QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
InstallOtherMethod( MorphismBetweenProjectiveResolutions,
          [ IsHomotopyCategoryMorphism ],
    alpha -> MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ) ) / CapCategory( alpha )
);

##
InstallOtherMethod( MorphismBetweenProjectiveResolutions,
          [ IsHomotopyCategoryMorphism, IsBool ],
    { alpha, bool } -> MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ), bool ) / CapCategory( alpha )
);

##
InstallOtherMethod( InjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> InjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
InstallOtherMethod( InjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    { a, bool } -> InjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
InstallOtherMethod( MorphismBetweenInjectiveResolutions,
          [ IsHomotopyCategoryMorphism ],
    alpha -> MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ) ) / CapCategory( alpha )
);

##
InstallOtherMethod( MorphismBetweenInjectiveResolutions,
          [ IsHomotopyCategoryMorphism, IsBool ],
    { alpha, bool } -> MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ), bool ) / CapCategory( alpha )
);

##
InstallOtherMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsHomotopyCategoryObject ],
    a -> QuasiIsomorphismIntoInjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a )
);

##
InstallOtherMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
    { a, bool } -> QuasiIsomorphismIntoInjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a )
);

##
InstallOtherMethod( HomologyAt,
          [ IsHomotopyCategoryObject, IsInt ],
    { a, i } -> HomologyAt( UnderlyingCell( a ), i )
);

##
InstallOtherMethod( HomologyFunctorialAt,
          [ IsHomotopyCategoryMorphism, IsInt ],
    { alpha, i } -> HomologyFunctorialAt( UnderlyingCell( alpha ), i )
);

##
InstallOtherMethod( ObjectsSupport,
          [ IsHomotopyCategoryObject ],
    a -> ObjectsSupport( UnderlyingCell( a ) )
);

##
InstallOtherMethod( MorphismsSupport,
          [ IsHomotopyCategoryMorphism ],
    alpha -> MorphismsSupport( UnderlyingCell( alpha ) )
);

##
InstallOtherMethod( DifferentialsSupport,
          [ IsHomotopyCategoryObject ],
  a -> DifferentialsSupport( UnderlyingCell( a ) ));

##
InstallOtherMethod( HomologySupport,
          [ IsHomotopyCategoryObject ],
    a -> HomologySupport( UnderlyingCell( a ) )
);

##
InstallOtherMethod( ViewComplex,
              [ IsHomotopyCategoryObject ],
  function( a )
    
    ViewComplex( UnderlyingCell( a ) );
    
end );

##
InstallOtherMethod( ViewChainMorphism,
              [ IsHomotopyCategoryMorphism ],
  function( alpha )
    
    ViewChainMorphism( UnderlyingCell( alpha ) );
    
end );
