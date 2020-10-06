#
# TriangulatedCategories: Framework for triangulated categories
#
# Implementations
#

###############################
##
##  Methods record
##
###############################

InstallValue( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD, rec(

StandardConeObject:= rec(
  installation_name := "StandardConeObject",
  filter_list := [ "morphism" ],
  cache_name := "StandardConeObject",
  return_type := "object"
),

MorphismIntoStandardConeObjectWithGivenStandardConeObject := rec(
  installation_name := "MorphismIntoStandardConeObjectWithGivenStandardConeObject",
  filter_list := [ "morphism", "object" ],
  io_type := [ [ "alpha", "cone_alpha" ], [ "range_alpha", "cone_alpha" ] ],
  number_of_diagram_arguments := 1,
  cache_name := "MorphismIntoStandardConeObjectWithGivenStandardConeObject",
  return_type := "morphism"
),

MorphismFromStandardConeObjectWithGivenStandardConeObject := rec(
  installation_name := "MorphismFromStandardConeObjectWithGivenStandardConeObject",
  filter_list := [ "morphism", "object" ],
  io_type := [ [ "alpha", "cone_alpha" ], [ "cone_alpha", "sh_source_alpha" ] ],
  number_of_diagram_arguments := 1,  
  cache_name := "MorphismFromStandardConeObjectWithGivenStandardConeObject",
  return_type := "morphism"
),

MorphismIntoStandardConeObject := rec(
  installation_name := "MorphismIntoStandardConeObject",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "range_alpha", "cone_alpha" ] ],
  cache_name := "MorphismIntoStandardConeObject",
  return_type := "morphism"
),

MorphismFromStandardConeObject := rec(
  installation_name := "MorphismFromStandardConeObject",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "cone_alpha", "sh_source_alpha" ] ],
  cache_name := "MorphismFromStandardConeObject",
  return_type := "morphism"
),

ShiftOnObject:= rec(
  installation_name := "ShiftOnObject",
  filter_list := [ "object" ],
  cache_name := "ShiftOnObject",
  return_type := "object"
),

ShiftOnMorphismWithGivenObjects := rec(
  installation_name := "ShiftOnMorphismWithGivenObjects",
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "object", "morphism", "object" ],
  cache_name := "ShiftOnMorphismWithGivenObjects",
  return_type := "morphism"
),

InverseShiftOnObject := rec(
  installation_name := "InverseShiftOnObject",
  filter_list := [ "object" ],
  cache_name := "InverseShiftOnObject",
  return_type := "object"
),

InverseShiftOnMorphismWithGivenObjects := rec(
  installation_name := "InverseShiftOnMorphismWithGivenObjects",
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "object", "morphism", "object" ],
  cache_name := "InverseShiftOnMorphismWithGivenObjects",
  return_type := "morphism"
),

WitnessIsomorphismOntoStandardConeObject := rec(
  installation_name := "WitnessIsomorphismOntoStandardConeObject",
  io_type := [ [ "alpha", "iota", "pi" ], [ "range_iota", "cone_alpha" ] ],
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "WitnessIsomorphismOntoStandardConeObject",
  return_type := "morphism_or_fail"
),

WitnessIsomorphismFromStandardConeObject := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObject",
  io_type := [ [ "alpha", "iota", "pi" ], [ "cone_alpha", "range_iota" ] ],
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "WitnessIsomorphismFromStandardConeObject",
  return_type := "morphism_or_fail"
),

IsExactTriangle := rec(
  installation_name := "IsExactTriangle",
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "IsExactTriangle",
  return_type := "bool"
),

IsomorphismOntoShiftOfInverseShiftWithGivenObject := rec(
  installation_name := "IsomorphismOntoShiftOfInverseShiftWithGivenObject",
  filter_list := [ "object", "object" ],
  io_type := [ [ "s", "sh_o_rev_sh_s" ], [ "s", "alpha", "sh_o_rev_sh_s" ] ],
  cache_name := "IsomorphismOntoShiftOfInverseShiftWithGivenObject",
  return_type := "morphism"
),

#IsomorphismOntoShiftOfInverseShift := rec(
#  installation_name := "IsomorphismOntoShiftOfInverseShift",
#  filter_list := [ "object" ],
#  io_type := [ [ "s" ], [ "s", "alpha", "sh_o_rev_sh_s" ] ],
#  cache_name := "IsomorphismOntoShiftOfInverseShift",
#  return_type := "morphism"
#),

