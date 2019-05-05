#############################################################################
##
##  ComplexesForCAP package             Kamal Saleh 
##  2017                                University of Siegen
##
##  Chapter Complexes categories
##
#############################################################################


#################################################################
#
# Record for methods that can be added to complexes categories
#
#################################################################

DeclareGlobalVariable( "CAP_INTERNAL_NULL_HOMOTOPIC_METHOD_FOR_COMPLEXCES_CATEGORIES" );
DeclareGlobalVariable( "NULL_HOMOTOPIC_METHOD_FOR_COMPLEXCES_CATEGORIES" );

InstallValue( CAP_INTERNAL_NULL_HOMOTOPIC_METHOD_FOR_COMPLEXCES_CATEGORIES, rec( ) );
InstallValue( NULL_HOMOTOPIC_METHOD_FOR_COMPLEXCES_CATEGORIES, rec( 

IsNullHomotopic := rec( 

installation_name := "IsNullHomotopic", 
filter_list := [ "morphism" ],
cache_name := "IsNullHomotopic",
return_type := "bool" ),

HomotopyMorphisms := rec( 

installation_name := "HomotopyMorphisms", 
filter_list := [ "morphism" ],
cache_name := "HomotopyMorphisms",
return_type := [ IsInfList ] ),

GeneratorsOfExternalHom := rec( 

installation_name := "GeneratorsOfExternalHom", 
filter_list := [ "object", "object" ],
cache_name := "GeneratorsOfExternalHom",
return_type := [ IsList ] ),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( NULL_HOMOTOPIC_METHOD_FOR_COMPLEXCES_CATEGORIES );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( NULL_HOMOTOPIC_METHOD_FOR_COMPLEXCES_CATEGORIES );

###########################
#
# Categories constructor
#
###########################

KeyDependentOperation( "CHAIN_OR_COCHAIN_COMPLEX_CATEGORY", IsCapCategory, IsInt, ReturnTrue );

InstallMethod( CHAIN_OR_COCHAIN_COMPLEX_CATEGORYOp,
            [ IsCapCategory, IsInt ],
  function( cat, shift_index )
    local name, complex_cat, complex_constructor, morphism_constructor, to_be_finalized, range_cat_of_hom_struc, objects_equality_for_cache, morphisms_equality_for_cache;
    
    if shift_index = -1 then 
      
      name := Concatenation( "Chain complexes category over ", Big_to_Small( Name( cat ) ) );
      
      complex_cat := CreateCapCategory( name );
      
      SetFilterObj( complex_cat, IsChainComplexCategory );
      
      complex_constructor := ChainComplex;
      
      morphism_constructor := ChainMorphism;
      
      
    elif shift_index = 1 then
      
      name := Concatenation( "Cochain complexes category over ", Big_to_Small( Name( cat ) ) );
      
      complex_cat := CreateCapCategory( name );
      
      SetFilterObj( complex_cat, IsCochainComplexCategory );
      
      complex_constructor := CochainComplex;
      
      morphism_constructor := CochainMorphism;
      
    fi;
    
    SetUnderlyingCategory( complex_cat, cat );
    
    if HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) then
      
      SetIsAdditiveCategory( complex_cat, true );
    
    fi;
    
    if HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) then
      
      SetIsAbelianCategory( complex_cat, true );
    
    fi;
    
    
    if HasIsStrictMonoidalCategory( cat ) and IsStrictMonoidalCategory( cat ) then
      
      SetIsStrictMonoidalCategory( complex_cat, true );
    
    fi;
    
    if HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) then
      
      SetIsMonoidalCategory( complex_cat, true );
    
    fi;
    
    if HasIsBraidedMonoidalCategory( cat ) and IsBraidedMonoidalCategory( cat ) then
      
      SetIsBraidedMonoidalCategory( complex_cat, true );
    
    fi;
    
    if HasIsSymmetricMonoidalCategory( cat ) and IsSymmetricMonoidalCategory( cat ) then
      
      SetIsSymmetricMonoidalCategory( complex_cat, true );
    
    fi;
    
    if HasIsSymmetricClosedMonoidalCategory( cat ) and IsSymmetricClosedMonoidalCategory( cat ) then
      
      SetIsSymmetricClosedMonoidalCategory( complex_cat, true );
    
    fi;
    
    ##
    objects_equality_for_cache := ValueOption( "ObjectsEqualityForCache" );
    
    if objects_equality_for_cache = IsIdenticalObj then
      
      AddIsEqualForCacheForObjects( complex_cat,
        function( C1, C2 )
          
          return IsIdenticalObj( C1, C2 );
          
      end );
      
    else
     
      AddIsEqualForCacheForObjects( complex_cat,
        function( C1, C2 )
          local computed_objects_1, computed_objects_2, indices_1, indices_2, indices, l, u, lu, i;
          
          if IsIdenticalObj( C1, C2 ) then 
          
            return true;
          
          fi;
          
          if not ForAll( [ C1, C2 ], IsBoundedChainOrCochainComplex ) then
          
            return false;
          
          fi;
          
          computed_objects_1 := ComputedObjectAts( C1 );

          computed_objects_2 := ComputedObjectAts( C2 );

          indices_1 := List( [ 1 .. Length( computed_objects_1 )/2 ], i -> computed_objects_1[ 2 * i - 1 ] );
          
          indices_2 := List( [ 1 .. Length( computed_objects_2 )/2 ], i -> computed_objects_2[ 2 * i - 1 ] );

          indices := Intersection( indices_1, indices_2 );

          for i in indices do
            
            if not IsEqualForObjects( C1[ i ], C2[ i ] ) or not IsEqualForMorphismsOnMor( C1^i, C2^i ) then
              
              return false;
            
            fi;

          od;
          
          l := Minimum( ActiveLowerBound( C1 ), ActiveLowerBound( C2 ) );
          
          u := Maximum( ActiveUpperBound( C1 ), ActiveUpperBound( C2 ) );
          
          lu := [ l .. u ];
          
          SubtractSet( lu, indices );

          if lu = [ ] then
            
            return true;
            
          fi;
          
          # They still may be equal but I don't want to compute components when comparing in Cache.
          return false;
        
      end );
      
    fi;
    
    morphisms_equality_for_cache := ValueOption( "MorphismsEqualityForCache" );
    
    if morphisms_equality_for_cache = IsIdenticalObj then
      
      AddIsEqualForCacheForMorphisms( complex_cat,
        function( m1, m2 )
          
          return IsIdenticalObj( m1, m2 );
          
      end );
    
    else
    
      AddIsEqualForCacheForMorphisms( complex_cat,
        function( m1, m2 )
          local computed_morphisms_1, computed_morphisms_2, indices_1, indices_2, indices, l, u, lu, i;
          
          if IsIdenticalObj( m1, m2 ) then 
            
            return true;
          
          fi;
          
          if not ForAll( [ m1, m2 ], IsBoundedChainOrCochainMorphism ) then
            
            return false;
          
          fi;
          
          if not IsEqualForCacheForObjects( Source( m1 ), Source( m2 ) ) then
            
            return false;
            
          fi;
          
          if not IsEqualForCacheForObjects( Range( m1 ), Range( m2 ) ) then
            
            return false;
            
          fi;
          
          computed_morphisms_1 := ComputedMorphismAts( m1 );

          computed_morphisms_2 := ComputedMorphismAts( m2 );

          indices_1 := List( [ 1 .. Length( computed_morphisms_1 )/2 ], i -> computed_morphisms_1[ 2 * i - 1 ] );
          
          indices_2 := List( [ 1 .. Length( computed_morphisms_2 )/2 ], i -> computed_morphisms_2[ 2 * i - 1 ] );

          indices := Intersection( indices_1, indices_2 );

          for i in indices do
            
            if not IsEqualForMorphisms( m1[ i ], m2[ i ] ) then
              
              return false;
            
            fi;

          od;

          l := Minimum( 
                Minimum( ActiveLowerBound( Source( m1 ) ), ActiveLowerBound( Range( m1 ) ) ),
                Minimum( ActiveLowerBound( Source( m2 ) ), ActiveLowerBound( Range( m2 ) ) )
                );
          
          u := Maximum( 
                Maximum( ActiveUpperBound( Source( m1 ) ), ActiveUpperBound( Range( m1 ) ) ),
                Maximum( ActiveUpperBound( Source( m2 ) ), ActiveUpperBound( Range( m2 ) ) )
                );
          
          lu := [ l .. u ];

          SubtractSet( lu, indices );

          if lu = [ ] then
            
            return true;
            
          fi;
          
          # They still may be equal but I don't want to compute components when comparing in Cache.
          return false;
        
      end );
      
    fi;
    
    ##
    
    AddIsEqualForObjects( complex_cat, 
      function( C1, C2 )
        local computed_objects_1, computed_objects_2, indices_1, indices_2, indices, l, u, lu, i;
        
        if IsIdenticalObj( C1, C2 ) then 
        
          return true;
        
        fi;
        
        if not ForAll( [ C1, C2 ], IsBoundedChainOrCochainComplex ) then
        
          Error( "Complexes must be bounded" );
        
        fi;
        
        computed_objects_1 := ComputedObjectAts( C1 );

        computed_objects_2 := ComputedObjectAts( C2 );

        indices_1 := List( [ 1 .. Length( computed_objects_1 )/2 ], i -> computed_objects_1[ 2 * i - 1 ] );
        
        indices_2 := List( [ 1 .. Length( computed_objects_2 )/2 ], i -> computed_objects_2[ 2 * i - 1 ] );

        indices := Intersection( indices_1, indices_2 );

        for i in indices do
          
          if not IsEqualForObjects( C1[ i ], C2[ i ] ) or not IsEqualForMorphismsOnMor( C1^i, C2^i ) then
            
            return false;
          
          fi;

        od;

        l := Minimum( ActiveLowerBound( C1 ), ActiveLowerBound( C2 ) );
        
        u := Maximum( ActiveUpperBound( C1 ), ActiveUpperBound( C2 ) );
        
        lu := [ l .. u ];
        
        SubtractSet( lu, indices );

        for i in lu do
          
          if not IsEqualForObjects( C1[ i ], C2[ i ] ) or not IsEqualForMorphismsOnMor( C1^i, C2^i ) then
            
            return false;
          
          fi;

        od;
        
        return true;
    
    end );
    
    AddIsEqualForMorphisms( complex_cat, 
      function( m1, m2 )
        local computed_morphisms_1, computed_morphisms_2, indices_1, indices_2, indices, l, u, lu, i;
        
        if IsIdenticalObj( m1, m2 ) then 
          
          return true;
        
        fi;
        
        if not IsEqualForObjects( Source( m1 ), Source( m2 ) ) then
          
          return false;
          
        fi;
        
        if not IsEqualForObjects( Range( m1 ), Range( m2 ) ) then
          
          return false;
          
        fi;
        
        if not ForAll( [ m1, m2 ], IsBoundedChainOrCochainMorphism ) then
          
          Error( "Complex morphisms must be bounded" );
        
        fi;
        
        computed_morphisms_1 := ComputedMorphismAts( m1 );

        computed_morphisms_2 := ComputedMorphismAts( m2 );

        indices_1 := List( [ 1 .. Length( computed_morphisms_1 )/2 ], i -> computed_morphisms_1[ 2 * i - 1 ] );
        
        indices_2 := List( [ 1 .. Length( computed_morphisms_2 )/2 ], i -> computed_morphisms_2[ 2 * i - 1 ] );

        indices := Intersection( indices_1, indices_2 );

        for i in indices do
          
          if not IsEqualForMorphisms( m1[ i ], m2[ i ] ) then
            
            return false;
          
          fi;

        od;

        l := Minimum( 
              Minimum( ActiveLowerBound( Source( m1 ) ), ActiveLowerBound( Range( m1 ) ) ),
              Minimum( ActiveLowerBound( Source( m2 ) ), ActiveLowerBound( Range( m2 ) ) )
              );
        
        u := Maximum( 
              Maximum( ActiveUpperBound( Source( m1 ) ), ActiveUpperBound( Range( m1 ) ) ),
              Maximum( ActiveUpperBound( Source( m2 ) ), ActiveUpperBound( Range( m2 ) ) )
              );
        
        lu := [ l .. u ];

        SubtractSet( lu, indices );

        for i in lu do
        
          if not IsEqualForMorphisms( m1[ i ], m2[ i ] ) then
            
            return false;
          
          fi;
        
        od;
        
        return true;
        
    end );
    
    AddIsCongruentForMorphisms( complex_cat, 
      function( m1, m2 )
        local computed_morphisms_1, computed_morphisms_2, indices_1, indices_2, indices, l, u, lu, i;
        
        if IsIdenticalObj( m1, m2 ) then 
          
          return true;
        
        fi;
        
        if not ForAll( [ m1, m2 ], IsBoundedChainOrCochainMorphism ) then
          
          Error( "Complex morphisms must be bounded" );
        
        fi;
        
        if not IsEqualForObjects( Source( m1 ), Source( m2 ) ) then
          
          return false;
          
        fi;
        
        if not IsEqualForObjects( Range( m1 ), Range( m2 ) ) then
          
          return false;
          
        fi;
 
        computed_morphisms_1 := ComputedMorphismAts( m1 );

        computed_morphisms_2 := ComputedMorphismAts( m2 );

        indices_1 := List( [ 1 .. Length( computed_morphisms_1 )/2 ], i -> computed_morphisms_1[ 2 * i - 1 ] );
        
        indices_2 := List( [ 1 .. Length( computed_morphisms_2 )/2 ], i -> computed_morphisms_2[ 2 * i - 1 ] );

        indices := Intersection( indices_1, indices_2 );

        for i in indices do
          
          if not IsCongruentForMorphisms( m1[ i ], m2[ i ] ) then
            
            return false;
          
          fi;

        od;

        l := Minimum( 
              Minimum( ActiveLowerBound( Source( m1 ) ), ActiveLowerBound( Range( m1 ) ) ),
              Minimum( ActiveLowerBound( Source( m2 ) ), ActiveLowerBound( Range( m2 ) ) )
              );
        
        u := Maximum( 
              Maximum( ActiveUpperBound( Source( m1 ) ), ActiveUpperBound( Range( m1 ) ) ),
              Maximum( ActiveUpperBound( Source( m2 ) ), ActiveUpperBound( Range( m2 ) ) )
              );
         
        lu := [ l .. u ];

        indices := SubtractSet( lu, indices );

        for i in indices do
        
          if not IsCongruentForMorphisms( m1[ i ], m2[ i ] ) then
            
            return false;
          
          fi;
        
        od;
        
        return true;
        
    end );
      ##
    if CanCompute( cat, "IsWellDefinedForObjects" ) and CanCompute( cat, "IsWellDefinedForMorphisms" ) then
      
      AddIsWellDefinedForObjects( complex_cat,
          function( C )
            
            if not IsBoundedChainOrCochainComplex( C ) then
              
              Error( "The complex must be bounded" );
            
            else
              
              return IsWellDefined( C, ActiveLowerBound( C  ), ActiveUpperBound( C ) );
            
            fi;
            
          end );
    fi;
    ##
    if CanCompute( cat, "IsWellDefinedForObjects" ) and CanCompute( cat, "IsWellDefinedForMorphisms" ) then
      
      AddIsWellDefinedForMorphisms( complex_cat,
          
          function( phi )
              
              if not IsBoundedChainOrCochainMorphism( phi ) then
                
                Error( "The morphism must be bounded" );
                
              else
                
                return IsWellDefined( phi, ActiveLowerBound( phi  ), ActiveUpperBound( phi ) );
                
              fi;
              
          end );
    
    fi;
    
    if HasIsAdditiveCategory( complex_cat ) and IsAdditiveCategory( complex_cat ) then 
    
      if CanCompute( cat, "ZeroObject" ) then
          AddZeroObject( complex_cat, 
              function( )
              local C;
              
              C := complex_constructor( [ ZeroMorphism( ZeroObject( cat ), ZeroObject( cat ) ) ], 0 );
              
              SetUpperBound( C, 0 );
              
              SetLowerBound( C, 0 );
              
              return C;
              
              end );
      fi;
      
      if CanCompute( cat, "IsZeroForObjects" ) then
          
          AddIsZeroForObjects( complex_cat, 
              function( C )
              local obj, i;
              
              if not HasActiveLowerBound( C ) or not HasActiveUpperBound( C ) then 
                  
                  Error( "The complex must have lower and upper bounds" );
              
              fi;
              
              for obj in ComputedObjectAts( C ) do
                  
                  if IsCapCategoryObject( obj ) and not IsZeroForObjects( obj ) then
                      
                      return false;
                  
                  fi;
              
              od;
              
              for i in [ ActiveLowerBound( C ) + 1 .. ActiveUpperBound( C ) - 1 ] do
                  
                  if not IsZeroForObjects( C[ i ] ) then 
                  
                  SetLowerBound( C, i - 1 );
                  
                  return false;
                  
                  fi;
              
              od;
              
              return true;
              
              end );
      
      fi;
      
      if CanCompute( cat, "ZeroMorphism" ) then
          
          AddZeroMorphism( complex_cat, function( C1, C2 )
              local morphisms;
              
              morphisms := MapLazy( [ Objects( C1 ), Objects( C2 ) ], ZeroMorphism, 2 );
              
              morphisms := morphism_constructor( C1, C2, morphisms );
              
              SetUpperBound( morphisms, 0 );
              
              SetLowerBound( morphisms, 0 );
              
              return morphisms;
          
          end );
      
      fi;
      
      if CanCompute( cat, "IsZeroForMorphisms" ) then
        
        AddIsZeroForMorphisms( complex_cat, 
          function( phi )
            local mor, i;
            
            if not HasActiveLowerBound( phi ) or not HasActiveUpperBound( phi ) then
              
              Error( "The morphism must have lower and upper bounds" );
            
            fi;
            
            for mor in ComputedMorphismAts( phi ) do
              
              if IsCapCategoryMorphism( mor ) and not IsZeroForMorphisms( mor ) then
                
                return false;
                
              fi;
            
            od;
            
            for i in [ ActiveLowerBound( phi ) + 1 .. ActiveUpperBound( phi ) - 1 ] do
              
              if IsZeroForMorphisms( phi[ i ] ) then
                 
                SetLowerBound( phi, i );
              
              else
                
                return false;
              
              fi;
            
            od;
            
            return true;
          
          end );
      
      fi;
      
      if CanCompute( cat, "AdditionForMorphisms" ) then
        
        AddAdditionForMorphisms( complex_cat, 
          function( m1, m2 )
          local phi;
          
          phi:= morphism_constructor( Source( m1 ), Range( m1 ), MapLazy( [ Morphisms( m1 ), Morphisms( m2 ) ],AdditionForMorphisms, 2 ));
          
          AddToToDoList( ToDoListEntry( [ [ m1, "HAS_FAU_BOUND", true ],  [ m2, "HAS_FAU_BOUND", true ] ], 

                          function( )

                            if not HasFAU_BOUND( phi ) then 

                              SetUpperBound( phi, Minimum( FAU_BOUND( m1 ), FAU_BOUND( m2 ) ) );

                            fi;

                          end ) );
          
          AddToToDoList( ToDoListEntry( [ [ m1, "HAS_FAL_BOUND", true ],  [ m2, "HAS_FAL_BOUND", true ] ], 

                          function( )

                            if not HasFAL_BOUND( phi ) then 

                              SetLowerBound( phi, Maximum( FAL_BOUND( m1 ), FAL_BOUND( m2 ) ) );

                            fi;

                          end ) );
          return phi;

          end );

      fi;

      if CanCompute( cat, "AdditiveInverseForMorphisms" ) then

        AddAdditiveInverseForMorphisms( complex_cat, 

          function( m )

            local phi;

            phi := morphism_constructor( Source( m ), Range( m ), MapLazy( Morphisms( m ), AdditiveInverseForMorphisms, 1 ) );

            TODO_LIST_TO_PUSH_PULL_BOUNDS( m, phi );

            return phi;

          end );

      fi;

      

      if CanCompute( cat, "PreCompose" ) then

        AddPreCompose( complex_cat, 

          function( m1, m2 )

            local phi;

            phi := morphism_constructor( Source( m1 ), Range( m2 ), MapLazy( [ Morphisms( m1 ), Morphisms( m2 ) ], PreCompose, 2 ) );

            TODO_LIST_TO_PUSH_BOUNDS( m1, phi );

            TODO_LIST_TO_PUSH_BOUNDS( m2, phi );

            return phi;

          end );

      fi;

      
      if CanCompute( cat, "IdentityMorphism" ) then

             AddIdentityMorphism( complex_cat, 

                  function( C )

                  return morphism_constructor( C, C, MapLazy( Objects( C ), IdentityMorphism, 1 ) );

                  end );

      fi;

      if CanCompute( cat, "InverseImmutable" ) then

              AddInverse( complex_cat, 

                  function( m )

                  local phi;

                  phi := morphism_constructor( Range( m ), Source( m ), MapLazy( Morphisms( m ), Inverse, 1 ) );

                  TODO_LIST_TO_PUSH_PULL_BOUNDS( m, phi );

                  return phi;

                  end );

      fi;

      
      if CanCompute( cat, "LiftAlongMonomorphism" ) then

              AddLiftAlongMonomorphism( complex_cat, 

                  function( mono, test )

                  local morphisms;

                  morphisms := MapLazy( [ Morphisms( mono ), Morphisms( test ) ], LiftAlongMonomorphism, 2 );

                  return morphism_constructor( Source( test ), Source( mono ), morphisms );

                  end );

      fi;

      if CanCompute( cat, "ColiftAlongEpimorphism" ) then

              AddColiftAlongEpimorphism( complex_cat, 

                  function( epi, test )

                  local morphisms;

                  morphisms := MapLazy( [ Morphisms( epi ), Morphisms( test ) ], ColiftAlongEpimorphism, 2 );

                  return morphism_constructor( Range( epi ), Range( test ), morphisms );

                  end );

      fi;

      if CanCompute( cat, "DirectSum" ) then

              AddDirectSum( complex_cat, 

                  function( L )

                  local diffs, complex, u, l;

                  diffs := MapLazy( List( L, Differentials ), DirectSumFunctorial, 1 );

                  complex := complex_constructor( cat, diffs );

                  u := List( L, i-> [ i, "HAS_FAU_BOUND", true ] );

                  AddToToDoList( ToDoListEntry( u, 

                          function( )

                          local b;

                          b := Maximum( List( L, i-> ActiveUpperBound( i ) ) );

                          SetUpperBound( complex, b );

                          end ) );

                  l := List( L, i-> [ i, "HAS_FAL_BOUND", true ] ); 

                  AddToToDoList( ToDoListEntry( l, 

                          function( )

                          local b;

                          b := Minimum( List( L, i-> ActiveLowerBound( i ) ) );

                          SetLowerBound( complex, b );

                          end ) );

                  AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAU_BOUND", true ] ], 

                          function( )

                          local i;

                          for i in L do

                          SetUpperBound( i, ActiveUpperBound( complex ) );

                          od;

                          end ) );

                  AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAL_BOUND", true ] ], 

                          function( )

                          local i;

                          for i in L do

                          SetLowerBound( i, ActiveLowerBound( complex ) );

                          od;

                          end ) );

                  return complex;

                  end );

          fi;

          if CanCompute( cat, "DirectSumFunctorialWithGivenDirectSums" ) then

              AddDirectSumFunctorialWithGivenDirectSums( complex_cat, 

                  function( source, L, range )

                  local maps, morphism, u, l;

                  maps := MapLazy( List( L, Morphisms ), DirectSumFunctorial, 1 );

                  morphism := morphism_constructor( source, range, maps );

                  u := List( L, i-> [ i, "HAS_FAU_BOUND", true ] ); 

                  AddToToDoList( ToDoListEntry( u, 

                          function( )

                          local b;

                          b := Maximum( List( L, i-> ActiveUpperBound( i ) ) );

                          SetUpperBound( morphism, b );

                          end ) );

                  l := List( L, i-> [ i, "HAS_FAL_BOUND", true ] ); 

                  AddToToDoList( ToDoListEntry( l, 

                          function( )

                          local b;

                          b := Minimum( List( L, i-> ActiveLowerBound( i ) ) );

                          SetLowerBound( morphism, b );

                          end ) );

                  AddToToDoList( ToDoListEntry( [ [ morphism, "HAS_FAU_BOUND", true ] ], 

                        function( )

                          local i;

                          for i in L do

                          SetUpperBound( i, ActiveUpperBound( morphism ) );

                          od;

                        end ) );

                  AddToToDoList( ToDoListEntry( [ [ morphism, "HAS_FAL_BOUND", true ] ], 

                        function( )

                          local i;

                          for i in L do

                          SetLowerBound( i, ActiveLowerBound( morphism ) );

                          od;

                        end ) );

                  return morphism;

                  end );

          fi;

          if CanCompute( cat, "InjectionOfCofactorOfDirectSum" ) then

              AddInjectionOfCofactorOfDirectSum( complex_cat, 

                          function( L, n )

                          local objects, list, morphisms;

                          objects := CombineZLazy( List( L, Objects ) );

                          morphisms := MapLazy( objects, 

                                  function( l )

                                    return InjectionOfCofactorOfDirectSum( l, n );

                                  end, 1 );

                          return morphism_constructor( L[ n ], DirectSum( L ), morphisms );

                          end );

          fi;

          if CanCompute( cat, "ProjectionInFactorOfDirectSum" ) then

              AddProjectionInFactorOfDirectSum( complex_cat, 

                  function( L, n )

                  local objects, list, morphisms;

                  objects := CombineZLazy( List( L, Objects ) );

                  morphisms := MapLazy( objects, 

                                  function( l )

                                  return ProjectionInFactorOfDirectSum( l, n );

                                  end, 1 );

                  return morphism_constructor( DirectSum( L ), L[ n ], morphisms );

                  end );

          fi;

          

          if CanCompute( cat, "TerminalObject" ) and CanCompute( cat, "TerminalObjectFunctorial" ) then

              AddTerminalObject( complex_cat, 

                  function( )

                  local complex;

                  complex := complex_constructor( cat, RepeatListZ( [ TerminalObjectFunctorial( cat ) ] ) );

                  if HasZeroObject( cat ) and IsEqualForObjects( TerminalObject( cat ), ZeroObject( cat ) ) then

                      SetUpperBound( complex, 0 );

                      SetLowerBound( complex, 0 );

                  fi;

                  return complex;

                  end );

          fi;

          if CanCompute( cat, "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" ) then

              AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( complex_cat, 

                function( complex, terminal_object )

                  local objects, universal_maps;

                  objects := Objects( complex );

                  universal_maps := MapLazy( objects,  UniversalMorphismIntoTerminalObject, 1 );

                  return morphism_constructor( complex, terminal_object, universal_maps );

                end );

          fi;

          if CanCompute( cat, "InitialObject" ) and CanCompute( cat, "InitialObjectFunctorial" ) then

              AddInitialObject( complex_cat, 

                function( )

                  local complex;

                  complex := complex_constructor( cat, RepeatListZ( [ InitialObjectFunctorial( cat ) ] ) );

                  if HasZeroObject( cat ) and IsEqualForObjects( InitialObject( cat ), ZeroObject( cat ) ) then

                      SetUpperBound( complex, 0 );

                      SetLowerBound( complex, 0 );

                  fi;

                  return complex;

                end );

          fi;

          if CanCompute( cat, "UniversalMorphismFromInitialObjectWithGivenInitialObject" ) then

              AddUniversalMorphismFromInitialObjectWithGivenInitialObject( complex_cat, 

                function( complex, initial_object )

                  local objects, universal_maps;

                  objects := Objects( complex );

                  universal_maps := MapLazy( objects,  UniversalMorphismFromInitialObject, 1 );

                  return morphism_constructor( initial_object, complex, universal_maps );

                end );

          fi;

    fi;

    if HasIsAbelianCategory( complex_cat ) and IsAbelianCategory( complex_cat ) then

          if CanCompute( cat, "KernelEmbedding" ) then

              AddKernelEmbedding( complex_cat, 

                function( phi )

                  local embeddings, kernel_to_next_source, diffs, kernel_complex, kernel_emb;

                  embeddings := MapLazy( Morphisms( phi ), KernelEmbedding, 1 );

                  kernel_to_next_source := MapLazy( [ embeddings, Differentials( Source( phi ) ) ], PreCompose, 2 );

                  diffs := MapLazy( [ ShiftLazy( Morphisms( phi ), shift_index ), kernel_to_next_source ], KernelLift, 2 );

                  kernel_complex := complex_constructor( cat, diffs );

                  kernel_emb := morphism_constructor( kernel_complex, Source( phi ), embeddings );

                  TODO_LIST_TO_PUSH_BOUNDS( Source( phi ), kernel_complex );

                  return kernel_emb;

                end );

          fi;

          if CanCompute( cat, "KernelLift" ) then

              AddKernelLift( complex_cat,  

                function( phi, tau )

                  local morphisms, K;

                  K := KernelObject( phi );

                  morphisms := MapLazy( IntegersList, 

                          function( i )

                            return KernelLift( phi[ i ], tau[ i ] );

                          end, 1 );

                  return morphism_constructor( Source( tau ), K, morphisms );

                end );

          fi;

          if CanCompute( cat, "KernelLiftWithGivenKernelObject" ) then

              AddKernelLiftWithGivenKernelObject( complex_cat, 

                function( phi, tau, K )

                  local morphisms;

                  morphisms := MapLazy( IntegersList, 

                          function( i )

                          return KernelLift( phi[ i ], tau[ i ] );

                          end, 1 );

                  return morphism_constructor( Source( tau ), K, morphisms );

                end );

          fi;

          if CanCompute( cat, "CokernelProjection" ) then

              AddCokernelProjection( complex_cat, 

                function( phi )

                  local   projections, range_to_next_cokernel, diffs, cokernel_complex, cokernel_proj;

                  projections := MapLazy( Morphisms( phi ), CokernelProjection, 1 );

                  range_to_next_cokernel := MapLazy( [ Differentials( Range( phi ) ), ShiftLazy( projections, shift_index ) ], PreCompose, 2 );

                  diffs := MapLazy( [ Morphisms( phi ), range_to_next_cokernel ], CokernelColift, 2 );

                  cokernel_complex := complex_constructor( cat, diffs );

                  cokernel_proj := morphism_constructor( Range( phi ), cokernel_complex, projections );

                  TODO_LIST_TO_PUSH_BOUNDS( Range( phi ), cokernel_complex );

                  return cokernel_proj;

                end );

          fi;

          if CanCompute( cat, "CokernelColift" ) then

              AddCokernelColift( complex_cat,  

                function( phi, tau )

                  local morphisms, K;

                  K := CokernelObject( phi );

                  morphisms := MapLazy( IntegersList, 

                          function( i )

                            return CokernelColift( phi[ i ], tau[ i ] );

                          end, 1 );

                  return morphism_constructor( K, Range( tau ), morphisms );

                end );

          fi;

          if CanCompute( cat, "CokernelColiftWithGivenCokernelObject" ) then

              AddCokernelColiftWithGivenCokernelObject( complex_cat, 

                  function( phi, tau, K )

                  local morphisms;

                  morphisms := MapLazy( IntegersList, 

                          function( i )

                            return CokernelColift( phi[ i ], tau[ i ] );

                          end, 1 );

                  return morphism_constructor( K, Range( tau ), morphisms );

                  end );

          fi;

  fi;
  
  # This monoidal structure is yet only for chain complex categories ( shift_index = -1 )
  #
  if HasIsMonoidalCategory( complex_cat ) and IsMonoidalCategory( complex_cat ) and shift_index = -1 then

    ADD_TENSOR_PRODUCT_ON_CHAIN_COMPLEXES( complex_cat );

    ADD_INTERNAL_HOM_ON_CHAIN_COMPLEXES( complex_cat );

    ADD_TENSOR_PRODUCT_ON_CHAIN_MORPHISMS( complex_cat );

    ADD_INTERNAL_HOM_ON_CHAIN_MORPHISMS( complex_cat );

    ADD_TENSOR_UNIT_CHAIN( complex_cat );

    if HasIsBraidedMonoidalCategory( complex_cat ) and IsBraidedMonoidalCategory( complex_cat ) then 

        ADD_BRAIDING_FOR_CHAINS( complex_cat );

    fi;

    if IsSymmetricClosedMonoidalCategory( complex_cat ) then

        ADD_TENSOR_PRODUCT_TO_INTERNAL_HOM_ADJUNCTION_MAP( complex_cat );

        ADD_INTERNAL_HOM_TO_TENSOR_PRODUCT_ADJUNCTION_MAP( complex_cat );

    fi;

  fi;

  if HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) and CanCompute( cat, "IsProjective" ) and CanCompute( cat, "ProjectiveLift" ) then
    
    AddIsProjective( complex_cat,
      
      function( C )
      
        local i;
      
        if not IsBoundedChainOrCochainComplex( C ) then 
      
          Error( "The complex must be bounded" );
          
        fi;
      
        if not IsExact( C ) then 
      
          return false;
          
        fi;
      
        for i in [ ActiveLowerBound( C ) .. ActiveUpperBound( C ) ] do 
      
          if not IsProjective( C[ i ] ) then
      
            return false;
          
          fi;
      
        od;
      
        return true;
      
      end );
    
    AddProjectiveLift( complex_cat,
      function( phi, pi )
    
        local P, H, l, XX; 
          
        P := Source( phi );
        
        XX := Source( pi );
        
        H := MapLazy( IntegersList,
          
          function( i )
        
                                    local id, m, n; 
                                    
                                    id := IdentityMorphism( P );
                                    
                                    if i <= ActiveLowerBound( P ) then 
                                    
                                    return ZeroMorphism( P[ i ], P[ i + 1 ] );
                                    
                                    elif i = ActiveLowerBound( P ) + 1 then 
                                    
                                    return ProjectiveLift( id[ i ], P^(i+1) );
                                    
                                    fi;
                                    
                                    m := KernelLift( P^i, id[ i ] - PreCompose( P^i, H[ i - 1 ] ) );
                                    
                                    n := PreCompose( CoastrictionToImage( P^(i+1) ), KernelLift( P^i, ImageEmbedding( P^(i+1) ) ) );
                                    
                                    return ProjectiveLift( m, n );
                                    
                                    end, 1 );
                                    
        l := MapLazy( IntegersList, 
        
            function( i )
            
              return PreCompose( [ H[ i ], ProjectiveLift( phi[ i + 1 ], pi[ i + 1 ] ), XX^(i+1) ] ) 
            
                    + PreCompose( [ P^i,  H[ i -1 ], ProjectiveLift( phi[ i ], pi[ i ] ) ] );
                    
            end, 1 );
            
        return ChainMorphism( P, XX, l );
        
      end );
      
  fi;
  
  if CanCompute( cat, "Lift" ) and HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and 
  
      HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) and  shift_index = -1 then
      
      AddLift( complex_cat,
        function( alpha, beta )
          local cat, U, P, N, M, alpha_, beta_, internal_hom_P_M, internal_hom_P_N, internal_hom_id_P_beta, k_internal_hom_id_P_beta_0, alpha_1, lift;
          cat := CapCategory( alpha );
          
          U := TensorUnit( cat );
          
          P := Source( alpha );
          
          N := Range( alpha );
          
          M := Source( beta );
          
          alpha_ := TensorProductToInternalHomAdjunctionMap( U, Source( alpha ), alpha );
          
          beta_  := TensorProductToInternalHomAdjunctionMap( U, Source( beta ), beta );
          
          internal_hom_id_P_beta := InternalHomOnMorphisms( IdentityMorphism( P ), beta );
          
          internal_hom_P_M := Source( internal_hom_id_P_beta );
          
          internal_hom_P_N := Range( internal_hom_id_P_beta );
          
          k_internal_hom_id_P_beta_0 := KernelLift( internal_hom_P_N^0,
            
          PreCompose( CyclesAt( internal_hom_P_M, 0 ), internal_hom_id_P_beta[ 0 ]  ) );
          
          alpha_1 := KernelLift( internal_hom_P_N^0, alpha_[0] );
          
          lift := Lift( alpha_1, k_internal_hom_id_P_beta_0 );
          
          if lift = fail then
            
            return fail;
            
          else
            
            lift := ChainMorphism( U, internal_hom_P_M, [ PreCompose( lift, CyclesAt( internal_hom_P_M, 0 ) ) ], 0 );
            
            return InternalHomToTensorProductAdjunctionMap( P, M, lift );
          
          fi;
        
        end );
      
      AddColift( complex_cat,
          
        function( alpha, beta )
          local cat, U, P, N, M, alpha_, beta_, internal_hom_P_M, internal_hom_N_M, internal_hom_alpha_id_M, k_internal_hom_alpha_id_M_0, beta_1, lift;
          
          cat := CapCategory( alpha );
          
          U := TensorUnit( cat );
          
          P := Range( alpha );
          
          N := Source( alpha );
          
          M := Range( beta );
          
          alpha_ := TensorProductToInternalHomAdjunctionMap( U, Source( alpha ), alpha );
          
          beta_  := TensorProductToInternalHomAdjunctionMap( U, Source( beta ), beta );
          
          internal_hom_alpha_id_M := InternalHomOnMorphisms( alpha, IdentityMorphism( M ) );
          
          internal_hom_P_M := Source( internal_hom_alpha_id_M );
          
          internal_hom_N_M := Range( internal_hom_alpha_id_M );
          
          k_internal_hom_alpha_id_M_0 := KernelLift( internal_hom_N_M^0,
          
          PreCompose( CyclesAt( internal_hom_P_M, 0 ), internal_hom_alpha_id_M[ 0 ]  ) );
          
          beta_1 := KernelLift( internal_hom_N_M^0, beta_[0] );
          
          lift := Lift( beta_1, k_internal_hom_alpha_id_M_0 );
          
          if lift = fail then
            
            return fail;
            
          else
            
            lift := ChainMorphism( U, internal_hom_P_M, [ PreCompose( lift, CyclesAt( internal_hom_P_M, 0 ) ) ], 0 );
            
            return InternalHomToTensorProductAdjunctionMap( P, M, lift );
            
          fi;
        
        end );
    
  fi;
  
  if CanCompute( cat, "Lift" ) and HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and 
      HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) and  shift_index = 1 then
      
      AddLift( complex_cat,
        function( alpha, beta )
          
          local chains_cat, cat, cochains_to_chains, chains_to_cochains, l;
          
          cat := UnderlyingCategory( complex_cat );
          
          chains_cat := ChainComplexCategory( cat );
          
          cochains_to_chains := CochainToChainComplexFunctor( complex_cat, chains_cat );
          
          chains_to_cochains := ChainToCochainComplexFunctor( chains_cat, complex_cat );
          
          l := Lift( ApplyFunctor( cochains_to_chains, alpha ), ApplyFunctor( cochains_to_chains, beta ) );
          
          if l = fail then
            
            return fail;
          
          else
            
            return ApplyFunctor( chains_to_cochains, l );
          
          fi;
        
        end );
      
      AddColift( complex_cat,
          
        function( alpha, beta )
          
          local chains_cat, cat, cochains_to_chains, chains_to_cochains, l;
          
          cat := UnderlyingCategory( complex_cat );
          
          chains_cat := ChainComplexCategory( cat );
          
          cochains_to_chains := CochainToChainComplexFunctor( complex_cat, chains_cat );
          
          chains_to_cochains := ChainToCochainComplexFunctor( chains_cat, complex_cat );
          
          l := Colift( ApplyFunctor( cochains_to_chains, alpha ), ApplyFunctor( cochains_to_chains, beta ) );
          
          if l = fail then
            
            return fail;
            
          else
            
            return ApplyFunctor( chains_to_cochains, l );
          
          fi;
          
        end );
  
  fi;
  
  if shift_index = -1 and
     CanCompute( cat, "DistinguishedObjectOfHomomorphismStructure" ) and
       CanCompute( cat, "HomomorphismStructureOnObjects" ) and
         CanCompute( cat, "HomomorphismStructureOnMorphismsWithGivenObjects" ) and
           CanCompute( cat, "DistinguishedObjectOfHomomorphismStructure" ) and
             CanCompute( cat, "InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure" ) and
               CanCompute( cat, "InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism" ) and
                 HasRangeCategoryOfHomomorphismStructure( cat ) then
                
                range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
                
                if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
                  
                  SetRangeCategoryOfHomomorphismStructure( complex_cat, range_cat_of_hom_struc );
                  
                else
                  
                  if IsIdenticalObj( range_cat_of_hom_struc, cat ) then
                    
                    SetRangeCategoryOfHomomorphismStructure( complex_cat, complex_cat );
                  
                  else
                    
                    SetRangeCategoryOfHomomorphismStructure( complex_cat, ChainComplexCategory( range_cat_of_hom_struc ) );
                  
                  fi;
                
                fi;
                
                ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE( complex_cat );
                
                ADD_HOM_STRUCTURE_ON_CHAINS( complex_cat );
                
                ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS( complex_cat );
                
                ADD_INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE( complex_cat );
                
                ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM( complex_cat );
  
  fi;
  
  to_be_finalized := ValueOption( "FinalizeCategory" );
  
  if to_be_finalized = false then
    
    return complex_cat;
  
  else
    
    Finalize( complex_cat );
  
  fi;
  
  return complex_cat;
  
