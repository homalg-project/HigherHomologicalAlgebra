# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
#
#####################################################################

########################
##
## Declarations
##
########################

DeclareRepresentation( "IsHomotopyCategoryRep",
                       IsCapCategoryRep and IsHomotopyCategory and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheTypeOfHomotopyCategory",
        NewType( TheFamilyOfCapCategories,
                IsHomotopyCategoryRep ) );

##
InstallMethod( HomotopyCategoryByChains,
          [ IsCapCategory ],
          
  cat -> HomotopyCategory( cat, false )
);

##
InstallOtherMethod( HomotopyCategory,
          [ IsCapCategory ],
          
  HomotopyCategoryByChains
);

##
InstallMethod( HomotopyCategoryByCochains,
          [ IsCapCategory ],
          
  cat -> HomotopyCategory( cat, true )
);

##
InstallMethod( CohomotopyCategory,
          [ IsCapCategory ],
          
  HomotopyCategoryByCochains
);


# The StandardHomomorphismStructure is the one that comes from the stable structure.
# There is another way to equip the homotopy categories with a homomorphism structure,
# By the use of double complexes.
#
# if WithStandardHomomorphismStructure = false then the second way will be used,
# otherwise, the standard one will be used.
##

##
InstallMethod( HomotopyCategoryOp,
          [ IsCapCategory, IsBool ],
          
  function( cat, over_cochains )
    local complex_cat, bullet, coliftable_function, name, finalize, special_filters, homotopy_category, r;
    
    if over_cochains then
      
      complex_cat := CochainComplexCategory( cat );
      bullet := "^•";
      
    else
      
      complex_cat := ChainComplexCategory( cat );
      bullet := "";

    fi;
    
    if not ( HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) ) then
    
      Error( "The input category should be at least additive category" );
      
    fi;
      
    if not CanCompute( complex_cat, "IsColiftableAlongMorphismToColiftingObject" ) then
        
        Error( "The method IsColiftableAlongMorphismToColiftingObject should be added to the category of chains!" );
        
    fi;
        
    finalize := ValueOption( "FinalizeCategory" );
    
    special_filters := ValueOption( "SpecialFilters" );
    
    if special_filters = fail then
      
      special_filters := [ IsHomotopyCategory, IsHomotopyCategoryObject, IsHomotopyCategoryMorphism ];
      
    fi;
    
    homotopy_category := StableCategoryBySystemOfColiftingObjects( complex_cat :
                              FinalizeCategory := false,
                              WithHomomorphismStructure := true,
                              SpecialFilters := special_filters
                            );
    
    r := RandomTextColor( Name( cat ) );
    
    name := Concatenation( r[ 1 ], "Homotopy", bullet, " category( ", r[ 2 ],  Name( cat ), r[ 1 ], " )", r[ 2 ] );

    homotopy_category!.Name := name;
    
    ADD_FUNCTIONS_FOR_TRIANGULATED_OPERATIONS( homotopy_category );
    
    SetDefiningCategory( homotopy_category, cat );
    
    if ValueOption( "WithStandardHomomorphismStructure" ) <> true and not over_cochains and
        
        HasRangeCategoryOfHomomorphismStructure( cat ) then
        
        Info( InfoHomotopyCategories, 2, "The classical methods will be installed for the homomorphism structure on homotopy categories" );
        
        ADD_HOM_STRUCTURE_TO_HOMOTOPY_CATEGORY_OVER_CHAINS( homotopy_category );
        
    fi;
    
    if ValueOption( "WithStandardHomomorphismStructure" ) <> true and over_cochains and
        
        HasRangeCategoryOfHomomorphismStructure( cat ) then
        
        Info( InfoHomotopyCategories, 2, "The classical methods will be installed for the homomorphism structure on homotopy categories" );
        
        ADD_HOM_STRUCTURE_TO_HOMOTOPY_CATEGORY_OVER_COCHAINS( homotopy_category );
        
    fi;
    
    if finalize = false then
      
      return homotopy_category;
      
    else
      
      Finalize( homotopy_category );
      
      return homotopy_category;
      
    fi;
    
end );

