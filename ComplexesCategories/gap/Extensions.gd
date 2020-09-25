#
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#

DeclareCategory( "IsCapCategoryExtension", IsObject );

DeclareOperation( "YonedaExtension", [ IsBoundedChainComplex ] );

DeclareOperation( "YonedaExtension", [ IsBoundedCochainComplex ] );

DeclareAttribute( "Length", IsCapCategoryExtension );

DeclareAttribute( "UnderlyingChainComplex", IsCapCategoryExtension );

