# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Implementations
#
##
#############################################################################

#
# Implementations
#
##
DeclareRepresentation( "IsRoofRep",
                       IsAttributeStoringRep and IsRoof,
                       [ ] );
##
BindGlobal( "TheFamilyOfRoofs",
        NewFamily( "TheFamilyOfRoofs" , IsRoof ) );

##
BindGlobal( "TheTypeRoof",
        NewType( TheFamilyOfRoofs,
                 IsRoofRep ) );
##
InstallMethod( Roof,
          [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ],
  function( quasi_isomorphism, morphism )
    local roof;
    
    if not IsEqualForObjects( Source( quasi_isomorphism ), Source( morphism ) ) then
      
      Error( "wronge input" );
      
    fi;
    
    roof := rec( );
    
    ObjectifyWithAttributes( roof, TheTypeRoof,
          AmbientCategory, CapCategory( morphism ),
          SourceMorphism, quasi_isomorphism,
          RangeMorphism, morphism,
          Source, Range( quasi_isomorphism ),
          Range, Range( morphism ),
          MiddleObject, Source( morphism )
        );
    
    return roof;
    
end );

##
InstallMethod( IsHonest,
          [ IsRoof ],
  roof -> IsIsomorphism( QuasiIsomorphism( roof ) )
);

##
InstallMethod( AsHonestMorphism,
          [ IsRoof ],
  roof -> PreCompose( Inverse( QuasiIsomorphism( roof ) ), RangeMorphism( roof ) )
);

##
InstallMethod( AsMorphismBetweenProjectiveResolutions,
          [ IsRoof ],
  roof -> PreCompose(
            Inverse( MorphismBetweenProjectiveResolutions( QuasiIsomorphism( roof ), true ) ),
            MorphismBetweenProjectiveResolutions( RangeMorphism( roof ), true )
          )
);

##
InstallMethod( AsMorphismBetweenInjectiveResolutions,
          [ IsRoof ],
  roof -> PreCompose(
            Inverse( MorphismBetweenInjectiveResolutions( QuasiIsomorphism( roof ), true ) ),
            MorphismBetweenInjectiveResolutions( RangeMorphism( roof ), true )
          )
);

#       D
#      / \
#    C     A
#   / \r s/ \
# S     B     T

##
InstallMethod( PreComposeRoofs,
          [ IsRoof, IsRoof ],
  function( roof_1, roof_2 )
    local Ho_C, r, s, A, B, C, tau, r_o_tau, D, rr_maps, rr, ss_maps, ss;
    
    Ho_C := AmbientCategory( roof_1 );
    
    if not IsChainComplexCategory( UnderlyingCategory( Ho_C ) ) then
      TryNextMethod();
    fi;
    
    s := SourceMorphism( roof_2 );
    
    r := RangeMorphism( roof_1 );
    
    A := Source( s );
    
    B := Range( s );
    
    C := Source( r );
    
    tau := MorphismToStandardConeObject( s );
    
    r_o_tau := PreCompose( r, tau );
    
    D := Shift( StandardConeObject( r_o_tau ), -1 );
    
    rr_maps := AsZFunction(
                i -> MorphismBetweenDirectSums(
                  [
                    [ ZeroMorphism( C[ i ], A[ i ] ) ],
                    [ IdentityMorphism( A[ i ] ) ],
                    [ ZeroMorphism( B[ i + 1], A[ i ] ) ]
                  ] ) );
                  
    rr := HomotopyCategoryMorphism( D, A, rr_maps );
    
    ss_maps := AsZFunction(
                i -> MorphismBetweenDirectSums(
                  [
                    [ AdditiveInverse( IdentityMorphism( C[ i ] ) ) ],
                    [ ZeroMorphism( A[ i ], C[ i ] ) ],
                    [ ZeroMorphism( B[ i + 1], C[ i ] ) ]
                  ] ) );
    
    ss := HomotopyCategoryMorphism( D, C, ss_maps );
    
    ss := PreCompose( ss, SourceMorphism( roof_1 ) );
    
    rr := PreCompose( rr, RangeMorphism( roof_2 ) );
    
    return Roof( ss, rr );
    
end );

