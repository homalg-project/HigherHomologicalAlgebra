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

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then

  ##
  InstallOtherMethod( AdditiveClosureObject,
          [ IsJuliaObject, IsAdditiveClosureCategory ],
    function( list_of_objects, category )
      
      return AdditiveClosureObject( ConvertJuliaToGAP( list_of_objects ), category );
      
  end );
  
  ##
  InstallOtherMethod( AdditiveClosureMorphism,
          [ IsAdditiveClosureObject, IsJuliaObject, IsAdditiveClosureObject ],
    function( source, matrix, range )
      
      return AdditiveClosureMorphism( source, ConvertJuliaToGAP( matrix ), range );
      
  end );
  
fi;

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
BindGlobal( "BASIS_OF_EXTERNAL_HOM_IN_GRADED_ROWS_HELPER",
  
  function( o )
    local S, G, mats, z, i, j;
    
    S := UnderlyingHomalgGradedRing( o );
    
    G := List( DegreeList( o ), d -> [ MonomialsWithGivenDegree( S, d[ 1 ] ), d[ 2 ] ] );
    G := Concatenation( List( G, d -> ListWithIdenticalEntries( d[ 2 ], d[ 1 ] ) ) );
    
    mats := [ ];
    
    z := ListWithIdenticalEntries( Rank( o ), Zero( S ) );
    
    for i in [ 1 .. Rank( o ) ] do
      for j in [ 1 .. Length( G[i] ) ] do
        z[i] := G[i,j];
        Add( mats, ShallowCopy( z ) );
        z[i] := Zero( S );
      od;
    od;
    
    return mats;
    
end );

