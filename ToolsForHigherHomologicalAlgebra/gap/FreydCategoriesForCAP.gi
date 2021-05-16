# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#

#######################
#
# Dual functor
#
######################

##
InstallOtherMethod( UnderlyingMatrix, [ IsGradedRowMorphism ], UnderlyingHomalgMatrix );
InstallOtherMethod( GradedRow, [ IsList, IsCategoryOfGradedRows ], { degrees, rows } -> GradedRow( degrees, UnderlyingGradedRing( rows ) ) );


##
InstallMethod( DualOfFpModuleByFreyd,
          [ IsFreydCategoryObject ],
  function( M )
    local rows, rel_map, m;
    
    rows := UnderlyingCategory( CapCategory( M ) );
    
    rel_map := RelationMorphism( M );
    
    if IsCategoryOfGradedRows( rows ) then
      
      m := AsFreydCategoryMorphism(
              GradedRowOrColumnMorphism(
                GradedRow( List( DegreeList( Range( rel_map ) ), d -> [ -d[1], d[2] ] ), rows ),
                Involution( UnderlyingMatrix( rel_map ) ),
                GradedRow( List( DegreeList( Source( rel_map ) ), d -> [ -d[1], d[2] ] ), rows )
              )
          );
    
    elif IsCategoryOfRows( rows ) then
      
      m := AsFreydCategoryMorphism(
              CategoryOfRowsMorphism(
                Range( rel_map ),
                Involution( UnderlyingMatrix( rel_map ) ),
                Source( rel_map )
              )
          );
    
    else
      
      TryNextMethod( );
      
    fi;
     
    return KernelObject( m );
    
    
end );

##
InstallMethod( DualOfFpModuleHomomorphismByFreyd,
          [ IsFreydCategoryMorphism ],
  function( phi )
    local rows, s_map, phi_map, r_map;
    
    rows := UnderlyingCategory( CapCategory( phi ) );
    
    s_map := RelationMorphism( Source( phi ) );
    
    phi_map := MorphismDatum( phi );
     
    r_map := RelationMorphism( Range( phi ) );
    
    if IsCategoryOfGradedRows( rows ) then
        
        s_map := AsFreydCategoryMorphism(
              GradedRowOrColumnMorphism(
                GradedRow( List( DegreeList( Range( s_map ) ), d -> [ -d[1], d[2] ] ), rows ),
                Involution( UnderlyingMatrix( s_map ) ),
                GradedRow( List( DegreeList( Source( s_map ) ), d -> [ -d[1], d[2] ] ), rows )
              )
            );
        
        phi_map := AsFreydCategoryMorphism(
              GradedRowOrColumnMorphism(
                GradedRow( List( DegreeList( Range( phi_map ) ), d -> [ -d[1], d[2] ] ), rows ),
                Involution( UnderlyingMatrix( phi_map ) ),
                GradedRow( List( DegreeList( Source( phi_map ) ), d -> [ -d[1], d[2] ] ), rows )
              )
            );
        
        r_map := AsFreydCategoryMorphism(
              GradedRowOrColumnMorphism(
                GradedRow( List( DegreeList( Range( r_map ) ), d -> [ -d[1], d[2] ] ), rows ),
                Involution( UnderlyingMatrix( r_map ) ),
                GradedRow( List( DegreeList( Source( r_map ) ), d -> [ -d[1], d[2] ] ), rows )
              )
            );
        
    fi;
      
    return KernelObjectFunctorial( r_map, phi_map, s_map );
    
end );

##
InstallMethod( IsomorphismOntoDoubleDualOfFpModuleByFreyd,
          [ IsFreydCategoryObject ],
  function( M )
    local rel_map, rows, m, iota;
    
    rel_map := RelationMorphism( M );
    
    rows := CapCategory( rel_map );
    
    if IsCategoryOfGradedRows( rows ) then
      
      m := AsFreydCategoryMorphism(
              GradedRowOrColumnMorphism(
                GradedRow( List( DegreeList( Range( rel_map ) ), d -> [ -d[1], d[2] ] ), rows ),
                Involution( UnderlyingMatrix( rel_map ) ),
                GradedRow( List( DegreeList( Source( rel_map ) ), d -> [ -d[1], d[2] ] ), rows )
              )
          );
    
    elif IsCategoryOfRows( rows ) then
      
      m := AsFreydCategoryMorphism(
              CategoryOfRowsMorphism(
                Range( rel_map ),
                Involution( UnderlyingMatrix( rel_map ) ),
                Source( rel_map )
              )
          );
    
    else
      
      TryNextMethod( );
      
    fi;
    
    rel_map := AsFreydCategoryMorphism( rel_map );
    
    iota := KernelEmbedding( m );
    
    return CokernelColift( rel_map, DualOfFpModuleHomomorphismByFreyd( iota ) );
     
end );


