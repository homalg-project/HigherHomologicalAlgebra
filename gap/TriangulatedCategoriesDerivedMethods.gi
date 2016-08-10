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

AddDerivationToCAP( CompleteMorphismToExactTriangle, 
                   
                   [ [ ConeAndMorphisms, 1 ] ], 
                   
   function( mor )
   local mor2,mor3;
   
   mor2 := ConeAndMorphisms( mor )[ 1 ];
   
   mor3 := ConeAndMorphisms( mor )[ 3 ];
   
   return CreateExactTriangle( mor, mor2, mor3 );
   
end: Description := "Complete a given morphism to an exact triangle" );