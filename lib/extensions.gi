
#############################
##
## Representations
##
#############################

DeclareRepresentation( "IsCapCategoryExtensionRep",
                        IsCapCategoryExtension and IsAttributeStoringRep,
			                        [ ] );
##############################
##
## Family and type 
##
##############################

BindGlobal( "CapCategoryExtensionFamily",
  NewFamily( "CapCategoryExtensionFamily", IsObject ) );

BindGlobal( "TheTypeCapCategoryExtension",
  NewType( CapCategoryExtensionFamily,
                        IsCapCategoryExtensionRep) );

#############################
##
## Constructor
##
#############################

InstallMethod( YonedaExtension,
		[ IsBoundedChainComplex ],
 function( C )
   local ex, n; 

   ex := rec( );
   
   n := ActiveUpperBound( C ) - ActiveLowerBound( C ) - 2;

   ObjectifyWithAttributes( ex, TheTypeCapCategoryExtension,
   			    Length, n,
			    UnderlyingChainComplex, ShiftUnsignedLazy( C, ActiveLowerBound( C ) + 1 ) );
   return ex;

end );

   			    