end );

###########################################
#
#  Constructors of (Co)complexes category
#
###########################################

InstallMethod( ChainComplexCategory, 
                 [ IsCapCategory ],
  function( cat )
    
    return CHAIN_OR_COCHAIN_COMPLEX_CATEGORY( cat, -1 );
    
end );

InstallMethod( CochainComplexCategory, 
                 [ IsCapCategory ],
  function( cat )
    
    return CHAIN_OR_COCHAIN_COMPLEX_CATEGORY( cat, 1 );
    
end );

##########################################
#
# Adding monoidal methods
#
##########################################

InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_CHAIN_COMPLEXES,

  function( category )

    AddTensorProductOnObjects( category, 
      function( C, D )
        local H, V, d;
 
        if not ( HasActiveUpperBound( C ) and HasActiveUpperBound( D ) ) then 
           if not ( HasActiveLowerBound( C ) and HasActiveLowerBound( D ) ) then
              if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( C ) ) then
                  if not ( HasActiveLowerBound( D ) and HasActiveUpperBound( D ) ) then
                     Error( "To tensor two complexes they should have one of the following cases 1. One of them is bounded, 2. Both are upper bounded, 3. Both are lower bounded");
                  fi;
              fi;
           fi;
        fi;

        H := function( i, j )
        
              return TensorProductOnMorphisms( C^i, IdentityMorphism( D[ j ] ) );
              
           end;

        V := function( i, j )
        
            if i mod 2 = 0 then
              
                return TensorProductOnMorphisms( IdentityMorphism( C[ i ] ), D^j );
                
            else
              
                return AdditiveInverse( TensorProductOnMorphisms( IdentityMorphism( C[ i ] ), D^j ) );
            
            fi;
            
            end;

        d := DoubleChainComplex( UnderlyingCategory( category ), H, V );

        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( ) SetRightBound( d, ActiveUpperBound( C ) - 1 ); end ) );
        
        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( ) SetLeftBound( d, ActiveLowerBound( C ) + 1 ); end ) );
        
        AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAU_BOUND", true ] ], function( ) SetAboveBound( d, ActiveUpperBound( D ) - 1 ); end ) );
        
        AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAL_BOUND", true ] ], function( ) SetBelowBound( d, ActiveLowerBound( D ) + 1 ); end ) );

        return TotalChainComplex( d );

    end );