##
InstallMethod( PreComposeRoofs,
          [ IsRoof, IsRoof ],
  function( roof_1, roof_2 )
    local Ho_C, roof;
    
    Ho_C := AmbientCategory( roof_1 );
    
    if not IsCochainComplexCategory( UnderlyingCategory( Ho_C ) ) then
      TryNextMethod();
    fi;
    
    roof_1 := Roof( AsChainMorphism( SourceMorphism( roof_1 ) ), AsChainMorphism( RangeMorphism( roof_1 ) ) );
    
    roof_2 := Roof( AsChainMorphism( SourceMorphism( roof_2 ) ), AsChainMorphism( RangeMorphism( roof_2 ) ) );
   
    roof := PreComposeRoofs( roof_1, roof_2 );
    
    roof := Roof( AsCochainMorphism( SourceMorphism( roof ) ), AsCochainMorphism( RangeMorphism( roof ) ) );
    
    return roof;

end );

##
InstallMethod( DerivedCategoryObject,
          [ IsDerivedCategory, IsHomotopyCategoryObject ],
  function( D, object )
    local Ho_C, o;
    
    Ho_C := CapCategory( object );
    
    if not IsIdenticalObj( DefiningCategory( D ), DefiningCategory( Ho_C ) ) then
      
      Error( "wronge input!\n" );
      
    fi;
    
    o := rec( );
    
    ObjectifyObjectForCAPWithAttributes( o, D,
            UnderlyingCell, object );
    
    return o;
    
end );

##
InstallMethod( \[\],
          [ IsDerivedCategoryObject, IsInt ],
  { a, i } -> UnderlyingCell( a )[ i ]
);

##
InstallMethod( \^,
          [ IsDerivedCategoryObject, IsInt ],
  { a, i } -> UnderlyingCell( a ) ^ i
);

##
InstallMethod( \/, [ IsHomotopyCategoryObject, IsDerivedCategory ],
  { a, D } -> DerivedCategoryObject( D, a )
);

##
InstallMethod( DerivedCategoryMorphism,
          [ IsDerivedCategoryObject, IsRoof, IsDerivedCategoryObject ],
  function( source, roof, range )
    local D, Ho_C, m;
    
    D := CapCategory( source );
    
    Ho_C := CapCategory( SourceMorphism( roof ) );
    
    if not IsIdenticalObj( DefiningCategory( D ), DefiningCategory( Ho_C ) ) then
      
      Error( "wronge input" );
      
    fi;
    
    m := rec( );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( m, D,
            source,
            range,
            UnderlyingRoof, roof );
    
    return m;
    
end );

##
InstallMethod( DerivedCategoryMorphism,
          [ IsDerivedCategory, IsRoof ],
  function( D, roof )
    
    return DerivedCategoryMorphism(
              DerivedCategoryObject( D, Range( SourceMorphism( roof ) ) ),
              roof,
              DerivedCategoryObject( D, Range( RangeMorphism( roof ) ) )
            );
end );

##
InstallMethod( \/, [ IsRoof, IsDerivedCategory ],
  { r, D } -> DerivedCategoryMorphism(D,r)
);

##
InstallMethod( DerivedCategoryMorphism,
          [ IsDerivedCategory, IsDenseList ],
  function( D, L )
    local roof;
    
    if not Size( L ) = 2 then
      
      Error( "wronge input" );
      
    fi;
    
    roof := Roof( L[ 1 ], L[ 2 ] );
    
    return DerivedCategoryMorphism( D, roof );
    
end );

##
InstallMethod( DerivedCategoryMorphism,
          [ IsDerivedCategory, IsHomotopyCategoryMorphism ],
  function( D, alpha )
    local L;
    
    L := [ IdentityMorphism( Source( alpha ) ), alpha ];
    
    return DerivedCategoryMorphism( D, L );
    
end );

##
InstallMethod( \/, [ IsHomotopyCategoryMorphism, IsDerivedCategory ],
  { alpha, D } -> DerivedCategoryMorphism( D, alpha )
);

##
InstallOtherMethod( Shift, [ IsDerivedCategoryObject, IsInt ],
  { a, n } -> Shift( UnderlyingCell( a ), n ) / CapCategory( a )
);

##
InstallMethod( DerivedCategoryAttr,
          [ IsCapCategory ],
  C -> DerivedCategory( C, false )
);

##
InstallOtherMethod( DerivedCategory,
          [ IsCapCategory ],
  C -> DerivedCategoryAttr( C )
);