##
InstallMethod( FullSubcategoryGeneratedByObjectsConcentratedInDegreeOp,
          [ IsHomotopyCategory, IsInt ],
  function( homotopy_category, i )
    local name, r, full;
    
    name := Concatenation( "Full additive subcategory generated by objects concentrated in homological degree ", String( i ) );
    
    r := RandomTextColor( Name( homotopy_category ) );
    
    name := Concatenation( r[ 1 ], name, "( ", r[ 2 ], Name( homotopy_category ), r[ 1 ], " )", r[ 2 ] );
    
    full := ValueGlobal( "FullSubcategory" )( homotopy_category, name : FinalizeCategory := false, is_additive := true );
    
    AddIsWellDefinedForObjects( full,
      function( a )
        local c;
        
        c := UnderlyingCell( UnderlyingCell( a ) );
        
        return IsWellDefined( c ) and ActiveUpperBound( c ) = ActiveLowerBound( c ) and ActiveLowerBound( c ) = i;
        
    end );
    
    AddIsWellDefinedForMorphisms( full,
      function( alpha )
        local c;
        
        c := UnderlyingCell( UnderlyingCell( alpha ) );
        
        return IsWellDefined( c ) and ActiveUpperBound( c ) = ActiveLowerBound( c ) and ActiveLowerBound( c ) = i;
        
    end );
    
    Finalize( full );
    
    return full;
    
end );

InstallGlobalFunction( ADD_HOM_STRUCTURE_TO_HOMOTOPY_CATEGORY_OVER_COCHAINS,
  function( homotopy_category )
    local homotopy_cat;
    
    homotopy_cat := HomotopyCategory( DefiningCategory( homotopy_category ), false );
    
    SetRangeCategoryOfHomomorphismStructure( homotopy_category,
      RangeCategoryOfHomomorphismStructure( homotopy_cat )
    );
    
    AddDistinguishedObjectOfHomomorphismStructure( homotopy_category,
      { } -> DistinguishedObjectOfHomomorphismStructure( homotopy_cat )
    );
    
    AddHomomorphismStructureOnObjects( homotopy_category,
      { a, b } ->
        HomomorphismStructureOnObjects(
            AsChainComplex( UnderlyingCell( a ) ) / homotopy_cat,
            AsChainComplex( UnderlyingCell( b ) ) / homotopy_cat
          )
    );
    
    AddHomomorphismStructureOnMorphismsWithGivenObjects( homotopy_category,
      { s, alpha, beta, r } ->
        HomomorphismStructureOnMorphismsWithGivenObjects(
          s,
          AsChainMorphism( UnderlyingCell( alpha ) ) / homotopy_cat,
          AsChainMorphism( UnderlyingCell( beta  ) ) / homotopy_cat,
          r
        )
    );
    
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( homotopy_category,
      alpha ->
        InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure(
          AsChainMorphism( UnderlyingCell( alpha ) ) / homotopy_cat
        )
    );
    
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( homotopy_category,
      { s, r, eta } ->
        AsCochainMorphism(
          UnderlyingCell(
            InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
              AsChainComplex( UnderlyingCell( s ) ) / homotopy_cat,
              AsChainComplex( UnderlyingCell( r ) ) / homotopy_cat,
              eta
            )
          )
        ) / homotopy_category
    );
    
    AddBasisOfExternalHom( homotopy_category,
      { a, b } ->
        List(
          BasisOfExternalHom(
              AsChainComplex( UnderlyingCell( a ) ) / homotopy_cat,
              AsChainComplex( UnderlyingCell( b ) ) / homotopy_cat
            ),
          m -> AsCochainMorphism( UnderlyingCell( m ) ) / homotopy_category
        )
    );
    
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( homotopy_category,
      { alpha, basis } ->
        CoefficientsOfMorphismWithGivenBasisOfExternalHom(
          AsChainMorphism( UnderlyingCell( alpha ) ) / homotopy_cat,
          List( basis, m -> AsChainMorphism( UnderlyingCell( m ) ) / homotopy_cat )
        )    
    );
    
end );

