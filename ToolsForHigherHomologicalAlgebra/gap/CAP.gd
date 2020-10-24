





DeclareGlobalVariable( "DISABLE_ALL_SANITY_CHECKS" );
DeclareGlobalVariable( "SWITCH_LOGIC_OFF" );
DeclareGlobalVariable( "DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS" );

DeclareOperation( "ViewCapCategoryCell", [ IsCapCategoryCell ] );
DeclareOperation( "DisplayCapCategoryCell", [ IsCapCategoryCell ] );

DeclareGlobalFunction( "DeactivateCachingForCertainOperations" );
DeclareGlobalFunction( "ActivateCachingForCertainOperations" );
DeclareGlobalFunction( "CurrentCaching" );

DeclareOperation( "_WeakKernelEmbedding", [ IsCapCategoryMorphism ] );

