# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#
## Random methods
##

EnhancePackage( "RingsForHomalg" );

RRANDOM_MODULE_PRESENTATION :=
  function( category, L, left_or_right )
    local homalg_ring, mat;
    
    homalg_ring := category!.ring_for_representation_category;
    
    if Length( L ) <> 2 then
      
      Error( "The list should have two entries" );
    
    fi;
    
    if not ForAll( L, l -> IsInt( l ) ) then
      
      Error( "The entries of the list should be integers" );
    
    fi;
    
    if ForAll( L, l -> l < 0 ) then
      
      return fail;
    
    fi;
    
    mat := homalg_ring!.random_matrix_func( L[ 1 ], L[ 2 ] );
    
    if left_or_right = "left" then
      
      return AsLeftPresentation( mat );
    
    else
      
      return AsRightPresentation( mat );
    
    fi;
    
end;

##
## Interpretation of n:
## The number of rows and colms of the matrix of the object is less or equal to n.
ADD_RRANDOM_OBJECT_FOR_MODULE_PRESENTATIONS :=

  function( category, left_or_right )
    
    AddRandomObjectByInteger( category,
      
      function( cat, n )
        
        if n < 0 then
          
          return fail;
        
        fi;
        
        if left_or_right = "left" then
          
          return RRANDOM_MODULE_PRESENTATION( cat, [ Random( [ Int( n/2 ) .. Int( 3*n/2 ) ] ), n ], "left" );
        
        else
          
          return RRANDOM_MODULE_PRESENTATION( cat, [ n, Random( [ Int( n/2 ) .. Int( 3*n/2 ) ] ) ], "right" );
        
        fi;
      
      end );
    
end;

##
## Interpretation of n:
## The number of relations of the range of the created random morphism is n.
ADD_RRANDOM_MORPHISM_WITH_FIXED_SOURCE_LEFT_FOR_MODULE_PRESENTATIONS :=
    function( category )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      
      AddRandomMorphismWithFixedSourceByInteger( category,
        function( cat, M, n )
          local m, y, syz, x, u, U, e;
          
          if n < 0 then
            
            return fail;
          
          fi;
          
          m := UnderlyingMatrix( M );
          
          y := homalg_ring!.random_matrix_func( NrRows( m ), n );
          
          syz := SyzygiesOfColumns( UnionOfColumns( m, y ) );
          
          syz := syz * homalg_ring!.random_matrix_func( NrCols( syz ), Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ) );
          
          x := CertainRows( syz, [ 1 .. NrCols( m ) ] );
          
          u := CertainRows( syz, [ NrCols( m ) + 1 .. NrRows( syz ) ] );
          
          U := AsLeftPresentation( u );
          
          return PresentationMorphism( M, x, U );
    
        end );
    
end;

##
## Interpretation of n:
## The number of generators of the source of the created random morphism is n.
ADD_RRANDOM_MORPHISM_WITH_FIXED_RANGE_LEFT_FOR_MODULE_PRESENTATIONS :=
    function( category )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      
      
      AddRandomMorphismWithFixedRangeByInteger( category,
        function( cat, U, n )
          local u, x, syz, m, M, e;
          
          if n < 0 then
            
            return fail;
          
          fi;
          
          if n = 0 then
            
            return UniversalMorphismFromZeroObject( U );
          
          fi;
          
          u := UnderlyingMatrix( U );
          
          x := homalg_ring!.random_matrix_func( n, NrCols( u ) );
          
          syz := SyzygiesOfRows( UnionOfRows( x, u ) );
          
          syz := homalg_ring!.random_matrix_func( Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ), NrRows( syz ) ) * syz;
          
          m := CertainColumns( syz, [ 1 .. NrRows( x ) ] );
          
          M := AsLeftPresentation( m );
          
          return PresentationMorphism( M, x, U );
    
      end );
    
end;

##
ADD_RRANDOM_MORPHISM_WITH_FIXED_SOURCE_RIGHT_FOR_MODULE_PRESENTATIONS :=
    function( category )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      
      AddRandomMorphismWithFixedSourceByInteger( category,
        function( cat, U, n )
          local u, x, syz, e, m, M, y;
          
          if n < 0 then
            
            return fail;
            
          fi;
          
          u := UnderlyingMatrix( U );
          
          x := homalg_ring!.random_matrix_func( n, NrCols( u ) );
          
          syz := SyzygiesOfRows( UnionOfRows( x, u ) );
          
          syz := homalg_ring!.random_matrix_func( Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ), NrRows( syz ) ) * syz;
          
          m := CertainColumns( syz, [ 1 .. NrRows( x ) ] );
          
          M := AsRightPresentation( m );
          
          y := CertainColumns( syz, [ NrRows( x ) + 1 .. NrCols( syz ) ] );
          
          # Now: m*x + y*u = 0
          return PresentationMorphism( U, y, M );
    
    end );
    
end;