IsomorphismOntoInverseShiftOfShiftWithGivenObject := rec(
  installation_name := "IsomorphismOntoInverseShiftOfShiftWithGivenObject",
  filter_list := [ "object", "object" ],
  io_type := [ [ "s", "rev_sh_o_sh_s" ], [ "s", "alpha", "rev_sh_o_sh_s" ] ],
  cache_name := "IsomorphismOntoInverseShiftOfShiftWithGivenObject",
  return_type := "morphism"
),

#IsomorphismOntoInverseShiftOfShift := rec(
#  installation_name := "IsomorphismOntoInverseShiftOfShift",
#  filter_list := [ "object" ],
#  io_type := [ [ "s" ], [ "s", "alpha", "rev_sh_o_sh_s" ] ],
#  cache_name := "IsomorphismOntoInverseShiftOfShift",
#  return_type := "morphism"
#),

IsomorphismFromShiftOfInverseShiftWithGivenObject := rec(
  installation_name := "IsomorphismFromShiftOfInverseShiftWithGivenObject",
  filter_list := [ "object", "object" ],
  io_type := [ [ "s", "sh_o_rev_sh_s" ], [ "sh_o_rev_sh_s", "alpha", "s" ] ],
  cache_name := "IsomorphismFromShiftOfInverseShiftWithGivenObject",
  return_type := "morphism"
),

#IsomorphismFromShiftOfInverseShift := rec(
#  installation_name := "IsomorphismFromShiftOfInverseShift",
#  filter_list := [ "object" ],
#  io_type := [ [ "s" ], [ "sh_o_rev_sh_s", "alpha", "s" ] ],
#  cache_name := "IsomorphismFromShiftOfInverseShift",
#  return_type := "morphism"
#),

IsomorphismFromInverseShiftOfShiftWithGivenObject := rec(
  installation_name := "IsomorphismFromInverseShiftOfShiftWithGivenObject",
  filter_list := [ "object", "object" ],
  io_type := [ [ "s", "rev_sh_o_sh_s" ], [ "rev_sh_o_sh_s", "alpha", "s" ] ],
  cache_name := "IsomorphismFromInverseShiftOfShiftWithGivenObject",
  return_type := "morphism"
),

#IsomorphismFromInverseShiftOfShift := rec(
#  installation_name := "IsomorphismFromInverseShiftOfShift",
#  filter_list := [ "object" ],
#  io_type := [ [ "s" ], [ "rev_sh_o_sh_s", "alpha", "s" ] ],
#  cache_name := "IsomorphismFromInverseShiftOfShift",
#  return_type := "morphism"
#),

MorphismBetweenStandardConeObjectsWithGivenObjects := rec(
  installation_name := "MorphismBetweenStandardConeObjectsWithGivenObjects",
  filter_list := [ "object", "morphism", "morphism", "morphism", "morphism", "object" ],
  io_type := [ ["cone_alpha", "alpha",  "mu", "nu", "alpha_prime", "cone_alpha_prime" ], [ "cone_alpha", "cone_alpha_prime" ] ],
  cache_name := "MorphismBetweenStandardConeObjectsWithGivenObjects",
  return_type := [ "morphism" ],
  is_with_given := false
),

DomainMorphismByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "DomainMorphismByOctahedralAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "morphism", "morphism", "object" ],
  cache_name := "DomainMorphismByOctahedralAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

MorphismIntoConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "MorphismIntoConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "morphism", "morphism", "object" ],
  cache_name := "MorphismIntoConeObjectByOctahedralAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

MorphismFromConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "MorphismFromConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "morphism", "morphism", "object" ],
  cache_name := "MorphismFromConeObjectByOctahedralAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "cone_g", "f", "g", "h", "st_cone" ], [ "cone_g", "st_cone" ] ],
  cache_name := "WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "g", "h", "cone_g" ], [ "st_cone", "cone_g" ] ],
  cache_name := "WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  cache_name := "WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  cache_name := "WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  cache_name := "WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  cache_name := "WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

