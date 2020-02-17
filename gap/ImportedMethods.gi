
##
InstallOtherMethod( HomologyAt,
          [ IsDerivedCategoryObject, IsInt ],
    { a, i } -> HomologyAt( UnderlyingCell( a ), i )
);

##
InstallOtherMethod( HomologyFunctorialAt,
          [ IsDerivedCategoryMorphism, IsInt ],
    { alpha, i } ->
      PreCompose(
        Inverse( HomologyFunctorialAt( SourceMorphism( UnderlyingRoof( alpha ) ), i ) ),
        HomologyFunctorialAt( RangeMorphism( UnderlyingRoof( alpha ) ), i )
      )
);

##
InstallOtherMethod( ObjectsSupport,
          [ IsDerivedCategoryObject ],
    a -> ObjectsSupport( UnderlyingCell( a ) )
);

##
InstallOtherMethod( DifferentialsSupport,
          [ IsDerivedCategoryObject ],
  a -> DifferentialsSupport( UnderlyingCell( a ) ));

##
InstallOtherMethod( HomologySupport,
          [ IsDerivedCategoryObject ],
    a -> HomologySupport( UnderlyingCell( a ) )
);

##
InstallOtherMethod( ActiveLowerBound,
          [ IsDerivedCategoryObject ],
    a -> ActiveLowerBound( UnderlyingCell( a ) )
);

##
InstallOtherMethod( ActiveUpperBound,
          [ IsDerivedCategoryObject ],
    a -> ActiveUpperBound( UnderlyingCell( a ) )
);

