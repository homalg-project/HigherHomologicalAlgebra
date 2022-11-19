# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#####################################################################

##
InstallOtherMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsChainOrCochainMorphism, IsHomotopyCategoryObject ],
  
  MorphismConstructor
);

##
InstallOtherMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsZFunction, IsHomotopyCategoryObject ],
  
  { homotopy_cat, S, morphisms, R } -> MorphismConstructor(
                                            homotopy_cat,
                                            S,
                                            CreateComplexMorphism( UnderlyingCategory( homotopy_cat ), UnderlyingCell( S ), UnderlyingCell( R ), morphisms ),
                                            R )
);

##
InstallOtherMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsFunction, IsHomotopyCategoryObject ],
  
  { homotopy_cat, S, morphisms, R } -> CreateComplexMorphism( homotopy_cat, S, AsZFunction( morphisms ), R )
);

##
InstallOtherMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsDenseList, IsInt ],
  
  { homotopy_cat, S, R, morphisms, l } -> MorphismConstructor(
                                                homotopy_cat,
                                                S,
                                                CreateComplexMorphism( UnderlyingCategory( homotopy_cat ), UnderlyingCell( S ), UnderlyingCell( R ), morphisms, l ),
                                                R )
);

##
InstallOtherMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsZFunction, IsInt, IsInt ],
  
  { homotopy_cat, S, R, morphisms, l, u } -> MorphismConstructor(
                                                homotopy_cat,
                                                S,
                                                CreateComplexMorphism( UnderlyingCategory( homotopy_cat ), UnderlyingCell( S ), UnderlyingCell( R ), morphisms, l, u ),
                                                R )
);

##
InstallOtherMethod( CreateComplexMorphism,
      [ IsHomotopyCategory, IsChainOrCochainMorphism ],
  
  { homotopy_cat, alpha } -> MorphismConstructor( homotopy_cat, ObjectConstructor( homotopy_cat, Source( alpha ) ), alpha, ObjectConstructor( homotopy_cat, Range( alpha ) ) )
);

##
InstallOtherMethod( \/,
      [ IsChainOrCochainMorphism, IsHomotopyCategory ],
  
  { alpha, homotopy_cat } -> CreateComplexMorphism( homotopy_cat, alpha )
);

##
for info in [ [ "Morphisms", 1 ],
              [ "MorphismAt", 2 ],
              [ "MorphismsSupport", 1 ],
              [ "LowerBound", 1 ],
              [ "UpperBound", 1 ],
              [ "CohomologyFunctorialAt", 2 ],
              [ "HomologyFunctorialAt", 2 ],
              [ "CocyclesFunctorialAt", 2 ],
              [ "CyclesFunctorialAt", 2 ],
              [ "WitnessForBeingHomotopicToZeroMorphism", 1 ],
              ] do
  
  ##
  InstallOtherMethod(
      ValueGlobal( info[1] ),
      (function()
          if info[2] = 1 then
            return [ IsHomotopyCategoryMorphism ];
          elif info[2] = 2 then
            return [ IsHomotopyCategoryMorphism, IsInt ];
          fi;
      end)(),
      EvalString( ReplacedStringViaRecord( "i_args -> oper( s_args );",
                    rec( oper := info[1],
                         i_args := (function()
                                      if info[2] = 1 then
                                        return "phi";
                                      elif info[2] = 2 then
                                        return "{ phi, i }";
                                      fi;
                                    end)(),
                         s_args := (function()
                                      if info[2] = 1 then
                                        return "UnderlyingCell( phi )";
                                      elif info[2] = 2 then
                                        return "UnderlyingCell( phi ), i";
                                      fi;
                                    end)()))));
  
od;


##
InstallOtherMethod( MorphismBetweenInjectiveResolutions,
              [ IsHomotopyCategoryMorphism, IsBool ],
  
  function( alpha, bool )
    local m, S, R;
    
    m := MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ), bool );
    
    S := ObjectConstructor( CapCategory( alpha ), Source( m ) );
    R := ObjectConstructor( CapCategory( alpha ), Range( m ) );
    
    return MorphismConstructor( CapCategory( alpha ), S, m, R );
end );

##
InstallOtherMethod( MorphismBetweenProjectiveResolutions,
              [ IsHomotopyCategoryMorphism, IsBool ],
  
  function( alpha, bool )
    local m, S, R;
    
    m := MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ), bool );
    
    S := ObjectConstructor( CapCategory( alpha ), Source( m ) );
    R := ObjectConstructor( CapCategory( alpha ), Range( m ) );
    
    return MorphismConstructor( CapCategory( alpha ), S, m, R );
end );

##
InstallOtherMethod( MorphismBetweenInjectiveResolutions,
              [ IsHomotopyCategoryMorphism, IsBool ],
  
  function( alpha, bool )
    local m, S, R;
    
    m := MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ), bool );
    
    S := ObjectConstructor( CapCategory( alpha ), Source( m ) );
    R := ObjectConstructor( CapCategory( alpha ), Range( m ) );
    
    return MorphismConstructor( CapCategory( alpha ), S, m, R );
end );


##
InstallMethod( ApplyShiftOp,
          [ IsHomotopyCategoryMorphism, IsInt ],
  
  { alpha, i } -> CreateComplexMorphism(
                      CapCategory( alpha ),
                      ApplyShift( Source( alpha ), i ),
                      ApplyShift( Range( alpha ), i ),
                      ApplyShift( Morphisms( alpha ), i ),
                      LowerBound( alpha ) - i,
                      UpperBound( alpha ) - i )
);

##
InstallMethod( ApplyUnsignedShiftOp,
          [ IsHomotopyCategoryMorphism, IsInt ],
  
  { alpha, i } -> CreateComplexMorphism(
                      CapCategory( alpha ),
                      ApplyUnsignedShift( Source( alpha ), i ),
                      ApplyUnsignedShift( Range( alpha ), i ),
                      ApplyShift( Morphisms( alpha ), i ),
                      LowerBound( alpha ) - i,
                      UpperBound( alpha ) - i )
);


##
InstallMethod( \[\],
          [ IsHomotopyCategoryMorphism, IsInt ],
  
  { phi, i } -> UnderlyingCell( phi )[ i ]
);

##
InstallOtherMethod( ViewObj, [ IsHomotopyCategoryMorphism ], _complexes_ViewObj );

##
InstallOtherMethod( Display,
        [ IsHomotopyCategoryMorphism ],
  
  function( phi )
    local l, u;
    
    l := LowerBound( phi );
    u := UpperBound( phi );
    
    if ForAll( [ l, u ], IsInt ) then
        Display( UnderlyingCell( phi ), l, u );
        Print( "\nA morphism in ", Name( CapCategory( phi ) ), " defined by the above data\n" );
    else
        TryNextMethod( );
    fi;
    
end );