##
InstallMethod( DerivedCategoryOp,
          [ IsCapCategory, IsBool ],
  function( C, over_cochains )
    local r, name, D;
    
    r := RandomTextColor( Name( C ) );
    
    if over_cochains then
      
      name := Concatenation( r[ 1 ], "Derived^• category(", r[ 2 ], " ", Name( C ), " ", r[ 1 ], ")", r[ 2 ] );
      
    else
      
      name := Concatenation( r[ 1 ], "Derived_• category(", r[ 2 ], " ", Name( C ), " ", r[ 1 ], ")", r[ 2 ] );
      
    fi;
    
    D := CreateCapCategory( name );
    
    SetFilterObj( D, IsDerivedCategory );
    
    SetDefiningCategory( D, C );
    
    SetUnderlyingCategory( D, HomotopyCategory( C, over_cochains ) );
    
    AddObjectRepresentation( D, IsDerivedCategoryObject );
    
    AddMorphismRepresentation( D, IsDerivedCategoryMorphism );
    
    SetIsAbCategory( D, true );
    
    if HasIsLinearCategoryOverCommutativeRing( C ) and 
        IsLinearCategoryOverCommutativeRing( C ) then
        
        SetIsLinearCategoryOverCommutativeRing( D, true );
        
        SetCommutativeRingOfLinearCategory( D,
              CommutativeRingOfLinearCategory( C )
            );
        
        AddMultiplyWithElementOfCommutativeRingForMorphisms( D,
          function( e, alpha )
            local roof;
            
            roof := UnderlyingRoof( alpha );
            
            return Roof(
                    MultiplyWithElementOfCommutativeRingForMorphisms( e, SourceMorphism( roof ) ),
                    RangeMorphism( roof )
                  ) / D;
        end );
        
    fi;
    
    ##
    AddIsEqualForObjects( D,
      function( a1, a2 )
        
        return IsEqualForObjects( UnderlyingCell( a1 ), UnderlyingCell( a2 ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( D,
      function( alpha, beta )
        local roof_alpha, roof_beta;
        
        roof_alpha := UnderlyingRoof( alpha );
        
        roof_beta := UnderlyingRoof( beta );
        
        return IsEqualForMorphisms(
                  SourceMorphism( roof_alpha ),
                    SourceMorphism( roof_beta ) ) and
                IsEqualForMorphisms(
                  RangeMorphism( roof_alpha ),
                    RangeMorphism( roof_beta ) );
                
    end );
    
    ##
    AddIsZeroForObjects( D,
      function( a )
      
        return IsExact( UnderlyingCell( UnderlyingCell( a ) ) );
        
    end );
    
    ##
    AddIdentityMorphism( D,
      function( a )
        
        return IdentityMorphism( UnderlyingCell( a ) ) / D;
        
    end );
    
    ##
    AddZeroObject( D,
      {} -> ZeroObject( UnderlyingCategory( D ) ) / D
    );
    
    ##
    AddZeroMorphism( D,
      function( a, b )
        
        a := UnderlyingCell( a );
        
        b := UnderlyingCell( b );
        
        return Roof( IdentityMorphism( a ), ZeroMorphism( a, b ) ) / D;
        
    end );
    
    ##
    AddPreCompose( D,
      function( alpha_1, alpha_2 )
        local roof_1, roof_2;
        
        roof_1 := UnderlyingRoof( alpha_1 );
        
        roof_2 := UnderlyingRoof( alpha_2 );
        
        return PreComposeRoofs( roof_1, roof_2 ) / D;
        
    end );
    
    ##
    AddIsIsomorphism( D,
      function( alpha )
        local roof;
        
        roof := UnderlyingRoof( alpha );
        
        return IsQuasiIsomorphism( RangeMorphism( roof ) );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( D,
      function( a )
      
        return IsWellDefined( UnderlyingCell( a ) );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( D,
      function( alpha )
        local roof, source_morphism, range_morphism;
        
        roof := UnderlyingRoof( alpha );
        
        source_morphism := SourceMorphism( roof );
        
        range_morphism := RangeMorphism( roof );
        
        return IsEqualForObjects( Source( source_morphism ), Source( range_morphism ) ) and
                IsWellDefined( source_morphism ) and
                  IsWellDefined( range_morphism ) and
                    IsQuasiIsomorphism( source_morphism );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( D,
      function( alpha )
        local roof;
        
        roof := UnderlyingRoof( alpha );
        
        return Roof(
                  SourceMorphism( roof ),
                  AdditiveInverseForMorphisms( RangeMorphism( roof ) )
                ) / D;
                
    end );
    
    D!.is_computable := false;
    
    if IsAbelianCategoryWithComputableEnoughProjectives( C ) then
      
      ADD_SPECIAL_METHODS_BY_ENOUGH_PROJECTIVE_OBJECTS( D );
      
    elif IsAbelianCategoryWithComputableEnoughInjectives( C ) then
      
      ADD_SPECIAL_METHODS_BY_ENOUGH_INJECTIVE_OBJECTS( D );
      
    fi;
    
    Finalize( D );
    
    return D;
    
end );

##
InstallGlobalFunction( ADD_SPECIAL_METHODS_BY_ENOUGH_PROJECTIVE_OBJECTS,
  function( D )
    local C, P, I, Ho_C, L, range_cat;
    
    D!.is_computable := true;
    
    C := DefiningCategory( D );
    
    P := FullSubcategoryGeneratedByProjectiveObjects( C );
    
    I := InclusionFunctor( P );
    
    I := ExtendFunctorToHomotopyCategories( I );
    
    Ho_C := HomotopyCategory( C );
    
    L := LocalizationFunctorByProjectiveObjects( Ho_C );
     
    AddIsCongruentForMorphisms( D,
      function( alpha, beta )
        local U;
        
        U := UniversalFunctorFromDerivedCategory( L );
        
        return IsCongruentForMorphisms( ApplyFunctor( U, alpha ), ApplyFunctor( U, beta ) );
        
    end );
    
    AddIsZeroForMorphisms( D,
      function( alpha )
        local U;
        
        U := UniversalFunctorFromDerivedCategory( L );
        
        return IsZeroForMorphisms( ApplyFunctor( U, alpha ) );
        
    end );
    
    AddAdditionForMorphisms( D,
      function( alpha, beta )
        local a, qa, b, qb, U, m, roof;
        
        a := UnderlyingCell( Source( alpha ) );
        
        qa := QuasiIsomorphismFromProjectiveResolution( a, true );
        
        b := UnderlyingCell( Range( alpha ) );
        
        qb := QuasiIsomorphismFromProjectiveResolution( b, true );
        
        U := UniversalFunctorFromDerivedCategory( L );
        
        m := AdditionForMorphisms( ApplyFunctor( U, alpha ), ApplyFunctor( U, beta ) );
        
        roof := Roof( qa, PreCompose( ApplyFunctor( I, m ), qb ) );
        
        return roof / D;
        
    end );
    
    if HasRangeCategoryOfHomomorphismStructure( Ho_C ) then
      
      range_cat := RangeCategoryOfHomomorphismStructure( Ho_C );
      
      if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
        
        SetRangeCategoryOfHomomorphismStructure( D, range_cat );
        
        AddDistinguishedObjectOfHomomorphismStructure( D,
          {} -> DistinguishedObjectOfHomomorphismStructure( Ho_C )
        );
        
        AddHomomorphismStructureOnObjects( D,
          function( a, b )
            local Pa, Pb;
            
            Pa := ProjectiveResolution( UnderlyingCell( a ), true );
            
            Pb := ProjectiveResolution( UnderlyingCell( b ), true );
            
            return HomomorphismStructureOnObjects( Pa, Pb );
            
        end );
        
        AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
          function( s, phi, psi, r )
            local roof_phi, roof_psi;
            
            phi := AsMorphismBetweenProjectiveResolutions( UnderlyingRoof( phi ) );
            
            psi := AsMorphismBetweenProjectiveResolutions( UnderlyingRoof( psi ) );
            
            return HomomorphismStructureOnMorphismsWithGivenObjects( s, phi, psi, r );
            
        end );
        
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( D,
          function( phi )
            local roof_phi;
            
            phi := AsMorphismBetweenProjectiveResolutions( UnderlyingRoof( phi ) );
            
            return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( phi );
            
        end );
        
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
          function( s, r, phi )
            local qs, qr;
            
            qs := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( s ), true );
            
            qr := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( r ), true );
            
            phi := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( qs ), Source( qr ), phi );
            
            return Roof( qs, PreCompose( phi, qr ) ) / D;
            
        end );
       
     fi;
      
    fi;
    
    
    if CanCompute( Ho_C, "BasisOfExternalHom" ) and
        CanCompute( Ho_C, "CoefficientsOfMorphismWithGivenBasisOfExternalHom" ) then
        
        AddBasisOfExternalHom( D,
          function( a, b )
            local qa, qb, U, Ua, Ub, B;
            
            qa := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( a ), true );
            
            qb := QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( b ), true );
            
            B := BasisOfExternalHom( Source( qa ), Source( qb ) );
            
            return List( B, m -> Roof( qa, PreCompose( m, qb ) ) / D );
            
        end );
        
        AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( D,
          function( phi, B )
            local roof_phi;
            
            phi := AsMorphismBetweenProjectiveResolutions( UnderlyingRoof( phi ) );
            
            return CoefficientsOfMorphism( phi );
            
        end );
        
    fi;
      