end );

InstallGlobalFunction( ADD_INTERNAL_HOM_ON_CHAIN_COMPLEXES,

  function( category )

  AddInternalHomOnObjects( category, 
    function( C, D )
      local H, V, d;
     
      if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( D ) ) then 
         if not ( HasActiveUpperBound( C ) and HasActiveLowerBound( D ) ) then
            if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( C ) ) then
                if not ( HasActiveLowerBound( D ) and HasActiveUpperBound( D ) ) then
                   Error( "To complete the error string");
                fi;
            fi;
         fi;
      fi;

      H := function( i, j )
          
          if ( i + j  + 1 ) mod 2 = 0 then
            
            return  InternalHomOnMorphisms( C^( -i + 1 ), IdentityMorphism( D[ j ] ) );
            
          else
            
            return AdditiveInverse( InternalHomOnMorphisms( C^( -i + 1 ), IdentityMorphism( D[ j ] ) ) );
            
          fi;
          
        end;

      V := function( i, j )
      
              return InternalHomOnMorphisms( IdentityMorphism( C[ -i ] ), D^j );
          
          end;
      
      d := DoubleChainComplex( UnderlyingCategory( category), H, V );
      
      AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( ) SetLeftBound( d, -ActiveUpperBound( C ) + 1 ); end ) );
      
      AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( ) SetRightBound( d, -ActiveLowerBound( C ) - 1 ); end ) );
      
      AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAU_BOUND", true ] ], function( ) SetAboveBound( d, ActiveUpperBound( D ) - 1 ); end ) );
      
      AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAL_BOUND", true ] ], function( ) SetBelowBound( d, ActiveLowerBound( D ) + 1 ); end ) );
      
      return TotalChainComplex( d );
      
      end );
  