AddFinalDerivation( MonomorphismIntoSomeInjectiveObject,
              [
                [ KernelLift, 1 ],
                [ CokernelColift, 1 ],
                [ EpimorphismFromSomeProjectiveObject, 1 ]
              ],
              [
                MonomorphismIntoSomeInjectiveObject
              ],
  { category, o } -> PreCompose(
              IsomorphismOntoDoubleDualOfFpModuleByFreyd( o ),
              DualOfFpModuleHomomorphismByFreyd(
                EpimorphismFromSomeProjectiveObject(
                  DualOfFpModuleByFreyd( o )
                )
              )
            )
  :
  FunctionCalledBeforeInstallation :=
  function( cat )
    SetIsAbelianCategoryWithEnoughInjectives( cat, true );
  end,
  CategoryFilter :=
      function( cat )
        local ring;
        
        if not IsFreydCategory( cat ) then
          return false;
        fi;
        
        cat := UnderlyingCategory( cat );
        
        if IsCategoryOfGradedRows( cat  ) then
          ring := UnderlyingNonGradedRing( UnderlyingGradedRing( cat ) );
        elif IsCategoryOfRows( cat ) then
          ring := UnderlyingRing( cat );
        else
          return false;
        fi;
        
        return HasIsExteriorRing( ring ) and IsExteriorRing( ring );
      
      end
);

##
InstallMethod( UniversalEquivalenceFromFreydCategory,
          [ IsCapFunctor ],
          
  function( F )
    local freyd_category, range_category, name, FF;
    
    freyd_category := FreydCategory( SourceOfFunctor( F ) );
    
    range_category := RangeOfFunctor( F );
    
    if not ( HasIsAbelianCategory( range_category ) and IsAbelianCategory( range_category ) ) then
      
      Error( "The range category of the passed functor must be abelian!\n" );
      
    fi;
    
    name := "Universal equivalence from Freyd category";
    
    FF := CapFunctor( name, freyd_category, range_category );
    
    AddObjectFunction( FF,
      object -> CokernelObject( ApplyFunctor( F, RelationMorphism( object ) ) )
    );
    
    AddMorphismFunction( FF,
      {s, morphism, r} -> CokernelObjectFunctorialWithGivenCokernelObjects(
                              s,
                              ApplyFunctor( F, RelationMorphism( Source( morphism ) ) ),
                              ApplyFunctor( F, MorphismDatum( morphism ) ),
                              ApplyFunctor( F, RelationMorphism( Range( morphism ) ) ),
                              r
                          )
    );
    
    return FF;
    
end );

##
InstallMethod( QuiverRows,
          [ IsQuiverAlgebra ],
  function( A )
    local v, QRows, name, r;
    
    v := ValueOption( "QuiverRows_ToolForHigherHomologicalAlgebra" );
    
    if v = false then
      
      TryNextMethod( );
      
    fi;
    
    QRows := QuiverRows( A : QuiverRows_ToolForHigherHomologicalAlgebra := false );
    
    if HasTensorProductFactors( A ) then
      
      name := List( TensorProductFactors( A ), Name );
      
      name := JoinStringsWithSeparator( name, "⊗ " );
      
      A!.alternative_name := name;
      
    else
      
      name := Name( A );
      
    fi;
    
    r := RandomTextColor( "" );
    
    QRows!.Name := Concatenation( r[ 1 ], "Quiver rows( ", r[ 2 ], name, r[ 1 ], " )", r[ 2 ] );
    
    return QRows;

end );

#######################
#
# LaTeX Strings
#
#######################

##
InstallMethod( LaTeXStringOp,
          [ IsFreydCategoryObject ],
  LaTeXOutput
);