end );

##
InstallGlobalFunction( ADD_SPECIAL_METHODS_BY_ENOUGH_INJECTIVE_OBJECTS,
  function( D )
    
    # complete the code similarily to the above global function
    
end );

#######################
#
# View & Display
#
######################

##
InstallMethod( ViewObj,
          [ IsRoof ],
  function( roof )
    
    Print( "<A roof s <~~ a --> r in ", Name( CapCategory( SourceMorphism( roof ) ) ), ">" );
    
end );

##
InstallMethod( Display,
          [ IsRoof ],
  function( roof )
    
    Print( "A roof s <~~ a --> r, defined over ", Name( CapCategory( SourceMorphism( roof ) ) ), " by the following data:\n\n" );
    
    Print( TextAttr.b4, "Source Morphism:", TextAttr.reset, "\n\n" );
    Display( SourceMorphism( roof ) );
    
    Print( TextAttr.b4, "Range Morphism:", TextAttr.reset, "\n\n" );
    Display( RangeMorphism( roof ) );
    
end );

##
InstallMethod( Display,
          [ IsDerivedCategoryObject ],
  function( a )
    local c, l, u;
    
    c := UnderlyingCell( UnderlyingCell( a ) );
    
    l := ActiveLowerBound( c );
    
    u := ActiveUpperBound( c );
    
    DISPLAY_DATA_OF_CHAIN_OR_COCHAIN_COMPLEX( c, l, u );
    
    Print( "\nAn object in ", Name( CapCategory( a ) ), " given by the above data\n" );
    
end );