end );


InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_CHAIN_MORPHISMS,
    function( category )
    
      AddTensorProductOnMorphismsWithGivenTensorProducts( category,
        
        function( S, phi, psi, T )
          
          local ss, tt, l;
       
          ss := S!.UnderlyingDoubleComplex;

          tt := T!.UnderlyingDoubleComplex;

          l := MapLazy( IntegersList,
            
            function( m )
              local ind_s, ind_t, morphisms, obj;
              
              # this is important to write the used indices.
              obj := ObjectAt( S, m );
              
              obj := ObjectAt( T, m );
              
              ind_s := ss!.IndicesOfTotalComplex.( String( m ) );
              
              ind_t := tt!.IndicesOfTotalComplex.( String( m ) );
              
              # correct this
              morphisms := List( [ ind_s[ 1 ] .. ind_s[ 2 ] ],
              
                function( i )
                
                  return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                  
                    function( j )
                    
                      if i = j then
                        
                        return TensorProductOnMorphisms( phi[ i ], psi[ m - i ] );
                        
                      else
                        
                        return ZeroMorphism( ObjectAt( ss, i, m - i), ObjectAt( tt, j, m - j ) );
                        
                      fi;
                      
                      end );
                  
                end );
              
              return MorphismBetweenDirectSums( morphisms );
              
              end, 1 );
                                      
          return ChainMorphism( S, T, l );
          
       end );
