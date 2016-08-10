###############################################################################
##
##                                CAP package
##
##                             Kamal Saleh, 2016
##
###############################################################################

################################################
##
## Derived Methods for Triangulated Categories
##
################################################

##

AddDerivationToCAP( CompleteMorphismToExactTriangleByTR1, 
                   
                   [ [ TR1, 1 ] ], 
                   
   function( mor )
   local mor2,mor3;
   
   mor2 := TR1( mor )[ 1 ];
   
   mor3 := TR1( mor )[ 3 ];
   
   return CreateExactTriangle( mor, mor2, mor3 );
   
end: Description := "Complete a given morphism to an exact triangle" );