##
InstallMethod( LaTeXStringOp,
          [ IsFreydCategoryMorphism ],
  LaTeXOutput
);

##
InstallMethod( LaTeXStringOp,
          [ IsCategoryOfRowsObject ],
  LaTeXOutput
);

##
InstallMethod( LaTeXStringOp,
          [ IsCategoryOfRowsMorphism ],
  LaTeXOutput
);

##
InstallMethod( LaTeXStringOp,
          [ IsQuiverRowsObject ],
          
  function( obj )
    local Qrows, Q, vertices, l, exp_func, v;
    
    Qrows := CapCategory( obj );
    
    Q := UnderlyingQuiver( Qrows );
    
    vertices := Vertices( Q );
    
    if ForAll( vertices, v -> Int( String( v ) ) <> fail and not HasLabelAsLaTeXString( v ) ) then
        
      for v in vertices do
        
        SetLabelAsLaTeXString( v, Concatenation( "V_{", String( v ), "}" ) );
        
      od;
      
    fi;
 
    l := ListOfQuiverVertices( obj );
    
    if IsEmpty( l ) then
        
        return "0";
        
    fi;
    
    exp_func := function( i )
        if i = 1 then
            return "";
        else
            return Concatenation( "\\oplus", String( i ) );
        fi;
    end;
    
    l := List( l, pair -> Concatenation( "{", LaTeXStringForQPA( pair[1] ), "}^{", exp_func( pair[2] ), "}" ) );
    
    return JoinStringsWithSeparator( l, " \\oplus " );
    
end );

##
InstallMethod( LaTeXStringOp,
          [ IsQuiverRowsMorphism ],
               
  function( morphism )
    local Qrows, Q, vertices, matrix, v, source, range;
    
    Qrows := CapCategory( morphism );
    
    Q := UnderlyingQuiver( Qrows );
    
    vertices := Vertices( Q );
    
    if ForAll( vertices, v -> Int( String( v ) ) <> fail and not HasLabelAsLaTeXString( v ) ) then
        
      for v in vertices do
        
        SetLabelAsLaTeXString( v, Concatenation( "V_{", String( v ), "}" ) );
        
      od;
      
    fi;
    
    matrix := MorphismMatrix( morphism );
    
    if IsEmpty( matrix ) then
        matrix := "0";
    else
        
        matrix := JoinStringsWithSeparator(
            List( matrix, row -> JoinStringsWithSeparator( List( row, el -> Concatenation( "CAPINTMARKER", LaTeXStringForQPA( el ) ) ), "\&" ) ),
            """\\"""
        );
        
        matrix := ReplacedString( matrix, "{ 1*", "{" );
        
        matrix := ReplacedString( matrix, "{ -1*", "{-" );
        
        matrix := ReplacedString( matrix, " + 1*", " + " );
        
        matrix := ReplacedString( matrix, " - 1*", " - " );
        
        matrix := ReplacedString( matrix, "CAPINTMARKER1*", "" );
        
        matrix := ReplacedString( matrix, "CAPINTMARKER-1*", "-" );
        
        matrix := ReplacedString( matrix, "CAPINTMARKER", "" );
        
        matrix := ReplacedString( matrix, "*", "" );
        
        if matrix = "" then
          
          matrix := "\\\\";
          
        fi;
        
        matrix :=  Concatenation( "\\begin{pmatrix}", matrix, "\\end{pmatrix}" );
    
    fi;
    
    if ValueOption( "OnlyDatum" ) = true then
        
        return matrix;
        
    fi;
    
    source := LaTeXStringOp( Source( morphism ) );
    
    range := LaTeXStringOp( Range( morphism ) );
    
    return Concatenation( source, "\\xrightarrow{", matrix, "}", range );
    
end );

##
InstallOtherMethod( LaTeXStringOp,
          [ IsGradedRow ],
          
  function( obj )
    local ring, degrees, exp_func, l;
    
    ring := UnderlyingHomalgGradedRing( obj );
    
    degrees := CollectEntries( UnzipDegreeList( obj ) );
    degrees := List( degrees, d -> [ String( HomalgElementToInteger( d[1] ) ), d[2] ] );
    
    if IsEmpty( degrees ) then
        
        return "0";
        
    fi;
    
    exp_func := function( i )
        if i = 1 then
            return "";
        else
            return Concatenation( "\\oplus", String( i ) );
        fi;
    end;
    
    l := List( degrees, pair -> Concatenation( "{", LaTeXStringOp( ring ),"(", pair[1] ,")}^{", exp_func( pair[2] ), "}" ) );
    
    return JoinStringsWithSeparator( l, " \\oplus " );
    
end );

