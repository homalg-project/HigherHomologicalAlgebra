#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   13.Feb.2017                             Kamal Saleh
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

# The StandardHomomorphismStructure is the one that comes from the stable structure.
# There is another way to enhance the homotopy categories with a homomorphism structure,
# By the use of double complexes.
#
# if WithStandardHomomorphismStructure = false then the second way will be used,
# otherwise, the standard one will be used.
##
InstallMethod( HomotopyCategory,
      [ IsCapCategory ],
  function( cat )
    local chains, coliftable_function, name, to_be_finalized, special_filters, homotopy_category;
    
    chains := ChainComplexCategory( cat : FinalizeCategory := false );
    
    if HasIsFinalized( chains ) then
      
      if not CanCompute( chains, "MorphismIntoColiftingObject" ) or
          not CanCompute( chains, "IsColiftableThroughColiftingObject" ) then
          
          Error( "The chains complex category seems to have been finalized without adding colifting structure" );
          
      fi;
    
    else
    
      AddMorphismIntoColiftingObject( chains,
        function( a )
      
          return NaturalInjectionInMappingCone( IdentityMorphism( a ) );
        
      end );
    
      coliftable_function := ValueOption( "is_coliftable_through_colifting_object_func" );
    
      if coliftable_function = fail then
      
        if not CanCompute( chains, "IsColiftableThroughColiftingObject" ) then
        
          Error( "The method IsColiftableThroughColiftingObject should be added to the category of chains!" );
        
        fi;
    
      elif IsFunction( coliftable_function ) then
                
        AddIsColiftableThroughColiftingObject( chains, coliftable_function );
        
      else
        
        Error( "The optional input is not valid" );
    
      fi;
      
      Finalize( chains );
    
    fi;
    
    name := Concatenation( "Homotopy category of ", Name( cat ) );
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    special_filters := ValueOption( "SpecialFilters" );
    
    if special_filters = fail then
      
      special_filters := [ IsHomotopyCategory, IsHomotopyCategoryObject, IsHomotopyCategoryMorphism ];
      
    fi;
    
    homotopy_category := StableCategoryByColiftingStructure( chains: NameOfCategory := name,
                                                                     FinalizeCategory := false,
                                                                     WithHomomorphismStructure := true,
                                                                     SpecialFilters := special_filters );
    
    if ValueOption( "WithStandardHomomorphismStructure" ) = false and
      
        ValueGlobal( "HasRangeCategoryOfHomomorphismStructure" )( cat ) then
        
        ADD_HOM_STRUCTURE_TO_HOMOTOPY_CATEGORY( homotopy_category );

    fi;

    ADD_TRIANGULATED_STRUCUTRE( homotopy_category );
    
    if to_be_finalized = false then
      
      return homotopy_category;
    
    fi;

    Finalize( homotopy_category );

    return homotopy_category;
 
end );

###
### For homotopy category
###

##
InstallGlobalFunction( ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_IN_HOMOTOPY_CATEGORY,
  function( homotopy_category )
    local chains, cat, range_cat_of_hom_struc;
       
    chains := UnderlyingCapCategory( homotopy_category );
       
    cat := ValueGlobal( "UnderlyingCategory" )( chains );
       
    range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
        
    AddDistinguishedObjectOfHomomorphismStructure( homotopy_category,
      function( )
           
        if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
          
          return DistinguishedObjectOfHomomorphismStructure( cat );
          
        else
          
          Error( "to do" );

          return 
          HomotopyCategoryObject( homotopy_category,
          ValueGlobal( "StalkChainComplex" )( DistinguishedObjectOfHomomorphismStructure( cat ), 0 ) );
          
        fi;
         
      end );
     
 end );
 
##
InstallGlobalFunction( ADD_HOM_STRUCTURE_ON_CHAINS_IN_HOMOTOPY_CATEGORY,
  function( homotopy_category )
    local chains, cat, range_cat_of_hom_struc;
    
    chains := UnderlyingCapCategory( homotopy_category );
    
    cat := ValueGlobal( "UnderlyingCategory" )( chains );
    
    range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
    
    AddHomomorphismStructureOnObjects( homotopy_category,
      function ( hC, hD )
        local C, D, d;
        
        C := UnderlyingCell( hC );
        
        D := UnderlyingCell( hD );
        
        if not (ValueGlobal( "HasActiveLowerBound" )( C ) and ValueGlobal( "HasActiveUpperBound" )( D )) then
          if not (ValueGlobal( "HasActiveUpperBound" )( C ) and ValueGlobal( "HasActiveLowerBound" )( D )) then
            if not (ValueGlobal( "HasActiveLowerBound" )( C ) and ValueGlobal( "HasActiveUpperBound" )( C )) then
              if not (ValueGlobal( "HasActiveLowerBound" )( D ) and ValueGlobal( "HasActiveUpperBound" )( D )) then
                Error( "The complexes should be bounded" );
              fi;
            fi;
          fi;
        fi; 
        
        d := ValueGlobal( "DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS" )( C, D );
        
        if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
          
          return ValueGlobal( "HomologyAt" )( ValueGlobal( "TotalChainComplex" )( d ), 0 );
          
        else
          
          Error( "to do" );
         
          return HomotopyCategoryObject( homotopy_category, ValueGlobal( "TotalChainComplex" )( d ) );
          
        fi;
  
  end );

end );

