# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#
InstallMethod( Algebroid,
          [ IsQuiverAlgebra ],
          
  function( A )
    local v, algebroid, name, r;
    
    v := ValueOption( "Algebroid_ToolsForHigherHomologicalAlgebra" );
    
    if v = false then
      
      TryNextMethod( );
      
    fi;
    
    algebroid := Algebroid( A : Algebroid_ToolsForHigherHomologicalAlgebra := false );
    
    if HasTensorProductFactors( A ) then
      
      name := List( TensorProductFactors( A ), Name );
      
      name := JoinStringsWithSeparator( name, "⊗ " );
      
      A!.alternative_name := name;
      
    elif HasName( A ) then
      
      A!.alternative_name := Name( A );
      
    else
      
      A!.alternative_name := String( A );
      
    fi;
    
    name := A!.alternative_name;
    
    r := RandomTextColor( "" );
    
    algebroid!.Name := Concatenation( r[ 1 ], "Algebroid( ", r[ 2 ], name, r[ 1 ], " )", r[ 2 ] );
    
    return algebroid;
    
end );

##
functor :=
  [
    IsQuiverRowsCategory,
    IsAdditiveClosureCategory,
    { c1, c2 } -> IsAlgebroid( UnderlyingCategory( c2 ) ) and
                    IsIdenticalObj(
                        UnderlyingQuiver( c1 ),
                        UnderlyingQuiver( UnderlyingCategory( c2 ) )
                      ),
    { c1, c2 } -> IsomorphismOntoAdditiveClosureOfAlgebroid( c1 ),
    "Isomorphism from quiver rows category onto the additive closure of algebroid"
  ];

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
if IsPackageLoaded( "homotopycategories" ) then
  ExtendFunctorMethodToHomotopyCategories( functor );
fi;

##
functor :=
  [
    IsAdditiveClosureCategory,
    IsQuiverRowsCategory,
    { c1, c2 } -> IsAlgebroid( UnderlyingCategory( c1 ) ) and
                    IsIdenticalObj(
                      UnderlyingQuiver( c2 ),
                      UnderlyingQuiver( UnderlyingCategory( c1 ) )
                    ),
    { c1, c2 } -> IsomorphismFromAdditiveClosureOfAlgebroid( c2 ),
    "Isomorphism from additive closure of algebroid onto quiver rows category"
  ];

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
if IsPackageLoaded( "homotopycategories" ) then
  ExtendFunctorMethodToHomotopyCategories( functor );
fi;