InstallOtherMethod( LaTeXOutput, [ IsGradedRow ], LaTeXStringOp );

##
InstallOtherMethod( LaTeXStringOp,
          [ IsGradedRowMorphism ],
               
  function( morphism )
    local matrix, source, range;
    
    matrix := UnderlyingHomalgMatrix( morphism );
    
    matrix := LaTeXStringOp( matrix );
    
    if ValueOption( "OnlyDatum" ) = true then
        
        return matrix;
        
    fi;
    
    source := LaTeXStringOp( Source( morphism ) );
    
    range := LaTeXStringOp( Range( morphism ) );
    
    return Concatenation( source, "\\xrightarrow{", matrix, "}", range );
    
end );

##
InstallOtherMethod( LaTeXOutput, [ IsGradedRowMorphism ], LaTeXStringOp );

##
InstallMethod( LaTeXStringOp,
          [ IsAdditiveClosureObject ],
          
  function( obj )
    local l, latex_string;
    
    l := ObjectList( obj );
    
    if IsEmpty( l ) then
      
      return "0";
      
    fi;
    
    l := CollectEntries( l );
    
    l := List( l,
            function( pair )
              local s;
              
              s := Concatenation( "{", LaTeXStringOp( pair[ 1 ] ), "}" );
              
              if pair[ 2 ] <> 1 then
                  s := Concatenation( s, "^{\\oplus ", String( pair[ 2 ] ), "}" );
              fi;
              
              return s;
              
            end );
            
    return JoinStringsWithSeparator( l, "\\oplus" );
    
end );

##
InstallMethod( LaTeXStringOp,
          [ IsAdditiveClosureMorphism ],
          
  function( morphism )
    local matrix, source, range;
    
    matrix := MorphismMatrix( morphism );
    
    if IsEmpty( matrix ) then
        matrix := "0";
    else
        
        matrix := JoinStringsWithSeparator(
            List( matrix, row -> JoinStringsWithSeparator( List( row, morphism -> LaTeXStringOp( morphism : OnlyDatum := true ) ), "\&" ) ),
            "\\\\ \n"
          );
          
        if matrix = "" then
          
          matrix := "\\\\";
          
        fi;
        
        matrix :=  Concatenation( "\\begin{pmatrix}", matrix, "\\end{pmatrix}" );
        
    fi;
    
    if ValueOption( "OnlyDatum" ) = true then
        
        return matrix;
        
    fi;
    
    source := LaTeXStringOp( Source( morphism ) );
    
    range := LaTeXStringOp( Range( morphism ) );
    
    return Concatenation( source, "\\xrightarrow{", matrix, "}", range );
    
end );

################################
#
# Random methods
#
################################

## These random methods should be removed as soon as the following PR has been merged to CAP
## https://github.com/homalg-project/CAP_project/pull/479

########################
##
## Additive closures
##
########################

##
InstallMethod( RandomObjectByInteger,
          [ IsAdditiveClosureCategory, IsInt ],
          -1,
  function( category, n )
    local underlying_category;
     
    if CanCompute( category, "RandomObjectByInteger" ) then
      
      TryNextMethod( );
      
    fi;
    
    underlying_category := UnderlyingCategory( category );
    
    if n = 0 then
      
      return ZeroObject( category );
      
    else
      
      return List( [ 1 .. AbsInt( n ) ],
              i -> RandomObjectByInteger( underlying_category, n )
               ) / category;
               
    fi;
    
end );