##
InstallMethod( CategoryOfGradedRows,
          [ IsHomalgGradedRing ],
  function( S )
    local v, rows, r;
    
    v := ValueOption( "CategoryOfGradedRows_ToolsForHigherHomologicalAlgebra" );
    
    if v = false then
      
      TryNextMethod( );
      
    fi;
     
    rows := CategoryOfGradedRows( S : FinalizeCategory := false, CategoryOfGradedRows_ToolsForHigherHomologicalAlgebra := false );
    
    SetIsLinearCategoryOverCommutativeRing( rows, true );
    
    SetCommutativeRingOfLinearCategory( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
    
    AddMultiplyWithElementOfCommutativeRingForMorphisms( rows,
      { r, phi } -> GradedRowOrColumnMorphism( Source( phi ), ( r / S ) * UnderlyingHomalgMatrix( phi ), Range( phi ) )
    );
    
    if CanComputeMonomialsWithGivenDegreeForRing( S ) then
    
      AddBasisOfExternalHom( rows,
         
        function( a, b )
          local S, degrees_a, degrees_b, degrees, hom_a_b, mats;
          
          S := UnderlyingHomalgGradedRing( a );
          
          degrees_a := UnzipDegreeList( a );
          
          degrees_b := UnzipDegreeList( b );
          
          degrees := CollectEntries( Concatenation( List( degrees_a, a -> List( degrees_b, b -> b - a ) ) ) );
          
          hom_a_b := GradedRow( degrees, S );
          
          mats := BASIS_OF_EXTERNAL_HOM_IN_GRADED_ROWS_HELPER( hom_a_b );
          
          return List( mats, 
                    mat -> GradedRowOrColumnMorphism(
                                a,
                                HomalgMatrix( mat, Rank( a ), Rank( b ), S ),
                                b
                              )
                  );
          
      end );
      
      ##
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( rows,
        
        { phi, B } -> CoefficientsOfMorphism( phi )
      );
      
      ##
      InstallMethod( CoefficientsOfMorphism,
                [ IsGradedRowOrColumnMorphism and MorphismFilter( rows ) ],
                
        function( phi )
          local K, degrees_s, degrees_r, degrees, hom_s_r, B, sol, positions, coeff, mon, position_in_basis, p, j;
          
          K := CommutativeRingOfLinearCategory( rows );
          
          degrees_s := UnzipDegreeList( Source( phi ) );
          
          degrees_r := UnzipDegreeList( Range( phi ) );
          
          degrees := CollectEntries( Concatenation( List( degrees_s, a -> List( degrees_r, b -> b - a ) ) ) );
          
          hom_s_r := GradedRow( degrees, UnderlyingHomalgGradedRing( phi ) );
          
          B := BASIS_OF_EXTERNAL_HOM_IN_GRADED_ROWS_HELPER( hom_s_r );

          phi := UnderlyingHomalgMatrix( phi );
          
          phi := EntriesOfHomalgMatrix( phi );
                    
          if B = [  ] then
            
            return [  ];
            
          fi;
          
          sol := ListWithIdenticalEntries( Length( B ), Zero( K) );
          
          positions := PositionsProperty( phi, e -> not IsZero( e ) );
          
          for p in positions do
            
            mon := Coefficients( phi[ p ] )!.monomials;
            
            coeff := EntriesOfHomalgMatrix( Coefficients( phi[ p ] ) );
            
            for j in [ 1 .. Length( coeff ) ] do
              
              position_in_basis := PositionProperty( B, b -> b[ p ] = mon[ j ] );
              sol[ position_in_basis ] := coeff[ j ] / K;
              
            od;
            
          od;
          
          return sol;
         
      end );
       
    fi;
    
    Finalize( rows );;
        
    return rows;
    
end );


#######################
#
# LaTeX Strings
#
#######################

##
InstallMethod( LaTeXOutput,
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
InstallMethod( LaTeXOutput,
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
    
    source := LaTeXOutput( Source( morphism ) );
    
    range := LaTeXOutput( Range( morphism ) );
    
    return Concatenation( source, "\\xrightarrow{", matrix, "}", range );
    
end );

##
InstallOtherMethod( LaTeXOutput,
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
    
    l := List( degrees, pair -> Concatenation( "{", LaTeXOutput( ring ),"(", pair[1] ,")}^{", exp_func( pair[2] ), "}" ) );
    
    return JoinStringsWithSeparator( l, " \\oplus " );
    
end );

##
InstallMethod( LaTeXOutput,
          [ IsGradedRowMorphism ],
          
  function( morphism )
    local matrix, source, range;
    
    matrix := UnderlyingHomalgMatrix( morphism );
    
    matrix := LaTeXOutput( matrix );
    
    if ValueOption( "OnlyDatum" ) = true then
        
        return matrix;
        
    fi;
    
    source := LaTeXOutput( Source( morphism ) );
    
    range := LaTeXOutput( Range( morphism ) );
    
    return Concatenation( source, "\\xrightarrow{", matrix, "}", range );
    
end );

##
InstallMethod( LaTeXOutput,
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
              
              s := Concatenation( "{", LaTeXOutput( pair[ 1 ] ), "}" );
              
              if pair[ 2 ] <> 1 then
                  s := Concatenation( s, "^{\\oplus ", String( pair[ 2 ] ), "}" );
              fi;
              
              return s;
              
            end );
            
    return JoinStringsWithSeparator( l, "\\oplus" );
    
end );

##
InstallMethod( LaTeXOutput,
          [ IsAdditiveClosureMorphism ],
          
  function( morphism )
    local matrix, source, range;
    
    matrix := MorphismMatrix( morphism );
    
    if IsEmpty( matrix ) then
        matrix := "0";
    else
        
        matrix := JoinStringsWithSeparator(
            List( matrix, row -> JoinStringsWithSeparator( List( row, morphism -> LaTeXOutput( morphism : OnlyDatum := true ) ), "\&" ) ),
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
    
    source := LaTeXOutput( Source( morphism ) );
    
    range := LaTeXOutput( Range( morphism ) );
    
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
    
    fpres := ValueGlobal( "LeftPresentations" )( S );
    
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
    
    fpres := ValueGlobal( "LeftPresentations" )( S );
 
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
    
    fpres := ValueGlobal( "LeftPresentations" )( S );
 
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
    
    fpres := ValueGlobal( "LeftPresentations" )( S );
 
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

#################
#
# Category of rows
#
#################

##
InstallMethod( RandomObjectByInteger,
      [ IsCategoryOfRows, IsInt ],
      
  {category, n} -> RandomObjectByList( category, [ 1 .. n ] )
);

##
InstallMethod( RandomObjectByList,
      [ IsCategoryOfRows, IsList ],
      
  function( category, L )
    
    if Length( L ) = 0 then
      Error();
    fi;
    
    if not ForAll( L, IsPosInt ) then
      Error();
    fi;
    
    return CategoryOfRowsObject( Random( L ), category ); 
    
end );

##
InstallMethod( RandomMorphismWithFixedSourceByInteger,
      [ IsCategoryOfRows, IsCategoryOfRowsObject, IsInt ],
      
  {category, a, n} -> RandomMorphismWithFixedSourceByList( category, a, [ 1 .. n ] )
);

##
InstallMethod( RandomMorphismWithFixedSourceByList,
          [ IsCategoryOfRows, IsCategoryOfRowsObject, IsList ],
          
  function( category, a, L )
    local R, r, mat, b;
    
    R := UnderlyingRing( category );
    
    if Length( L ) = 0 then
      Error();
    fi;
    
    if not ForAll( L, IsPosInt ) then
      Error();
    fi;
   
    r := Random( L );
    
    mat := R!.random_matrix_func( RankOfObject( a ), r );
    
    b := CategoryOfRowsObject( r, category );
    
    return CategoryOfRowsMorphism( a, mat, b );
    
end );

##
InstallMethod( RandomMorphismWithFixedRangeByInteger,
      [ IsCategoryOfRows, IsCategoryOfRowsObject, IsInt ],
      
  {category, b, n} -> RandomMorphismWithFixedRangeByList( category, b, [ 1 .. n ] )
);

##
InstallMethod( RandomMorphismWithFixedRangeByList,
          [ IsCategoryOfRows, IsCategoryOfRowsObject, IsList ],
          
  function( category, b, L )
    local R, r, mat, a;
    
    R := UnderlyingRing( category );
   
    if Length( L ) = 0 then
      Error();
    fi;
    
    if not ForAll( L, IsPosInt ) then
      Error();
    fi;
   
    r := Random( L );
    
    mat := R!.random_matrix_func( r, RankOfObject( b ) );
    
    a := CategoryOfRowsObject( r, category );
    
    return CategoryOfRowsMorphism( a, mat, b );
    
end );

##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByInteger,
      [ IsCategoryOfRows, IsCategoryOfRowsObject, IsCategoryOfRowsObject, IsInt ],
      
  {category, a, b, n} -> RandomMorphismWithFixedSourceByList( category, a, b, [ 1 .. n ] )
);


##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByList,
          [ IsCategoryOfRows, IsCategoryOfRowsObject, IsCategoryOfRowsObject, IsList ],
          
  function( category, a, b, L )
    local R, mat;
    
    R := UnderlyingRing( category );

    if Length( L ) = 0 then
      Error();
    fi;
    
    if not ForAll( L, IsPosInt ) then
      Error();
    fi;
    
    mat := R!.random_matrix_func( RankOfObject( a ), RankOfObject( b ) );
    
    return CategoryOfRowsMorphism( a, mat, b );
    
end );

##
InstallMethod( RandomMorphismByList,
          [ IsCategoryOfRows, IsList ],
          
  function( category, L )
    local R, r1, r2, a, b, mat;
    
    R := UnderlyingRing( category );

    if Length( L ) = 0 then
      Error();
    fi;
    
    if not ForAll( L, IsPosInt ) then
      Error();
    fi;
    
    r1 := Random( L );
    
    r2 := Random( L );
    
    a := CategoryOfRowsObject( r1, category );

    b := CategoryOfRowsObject( r2, category );

    mat := R!.random_matrix_func( r1, r2 );
    
    return CategoryOfRowsMorphism( a, mat, b );
    
end );


#####################
##
## Graded Rows
##
#####################
    
##
InstallMethod( RandomObjectByList,
          [ IsCategoryOfGradedRows, IsList ],
          -1, 
  function( category, L )
    local S, degree_list;
    S := UnderlyingGradedRing( category );
    degree_list := List( [ 1 .. L[1] ], i -> [ Random( L[2] ), 1 ] );
    return GradedRow( degree_list, S );
end );

##
InstallMethod( RandomMorphismWithFixedSourceByList,
          [ IsCategoryOfGradedRows, IsGradedRow, IsList ],
          -1,
  function( category, a, L )
    local S, degrees_a, degrees_b, b, mat;
    S := UnderlyingGradedRing( category );
    degrees_a := UnzipDegreeList( a );
    degrees_b := List( L, l -> [ l, 1 ] );
    b := GradedRow( degrees_b, S );
    degrees_b := UnzipDegreeList( b );
    mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
    return GradedRowOrColumnMorphism( a, mat, b );
end );

##
InstallMethod( RandomMorphismWithFixedRangeByList,
          [ IsCategoryOfGradedRows, IsGradedRow, IsList ],
          -1,
  function( category, b, L )
    local S, degrees_a, degrees_b, a, mat;
    S := UnderlyingGradedRing( category );
    degrees_b := UnzipDegreeList( b );
    degrees_a := List( L, l -> [ l, 1 ] );
    a := GradedRow( degrees_a, S );
    degrees_a := UnzipDegreeList( a );
    mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
    return GradedRowOrColumnMorphism( a, mat, b );
end );

##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByList,
          [ IsCategoryOfGradedRows, IsGradedRow, IsGradedRow, IsList ],
          -1,
  function( category, a, b, L )
    local S, degrees_a, degrees_b, mat;
    S := UnderlyingGradedRing( category );
    degrees_a := UnzipDegreeList( a );
    degrees_b := UnzipDegreeList( b );
    mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
    return GradedRowOrColumnMorphism( a, mat, b );
end );

