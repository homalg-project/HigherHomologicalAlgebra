# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#
#

##
InstallMethod( LaTeXOutput,
          [ IsVectorSpaceObject ],
          
  function( a )
    
    return Concatenation( "{", LaTeXOutput( UnderlyingRing( CapCategory( a ) ) ), "}^{1\\times ", String( Dimension( a ) ), "}" );
    
end );

##
InstallMethod( LaTeXOutput,
          [ IsVectorSpaceMorphism ],
          
  function( alpha )
    local datum, only_datum;
    
    datum := LaTeXOutput( UnderlyingMatrix( alpha ) );
    
    only_datum := ValueOption( "OnlyDatum" );
    
    if only_datum = true then
      
      return datum;
      
    else
      
      return Concatenation(
                LaTeXOutput( Source( alpha ) ),
                "\\xrightarrow{",
                datum,
                "}",
                LaTeXOutput( Range( alpha ) )
              );
              
    fi;
    
end );

##
InstallMethod( RandomObjectByList,
          [ IsMatrixCategory, IsList ],
          
  function( category, L )
    local homalg_field, n;
    
    homalg_field := UnderlyingRing( category );
    
    if Length( L ) = 0 then
      
      Error( "The list should not be empty" );
    
    fi;
    
    if not ForAll( L, IsInt ) then
      
      Error( "All entries in the list should be integers" );
    
    fi;
    
    n := Random( L );
    
    if n < 0 then
      
      return fail;
    
    fi;
    
    return VectorSpaceObject( n, homalg_field );
    
end );

##
## entries of the matrix are linear combinations of elements in L
##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByList,
          [ IsVectorSpaceObject, IsVectorSpaceObject, IsList ],
          
  function( a, b, L )
    local category, homalg_field, entries, matrix;
    
    category := CapCategory( a );
    
    homalg_field := UnderlyingRing( category );
    
    if Length( L ) = 0 then
      
      Error( "The list should not be empty" );
    
    fi;
    
    if not ForAll( L, l -> l = l/homalg_field ) then
      
      Error( Concatenation( "All elements in the list should belong to ", String( homalg_field ) ) );
    
    fi;
    
    entries := List( [ 1 .. Dimension( a ) ], i -> List( [ 1 .. Dimension( b ) ],
                 j -> RandomMat( 1, Length( L ) )[ 1 ] * L ) );
    
    matrix := HomalgMatrix( entries, Dimension( a ), Dimension( b ), homalg_field );
    
    return VectorSpaceMorphism( a, matrix, b );
    
end );

##
## alpha: a --> b, dim(b) = L[1] and entries of matrix are linear combinations of elements in L[2]
##
InstallMethod( RandomMorphismWithFixedSourceByList,
          [ IsVectorSpaceObject, IsList ],
          
  function( a, L )
    local category, homalg_field, b, entries, matrix;
    
    category := CapCategory( a );
    
    homalg_field := UnderlyingRing( category );
    
    if not ( IsInt( L[ 1 ] ) and L[ 1 ] >= 0 ) then
      
      Error( "The first entry should be an integer greater or equal to 0" );
    
    fi;
    
    if not IsList( L[ 2 ] ) then
      
      Error( "The second entry should be a list" );
    
    fi;
    
    if Length( L[ 2 ] ) = 0 then
      
      Error( "The second entry should not be an empty list" );
    
    fi;
    
    if not ForAll( L[ 2 ], l -> l = l/homalg_field ) then
      
      Error( Concatenation( "All elements in the second entry list should belong to ", String( homalg_field ) ) );
    
    fi;
    
    b := VectorSpaceObject( L[ 1 ], homalg_field );
    
    entries := List( [ 1 .. Dimension( a ) ], i -> List( [ 1 .. Dimension( b ) ],
                 j -> RandomMat( 1, Length( L[ 2 ] ) )[ 1 ] * L[ 2 ] ) );
    
    matrix := HomalgMatrix( entries, Dimension( a ), Dimension( b ), homalg_field );
    
    return VectorSpaceMorphism( a, matrix, b );

end );