ShiftExpandingIsomorphismWithGivenObjects := rec(
  installation_name := "ShiftExpandingIsomorphismWithGivenObjects",
  filter_list := [ "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  cache_name := "ShiftExpandingIsomorphismWithGivenObjects",
  return_type := "morphism"
),

ShiftFactoringIsomorphismWithGivenObjects := rec(
  installation_name := "ShiftFactoringIsomorphismWithGivenObjects",
  filter_list := [ "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  cache_name := "ShiftFactoringIsomorphismWithGivenObjects",
  return_type := "morphism"
),

InverseShiftExpandingIsomorphismWithGivenObjects := rec(
  installation_name := "InverseShiftExpandingIsomorphismWithGivenObjects",
  filter_list := [ "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  cache_name := "InverseShiftExpandingIsomorphismWithGivenObjects",
  return_type := "morphism"
),

InverseShiftFactoringIsomorphismWithGivenObjects := rec(
  installation_name := "InverseShiftFactoringIsomorphismWithGivenObjects",
  filter_list := [ "object", IsList, "object" ],
  io_type := [ [ "s", "L", "r" ], [ "s", "r" ] ],
  cache_name := "InverseShiftFactoringIsomorphismWithGivenObjects",
  return_type := "morphism"
)

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD );


###########################################
#
# Convenient methods
#
##########################################

##
InstallMethod( ShiftOnMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> ShiftOnMorphismWithGivenObjects(
              ShiftOnObject( Source( alpha ) ),
              alpha,
              ShiftOnObject( Range( alpha ) )
            )
);

##
InstallMethod( InverseShiftOnMorphism,
          [ IsCapCategoryMorphism ],
  alpha -> InverseShiftOnMorphismWithGivenObjects(
              ShiftOnObject( Source( alpha ) ),
              alpha,
              ShiftOnObject( Range( alpha ) )
            )
);

##
InstallMethod( ConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    
    return StandardConeObject( beta );
    
end );

##
InstallMethod( MorphismBetweenStandardConeObjects,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, mu, nu, beta )
    local cone_alpha, cone_beta;
    
    cone_alpha := StandardConeObject( alpha );

    cone_beta := StandardConeObject( beta );
    
    return MorphismBetweenStandardConeObjectsWithGivenObjects(
            cone_alpha, alpha, mu, nu, beta, cone_beta );
end );

##
InstallMethod( WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, u, r;
    
    s := ConeObjectByOctahedralAxiom( alpha, beta, gamma );
    
    u := DomainMorphismByOctahedralAxiom( alpha, beta, gamma );
     
    r := StandardConeObject( u );
    
    return WitnessIsomorphismOntoStandardConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
      
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, u, r;
    
    u := DomainMorphismByOctahedralAxiom( alpha, beta, gamma );
     
    s := StandardConeObject( u );

    r := ConeObjectByOctahedralAxiom( alpha, beta, gamma );
        
    return WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
      
end );

##
InstallMethod( ConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return ShiftOnObject( Source( alpha ) );
    
end );

##
InstallMethod( DomainMorphismByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return MorphismIntoStandardConeObject( alpha );
    
end );

##
InstallMethod( MorphismIntoConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return MorphismFromStandardConeObject( alpha );
    
end );

##
InstallMethod( MorphismFromConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return AdditiveInverseForMorphisms( ShiftOnMorphism( alpha ) );
    
end );

##
InstallMethod( ConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return Range( alpha );
    
end );

##
InstallMethod( DomainMorphismByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local u;
    
    u := MorphismFromStandardConeObject( alpha );
    
    return PreCompose(
              AdditiveInverseForMorphisms( InverseShiftOnMorphism( u ) ),
              IsomorphismFromInverseShiftOfShift( Source( alpha ) )
            );
    
end );

##
InstallMethod( MorphismIntoConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ], IdFunc
);

##
InstallMethod( MorphismFromConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return PreCompose(
              MorphismIntoStandardConeObject( alpha ),
              IsomorphismOntoShiftOfInverseShift( StandardConeObject( alpha ) )
            );
    
end );

##
InstallMethod( WitnessIsomorphismOntoStandardConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByRotationAxiom( alpha ) );
    
    return WitnessIsomorphismOntoStandardConeObjectByRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := StandardConeObject( DomainMorphismByRotationAxiom( alpha ) );
    
    r := ConeObjectByRotationAxiom( alpha );
    
    return WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByInverseRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByInverseRotationAxiom( alpha ) );
    
    return WitnessIsomorphismOntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := StandardConeObject( DomainMorphismByInverseRotationAxiom( alpha ) );
    
    r := ConeObjectByInverseRotationAxiom( alpha );
    
    return WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects( s, alpha, r );
    
end );

##
InstallMethod( DomainMorphismByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
    
    s := StandardConeObject( alpha );
    
    r := StandardConeObject( gamma );
    
    return DomainMorphismByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
  
end );

##
InstallMethod( MorphismIntoConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
    
    s := StandardConeObject( gamma );
    
    r := StandardConeObject( beta );
    
    return MorphismIntoConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( MorphismFromConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta, gamma )
    local s, r;
     
    s := StandardConeObject( beta );
    
    r := ShiftOnObject( StandardConeObject( alpha ) );
    
    return MorphismFromConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, gamma, r );
    
end );

##
InstallMethod( StandardCoConeObject,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return InverseShiftOnObject( StandardConeObject( alpha ) );
    
end );

