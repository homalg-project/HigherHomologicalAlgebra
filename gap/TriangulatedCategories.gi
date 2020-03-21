#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2020,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################

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
  cache_name := "MorphismIntoStandardConeObjectWithGivenStandardConeObject",
  return_type := "morphism"
),

MorphismFromStandardConeObjectWithGivenStandardConeObject := rec(
  installation_name := "MorphismFromStandardConeObjectWithGivenStandardConeObject",
  filter_list := [ "morphism", "object" ],
  io_type := [ [ "alpha", "cone_alpha" ], [ "cone_alpha", "sh_source_alpha" ] ],
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

WitnessIsomorphismIntoStandardConeObjectByExactTriangle := rec(
  installation_name := "WitnessIsomorphismIntoStandardConeObjectByExactTriangle",
  io_type := [ [ "alpha", "iota_alpha", "pi_alpha" ], [ "range_iota_alpha", "cone_alpha" ] ],
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "WitnessIsomorphismIntoStandardConeObjectByExactTriangle",
  return_type := "morphism_or_fail"
),

WitnessIsomorphismFromStandardConeObjectByExactTriangle := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByExactTriangle",
  io_type := [ [ "alpha", "iota_alpha", "pi_alpha" ], [ "cone_alpha", "range_iota_alpha" ] ],
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "WitnessIsomorphismFromStandardConeObjectByExactTriangle",
  return_type := "morphism_or_fail"
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
),

IsomorphismIntoShiftOfInverseShiftWithGivenObject := rec(
  installation_name := "IsomorphismIntoShiftOfInverseShiftWithGivenObject",
  filter_list := [ "object", "object" ],
  io_type := [ [ "s", "sh_o_rev_sh_s" ], [ "s", "alpha", "sh_o_rev_sh_s" ] ],
  cache_name := "IsomorphismIntoShiftOfInverseShiftWithGivenObject",
  return_type := "morphism"
),

IsomorphismIntoShiftOfInverseShift := rec(
  installation_name := "IsomorphismIntoShiftOfInverseShift",
  filter_list := [ "object" ],
  io_type := [ [ "s" ], [ "s", "alpha", "sh_o_rev_sh_s" ] ],
  cache_name := "IsomorphismIntoShiftOfInverseShift",
  return_type := "morphism"
),

IsomorphismIntoInverseShiftOfShiftWithGivenObject := rec(
  installation_name := "IsomorphismIntoInverseShiftOfShiftWithGivenObject",
  filter_list := [ "object", "object" ],
  io_type := [ [ "s", "rev_sh_o_sh_s" ], [ "s", "alpha", "rev_sh_o_sh_s" ] ],
  cache_name := "IsomorphismIntoInverseShiftOfShiftWithGivenObject",
  return_type := "morphism"
),

IsomorphismIntoInverseShiftOfShift := rec(
  installation_name := "IsomorphismIntoInverseShiftOfShift",
  filter_list := [ "object" ],
  io_type := [ [ "s" ], [ "s", "alpha", "rev_sh_o_sh_s" ] ],
  cache_name := "IsomorphismIntoInverseShiftOfShift",
  return_type := "morphism"
),

IsomorphismFromShiftOfInverseShiftWithGivenObject := rec(
  installation_name := "IsomorphismFromShiftOfInverseShiftWithGivenObject",
  filter_list := [ "object", "object" ],
  io_type := [ [ "s", "sh_o_rev_sh_s" ], [ "sh_o_rev_sh_s", "alpha", "s" ] ],
  cache_name := "IsomorphismFromShiftOfInverseShiftWithGivenObject",
  return_type := "morphism"
),

IsomorphismFromShiftOfInverseShift := rec(
  installation_name := "IsomorphismFromShiftOfInverseShift",
  filter_list := [ "object" ],
  io_type := [ [ "s" ], [ "sh_o_rev_sh_s", "alpha", "s" ] ],
  cache_name := "IsomorphismFromShiftOfInverseShift",
  return_type := "morphism"
),

IsomorphismFromInverseShiftOfShiftWithGivenObject := rec(
  installation_name := "IsomorphismFromInverseShiftOfShiftWithGivenObject",
  filter_list := [ "object", "object" ],
  io_type := [ [ "s", "rev_sh_o_sh_s" ], [ "rev_sh_o_sh_s", "alpha", "s" ] ],
  cache_name := "IsomorphismFromInverseShiftOfShiftWithGivenObject",
  return_type := "morphism"
),

