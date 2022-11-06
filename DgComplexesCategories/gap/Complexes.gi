# SPDX-License-Identifier: GPL-2.0-or-later
# DgComplexesCategories: Category of graded (co)chain complexes of an additive category
#
# Implementations
#

#############################################
#
#  Representations, families and types
#
#############################################


DeclareRepresentation( "IsDgChainComplexRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

DeclareRepresentation( "IsDgCochainComplexRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfDgChainComplexes",
            NewFamily( "dg chain complexes" ) );


BindGlobal( "FamilyOfDgCochainComplexes",
            NewFamily( "dg cochain complexes" ) );

BindGlobal( "TheTypeOfDgChainComplexes",
            NewType( FamilyOfDgChainComplexes,
                     IsDgChainComplex and IsDgChainComplexRep ) );

BindGlobal( "TheTypeOfDgCochainComplexes",
            NewType( FamilyOfDgCochainComplexes,
                     IsDgCochainComplex and IsDgCochainComplexRep ) );


##################

##
InstallMethod( DgCochainComplex,
        [ IsDgCochainComplexCategory, IsZFunction ],
  function( dgCh_cat, diffs )

    return CreateCapCategoryObjectWithAttributes( dgCh_cat,
                              Differentials, diffs,
                              Objects, ApplyMap( diffs, Source )
                            );

end );

##
InstallMethod( DgCochainComplex,
        [ IsDgCochainComplexCategory, IsZFunction, IsInt, IsInt ],

  { dgCh_cat, diffs, lower_bound, upper_bound } ->
      
      CreateCapCategoryObjectWithAttributes( dgCh_cat,
                          Differentials, diffs,
                            Objects, ApplyMap( diffs, Source ),
                            LowerBoundOfDgComplex, lower_bound,
                            UpperBoundOfDgComplex, upper_bound
                          )
);

##
InstallMethod( DgCochainComplex,
        [ IsDgCochainComplexCategory, IsDenseList, IsInt ],
        
  function( dgCh_cat, diffs, lower_bound )
    local zero_obj, func, C;
    
    zero_obj := ZeroObject( UnderlyingCategory( dgCh_cat ) );
    
    func := function( i )
              
              if i < lower_bound - 1 then
                return UniversalMorphismFromZeroObject( zero_obj );
              elif i = lower_bound - 1 then
                return UniversalMorphismFromZeroObject( Source( diffs[ 1 ] ) );
              elif i >= lower_bound and i <= lower_bound + Length( diffs ) - 1 then
                return diffs[ i - lower_bound + 1 ];
              elif i = lower_bound + Length( diffs ) then
                return UniversalMorphismIntoZeroObject( Range( diffs[ Length( diffs ) ] ) );
              else
                return UniversalMorphismIntoZeroObject( zero_obj );
              fi;
              
            end;
            
    return DgCochainComplex( dgCh_cat, AsZFunction( func ), lower_bound, lower_bound + Length( diffs ) );
    
end );

##
InstallMethod( DifferentialAtOp,
        [ IsDgComplex, IsInt ],
        
  { C, i } -> Differentials( C )[ i ]
);

##
InstallMethod( \^, [ IsDgComplex, IsInt], DifferentialAt );


##
InstallMethod( ObjectAtOp,
        [ IsDgComplex, IsInt ],
        
  { C, i } -> Objects( C )[ i ]
);

##
InstallMethod( \[\], [ IsDgComplex, IsInt ], ObjectAt );

#################################

##
InstallMethod( ViewObj,
        [ IsDgComplex ],
        
  function( C )
    
    if HasLowerBoundOfDgComplex( C ) and HasUpperBoundOfDgComplex( C ) then
      
      Print(
        "<An object in ",
        Name( CapCategory( C ) ),
        " with lower bound ",
        LowerBoundOfDgComplex( C ),
        " and  upper bound ",
        UpperBoundOfDgComplex( C ), ">"
        );
        
    elif HasLowerBoundOfDgComplex( C ) then
      
      Print(
        "<An object in ",
        Name( CapCategory( C ) ),
        " with lower bound ",
        LowerBoundOfDgComplex( C ), ">"
        );
        
    elif HasUpperBoundOfDgComplex( C ) then
      
      Print(
        "<An object in ",
        Name( CapCategory( C ) ),
        " with upper bound ",
        UpperBoundOfDgComplex( C ), ">"
        );
        
    else
      
      TryNextMethod( );
      
    fi;
    
end );

##
InstallMethod( Display,
        [ IsDgCochainComplex, IsInt, IsInt ],

  function( C, m, n )
    local s, i;
    
    for i in Reversed( [ m .. n ] ) do
      if i <> n then
        Print( "  ", " Λ", "\n" );
        Print( "  ", " |", "\n" );
        Display( C^i );
        Print( "\n" );
        Print( "  ", " |", "\n\n" );
      fi;
      s := Concatenation( "== ", String( i ), " =======================" );
      Print( s );
      Print( "\n" );
      Display( C[ i ] );
      #Print( "\n" );
      Print( Concatenation(
        ListWithIdenticalEntries(
          Length( s ), "=" ) )
        );
      Print( "\n\n" );
    od;
    
end );

##
InstallMethod( Display,
        [ IsDgComplex ],
        
  function( C )

    if HasLowerBoundOfDgComplex( C ) and HasUpperBoundOfDgComplex( C ) then
        Display( C, LowerBoundOfDgComplex( C ), UpperBoundOfDgComplex( C ) );
    else
        TryNextMethod( );
    fi;
    
end );

##
InstallMethod( LaTeXOutput,
        [ IsDgCochainComplex ],
        
  function( C )
    local l_C, u_C, latex_string, i;
    
    l_C := LowerBoundOfDgComplex( C );
    u_C := UpperBoundOfDgComplex( C );
    
    latex_string := "\\begin{array}{c}\n";
    
    latex_string := Concatenation( latex_string, LaTeXOutput( C[ u_C ] ), "\n " );
    
    for i in Reversed( [ l_C .. u_C - 1 ] ) do
      
      latex_string := Concatenation( latex_string, "\\\\\n\\uparrow_{\\phantom{", String( i ), "}} \n\\\\\n " );
      
      latex_string := Concatenation( latex_string, LaTeXOutput( C ^ i : OnlyDatum := true ), "\n\\\\\n " );
      
      latex_string := Concatenation( latex_string, "{\\vert_{", String( i ), "}}\n " );
      
      latex_string := Concatenation( latex_string, "\n\\\\\n", LaTeXOutput( C[ i ] ) );
      
    od;
    
    return Concatenation( latex_string, "\\end{array}" );
    
end );

