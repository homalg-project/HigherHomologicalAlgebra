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
  function( roof )
    
    return IsIsomorphism( QuasiIsomorphism( roof ) );
    
end );

##
InstallMethod( AsHonestMorphism,
          [ IsRoof ],
  function( roof )
    
    return PreCompose( Inverse( QuasiIsomorphism( roof ) ), RangeMorphism( roof ) );
    
end );

##
InstallMethod( DerivedCategoryObject,
          [ IsDerivedCategory, IsHomotopyCategoryObject ],
  function( D, object )
    local homotopy, o;
    
    homotopy := CapCategory( object );
    
    if not IsIdenticalObj( DefiningCategory( D ), DefiningCategory( homotopy ) ) then
      
      Error( "wronge input" );
      
    fi;
    
    o := rec( );
    
    ObjectifyObjectForCAPWithAttributes( o, D,
            UnderlyingCell, object );
    
    return o;
    
end );

##
InstallMethod( \[\],
          [ IsDerivedCategoryObject, IsInt ],
  { a, i } -> UnderlyingCell( a )[ i ] );

##
InstallMethod( \^,
          [ IsDerivedCategoryObject, IsInt ],
  { a, i } -> UnderlyingCell( a ) ^ i );

##
InstallMethod( \/, [ IsHomotopyCategoryObject, IsDerivedCategory ], { a, D } -> DerivedCategoryObject( D, a ) );

##
InstallMethod( DerivedCategoryMorphism,
          [ IsDerivedCategoryObject, IsRoof, IsDerivedCategoryObject ],
  function( source, roof, range )
    local D, homotopy, m;
    
    D := CapCategory( source );
    
    homotopy := CapCategory( SourceMorphism( roof ) );
    
    if not IsIdenticalObj( DefiningCategory( D ), DefiningCategory( homotopy ) ) then
      
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
InstallMethod( \/, [ IsRoof, IsDerivedCategory ], {r,D} -> DerivedCategoryMorphism(D,r) );

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
InstallMethod( \/, [ IsHomotopyCategoryMorphism, IsDerivedCategory ], {alpha,D} -> DerivedCategoryMorphism(D,alpha) );

##
InstallMethod( DerivedCategory,
          [ IsCapCategory ],
  function( C )
    local r, name, D;
    
    r := RandomTextColor( );
    
    name := Concatenation( r[ 1 ], "Derived category (", r[ 2 ], " ", Name( C ), " ", r[ 1 ], ")", r[ 2 ] );
    
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
        
        return IsEqualForMorphisms( SourceMorphism( roof_alpha ), SourceMorphism( roof_beta ) ) and
                IsEqualForMorphisms( RangeMorphism( roof_alpha ), RangeMorphism( roof_beta ) );
                
    end );
    
    ##
    AddIdentityMorphism( D,
      function( a )
        
        return IdentityMorphism( UnderlyingCell( a ) ) / D;
        
    end );
    
    ##TODO add PreCompose
    
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

InstallMethod( ViewObj,
          [ IsDerivedCategoryObject ],
  function( a )
    
    Print( "<An object in derived category defined by: " );

    ViewObj( UnderlyingCell( a ) );
    
    Print(">" );

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
    
    Print( "<A morphism in derived category defined by: " );

    ViewObj( UnderlyingRoof( a ) );
    
    Print(">" );

end );

