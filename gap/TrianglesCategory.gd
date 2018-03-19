
#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2018,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################


DeclareAttribute( "CategoryOfTriangles", IsCapCategory );

DeclareOperation( "\^", [ IsCapCategoryTriangle, IsInt ] );
#DeclareOperation( "\[\]", [ IsCapCategoryTriangle, IsInt ] );
#DeclareOperation( "\[\]", [ IsCapCategoryTrianglesMorphism, IsInt ] );