##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByInteger,
          [ IsAdditiveClosureObject, IsAdditiveClosureObject, IsInt ],
          -1,
  function( source, range, n )
    local category, source_objects, range_objects, morphisms, current_row, s, r;
    
    category := CapCategory( source );
    
    if CanCompute( category, "RandomMorphismWithFixedSourceAndRangeByInteger" ) then
      
      TryNextMethod( );
      
    fi;
   
    source_objects := ObjectList( source );
    
    range_objects := ObjectList( range );
    
    if IsEmpty( source_objects ) or IsEmpty( range_objects ) then
      
      return ZeroMorphism( source, range );
      
    else
      
      morphisms := [ ];
      
      for s in source_objects do
        
        current_row := [ ];
        
        for r in range_objects do
          
          Add( current_row, RandomMorphismWithFixedSourceAndRange( s, r, n ) );
          
        od;
        
        Add( morphisms, current_row );
        
      od;
      
      return morphisms / category;
      
    fi;
    
end );

##
InstallMethod( RandomMorphismWithFixedSourceByInteger,
          [ IsAdditiveClosureObject, IsInt ],
          -1,
  function( source, n )
    local category, range;
    
    category := CapCategory( source );
    
    if CanCompute( category, "RandomMorphismWithFixedSourceByInteger" ) then
      
      TryNextMethod( );
      
    fi;

    range := RandomObjectByInteger( category, n );
    
    return RandomMorphismWithFixedSourceAndRangeByInteger( source, range, n );
    
end );

##
InstallMethod( RandomMorphismWithFixedRangeByInteger,
          [ IsAdditiveClosureObject, IsInt ],
          -1,
  function( range, n )
    local category, source;
    
    category := CapCategory( range );
    
    if CanCompute( category, "RandomMorphismWithFixedRangeByInteger" ) then
      
      TryNextMethod( );
      
    fi;

    source := RandomObjectByInteger( category, n );
    
    return RandomMorphismWithFixedSourceAndRangeByInteger( source, range, n );
    
end );

##
InstallMethod( RandomMorphismByInteger,
          [ IsAdditiveClosureCategory, IsInt ],
          -1,
  function( category, n )
    local a;
    
    a := RandomObjectByInteger( category, n );
    
    return RandomMorphismWithFixedSourceByInteger( a, Random( [ AbsInt( n ) - 1 .. AbsInt( n ) + 1 ] ) );
    
end );

################
##
## Quiver rows
##
################

##
InstallMethod( RandomObjectByInteger,
          [ IsQuiverRowsCategory, IsInt ],
          -1,
  function( Qrows, n )
    local J, AC;
    
    J := ValueGlobal( "IsomorphismFromAdditiveClosureOfAlgebroid" )( Qrows );
    
    AC := SourceOfFunctor( J );
    
    return J( RandomObjectByInteger( AC, n ) );
    
end );

##
InstallMethod( RandomMorphismWithFixedSourceByInteger,
          [ IsQuiverRowsObject, IsInt ],
          -1,
  function( o, n )
    local QRows, I, J;
    
    QRows := CapCategory( o );
    
    I := ValueGlobal( "IsomorphismOntoAdditiveClosureOfAlgebroid" )( QRows );
    
    J := ValueGlobal( "IsomorphismFromAdditiveClosureOfAlgebroid" )( QRows );
    
    return J( RandomMorphismWithFixedSourceByInteger( I( o ), n ) );
    
end );

##
InstallMethod( RandomMorphismWithFixedRangeByInteger,
          [ IsQuiverRowsObject, IsInt ],
          -1,
  function( o, n )
    local QRows, I, J;
    
    QRows := CapCategory( o );
   
    I := ValueGlobal( "IsomorphismOntoAdditiveClosureOfAlgebroid" )( QRows );
    
    J := ValueGlobal( "IsomorphismFromAdditiveClosureOfAlgebroid" )( QRows );
    
    return J( RandomMorphismWithFixedRangeByInteger( I( o ), n ) );
   
end );

##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByInteger,
          [ IsQuiverRowsObject, IsQuiverRowsObject, IsInt ],
          -1,
  function( s, r, n )
    local QRows, I, J;
    
    QRows := CapCategory( s );

    I := ValueGlobal( "IsomorphismOntoAdditiveClosureOfAlgebroid" )( QRows );
    
    J := ValueGlobal( "IsomorphismFromAdditiveClosureOfAlgebroid" )( QRows );
    
    return J( RandomMorphismWithFixedSourceAndRangeByInteger( I( s ), I( r ), n ) );
    
end );

