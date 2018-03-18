#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2018,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################

################################################
##
## Derived Methods for Triangulated Categories
##
################################################

# ##
# AddDerivationToCAP( CompleteToMorphismOfExactTrianglesByTR3,
#                     [ [ TR3, 1 ],
#                     [ ShiftOfMorphism, 1 ], 
#                     [ ReverseShiftOfMorphism, 1 ],
#                     [ ShiftOfObject, 1 ],
#                     [ ReverseShiftOfObject, 1 ] ], 
#    function( T, S, u, v, l )
#    local w;
#    
#    if l= [ 1, 2 ] then 
#    
#        w:= TR3( T, S, u, v );
#    
#        return CreateMorphismOfTriangles( T, S, u, v, w );
#    
#    elif l = [ 1, 3 ] then 
#    
#        w:= TR3( CreateTriangleByTR2Backward( T ), CreateTriangleByTR2Backward( S ),  ReverseShiftOfMorphism( v ), u );
#        
#        return CreateMorphismOfTriangles( T, S, u, w, v );
#        
#   else 
#    
#        w:= TR3( CreateTriangleByTR2Forward( T ), CreateTriangleByTR2Forward( S ),  u, v );
#        
#        return CreateMorphismOfTriangles( T, S, ReverseShiftOfMorphism( w ), u, v );
#        
#   fi;
#   
#       
# end: Description := "complete to morphism of exact triangles" );
#    