##
InstallMethod( ViewObj,
          [ IsDerivedCategoryObject ],
  function( a )
    
    Print( "<An object in ", Name( CapCategory( a ) ) );
    
    a := UnderlyingCell( a );
    
    if HasActiveLowerBound( a ) then
      Print( " with active lower bound ", ActiveLowerBound( a ) );
    fi;
    
    if HasActiveUpperBound( a ) then
      Print( " and active upper bound ", ActiveUpperBound( a ) );
    fi;
    
    Print(">" );
    
end );
 
##
InstallMethod( Display,
          [ IsDerivedCategoryMorphism ],
  function( a )
    
    Display( UnderlyingRoof( a ) );
    
    Print( "\nA morphism in ", Name( CapCategory( a ) ), " given by the above roof\n" );
    
end );

InstallMethod( ViewObj,
          [ IsDerivedCategoryMorphism ],
  function( a )
    
    Print( "<A morphism in ", Name( CapCategory( a ) ), ">" );
    
end );

InstallOtherMethod( LaTeXStringOp,
              [ IsDerivedCategoryObject ],
  a -> LaTeXStringOp( UnderlyingCell( a ) )
);

##
InstallOtherMethod( LaTeXStringOp,
        [ IsDerivedCategoryMorphism ],
        
  function( phi )
    local roof, f, g, l, u;
    
    roof := UnderlyingRoof( phi );
    
    f := SourceMorphism( roof );
    
    g := RangeMorphism( roof );
    
    l := Minimum(
            [
              ActiveLowerBound( Range( f ) ),
              ActiveLowerBound( Source( f ) ),
              ActiveLowerBound( Range( g ) )
            ]
          );
    
    u := Maximum(
            [
              ActiveUpperBound( Range( f ) ),
              ActiveUpperBound( Source( f ) ),
              ActiveUpperBound( Range( g ) )
            ]
          );
    
    return LaTeXStringOp( phi, l, u );
    
end );