##
InstallMethod( RandomMorphismByInteger,
          [ IsQuiverRowsCategory, IsInt ],
          -1,
  function( QRows, n )
    local a;
    
    a := RandomObjectByInteger( QRows, n );
    
    return RandomMorphismWithFixedSourceByInteger( a, Random( [ AbsInt( n ) - 1 .. AbsInt( n ) + 1 ] ) );
    
end );


##################################
#
# Freyd over category of rows
#
#################################

##
InstallMethod( RandomObjectByInteger,
          [ IsFreydCategory, IsInt ],
          -1,
  function( freyd, n )
    local S, fpres, J;
    
    if not IsCategoryOfRows( UnderlyingCategory( freyd ) ) then
      TryNextMethod( );
    fi;
    
    S := UnderlyingRing( UnderlyingCategory( freyd ) );
    
    fpres := LeftPresentations( S );
    
    J := Functor( fpres, freyd, 1 );
    
    return J( RandomObjectByInteger( fpres, n ) );
    
end );

##
InstallMethod( RandomMorphismWithFixedSourceByInteger,
          [ IsFreydCategoryObject, IsInt ],
          -1,
  function( o, n )
    local freyd, S, fpres, I, J;
    
    freyd := CapCategory( o );
    
    if not IsCategoryOfRows( UnderlyingCategory( freyd ) ) then
      TryNextMethod( );
    fi;
    
    S := UnderlyingRing( UnderlyingCategory( freyd ) );
    
    fpres := LeftPresentations( S );
 
    I := Functor( freyd, fpres, 1 );
    J := Functor( fpres, freyd, 1 );
    
    return J( RandomMorphismWithFixedSourceByInteger( I( o ), n ) );
    
end );

##
InstallMethod( RandomMorphismWithFixedRangeByInteger,
          [ IsFreydCategoryObject, IsInt ],
          -1,
  function( o, n ) 
    local freyd, S, fpres, I, J;
    
    freyd := CapCategory( o );
    
    if not IsCategoryOfRows( UnderlyingCategory( freyd ) ) then
      TryNextMethod( );
    fi;
    
    S := UnderlyingRing( UnderlyingCategory( freyd ) );
    
    fpres := LeftPresentations( S );
 
    I := Functor( freyd, fpres, 1 );
    J := Functor( fpres, freyd, 1 );
    
    return J( RandomMorphismWithFixedRangeByInteger( I( o ), n ) );
  
end );

##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByInteger,
          [ IsFreydCategoryObject, IsFreydCategoryObject, IsInt ],
          -1,
  function( s, r, n )
    local freyd, S, fpres, I, J;
    
    freyd := CapCategory( s );
    
    if not IsCategoryOfRows( UnderlyingCategory( freyd ) ) then
      TryNextMethod( );
    fi;
    
    S := UnderlyingRing( UnderlyingCategory( freyd ) );
    
    fpres := LeftPresentations( S );
 
    I := Functor( freyd, fpres, 1 );
    J := Functor( fpres, freyd, 1 );
   
    return J( RandomMorphismWithFixedSourceAndRangeByInteger( I( s ), I( r ), n ) );
    
end );

##
InstallMethod( RandomMorphismByInteger,
          [ IsFreydCategory, IsInt ],
          -1,
  function( freyd, n )
    local a;
    
    a := RandomObjectByInteger( freyd, n );
    
    return RandomMorphismWithFixedSourceByInteger( a, Random( [ AbsInt( n ) - 1 .. AbsInt( n ) + 1 ] ) );
    
end );

##
InstallMethod( SimplifyMorphism,
          [ IsFreydCategoryMorphism, IsObject ],
  
  function( phi, i )
    local freyd_cat, underlying_cat, datum_mat, range_mat, datum;
    
    freyd_cat := CapCategory( phi );
    
    underlying_cat := UnderlyingCategory( freyd_cat );
    
    if not IsCategoryOfRows( underlying_cat ) then
      TryNextMethod( );
    fi;
    
    datum_mat := UnderlyingMatrix( MorphismDatum( phi ) );
    
    range_mat := UnderlyingMatrix( RelationMorphism( Range( phi ) ) );
    
    datum := DecideZeroRows(  datum_mat, range_mat ) / underlying_cat;
    
    return FreydCategoryMorphism( Source( phi ), datum, Range( phi ) );
     
end, -1 );
