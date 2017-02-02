###############################################
# resolutions.gi             complex package
#
# Feb. 2017
###############################################


DeclareGlobalVariable( "ENOUGH_PROJECTIVES_INJECTIVES_METHODS" );

InstallValue( ENOUGH_PROJECTIVES_INJECTIVES_METHODS, rec( 

EpimorphismFromProjectiveObject := rec( 

installation_name := "EpimorphismFromProjectiveObject", 
filter_list := [ "object" ],
cache_name := "EpimorphismFromProjectiveObject",
return_type := "morphism",
post_function := function( object, return_value )
                 SetIsEpimorphism( return_value, true );
                 end ),

MonomorphismInInjectiveObject := rec(

installation_name := "MonomorphismInInjectiveObject",
filter_list := [ "object" ],
cache_name := "MonomorphismInInjectiveObject",
return_type := "morphism",
post_function := function( object, return_value )
                 SetIsMonomorphism( return_value, true );
                 end ),
) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( ENOUGH_PROJECTIVES_INJECTIVES_METHODS );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( ENOUGH_PROJECTIVES_INJECTIVES_METHODS );