## This function computes the homotopy by solving the associated two sided linear system of morphisms in the category.
##
InstallGlobalFunction( IS_COLIFTABLE_THROUGH_COLIFTING_OBJECT_IN_HOMOTOPY_CATEGORY,
  function( phi )
    local A, B, m, n, L, K, b, sol, H;

    A := Source( phi );

    B := Range( phi );
    
    # The following is to set better bounds to the complexes if possible
    ObjectsSupport( A );
    ObjectsSupport( B );
    
    if IsCochainMorphism( phi ) then

      m := Minimum( ActiveLowerBound( A ), ActiveLowerBound( B ) );
      n := Maximum( ActiveUpperBound( A ), ActiveUpperBound( B ) );

      L := Concatenation( 
          
            List( [ 1 .. n - m ], 
              i -> Concatenation(
                ##
                List( [ 1 .. i - 1 ],
                  j -> ZeroMorphism( A[ i + m - 1 ],A[ j + m - 1 ] ) ),
                ##
                [ IdentityMorphism( A[ i + m - 1 ] ), A^( i + m - 1 ) ],
                ##
                List( [ i + 2 ..n - m + 1 ], 
                  j -> ZeroMorphism( A[ i + m - 1 ] , A[ j + m - 1 ] ) )
                                )
              ),

              [ Concatenation(
                  List( [ 1 .. n - m ], 
                    j -> ZeroMorphism( A[ n ], A[ j + m - 1 ] ) ), 
                
                  [ IdentityMorphism( A[ n ] ) ] ) ] 
                  
            );

      K := Concatenation(
    
            List( [ 1 .. n - m ],
              i -> Concatenation( 
                
                List( [ 1 .. i - 1 ], 
                  j -> ZeroMorphism( B[ j + m - 2 ],B[ i + m - 1 ] ) ),
                
                [ B^( i + m - 2 ), IdentityMorphism( B[ i + m - 1 ] ) ],
                
                
                List( [ i + 2 ..n - m + 1 ],
                  j -> ZeroMorphism( B[ j + m - 2 ], B[ i + m - 1 ]) ) 
                                ) 
              ),
                
            [ Concatenation(
                
                List([ 1 .. n - m ], 
                  j -> ZeroMorphism( B[ j + m - 2 ], B[ n ] ) ),
                  
                [ B^(n - 1) ] ) ] 
              
            );
    
      b := List( [ m .. n ], i -> phi[ i ] );

      sol := SolveLinearSystemInAbCategoryOrFail( L, K, b );
    
      if sol = fail then
        
        SetHomotopyMorphisms( phi, fail );
        
        SetIsNullHomotopic( phi, false );
       
        return false;
      
      else
       
        # This H is not well-defined, we only need the infinite list
        
        if not HasHomotopyMorphisms( phi ) then
          
          H := CochainMorphism( A, ShiftLazy( B, -1 ), sol, m );
        
          H := Morphisms( H );
           
          SetHomotopyMorphisms( phi, H );
          
        fi;
        
        SetIsNullHomotopic( phi, true );
        
        return true;
      
      fi;
      
    else

      m := Minimum( ActiveLowerBound( A ), ActiveLowerBound( B ) );
      n := Maximum( ActiveUpperBound( A ), ActiveUpperBound( B ) );    

      L := Concatenation( 
          
            List( [ 1 .. n - m ],
              i -> Concatenation(
              
                List( [ 1 .. i - 1 ], 
                  j -> ZeroMorphism( A[ -i + n + 1 ], A[ -j + n + 1 ] ) ),
          
                [ IdentityMorphism( A[ -i + n + 1 ] ), A^( -i + n + 1 ) ],

                  List( [ i + 2 ..-m + n + 1 ],
                  j -> ZeroMorphism( A[ -i + n + 1 ] , A[ -j + n + 1 ] ) ) 
                
                                )
              
                ),
    
            [ Concatenation( 
                
                List([ 1 .. n - m ],
                  j -> ZeroMorphism( A[ m ], A[ -j + n + 1 ] ) ),
                  
                [ IdentityMorphism( A[ m ] ) ] 
                
                ) ] 
                
            );

      K := Concatenation(
          
            List( [ 1 .. n - m ],
              i -> Concatenation(
                
                List( [ 1 .. i - 1 ],
                    j -> ZeroMorphism( B[ -j + n + 2 ], B[ -i + n + 1 ] ) ), 
                    
                [ B^( -i + n + 2 ), IdentityMorphism( B[ -i + n + 1 ] ) ],
                
                List( [ i + 2 ..n - m + 1 ],
                  
                  j -> ZeroMorphism( B[ -j + n + 2 ], B[ -i + n + 1 ] ) ) ) 
                
                ),
                
            [ Concatenation(
              
                List([ 1 .. n - m ], j -> ZeroMorphism( B[ -j + n + 2 ], B[ m ] ) ),
              
                [ B^( m + 1 ) ] ) ] 
              
            );

      b := List( Reversed( [ m .. n ] ), i -> phi[ i ] );
     
      sol := SolveLinearSystemInAbCategoryOrFail( L, K, b );
      
      if sol = fail then
        
        SetHomotopyMorphisms( phi, fail );
        
        SetIsNullHomotopic( phi, false );
       
        return false;
      
      else
        
        if not HasHomotopyMorphisms( phi ) then
          
          H := ChainMorphism( A, ShiftLazy( B, 1 ), Reversed( sol ), m );
        
          H := Morphisms( H );
           
          SetHomotopyMorphisms( phi, H );
          
        fi;
        
        SetIsNullHomotopic( phi, true );
        
        return true;
      
      fi;
      
    fi;

end );

