# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#

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
InstallOtherMethod( CohomologyAt,
          [ IsDerivedCategoryObject, IsInt ],
    { a, i } -> CohomologyAt( UnderlyingCell( a ), i )
);

##
InstallOtherMethod( CohomologyFunctorialAt,
          [ IsDerivedCategoryMorphism, IsInt ],
    { alpha, i } ->
      PreCompose(
        Inverse( CohomologyFunctorialAt( SourceMorphism( UnderlyingRoof( alpha ) ), i ) ),
        CohomologyFunctorialAt( RangeMorphism( UnderlyingRoof( alpha ) ), i )
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
InstallOtherMethod( CohomologySupport,
          [ IsDerivedCategoryObject ],
    a -> CohomologySupport( UnderlyingCell( a ) )
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

