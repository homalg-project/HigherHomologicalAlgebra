#############################################################################
##
##  DerivedCategories: Derived categories for abelian categories
##
##  Copyright 2020, Kamal Saleh, University of Siegen
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
    
    s := SourceMorphism( roof_2 );
    
    r := RangeMorphism( roof_1 );
    
    A := Source( s );
    
    B := Range( s );
    
    C := Source( r );
    
    tau := MorphismIntoStandardConeObject( s );
    
    r_o_tau := PreCompose( r, tau );
    
    D := Shift( StandardConeObject( r_o_tau ), -1 );
    
    rr_maps := AsZFunction(
                i -> MorphismBetweenDirectSums(
                  [
                    [ ZeroMorphism( C[ i ], A[ i ] ) ],
                    [ IdentityMorphism( A[ i ] ) ],
                    [ ZeroMorphism( B[ i + 1], A[ i ] ) ]
                  ] ) );
                  
    rr := ChainMorphism( UnderlyingCell( D ), UnderlyingCell( A ), rr_maps ) / Ho_C;
    
    ss_maps := AsZFunction(
                i -> MorphismBetweenDirectSums(
                  [
                    [ AdditiveInverse( IdentityMorphism( C[ i ] ) ) ],
                    [ ZeroMorphism( A[ i ], C[ i ] ) ],
                    [ ZeroMorphism( B[ i + 1], C[ i ] ) ]
                  ] ) );
    
    ss := ChainMorphism( UnderlyingCell( D ), UnderlyingCell( C ), ss_maps ) / Ho_C;
    
    ss := PreCompose( ss, SourceMorphism( roof_1 ) );
    
    rr := PreCompose( rr, RangeMorphism( roof_2 ) );
    
    return Roof( ss, rr );
    
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
InstallMethod( DerivedCategory,
          [ IsCapCategory ],
  function( C )
    local r, name, D;
    
    r := RandomTextColor( Name( C ) );
    
    name := Concatenation( r[ 1 ], "Derived category(", r[ 2 ], " ", Name( C ), " ", r[ 1 ], ")", r[ 2 ] );
    
    D := CreateCapCategory( name );
    
    SetFilterObj( D, IsDerivedCategory );
    
    SetDefiningCategory( D, C );
    
    AddObjectRepresentation( D, IsDerivedCategoryObject );
    
    AddMorphismRepresentation( D, IsDerivedCategoryMorphism );
    
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
    AddIdentityMorphism( D,
      function( a )
        
        return IdentityMorphism( UnderlyingCell( a ) ) / D;
        
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
   
    D!.is_computable := false;
    
    Finalize( D );
    
    return D;
    
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
    
    Print( "<A roof s <~~ a --> r, defined over ", Name( CapCategory( SourceMorphism( roof ) ) ), ">" );
    
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
  
    Print( "An object in derived category defined by:\n\n" );

    Display( UnderlyingCell( a ) );

end );

##
InstallMethod( ViewObj,
          [ IsDerivedCategoryObject ],
  function( a )
    
    Print( "<An object in ", Name( CapCategory( a ) ), ">" );

end );
 
##
InstallMethod( Display,
          [ IsDerivedCategoryMorphism ],
  function( a )
  
    Print( "A morphism in derived category defined by:\n\n" );

    Display( UnderlyingRoof( a ) );

end );

InstallMethod( ViewObj,
          [ IsDerivedCategoryMorphism ],
  function( a )
    
    Print( "<A morphism in ", Name( CapCategory( a ) ), ">" );
    
end );