##
InstallGlobalFunction( ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS_IN_HOMOTOPY_CATEGORY,
  function( homotopy_category )
    local chains, cat, range_cat_of_hom_struc, chains_range_cat_of_hom_struc, H0;
    
    chains := UnderlyingCapCategory( homotopy_category );
    
    cat := ValueGlobal( "UnderlyingCategory" )( chains );
    
    range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
    
    AddHomomorphismStructureOnMorphismsWithGivenObjects( homotopy_category,
      function( s, h_phi, h_psi, r )
        local phi, psi, ss, rr, Tot1, Tot2, l, chains_range_cat_of_hom_struc, H0;
        
        phi := UnderlyingCell( h_phi );
        
        psi := UnderlyingCell( h_psi );
        
        ss := ValueGlobal( "DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS" )( Range( phi ), Source( psi ) );
        
        rr := ValueGlobal( "DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS" )( Source( phi ), Range( psi ) );
        
        Tot1 := ValueGlobal( "TotalChainComplex" )( ss );
        
        Tot2 := ValueGlobal( "TotalChainComplex" )( rr );
        
        l := ValueGlobal( "MapLazy" )( ValueGlobal( "IntegersList" ), function ( m )
                local ind_s, ind_t, morphisms, obj;
                
                obj := ValueGlobal( "ObjectAt" )( Tot1, m );
                
                obj := ValueGlobal( "ObjectAt" )( Tot2, m );
                
                ind_s := ss!.IndicesOfTotalComplex.(String( m ));
                
                ind_t := rr!.IndicesOfTotalComplex.(String( m ));
                
                morphisms := List( [ ind_s[1] .. ind_s[2] ],
                             function ( i )
                               return List( [ ind_t[1] .. ind_t[2] ],
                                 function ( j )
                                   if i = j then
                                     return HomomorphismStructureOnMorphisms( phi[- i], psi[m - i] );
                                   else
                                     return ZeroMorphism( ValueGlobal( "ObjectAt" )( ss, i, m - i ), ValueGlobal( "ObjectAt" )( rr, j, m - j ) );
                                   fi;
                                 end );
                             end );
                
                return MorphismBetweenDirectSums( morphisms );
              
              end, 1 );
        
        if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
          
          chains_range_cat_of_hom_struc := ValueGlobal( "ChainComplexCategory" )( range_cat_of_hom_struc );
          
          H0 := ValueGlobal( "HomologyFunctorAt" )( chains_range_cat_of_hom_struc, range_cat_of_hom_struc, 0 );
          
          return ApplyFunctor( H0, ValueGlobal( "ChainMorphism" )( Tot1, Tot2, l ) );
          
        else
           
         Error( "to do" );
         
          return HomotopyCategoryMorphism( homotopy_category, ValueGlobal( "ChainMorphism" )( Tot1, Tot2, l ) );
          
        fi;

    end );

end );

##
InstallGlobalFunction( ADD_INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_IN_HOMOTOPY_CATEGORY,
  function( homotopy_category )
    local chains, cat, range_cat_of_hom_struc;
    
    chains := UnderlyingCapCategory( homotopy_category );
    
    cat := ValueGlobal( "UnderlyingCategory" )( chains );
    
    range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
    
    AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( homotopy_category,
        function( h_phi )
          local phi, C, D, lower_bound, upper_bound, morphisms_from_distinguished_object, morphism, d, T, im, inc, U, i;
          
          phi := UnderlyingCell( h_phi );
          
          C := Source( phi );
          
          D := Range( phi );
          
          lower_bound := Minimum( ValueGlobal( "ActiveLowerBound" )( C ), ValueGlobal( "ActiveLowerBound" )( D ) ) + 1;
          
          upper_bound := Maximum( ValueGlobal( "ActiveUpperBound" )( C ), ValueGlobal( "ActiveUpperBound" )( D ) ) - 1;
          
          morphisms_from_distinguished_object := [  ];
          
          for i in Reversed( [ lower_bound .. upper_bound ] ) do
          
            Add( morphisms_from_distinguished_object,
              InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( phi[ i ] ) );
          
          od;
          
          morphism := MorphismBetweenDirectSums( [ morphisms_from_distinguished_object ] );
          
          d := ValueGlobal( "DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS" )( C, D );
          
          T := ValueGlobal( "TotalChainComplex" )( d );
          
          if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
           
            im := ValueGlobal( "BoundariesAt" )( T, 0 );
    
            inc := KernelLift( T^0, im );
 
            return PreCompose( KernelLift( T^0, morphism ), CokernelProjection( inc ) );
            
          else
            
            Error( "to do" );
            
            U := ValueGlobal( "StalkChainComplex" )( Source( morphism ), 0 );
            
            return HomotopyCategoryMorphism( homotopy_category, ValueGlobal( "ChainMorphism" )( U, T, [ morphism ], 0 ) );
            
          fi;
        
  end );

end );