end );

InstallGlobalFunction( ADD_INTERNAL_HOM_ON_CHAIN_MORPHISMS,
   function( category )
   
   AddInternalHomOnMorphismsWithGivenInternalHoms( category,
      function( S, phi, psi, T )
        local ss, tt, l;
        
        ss := S!.UnderlyingDoubleComplex;

        tt := T!.UnderlyingDoubleComplex;

        l := MapLazy( IntegersList,
          
          function( m )
            local ind_s, ind_t, morphisms, obj;
            
            obj := ObjectAt( S, m );
            obj := ObjectAt( T, m );
            ind_s := ss!.IndicesOfTotalComplex.( String( m ) );
            ind_t := tt!.IndicesOfTotalComplex.( String( m ) );
            morphisms := List( [ ind_s[ 1 ] .. ind_s[ 2 ] ], 
              function( i )
                return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                          function( j )
                            if i=j then 
                              return InternalHomOnMorphisms( phi[ -i ], psi[ m - i ] );
                            else
                              return ZeroMorphism( ObjectAt( ss, i, m - i ), ObjectAt( tt, j, m - j ) );
                            fi;
                          end );
              end );
            return MorphismBetweenDirectSums( morphisms );
            end, 1 );
                                    
      return ChainMorphism( S, T, l );
      
      end );