##
InstallMethod( RandomMorphismByList,
          [ IsCategoryOfGradedRows, IsList ],
          -1,
  function( category, L )
    local S, degrees_a, degrees_b, a, b, mat;
    S := UnderlyingGradedRing( category );
    degrees_a := List( [ 1 .. L[ 1 ] ], i -> [ Random( L[ 3 ] ), 1 ] );
    degrees_b := List( [ 1 .. L[ 2 ] ], i -> [ Random( L[ 4 ] ), 1 ] );
    a := GradedRow( degrees_a, S );
    b := GradedRow( degrees_b, S );
    degrees_a := UnzipDegreeList( a );
    degrees_b := UnzipDegreeList( b );
    mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
    return GradedRowOrColumnMorphism( a, mat, b );
end );

##
InstallMethod( RandomObjectByInteger,
          [ IsCategoryOfGradedRows, IsInt ],
          -1,
  function( category, n )
    local S, weights, degrees_list;
    S := UnderlyingGradedRing( category );
    weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
    Add( weights, Degree( One( S ) ) );
    weights := List( weights, ValueGlobal( "HomalgElementToListOfIntegers" ) );
    degrees_list := List( [ 1 .. n ], i -> Sum( List( [ 1 .. Random( [ 1 .. 4 ] ) ], j -> ( -1 ) ^ j * Random( weights ) ) ) );
    return RandomObjectByList( category, [ n, degrees_list ] );
end );