## at some time I was returning the additive inverse of this, but
## it turns out, this new method make things simpler.
##
InstallMethod( MorphismFromStandardCoConeObject,
          [ IsCapCategoryMorphism ],
  function( alpha )
    
    return InverseShiftOnMorphism(
                  MorphismFromStandardConeObject( alpha )
                );
    
end );

##
InstallMethod( MorphismBetweenStandardCoConeObjects,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, mu, nu, beta )
    
    return InverseShiftOnMorphism(
              MorphismBetweenStandardConeObjects(
                    alpha,
                    mu,
                    nu,
                    beta
                  )
              );
    
end );

###
#InstallMethod( ShiftExpandingIsomorphism,
#                [ IsList ],
#  function( L )
#    return ShiftExpandingIsomorphismWithGivenObjects( ShiftOnObject( DirectSum( L ) ), L, DirectSum( List( L, ShiftOnObject ) ) );
#end );
#
###
#InstallMethod( InverseShiftExpandingIsomorphism,
#                [ IsList ],
#  function( L )
#    return InverseShiftExpandingIsomorphismWithGivenObjects(
#            InverseShiftOnObject( DirectSum( L ) ),
#            L,
#            DirectSum( List( L, InverseShiftOnObject ) )
#          );
#end );
#
###
#InstallMethod( ShiftFactoringIsomorphism,
#                [ IsList ],
#    function( L )
#    return ShiftFactoringIsomorphismWithGivenObjects(
#            DirectSum(
#            List( L, ShiftOnObject ) ),
#            L,
#            ShiftOnObject( DirectSum( L ) )
#          );
#end );
#
###
#InstallMethod( InverseShiftFactoringIsomorphism,
#          [ IsList ],
#    function( L )
#    return InverseShiftFactoringIsomorphismWithGivenObjects(
#              DirectSum( List( L, InverseShiftOnObject ) ),
#              L,
#              InverseShiftOnObject( DirectSum( L ) )
#          );
#end );

###
#InstallMethod( IsomorphismFromStandardExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                -1000,
#    function( T )
#    local F, p;
#    F := T!.UnderlyingLazyMethods;
#    if not IsomorphismFromStandardExactTriangle in F then
#        TryNextMethod( );
#    else
#        p := Position( F, IsomorphismFromStandardExactTriangle );
#        return CallFuncList( F[p+1], F[ p+2 ] );
#    fi;
#end );
#
###
#InstallMethod( IsomorphismOntoStandardExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                -1000,
#    function( T )
#    local F, p;
#    F := T!.UnderlyingLazyMethods;
#    if not IsomorphismOntoStandardExactTriangle in F then
#        TryNextMethod( );
#    else
#        p := Position( F, IsomorphismOntoStandardExactTriangle );
#        return CallFuncList( F[p+1], F[ p+2 ] );
#    fi;
#end );
#

##
InstallMethod( ShiftOp,
          [ IsCapCategoryCell, IsInt ],
  function( cell, n )
    local C;
    
    C := CapCategory( cell );
    
    if not IsTriangulatedCategory( C ) then
      TryNextMethod( );
    fi;
    
    if n = 0 then
      
      return cell;
      
    elif n > 0 then
    
      if IsCapCategoryObject( cell ) then
        
        return ShiftOnObject( Shift( cell, n - 1 ) );
        
      else
        
        return ShiftOnMorphism( Shift( cell, n - 1 ) );
        
      fi;
      
    else
      
      if IsCapCategoryObject( cell ) then
        
        return InverseShiftOnObject( Shift( cell, n + 1 ) );
        
      else
        
        return InverseShiftOnMorphism( Shift( cell, n + 1 ) );
        
      fi;
      
    fi;

end );

##
InstallOtherMethod( Shift,
              [ IsCapCategoryCell ],
  function( c )
    
    if not IsTriangulatedCategory( CapCategory( c ) ) then
      
      TryNextMethod( );
      
    fi;
    
    return Shift( c, 1 );
    
end );

##
InstallMethod( InverseShift,
              [ IsCapCategoryCell ],
  function( c )
    
    if not IsTriangulatedCategory( CapCategory( c ) ) then
      
      TryNextMethod( );
      
    fi;
    
    return Shift( c, -1 );
    
end );

##
InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_TRIANGULATED_CATEGORY,
               IsCapCategory and IsTriangulatedCategory,
               0,

   function( category )

   AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "TriangulatedCategories", "LogicForTriangulatedCategories" ),
        "PredicateImplicationsForTriangulatedCategories.tex" ) );

   TryNextMethod( );

end );