end );

InstallGlobalFunction( ADD_TENSOR_UNIT_CHAIN,
   function( category )
   
   AddTensorUnit( category, function( )

       return StalkChainComplex( TensorUnit( UnderlyingCategory( category ) ), 0 );
       
   end );
   
end );

InstallGlobalFunction( ADD_BRAIDING_FOR_CHAINS,
   function( category )
   
   AddBraidingWithGivenTensorProducts( category,
      function( s, a, b, t )
      local ss, tt, l;
      
      ss := s!.UnderlyingDoubleComplex;
      tt := t!.UnderlyingDoubleComplex;
      
      l := MapLazy( IntegersList,
        function( m )
          local ind_s, ind_t, morphisms, obj;
             
          obj := ObjectAt( s, m );
          obj := ObjectAt( t, m );
          ind_s := ss!.IndicesOfTotalComplex.( String( m ) );
          ind_t := tt!.IndicesOfTotalComplex.( String( m ) );
          if  IsOddInt( m ) then
              morphisms := List( [ ind_s[ 1 ] .. ind_s[ 2 ] ], 
                function( i )
                  return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                               function( j )
                                 if i = m - j then 
                                 return Braiding( a[ i ], b[ m - i ] );
                                 else
                                 return ZeroMorphism( ObjectAt( ss, i, m - i ), ObjectAt( tt, j, m - j ) );
                                 fi;
                                 end );
                end );
          
          else
            
            morphisms :=  List( [ ind_s[ 1 ] .. ind_s[ 2 ] ], 
              function( i )
                return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                          function( j )
                            if i = m - j then
                              if i mod 2 = 0 then
                                return Braiding( a[ i ], b[ m - i ] );
                              else
                                return AdditiveInverse( Braiding( a[ i ], b[ m - i ] ) );
                              fi;
                            else
                              return ZeroMorphism( ObjectAt( ss, i, m - i ), ObjectAt( tt, j, m - j ) );
                            fi;
                          end );
              end );
          fi;
              
          return MorphismBetweenDirectSums( morphisms );
          
          end, 1 );
                                  
      return ChainMorphism( s, t, l );
      
      end );

