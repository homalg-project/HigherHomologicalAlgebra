

DeclareOperation( "\/", [ IsCapCategoryCell, IsCapFullSubcategory ] );
##
InstallMethod( \/, [ IsCapCategoryCell, IsCapFullSubcategory ], {cell, cat} -> AsFullSubcategoryCell( cat, cell ) );