##
InstallMethod( RandomMorphismByInteger,
          [ IsCategoryOfGradedRows, IsInt ],
          -1,
  function( category, n )
    local a;
    a := RandomObjectByInteger( category, n );
    return RandomMorphismWithFixedRangeByInteger( category, a, n );
end );


##
InstallMethod( RandomMorphismWithFixedSourceAndRangeByInteger,
          [ IsCategoryOfGradedRows, IsGradedRow, IsGradedRow, IsInt ],
          -1,
  function( category, a, b, n )
    return RandomMorphismWithFixedSourceAndRangeByList( a, b, [] );
end );

##
InstallMethod( RandomMorphismWithFixedSourceByInteger,
          [ IsCategoryOfGradedRows, IsGradedRow, IsInt ],
          -1,
  function( category, a, n )
    local S, degrees_a, weights, degrees_b, b;
    S := UnderlyingGradedRing( category );

    degrees_a := UnzipDegreeList( a );
    weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
    Add( weights, Degree( One( S ) ) );
    degrees_b := List( [ 1 .. n ],
                    i -> [ Random( degrees_a ) + Sum( List( [ 1 .. Random( [ 1 .. 3 ] ) ],
                      j -> Random( weights ) ) ), 1 ]  );
    b := GradedRow( degrees_b, S );
    return RandomMorphismWithFixedSourceAndRangeByInteger( a, b, 0 );
end );

##
InstallMethod( RandomMorphismWithFixedRangeByInteger,
          [ IsCategoryOfGradedRows, IsGradedRow, IsInt ],
          -1,
  function( category, b, n )
    local S, degrees_b, weights, degrees_a, a;
    S := UnderlyingGradedRing( category );

    degrees_b := UnzipDegreeList( b );
    weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
    Add( weights, Degree( One( S ) ) );
    degrees_a := List( [ 1 .. n ],
                    i -> [ Random( degrees_b ) - Sum( List( [ 1 .. Random( [ 1 .. 3 ] ) ],
                      j -> Random( weights ) ) ), 1 ]  );
    a := GradedRow( degrees_a, S );
    return RandomMorphismWithFixedSourceAndRangeByInteger( a, b, 0 );
end );