IsomorphismFromInverseShiftOfShift := rec(
  installation_name := "IsomorphismFromInverseShiftOfShift",
  filter_list := [ "object" ],
  io_type := [ [ "s" ], [ "rev_sh_o_sh_s", "alpha", "s" ] ],
  cache_name := "IsomorphismFromInverseShiftOfShift",
  return_type := "morphism"
),

MorphismBetweenStandardConeObjectsWithGivenObjects := rec(
  installation_name := "MorphismBetweenStandardConeObjectsWithGivenObjects",
  filter_list := [ "object", "morphism", "morphism", "morphism", "morphism", "object" ],
  io_type := [ ["cone_alpha", "alpha",  "mu", "nu", "alpha_prime", "cone_alpha_prime" ], [ "cone_alpha", "cone_alpha_prime" ] ],
  cache_name := "MorphismBetweenStandardConeObjectsWithGivenObjects",
  return_type := [ "morphism" ],
  is_with_given := false
),

DomainMorphismByOctahedralAxiom := rec(
  installation_name := "DomainMorphismByOctahedralAxiom",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "DomainMorphismByOctahedralAxiom",
  return_type := [ "morphism" ],
),

MorphismIntoConeObjectByOctahedralAxiom := rec(
  installation_name := "MorphismIntoConeObjectByOctahedralAxiom",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "MorphismIntoConeObjectByOctahedralAxiom",
  return_type := [ "morphism" ],
),

MorphismFromConeObjectByOctahedralAxiom := rec(
  installation_name := "MorphismFromConeObjectByOctahedralAxiom",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "MorphismFromConeObjectByOctahedralAxiom",
  return_type := [ "morphism" ],
),

WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "morphism", "object" ],
  io_type := [ [ "cone_g", "f", "g", "st_cone" ], [ "cone_g", "st_cone" ] ],
  cache_name := "WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "g", "cone_g" ], [ "st_cone", "cone_g" ] ],
  cache_name := "WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  cache_name := "WitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  cache_name := "WitnessIsomorphismFromStandardConeObjectByRotationAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "object" ],
  io_type := [ [ "cone", "f", "st_cone" ], [ "cone", "st_cone" ] ],
  cache_name := "WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects := rec(
  installation_name := "WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  filter_list := [ "object", "morphism", "object" ],
  io_type := [ [ "st_cone", "f", "cone" ], [ "st_cone", "cone" ] ],
  cache_name := "WitnessIsomorphismFromStandardConeObjectByInverseRotationAxiomWithGivenObjects",
  return_type := [ "morphism" ],
),

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
          [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta )
    
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
InstallMethod( WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta )
    local s, u, r;
    
    s := ConeObjectByOctahedralAxiom( alpha, beta );
    
    u := DomainMorphismByOctahedralAxiom( alpha, beta );
     
    r := StandardConeObject( u );
    
    return WitnessIsomorphismIntoStandardConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, r );
      
end );

##
InstallMethod( WitnessIsomorphismFromStandardConeObjectByOctahedralAxiom,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
  function( alpha, beta )
    local s, u, r;
    
    u := DomainMorphismByOctahedralAxiom( alpha, beta );
     
    s := StandardConeObject( u );

    r := ConeObjectByOctahedralAxiom( alpha, beta );
        
    return WitnessIsomorphismFromStandardConeObjectByOctahedralAxiomWithGivenObjects( s, alpha, beta, r );
      
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
              IsomorphismIntoShiftOfInverseShift( StandardConeObject( alpha ) )
            );
    
end );

