###############################################
# resolutions.gd             complex package
#
# Feb. 2017
###############################################

DeclareOperationWithCache( "EpimorphismFromProjectiveObject", [ IsCapCategoryObject  ] );

DeclareOperation( "AddEpimorphismFromProjectiveObject",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEpimorphismFromProjectiveObject",
                   [ IsCapCategory, IsFunction ] );


DeclareOperation( "AddEpimorphismFromProjectiveObject",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEpimorphismFromProjectiveObject",
                   [ IsCapCategory, IsList ] );


DeclareOperationWithCache( "MonomorphismInInjectiveObject", [ IsCapCategoryObject  ] );

DeclareOperation( "AddMonomorphismInInjectiveObject",
                   [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonomorphismInInjectiveObject",
                   [ IsCapCategory, IsFunction ] );


DeclareOperation( "AddMonomorphismInInjectiveObject",
                   [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonomorphismInInjectiveObject",
                   [ IsCapCategory, IsList ] );

# New properties of cap categories

DeclareProperty( "HasEnoughProjectives", IsCapCategory );

DeclareProperty( "HasEnoughInjectives", IsCapCategory );