##
InstallOtherMethod( LaTeXStringOp,
        [ IsDerivedCategoryMorphism, IsInt, IsInt ],
        
  function( phi, l, u )
    local over_cochains, f, g, s, i;
    
    over_cochains := IsCochainComplexCategory( UnderlyingCategory( UnderlyingCategory( CapCategory( phi ) ) ) );
    
    f := SourceMorphism( UnderlyingRoof( phi ) );
    
    g := RangeMorphism( UnderlyingRoof( phi ) );
      
    s := "\\begin{array}{ccccc}\n ";
    
    if over_cochains then
      
      s := Concatenation(
              s,
              LaTeXStringOp( Range( f )[ u ] ),
              "&\\leftarrow\\phantom{-}{",
              LaTeXStringOp( f[ u ] : OnlyDatum := true ),
              "}\\phantom{-}-&{",
              LaTeXStringOp( Source( f )[ u ] ),
              "}&-\\phantom{-}{",
              LaTeXStringOp( g[ u ] : OnlyDatum := true ),
              "}\\phantom{-}\\rightarrow&{",
              LaTeXStringOp( Range( g )[ u ] ),
              "}\n \\\\ \n"
            );
            
      for i in Reversed( [ l .. u - 1 ] ) do
        
        s := Concatenation(
                s,
                " \\uparrow_{\\phantom{", String( i ), "}}",
                "&&",
                " \n \\uparrow_{\\phantom{", String( i ), "}}",
                "&&",
                " \n \\uparrow_{\\phantom{", String( i ), "}}",
                "\n \\\\ \n "
              );
              
        s := Concatenation(
                s,
                LaTeXStringOp( Range( f ) ^ i : OnlyDatum := true ),
                "&&",
                LaTeXStringOp( Source( f ) ^ i : OnlyDatum := true ),
                "&&",
                LaTeXStringOp( Range( g ) ^ i : OnlyDatum := true ),
                "\n \\\\ \n "
              );
              
        s := Concatenation(
                s,
                "\\vert_{", String( i ), "} ",
                "&&",
                "\\vert_{", String( i ), "} ",
                "&&",
                "\\vert_{", String( i ), "} ",                
                "\n \\\\ \n "
              );
              
        s := Concatenation(
              s,
              LaTeXStringOp( Range( f )[ i ] ),
              "&\\leftarrow\\phantom{-}",
              LaTeXStringOp( f[ i ] : OnlyDatum := true ),
              "\\phantom{-}-&",
              LaTeXStringOp( Source( f )[ i ] ),
              "&-\\phantom{-}{",
              LaTeXStringOp( g[ i ] : OnlyDatum := true ),
              "}\\phantom{-}\\rightarrow&",
              LaTeXStringOp( Range( g )[ i ] ),
              "\n \\\\ \n "
            );
            
      od;
      
    else
      
      for i in Reversed( [ l + 1 .. u ] ) do
        
        s := Concatenation(
              s,
              "\\\\ \n",
              LaTeXStringOp( Range( f )[ i ] ),
              "&\\leftarrow\\phantom{-}{",
              LaTeXStringOp( f[ i ] : OnlyDatum := true ),
              "}\\phantom{-}-&",
              LaTeXStringOp( Source( f )[ i ] ),
              "&-\\phantom{-}{",
              LaTeXStringOp( g[ i ] : OnlyDatum := true ),
              "}\\phantom{-}\\rightarrow&",
              LaTeXStringOp( Range( g )[ i ] ),
              "\n "
            );
            
        s := Concatenation(
                s,
                "\\\\ \n \\vert^{", String( i ), "} ",
                "&& \n",
                "\\vert^{", String( i ), "}",
                "&&",
                "\\vert^{", String( i ), "} ",
                "\n \\\\ \n "
              );
              
        s := Concatenation(
                s,
                LaTeXStringOp( Range( f ) ^ i : OnlyDatum := true ),
                "&&",
                LaTeXStringOp( Source( f ) ^ i : OnlyDatum := true ),
                "&&",
                LaTeXStringOp( Range( g ) ^ i : OnlyDatum := true ),
                "\n \\\\ \n "
              );
              
        s := Concatenation(
                s,
                " \\downarrow_{\\phantom{", String( i ), "}}",
                "&&",
                " \\downarrow_{\\phantom{", String( i ), "}}",
                "&&",
                " \n \\downarrow_{\\phantom{", String( i ), "}}"
              );
              
      od;
      
      s := Concatenation(
              s,
              "\\\\ \n",
              LaTeXStringOp( Range( f )[ l ] ),
              "&\\leftarrow\\phantom{-}{",
              LaTeXStringOp( f[ l ] : OnlyDatum := true ),
              "}\\phantom{-}-&",
              LaTeXStringOp( Source( f )[ l ] ),
              "&-\\phantom{-}{",
              LaTeXStringOp( g[ l ] : OnlyDatum := true ),
              "}\\phantom{-}\\rightarrow&",
              LaTeXStringOp( Range( g )[ l ] ),
              "\n \\\\ \n "
            );
            
    fi;
     
    s := Concatenation( s, "\\end{array}" );
    
    return s;
    
end );