end );

InstallGlobalFunction( ADD_TENSOR_PRODUCT_TO_INTERNAL_HOM_ADJUNCTION_MAP,
  function( category )
   
    AddTensorProductToInternalHomAdjunctionMap( category, 
      function( A, B, phi )
      local tensor_A_B, C, hom_B_C, hh, tt, l;
      
      tensor_A_B := TensorProductOnObjects( A, B );
      
      if not IsEqualForObjects( tensor_A_B, Source( phi ) ) then
      
         Error( "The inputs are not compatible" );
        
      fi;
      
      C := Range( phi );
      
      hom_B_C := InternalHomOnObjects( B, C );
      
      hh := hom_B_C!.UnderlyingDoubleComplex;
      
      tt := tensor_A_B!.UnderlyingDoubleComplex;
      
      l := MapLazy( IntegersList,
        function( m )
          local obj, ind_hh, morphisms;
          
          obj := ObjectAt( hom_B_C, m );
          
          ind_hh := hh!.IndicesOfTotalComplex.( String( m ) );
          
          morphisms := List( [ ind_hh[ 1 ] .. ind_hh[ 2 ] ],
            
            function( j )
              local obj2, ind_tt, ll, f;
              
              obj2 := ObjectAt( tensor_A_B, m - j );
              
              ind_tt := tt!.IndicesOfTotalComplex.( String( m - j ) );
              
              ll := List( [ ind_tt[ 1 ] .. ind_tt[ 2 ] ], 
                        function( i )
                        
                          if m = i then
                            
                            return IdentityMorphism( ObjectAt( tt, m, -j ) );
                           
                          else
                          
                            return ZeroMorphism( ObjectAt( tt, m, -j ), ObjectAt( tt, i, m - j - i ) );
                          
                          fi;
                        
                        end );
                        
              f := PreCompose( MorphismBetweenDirectSums( [ ll ] ), phi[ m - j ] );
              
              return TensorProductToInternalHomAdjunctionMap( A[ m ], B[ - j ], f );
              
            end );
                             
          return MorphismBetweenDirectSums( [ morphisms ] );
           
        end, 1 );
      
      return ChainMorphism( A, hom_B_C, l );
       
  end );
       
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_TO_TENSOR_PRODUCT_ADJUNCTION_MAP,
  function( category )
   
    AddInternalHomToTensorProductAdjunctionMap( category, 
      function( B, C, psi )
      local hom_B_C, A, tensor_A_B, tt, l, hh;
      
      hom_B_C := InternalHomOnObjects( B, C );
      
      if not IsEqualForObjects( hom_B_C, Range( psi ) ) then
      
         Error( "The inputs are not compatible" );
        
      fi;
      
      A := Source( psi );
      
      tensor_A_B := TensorProductOnObjects( A, B );
      
      hh := hom_B_C!.UnderlyingDoubleComplex;
      
      tt := tensor_A_B!.UnderlyingDoubleComplex;
      
      l := MapLazy( IntegersList, 
        function( m )
          local obj, ind_tt, morphisms;
          
          obj := ObjectAt( tensor_A_B, m );
          
          ind_tt := tt!.IndicesOfTotalComplex.( String( m ) );
          
          morphisms := List( [ ind_tt[ 1 ] .. ind_tt[ 2 ] ],
                            
            function( i )
              local obj2, ind_hh, ll, f;
              
              obj2 := ObjectAt( hom_B_C, i );
              
              ind_hh := hh!.IndicesOfTotalComplex.( String( i ) );
              
              ll := List( [ ind_hh[ 1 ] .. ind_hh[ 2 ] ],
                       
                      function( j )
                       
                        if j = i - m then
                           
                          return [ IdentityMorphism( ObjectAt( hh, i - m, m ) ) ];
                           
                        else
                           
                          return [ ZeroMorphism( ObjectAt( hh, j, i - j ), ObjectAt( hh, i - m, m ) ) ];
                          
                        fi;
                      
                      end );
                        
              f := PreCompose( psi[ i ], MorphismBetweenDirectSums( ll ) );
              
              return [ InternalHomToTensorProductAdjunctionMap( B[ m - i], C[ m ], f ) ];
            
            end );
                             
          return MorphismBetweenDirectSums( morphisms );
           
        end, 1 );
                                   
       return ChainMorphism( tensor_A_B, C, l );
       
  end );
       
end );

