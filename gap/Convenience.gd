
DeclareOperation( "\/", [ IsList, IsCapCategory ] );
DeclareOperation( "\/", [ IsCapCategoryCell, IsCategoryOfGradedRows ] );
DeclareOperation( "FindSomeFunctor", [ IsCapCategory, IsCapCategory ] );
DeclareOperation( "\/", [ IsCapCategory, IsCapCategory ] );

DeclareOperation( "FindSomeFunctorThenApply", [ IsCapCategoryCell, IsCapCategory ] );
DeclareOperation( "\*", [ IsCapCategoryCell, IsCapCategory ] );

DeclareOperation( "FindSomeFunctor", [ IsCapFunctor, IsCapCategory ] );
DeclareOperation( "\/", [ IsCapFunctor, IsCapCategory ] );

DeclareOperation( "FindSomeFunctor", [ IsCapCategory, IsCapFunctor ] );
DeclareOperation( "\/", [ IsCapCategory, IsCapFunctor ] );