##
ADD_RRANDOM_MORPHISM_WITH_FIXED_RANGE_RIGHT_FOR_MODULE_PRESENTATIONS:= 
    function( category )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      
      AddRandomMorphismWithFixedRangeByInteger( category,
        function( cat, M, n )
          local m, y, syz, e, u, U;
          
          if n < 0 then
            
            return fail;
          
          fi;
          
          if n = 0 then
            
            return UniversalMorphismFromZeroObject( M );
            
          fi;
          
          m := UnderlyingMatrix( M );
          
          y := homalg_ring!.random_matrix_func( NrRows( m ), n );
          
          syz := SyzygiesOfColumns( UnionOfColumns( m, y ) );
          
          syz := syz * homalg_ring!.random_matrix_func( NrCols( syz  ), Random( [ Int( n/2 ) + 1 .. Int( 3*n/2 ) + 1 ] ) );
          
          u := CertainRows( syz, [ NrCols( m ) + 1 .. NrRows( syz ) ] );
          
          U := AsRightPresentation( u );
          
          return PresentationMorphism( U, y, M );
          
     end );
    
end;

## In this method: we find a random linear combination of random elements in Hom(M,N) with coefficients |n|-powers of random ring elements.
##

ADD_RRANDOM_MORPHISM_WITH_FIXED_SOURCE_AND_RANGE_FOR_MODULE_PRESENTATIONS:=
    function( category, left_or_right )
      local homalg_ring;
      
      homalg_ring := category!.ring_for_representation_category;
      
      AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
        function( cat, M, N, n )
          local H, nr_generators, random_positions, maps;
          
          H := InternalHomOnObjects( M, N );
          
          if left_or_right = "left" then
            
            nr_generators := NrCols( UnderlyingMatrix( H ) );
            
          else
            
            nr_generators := NrRows( UnderlyingMatrix( H ) );
            
          fi;
          
          if nr_generators = 0 then
            
            return ZeroMorphism( M, N );
            
          fi;
          
          random_positions := List( [ 1 .. Random( [ 1 .. nr_generators ] ) ], i -> Random( [ 1 .. nr_generators ] ) );
          
          maps := List( random_positions, p -> StandardGeneratorMorphism( H, p ) );
          
          if left_or_right = "left" then
            
            maps := List( maps, map ->
                    homalg_ring!.random_element_func(  )^AbsInt( n ) * InternalHomToTensorProductAdjunctionMap( M, N, map ) );
          
          else
            
            maps := List( maps, map -> InternalHomToTensorProductAdjunctionMap( M, N, map ) * homalg_ring!.random_element_func(  ) );
          
          fi;
          
          return Sum( maps );
    
        end );
    
end;

ADD_RRANDOM_METHODS_TO_MODULE_PRESENTATIONS :=
  function( category, left_or_right )
    local S;

    S := category!.ring_for_representation_category;
    
    if not EnhanceHomalgRingWithRandomFunctions( S ) = true then
      
      Finalize( category );
      
      return;
      
    fi;
    
    if left_or_right = "left"  then
      
      ADD_RRANDOM_OBJECT_FOR_MODULE_PRESENTATIONS( category, "left" );
      
      ADD_RRANDOM_MORPHISM_WITH_FIXED_SOURCE_LEFT_FOR_MODULE_PRESENTATIONS( category );
      
      ADD_RRANDOM_MORPHISM_WITH_FIXED_RANGE_LEFT_FOR_MODULE_PRESENTATIONS( category );
      
      if HasIsCommutative( S ) and IsCommutative( S ) then
        
        ADD_RRANDOM_MORPHISM_WITH_FIXED_SOURCE_AND_RANGE_FOR_MODULE_PRESENTATIONS( category, "left" );
        
      fi;
      
    elif left_or_right = "right" then
      
      ADD_RRANDOM_OBJECT_FOR_MODULE_PRESENTATIONS( category, "right" );
      
      ADD_RRANDOM_MORPHISM_WITH_FIXED_SOURCE_RIGHT_FOR_MODULE_PRESENTATIONS( category );
      
      ADD_RRANDOM_MORPHISM_WITH_FIXED_RANGE_RIGHT_FOR_MODULE_PRESENTATIONS( category );
      
      if HasIsCommutative( S ) and IsCommutative( S ) then
        
        ADD_RRANDOM_MORPHISM_WITH_FIXED_SOURCE_AND_RANGE_FOR_MODULE_PRESENTATIONS( category, "right" );
      
      fi;
      
    fi;
    
    Finalize( category );
  
end;

##
InstallMethod( LeftPresentations,
          [ IsHomalgRing ],
          
  function( S )
    local random_methods, cat;
    
    random_methods := ValueOption( "RandomMethod_ToolsForHigherHomologicalAlgebra" );
    
    if random_methods = false then
      TryNextMethod( );
    fi;
    
    cat := LeftPresentations( S : FinalizeCategory := false, RandomMethod_ToolsForHigherHomologicalAlgebra := false );
     
    ADD_RRANDOM_METHODS_TO_MODULE_PRESENTATIONS( cat, "left" );
    
    return cat;
    
end, 100 );