##
InstallGlobalFunction( ADD_HOM_STRUCTURE_ON_CHAINS,
  function( category )
    local cat, range_cat_of_hom_struc, V, d;
    
    cat := UnderlyingCategory( category );
    
    range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
    
    AddHomomorphismStructureOnObjects( category,
      function ( C, D )
        local H, V, d, hom;
        
        if not (HasActiveLowerBound( C ) and HasActiveUpperBound( D )) then
          if not (HasActiveUpperBound( C ) and HasActiveLowerBound( D )) then
            if not (HasActiveLowerBound( C ) and HasActiveUpperBound( C )) then
              if not (HasActiveLowerBound( D ) and HasActiveUpperBound( D )) then
                Error( "The complexes should be bounded" );
              fi;
            fi;
          fi;
        fi; 
        
        d := DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS( C, D );
        
        if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
          
          return Source(  CyclesAt( TotalChainComplex( d ), 0 ) );
          
        else
          
          return TotalChainComplex( d );
          
        fi;
  
  end );

end );

##
InstallGlobalFunction( ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS,
  function( category )
    local cat, range_cat_of_hom_struc;
    
    cat := UnderlyingCategory( category );
    
    range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
    
    AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
      function( s, phi, psi, r )
        local ss, Tot1, rr, Tot2, l;
        
        ss := DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS( Range( phi ), Source( psi ) );
        
        rr := DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS( Source( phi ), Range( psi ) );
        
        Tot1 := TotalChainComplex( ss );
        
        Tot2 := TotalChainComplex( rr );
        
        l := MapLazy( IntegersList, function ( m )
                local ind_s, ind_t, morphisms, obj;
                
                obj := ObjectAt( Tot1, m );
                
                obj := ObjectAt( Tot2, m );
                
                ind_s := ss!.IndicesOfTotalComplex.(String( m ));
                
                ind_t := rr!.IndicesOfTotalComplex.(String( m ));
                
                morphisms := List( [ ind_s[1] .. ind_s[2] ],
                             function ( i )
                               return List( [ ind_t[1] .. ind_t[2] ],
                                 function ( j )
                                   if i = j then
                                     return HomomorphismStructureOnMorphisms( phi[- i], psi[m - i] );
                                   else
                                     return ZeroMorphism( ObjectAt( ss, i, m - i ), ObjectAt( rr, j, m - j ) );
                                   fi;
                                 end );
                             end );
                
                return MorphismBetweenDirectSums( morphisms );
              
              end, 1 );
        
        if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
          
          return CyclesFunctorialAt( ChainMorphism( Tot1, Tot2, l ), 0 );
          
        else
          
          return ChainMorphism( Tot1, Tot2, l );
          
        fi;

    end );

end );

##
InstallGlobalFunction( ADD_INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE,
  function( category )
    local cat, range_cat_of_hom_struc;
    
    cat := UnderlyingCategory( category );
    
    range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
    
    AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( category,
        function( phi )
          local C, D, lower_bound, upper_bound, morphisms_from_distinguished_object, morphism, d, T, i, U;
          
          C := Source( phi );
          D := Range( phi );
          
          lower_bound := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) ) + 1;
          
          upper_bound := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) ) - 1;
          
          morphisms_from_distinguished_object := [  ];
          
          for i in Reversed( [ lower_bound .. upper_bound ] ) do
          
            Add( morphisms_from_distinguished_object,
              InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( phi[ i ] ) );
          
          od;
          
          morphism := MorphismBetweenDirectSums( [ morphisms_from_distinguished_object ] );
          
          d := DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS( C, D );
          
          T := TotalChainComplex( d );
          
          if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
            
            return KernelLift( T^0, morphism );
            
          else
            
            U := StalkChainComplex( Source( morphism ), 0 );
            
            return ChainMorphism( U, T, [ morphism ], 0 );
            
          fi;
        
  end );

end );

##
InstallGlobalFunction( ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM,
  function( category )
    local cat, range_cat_of_hom_struc;
    
    cat := UnderlyingCategory( category );
    
    range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
    
    AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( category,
        function( C, D, psi )
          local lower_bound, upper_bound, d, T, phi, struc_on_objects, indices, L, i;
          
          lower_bound := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) ) + 1;
          upper_bound := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) ) - 1;
          
          d := DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS( C, D );
          
          T := TotalChainComplex( d );
          
          if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
            
            phi := PreCompose( psi, CyclesAt( T, 0 ) );
            
          else
            
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
          
          return ChainMorphism( C, D, Reversed( L ), lower_bound );
  
  end );

end );

##
InstallGlobalFunction( ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE,
    function( category )
      local cat, range_cat_of_hom_struc;
      
      cat := UnderlyingCategory( category );
      
      range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat );
       
      AddDistinguishedObjectOfHomomorphismStructure( category,
        function( )
          
          if HasIsAbelianCategory( range_cat_of_hom_struc ) and IsAbelianCategory( range_cat_of_hom_struc ) then
            
            return DistinguishedObjectOfHomomorphismStructure( cat );
            
          else
            
            return StalkChainComplex( DistinguishedObjectOfHomomorphismStructure( cat ), 0 );
            
          fi;
        
        end );
    
end );

##
InstallMethodWithCrispCache( DOUBLE_COMPLEX_FOR_HOM_STRUCTURE_ON_CHAINS,
      [ IsChainComplex, IsChainComplex ],
      function ( C, D )
        local category, cat, range_cat_of_hom_struc, H, V, d, hom;
        
        category := CapCategory( C );
        
        cat := UnderlyingCategory( category );
        
        range_cat_of_hom_struc := RangeCategoryOfHomomorphismStructure( cat ); 
        
        H := function ( i, j )
              
               if (i + j + 1) mod 2 = 0 then
                 
                 return HomomorphismStructureOnMorphisms( C ^ (- i + 1), IdentityMorphism( D[j] ) );
                 
               else
                 
                 return AdditiveInverse( HomomorphismStructureOnMorphisms( C ^ (- i + 1), IdentityMorphism( D[j] ) ) );
                 
               fi;
               
               return;
          end;
        
        V := function ( i, j )
        
              return HomomorphismStructureOnMorphisms( IdentityMorphism( C[- i] ), D ^ j );
              
          end;
        
        d := DoubleChainComplex( range_cat_of_hom_struc, H, V );
        
        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function (  )
                SetLeftBound( d, - ActiveUpperBound( C ) + 1 );
                return;
            end ) );
        
        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function (  )
                SetRightBound( d, - ActiveLowerBound( C ) - 1 );
                return;
            end ) );
        
        AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAU_BOUND", true ] ], function (  )
                SetAboveBound( d, ActiveUpperBound( D ) - 1 );
                return;
            end ) );
        
        AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAL_BOUND", true ] ], function (  )
                SetBelowBound( d, ActiveLowerBound( D ) + 1 );
                return;
            end ) );
        
        return d;
    
end );