##
InstallGlobalFunction( ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM_IN_HOMOTOPY_CATEGORY,
  function( homotopy_category )
    local chains, cat, range_cat_of_hom_struc;
    
    chains := UnderlyingCapCategory( homotopy_category );
    
    cat := ValueGlobal( "UnderlyingCategory" )( chains );
    
    range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
    
    AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( homotopy_category,
        function( hC, hD, psi )
          local C, D, lower_bound, upper_bound, d, T, phi, struc_on_objects, indices, L, i;
          
          C := UnderlyingCell( hC );
          
          D := UnderlyingCell( hD );
          
          lower_bound := Minimum( ValueGlobal( "ActiveLowerBound" )( C ), ValueGlobal( "ActiveLowerBound" )( D ) ) + 1;
          
          upper_bound := Maximum( ValueGlobal( "ActiveUpperBound" )( C ), ValueGlobal( "ActiveUpperBound" )( D ) ) - 1;
          
          d := ValueGlobal( "DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS" )( C, D );
          
          T := ValueGlobal( "TotalChainComplex" )( d );
          
          if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
            
            phi := PreCompose( psi, ValueGlobal( "HonestRepresentative" )( ValueGlobal( "GeneralizedEmbeddingOfHomologyAt" )( T, 0 ) ) );
            
          else
            
            Error( "to do" );
           
            phi := psi[ 0 ];
            
          fi;
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ lower_bound .. upper_bound ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( C[ i ], D[ i ] ) );
          
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                 i -> InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( C[ indices[i] ], D[ indices[i] ], L[i] ) );
          
          return HomotopyCategoryMorphism( homotopy_category, ValueGlobal( "ChainMorphism" )( C, D, Reversed( L ), lower_bound ) );
  
  end );

end );

InstallGlobalFunction( ADD_HOM_STRUCTURE_TO_HOMOTOPY_CATEGORY,
  function( homotopy_category )
    local chains, cat, range_cat_of_hom_struc;

    chains := UnderlyingCapCategory( homotopy_category );

    cat := ValueGlobal( "UnderlyingCategory" )( chains );

    range_cat_of_hom_struc := ValueGlobal( "RangeCategoryOfHomomorphismStructure" )( cat );

    if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then

      ValueGlobal( "SetRangeCategoryOfHomomorphismStructure" )( homotopy_category, range_cat_of_hom_struc );

    else
          
      Error( "to do" );

    fi;
        
    ADD_HOM_STRUCTURE_ON_CHAINS_IN_HOMOTOPY_CATEGORY( homotopy_category );
    ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS_IN_HOMOTOPY_CATEGORY( homotopy_category );
    ADD_INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_IN_HOMOTOPY_CATEGORY( homotopy_category );
    ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM_IN_HOMOTOPY_CATEGORY( homotopy_category );
    ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_IN_HOMOTOPY_CATEGORY( homotopy_category );

end );

InstallMethod( TotalComplexUsingMappingCone,
  [ IsChainComplex ],
  function( C )
    local l, u, tau, L, with_infos;

    l := ActiveLowerBound( C ) + 1;
    u := ActiveUpperBound( C ) - 1;
    
    Print( "TotalComplexUsingMappingCone has been called on a chain with active lower bound =", l, " and active upper bound =", u, "\n" );

    if l = u then
      
      return C;
    
    elif l + 1 = u then

      return MappingCone( C^u );

    else
      
      with_infos := ValueOption( "WithInfos" );
      
      tau := MappingConeColift( C^u, C^( u - 1 ) : WithInfos := with_infos );
    
      L := List( [ l + 1 .. u - 2 ], i -> C^i );
    
      Add( L, tau );
    
      return TotalComplexUsingMappingCone( ChainComplex( L, l + 1 ) );
    
    fi;

  
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

      m := Minimum( ActiveLowerBound( A ) + 1, ActiveLowerBound( B ) + 1 );    
      n := Maximum( ActiveUpperBound( A ) - 1, ActiveUpperBound( B ) - 1 );

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

      sol := SolveLinearSystemInAbCategory( L, K, b );
    
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

      m := Minimum( ActiveLowerBound( A ) + 1, ActiveLowerBound( B ) + 1 );
      n := Maximum( ActiveUpperBound( A ) - 1, ActiveUpperBound( B ) - 1 );    

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
     
      sol := SolveLinearSystemInAbCategory( L, K, b );
      
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