##
InstallMethod( WitnessIsomorphismIntoStandardConeObjectByRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByRotationAxiom( alpha ) );
    
    return WitnessIsomorphismIntoStandardConeObjectByRotationAxiomWithGivenObjects( s, alpha, r );
    
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
InstallMethod( WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiom,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local s, r;
    
    s := ConeObjectByInverseRotationAxiom( alpha );
    
    r := StandardConeObject( DomainMorphismByInverseRotationAxiom( alpha ) );
    
    return WitnessIsomorphismIntoStandardConeObjectByInverseRotationAxiomWithGivenObjects( s, alpha, r );
    
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

###
#InstallMethod( TrivialExactTriangle,
#                [ IsCapCategoryObject ],
#    function( obj )
#    local T, i, j, can_triangle;
#
#    T := CreateExactTriangle( IdentityMorphism( obj ), UniversalMorphismIntoZeroObject( obj ), UniversalMorphismFromZeroObject( ShiftOnObject( obj ) ) );
#    can_triangle := CompleteMorphismToStandardExactTriangle( IdentityMorphism( obj ) );
#
#    i := CreateTrianglesMorphism( T, can_triangle, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T, 1 ) ),
#                                                    UniversalMorphismFromZeroObject( ObjectAt( can_triangle, 2 ) ) );
#    j := CreateTrianglesMorphism( can_triangle, T, IdentityMorphism( ObjectAt( T, 0 ) ), IdentityMorphism( ObjectAt( T, 1 ) ),
#                                                    UniversalMorphismIntoZeroObject( ObjectAt( can_triangle, 2 ) ) );
#    SetIsomorphismFromStandardExactTriangle( T, j );
#    SetIsomorphismIntoStandardExactTriangle( T, i );
#
#    return T;
#
#end );
#
###
#InstallMethod( UnderlyingStandardExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#    function( T )
#
#    if IsCapCategoryStandardExactTriangle( T ) then
#        return T;
#    else
#        return CompleteMorphismToStandardExactTriangle( MorphismAt( T, 0 ) );
#    fi;
#
#end );
#
###
#InstallMethod( RotationOfExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                # the following -1000 implies that this method will be called only if there is no other option to compute the isomorphism.
#                -1000,
#    function( T )
#    local rT, iso_from_can_exact_tr, iso_into_can_exact_tr;
#
#    if IsCapCategoryStandardExactTriangle( T ) then
#        return RotationOfStandardExactTriangle( T );
#    fi;
#
#    rT := CreateExactTriangle( MorphismAt( T, 1 ), MorphismAt( T, 2 ), AdditiveInverse( ShiftOnMorphism( MorphismAt( T, 0 ) ) ) );
#
#    iso_into_can_exact_tr := function( T, rT )
#    local can_T, T_to_can_T, rcan_T, rT_to_rcan_T, rcan_T_to_can_rcan_T, can_rcan_T, can_rT, can_T_to_T, can_rcan_T_to_can_rT,iso;
#    can_T := UnderlyingStandardExactTriangle( T );
#    T_to_can_T := IsomorphismIntoStandardExactTriangle( T );
#    rcan_T := RotationOfStandardExactTriangle( can_T );
#    rT_to_rcan_T := CreateTrianglesMorphism( rT, rcan_T, MorphismAt( T_to_can_T, 1 ), MorphismAt( T_to_can_T, 2 ), MorphismAt( T_to_can_T, 3 ) );
#    rcan_T_to_can_rcan_T := IsomorphismIntoStandardExactTriangle( rcan_T );
#    can_rcan_T := UnderlyingStandardExactTriangle( rcan_T );
#    can_rT := UnderlyingStandardExactTriangle( rT );
#    can_T_to_T := IsomorphismFromStandardExactTriangle( T );
#    can_rcan_T_to_can_rT := CompleteToMorphismOfStandardExactTriangles( can_rcan_T, can_rT, MorphismAt( can_T_to_T, 1 ), MorphismAt( can_T_to_T, 2 ) );
#    iso := PreCompose( [ rT_to_rcan_T, rcan_T_to_can_rcan_T, can_rcan_T_to_can_rT ] );
#    Assert( 5, IsIsomorphism( iso[2] ) );
#    SetIsIsomorphism( iso, true );
#    return iso;
#    end;
#    AddToUnderlyingLazyMethods( rT, IsomorphismIntoStandardExactTriangle, iso_into_can_exact_tr, [T, rT ] );
#
#    iso_from_can_exact_tr := function( T, rT )
#    local rcan_T_to_rT, can_T, T_to_can_T, rcan_T, rT_to_rcan_T, can_rcan_T, can_rT, can_T_to_T, can_rcan_T_to_rcan_T, can_rT_to_can_rcan_T, iso;
#
#    can_T := UnderlyingStandardExactTriangle( T );
#    can_T_to_T := IsomorphismFromStandardExactTriangle( T );
#    rcan_T := RotationOfStandardExactTriangle( can_T );
#    T_to_can_T := IsomorphismIntoStandardExactTriangle( T );
#    can_rcan_T := UnderlyingStandardExactTriangle( rcan_T );
#    can_rT := UnderlyingStandardExactTriangle( rT );
#    rcan_T_to_rT := CreateTrianglesMorphism( rcan_T, rT, MorphismAt( can_T_to_T, 1 ), MorphismAt( can_T_to_T, 2 ), MorphismAt( can_T_to_T, 3 ) );
#    can_rcan_T_to_rcan_T := IsomorphismFromStandardExactTriangle( rcan_T );
#    can_rT_to_can_rcan_T := CompleteToMorphismOfStandardExactTriangles( can_rT, can_rcan_T, MorphismAt( T_to_can_T, 1 ), MorphismAt( T_to_can_T, 2 ) );
#    iso := PreCompose( [ can_rT_to_can_rcan_T, can_rcan_T_to_rcan_T, rcan_T_to_rT ] );
#    Assert( 5, IsIsomorphism( iso[2] ) );
#    SetIsIsomorphism( iso, true );
#    return iso;
#    end;
#    AddToUnderlyingLazyMethods( rT, IsomorphismFromStandardExactTriangle, iso_from_can_exact_tr, [T, rT ] );
#
#    return rT;
#
#end );
#
#
##\begin{tikzcd}
##A \arrow[r, "f"] & B \arrow[r, "g"] & C \arrow[r, "h"] \arrow[d, "u", two heads, tail] & A[1] &  &  &  & C[-1] \arrow[r, "{-h[-1]}"] \arrow[d, "{u[-1]}"'] & A \arrow[r, "f"] & B \arrow[r, "g"] & C \arrow[d, "u"] \\
##A \arrow[r, "f"'] & B \arrow[r, "\alpha(f)"'] & C(f) \arrow[r, "\beta(f)"'] & A[1] &  &  &  & C(f)[-1] \arrow[r, "{-\beta(f)[-1]}"'] & A \arrow[r, "f"'] & B \arrow[r, "\alpha(f)"'] \arrow[d, "t"] & C(f) \\
## &  &  &  &  &  &  & C(f)[-1] \arrow[r, "{-\beta(f)[-1]}"] \arrow[d, "{u[-1]^{-1}}"'] & A \arrow[r, "\alpha(*)"] & C(\beta(f)[-1]) \arrow[r, "\beta(*)"] \arrow[d, "s"] & C(f) \arrow[d, "u^{-1}"] \\
## &  &  &  &  &  &  & C[-1] \arrow[r, "{-h[-1]}"'] & A \arrow[r, "{\alpha(-h[-1])}"'] & C(h[-1]) \arrow[r, "{\beta(-h[-1])}"'] & C
##\end{tikzcd}
#
#InstallMethod( InverseRotationOfExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                -1000,
#    function( T )
#    local can_T, T_to_can_T, can_T_to_T, rT, rcan_T, rT_to_rcan_T, rcan_T_to_rT, can_rcan_T,
#       rcan_T_to_can_rcan_T, can_rcan_T_to_rcan_T, can_rT, can_rcan_T_to_can_rT, can_rT_to_can_rcan_T;
#
#    if not HasIsTriangulatedCategoryWithShiftAutomorphism( UnderlyingCapCategory( T ) ) then
#        Error( "Its not known wether the shift functor is automorphism!" );
#    fi;
#
#    if not IsTriangulatedCategoryWithShiftAutomorphism( UnderlyingCapCategory( T ) ) then
#        Error( "The shift-functor that defines the triangulated struture must be automorphism!" );
#    fi;
#
#    if IsCapCategoryStandardExactTriangle( T ) then
#        return InverseRotationOfStandardExactTriangle( T );
#    fi;
#
#    can_T := UnderlyingStandardExactTriangle( T );
#    T_to_can_T := IsomorphismIntoStandardExactTriangle( T );
#    can_T_to_T := IsomorphismFromStandardExactTriangle( T );
#
#    rT := CreateExactTriangle( AdditiveInverse(InverseShiftOnMorphism( MorphismAt( T, 2 ) ) ), MorphismAt( T, 0), MorphismAt( T, 1 ) );
#    rcan_T := InverseRotationOfStandardExactTriangle( can_T );
#
#    rT_to_rcan_T := CreateTrianglesMorphism( rT, rcan_T, InverseShiftOnMorphism( MorphismAt( T_to_can_T, 2 ) ),
#                                                        MorphismAt( T_to_can_T, 0 ),
#                                                        MorphismAt( T_to_can_T, 1 ) );
#
#    rcan_T_to_rT := CreateTrianglesMorphism( rcan_T, rT, InverseShiftOnMorphism( MorphismAt( can_T_to_T, 2 ) ),
#                                                        MorphismAt( can_T_to_T, 0 ),
#                                                        MorphismAt( can_T_to_T, 1 ) );
#
#
#    can_rcan_T := UnderlyingStandardExactTriangle( rcan_T );
#    rcan_T_to_can_rcan_T := IsomorphismIntoStandardExactTriangle( rcan_T );
#    can_rcan_T_to_rcan_T := IsomorphismFromStandardExactTriangle( rcan_T );
#
#    can_rT := UnderlyingStandardExactTriangle( rT );
#
#    can_rcan_T_to_can_rT := CompleteToMorphismOfStandardExactTriangles( can_rcan_T, can_rT,
#                                InverseShiftOnMorphism( MorphismAt( can_T_to_T, 2 ) ), MorphismAt( can_T_to_T, 0 ) );
##    can_rcan_T_to_can_rT := CreateTrianglesMorphism( can_rcan_T, can_rT,
##                                InverseShiftOnMorphism( MorphismAt( can_T_to_T, 2 ) ), MorphismAt( can_T_to_T, 0 ), can_rcan_T_to_can_rT );
#
#    can_rT_to_can_rcan_T := CompleteToMorphismOfStandardExactTriangles( can_rT, can_rcan_T,
#                                InverseShiftOnMorphism( MorphismAt( T_to_can_T, 2 ) ), MorphismAt( T_to_can_T, 0 ) );
##    can_rT_to_can_rcan_T := CreateTrianglesMorphism( can_rT, can_rcan_T,
##                                InverseShiftOnMorphism( MorphismAt( T_to_can_T, 2 ) ), MorphismAt( T_to_can_T, 0 ), can_rT_to_can_rcan_T );
#
#    SetIsomorphismIntoStandardExactTriangle(   rT, PreCompose( [ rT_to_rcan_T, rcan_T_to_can_rcan_T, can_rcan_T_to_can_rT ] ) );
#    SetIsomorphismFromStandardExactTriangle( rT, PreCompose( [ can_rT_to_can_rcan_T, can_rcan_T_to_rcan_T, rcan_T_to_rT ] ) );
#
#    return rT;
#
#end );
#
#InstallMethod( CompleteToMorphismOfExactTriangles,
#                [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism ],
#                -1000,
#    function( T1, T2, m0, m1 )
#    local can_T1, can_T2, T1_to_can_T1, T2_to_can_T2, can_T1_to_T1, can_T2_to_T2, can_T1_to_can_T2,
#        can_T1_to_can_T2_0, can_T1_to_can_T2_1;
#
#    if IsCapCategoryStandardExactTriangle( T1 ) and IsCapCategoryStandardExactTriangle( T2 ) then
#        return CompleteToMorphismOfStandardExactTriangles( T1, T2, m0, m1 );
#    fi;
#
#    can_T1 := UnderlyingStandardExactTriangle( T1 );
#    can_T2 := UnderlyingStandardExactTriangle( T2 );
#
#    T1_to_can_T1 := IsomorphismIntoStandardExactTriangle( T1 );
#    can_T1_to_T1 := IsomorphismFromStandardExactTriangle( T1 );
#
#    T2_to_can_T2 := IsomorphismIntoStandardExactTriangle( T2 );
#    can_T2_to_T2 := IsomorphismFromStandardExactTriangle( T2 );
#
#    can_T1_to_can_T2_0 := PreCompose( [ MorphismAt( can_T1_to_T1, 0 ), m0, MorphismAt( T2_to_can_T2, 0 ) ] );
#    can_T1_to_can_T2_1 := PreCompose( [ MorphismAt( can_T1_to_T1, 1 ), m1, MorphismAt( T2_to_can_T2, 1 ) ] );
#    can_T1_to_can_T2 := CompleteToMorphismOfStandardExactTriangles( can_T1, can_T2, can_T1_to_can_T2_0, can_T1_to_can_T2_1 );
#    return PreCompose( [ T1_to_can_T1, can_T1_to_can_T2, can_T2_to_T2 ] );
#
#end );
#

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
#InstallMethod( IsomorphismIntoStandardExactTriangle,
#                [ IsCapCategoryExactTriangle ],
#                -1000,
#    function( T )
#    local F, p;
#    F := T!.UnderlyingLazyMethods;
#    if not IsomorphismIntoStandardExactTriangle in F then
#        TryNextMethod( );
#    else
#        p := Position( F, IsomorphismIntoStandardExactTriangle );
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
      Error( "The ambient category should be a triangulated category!" );
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
#
#InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_TRIANGULATED_CATEGORY,
#               IsCapCategory and IsTriangulatedCategory,
#               0,
#
#   function( category )
#
#   AddPredicateImplicationFileToCategory( category,
#      Filename(
#        DirectoriesPackageLibrary( "TriangulatedCategories", "LogicForTriangulatedCategories" ),
#        "PredicateImplicationsForTriangulatedCategories.tex" ) );
#
#   TryNextMethod( );
#
#end );