##
## alpha: a --> b, dim(a) = L[1] and entries of matrix are linear combinations of elements in L[2]
##
InstallMethod( RandomMorphismWithFixedRangeByList,
          [ IsVectorSpaceObject, IsList ],
          
  function( b, L )
    local category, homalg_field, a, entries, matrix;
    
    category := CapCategory( b );
    
    homalg_field := UnderlyingRing( category );
    
    if not ( IsInt( L[ 1 ] ) and L[ 1 ] >= 0 ) then
      
      Error( "The first entry should be an integer greater or equal to 0" );
    
    fi;
    
    if not IsList( L[ 2 ] ) then
      
      Error( "The second entry should be a list" );
    
    fi;
    
    if Length( L[ 2 ] ) = 0 then
      
      Error( "The second entry should not be an empty list" );
    
    fi;
    
    if not ForAll( L[ 2 ], l -> l = l/homalg_field ) then
      
      Error( Concatenation( "All elements in the second entry list should belong to ", String( homalg_field ) ) );
    
    fi;
    
    a := VectorSpaceObject( L[ 1 ], homalg_field );
    
    entries := List( [ 1 .. Dimension( a ) ], i -> List( [ 1 .. Dimension( b ) ],
                 j -> RandomMat( 1, Length( L[ 2 ] ) )[ 1 ] * L[ 2 ] ) );
    
    matrix := HomalgMatrix( entries, Dimension( a ), Dimension( b ), homalg_field );
    
    return VectorSpaceMorphism( a, matrix, b );
    
end );

##
## alpha: a --> b, dim(a) = L[1], dim(b) = L[2] and entries of matrix are linear combinations of elements in L[3]
##
InstallMethod( RandomMorphismByList,
          [ IsMatrixCategory, IsList ],
          
  function( category, L )
    local homalg_field, a, b, entries, matrix;
    
    homalg_field := UnderlyingRing( category );
    
    if not ( IsInt( L[ 1 ] ) and L[ 1 ] >= 0 ) then
      
      Error( "The first entry should be an integer greater or equal to 0" );
    
    fi;
    
    if not ( IsInt( L[ 2 ] ) and L[ 2 ] >= 0 ) then
      
      Error( "The second entry should be an integer greater or equal to 0" );
    
    fi;
    
    if not IsList( L[ 3 ] ) then
      
      Error( "The third entry should be a list" );
    
    fi;
    
    if Length( L[ 3 ] ) = 0 then
      
      Error( "The third entry should not be an empty list" );
    
    fi;
    
    if not ForAll( L[ 3 ], l -> l = l/homalg_field  ) then
      
      Error( Concatenation( "All elements in the third entry list should belong to ", String( homalg_field ) ) );
    
    fi;
    
    a := VectorSpaceObject( L[ 1 ], homalg_field );
    
    b := VectorSpaceObject( L[ 2 ], homalg_field );
    
    entries := List( [ 1 .. Dimension( a ) ], i -> List( [ 1 .. Dimension( b ) ],
               j -> RandomMat( 1, Length( L[ 3 ] ) )[ 1 ] * L[ 3 ] ) );
    
    matrix := HomalgMatrix( entries, Dimension( a ), Dimension( b ), homalg_field );
    
    return VectorSpaceMorphism( a, matrix, b );
    
end );

##
## Interpretation: the output has dimension at most n.
##
InstallMethod( RandomObjectByInteger,
          [ IsMatrixCategory, IsInt ],
          
    function( category, n )
      
      if n < 0 then
        
        return fail;
      
      fi;
      
      return RandomObjectByList( category, [ 0 .. n ] );
  
end );

##
## Interpretation: the range of the output has dimension n.
##
InstallMethod( RandomMorphismWithFixedSourceByInteger,
          [ IsVectorSpaceObject, IsInt ],
          
  function( a, n )
    local category, homalg_field;
    
    category := CapCategory( a );
    
    homalg_field := UnderlyingRing( category );
    
    if n < 0 then
      
      return fail;
      
    fi;
    
    return RandomMorphismWithFixedSourceByList( a, [ n, [ -50 .. 50 ] * One( homalg_field ) ] );
    
end );

##
## Interpretation: the source of the output has dimension n.
##
InstallMethod( RandomMorphismWithFixedRangeByInteger,
          [ IsVectorSpaceObject, IsInt ],
          
  function( b, n )
    local category, homalg_field;
    
    category := CapCategory( b );
    
    homalg_field := UnderlyingRing( category );
    
    if n < 0 then
      
      return fail;
    
    fi;
    
    return RandomMorphismWithFixedRangeByList( b, [ n, [ -50 .. 50 ] * One( homalg_field ) ] );

end );

##
## Interpretation: The entries of the matrix elements are
## linear combinations of elements in [ -|n| .. |n| ] * One( homalg_field )
##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByInteger,
          [ IsVectorSpaceObject, IsVectorSpaceObject, IsInt ],
            
  function( a, b, n )
    local category, homalg_field;
    
    category := CapCategory( a );
    
    homalg_field := UnderlyingRing( category );

    return RandomMorphismWithFixedSourceAndRangeByList( a, b, [ -AbsInt( n ) .. AbsInt( n ) ] * One( homalg_field ) );

end );

##
InstallMethod( RandomMorphismByInteger,
          [ IsMatrixCategory, IsInt ],
          
  function( category, n )
    
    return RandomMorphismWithFixedSourceByInteger( RandomObjectByInteger( category, n ), n );
    
end );
