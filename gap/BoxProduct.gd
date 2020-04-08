

DeclareAttribute( "BoxProductFunctor", IsQuiverAlgebra );

DeclareOperation( "BoxProductFunctor", [ IsQuiverAlgebra, IsQuiverAlgebra ] );

DeclareOperation( "EmbeddingFromProductOfAlgebroidsIntoTensorProduct",
      [ IsAlgebroid, IsAlgebroid ] );

DeclareAttribute( "ExtendFunctorFromProductCategoryToAdditiveClosures", IsCapFunctor );

DeclareOperation( "ProductOfFunctors", [ IsCapProductCategory, IsList, IsCapProductCategory ] );