##
InstallMethod( RightPresentations,
          [ IsHomalgRing ],
  function( S )
    local random_methods, cat;
    
    random_methods := ValueOption( "RandomMethod_ToolsForHigherHomologicalAlgebra" );
    
    if random_methods = false then
      TryNextMethod( );
    fi;
    
    cat := RightPresentations( S : FinalizeCategory := false, RandomMethod_ToolsForHigherHomologicalAlgebra := false );
    
    ADD_RRANDOM_METHODS_TO_MODULE_PRESENTATIONS( cat, "right" );
    
    return cat;
    
end );

##
InstallMethod( LaTeXOutput,
               [ IsLeftOrRightPresentation ],
  function( object )
    local rel, ring_name, rel_dat;
    
    rel := UnderlyingMatrix( object );
    
    ring_name := LaTeXOutput( HomalgRing( rel ) );
    
    rel_dat := LaTeXOutput( rel );
    
    if IsLeftPresentation( object ) then
      return
       Concatenation(
        "\\big(",
        ring_name,
        "^{1\\times ",
        String( NrRows( rel ) ),
        "}",
        "\\xrightarrow{",
        rel_dat,
        "}",
        ring_name,
        "^{1\\times ",
        String( NrCols( rel ) ),
        "}",
        "\\big)_{",
        ring_name,
        "\\mbox{-fpres}",
        "}"
      );
      
    else
      
      return
       Concatenation(
        "\\big(",
        ring_name,
        "^{",
        String( NrCols( rel ) ),
        "\\times 1}",
        "\\xrightarrow{",
        rel_dat,
        "}",
        ring_name,
        "^{",
        String( NrRows( rel ) ),
        "\\times 1}",
        "\\big)_{",
        "\\mbox{fpres-}",
        ring_name,
        "}"
      );
    
    fi;
    
end );

##
InstallMethod( LaTeXOutput,
          [ IsLeftOrRightPresentationMorphism ],
          
  function( mor )
    local datum;
    
    datum := LaTeXOutput( UnderlyingMatrix( mor ) );
    
    if ValueOption( "OnlyDatum" ) = true then
       
       return Concatenation(
        """{\color{blue}{""",
        datum,
        """}}"""
      );
      
    else
      
      return Concatenation(
        "{ \\tiny ", LaTeXOutput( Source( mor ) ), "}",
        """{\color{blue}{\xrightarrow{""",
        datum,
        """}}}""",
        "{ \\tiny ", LaTeXOutput( Range( mor ) ), "}"
      );
      
    fi;
    
end );

##
functor :=
  [
    c1 -> IsBound( c1!.ring_for_representation_category ),
    IsFreydCategory,
    { c1, c2 } -> IsCategoryOfRows( UnderlyingCategory( c2 ) ) and
                    IsIdenticalObj(
                        c1!.ring_for_representation_category,
                        UnderlyingRing( UnderlyingCategory( c2 ) )
                      ),
    function( c1, c2 )
      local name, F;
      
      name := "Isomorphism from the category of finite left presentations to the equivalent Freyd category";
      
      F := CapFunctor( name, c1, c2 );
      
      AddObjectFunction( F, o -> UnderlyingMatrix( o ) / c2 );
      
      AddMorphismFunction( F, { s, phi, r } -> FreydCategoryMorphism( s, UnderlyingMatrix( phi ) / UnderlyingCategory( c2 ), r ) );
      
      return F;
      
    end,
    "Isomorphism functor",
    "Isomorphism from the category of finite left presentations to the equivalent Freyd category"
  ];

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
if IsPackageLoaded( "homotopycategories" ) then
  ExtendFunctorMethodToHomotopyCategories( functor );
fi;

##
functor :=
  [
  
    IsFreydCategory,
    c1 -> IsBound( c1!.ring_for_representation_category ),
    { c2, c1 } -> IsCategoryOfRows( UnderlyingCategory( c2 ) ) and
                    IsIdenticalObj(
                        c1!.ring_for_representation_category,
                        UnderlyingRing( UnderlyingCategory( c2 ) )
                      ),
    function( c2, c1 )
      local name, F;
      
      name := "Isomorphism from Freyd category of rows to the equivalent category of finite left presentations";
      
      F := CapFunctor( name, c2, c1 );
      
      AddObjectFunction( F, o -> AsLeftPresentation( UnderlyingMatrix( RelationMorphism( o ) ) ) );
      
      AddMorphismFunction( F, { s, phi, r } -> PresentationMorphism( s, UnderlyingMatrix( MorphismDatum( phi ) ), r ) );
      
      return F;
      
    end,
    "Isomorphism functor",
    "Isomorphism from Freyd category of rows to the equivalent category of left finite presentations",
  ];

AddFunctor( functor );
ExtendFunctorMethodToComplexCategories( functor );
if IsPackageLoaded( "homotopycategories" ) then
  ExtendFunctorMethodToHomotopyCategories( functor );
fi;
