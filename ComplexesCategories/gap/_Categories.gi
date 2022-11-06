# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
##  Chapter Complexes categories
##
#############################################################################


###########################
#
# Categories constructor
#
###########################

KeyDependentOperation( "CHAIN_OR_COCHAIN_COMPLEX_CATEGORY", IsCapCategory, IsInt, ReturnTrue );

InstallMethod( CHAIN_OR_COCHAIN_COMPLEX_CATEGORYOp,
          [ IsCapCategory, IsInt ],
  function ( cat, shift_index )
    local name, complex_cat, complex_constructor, morphism_constructor, to_be_finalized, range_cat, objects_equality_for_cache, 
    morphisms_equality_for_cache, chains_range_cat, r, list_of_operations, create_func_from_name, add_methods, chains_cat, cochains_range_cat;
    
    r := RandomTextColor( Name( cat ) );
    if shift_index = -1 then
        name := Concatenation( r[1], "Chain complexes( ", r[2], Name( cat ), r[1], " )", r[2] );
        complex_cat := CreateCapCategory( name );
        SetFilterObj( complex_cat, IsChainComplexCategory );
        AddObjectRepresentation( complex_cat, IsChainComplex );
        AddMorphismRepresentation( complex_cat, IsChainMorphism );
        complex_constructor := ChainComplex;
        morphism_constructor := ChainMorphism;
    elif shift_index = 1 then
        name := Concatenation( r[1], "Cochain complexes( ", r[2], Name( cat ), r[1], " )", r[2] );
        complex_cat := CreateCapCategory( name );
        SetFilterObj( complex_cat, IsCochainComplexCategory );
        AddObjectRepresentation( complex_cat, IsCochainComplex );
        AddMorphismRepresentation( complex_cat, IsCochainMorphism );
        complex_constructor := CochainComplex;
        morphism_constructor := CochainMorphism;
    fi;
    SetUnderlyingCategory( complex_cat, cat );
    if HasIsAbCategory( cat ) and IsAbCategory( cat ) then
        SetIsAbCategory( complex_cat, true );
    fi;
    if HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) then
        SetIsAdditiveCategory( complex_cat, true );
    fi;
    if HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) then
        SetIsAbelianCategory( complex_cat, true );
    fi;
    if HasIsLinearCategoryOverCommutativeRing( cat ) and HasCommutativeRingOfLinearCategory( cat ) then
        SetIsLinearCategoryOverCommutativeRing( complex_cat, IsLinearCategoryOverCommutativeRing( cat ) );
        SetCommutativeRingOfLinearCategory( complex_cat, CommutativeRingOfLinearCategory( cat ) );
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
    objects_equality_for_cache := ValueOption( "ObjectsEqualityForCache" );
    if objects_equality_for_cache in [ 1, fail ] then
        Info( InfoComplexesCategories, 3, "Setting the default Caching for objects in ", Name( complex_cat ) );
        AddIsEqualForCacheForObjects( complex_cat, function ( C1, C2 )
              return IsIdenticalObj( C1, C2 );
          end );
    elif objects_equality_for_cache in [ 2 ] then
        AddIsEqualForCacheForObjects( complex_cat, function ( C1, C2 )
              local computed_objects_1, computed_objects_2, indices_1, indices_2, indices, l, u, lu, i;
              if IsIdenticalObj( C1, C2 ) then
                  return true;
              fi;
              if not ForAll( [ C1, C2 ], IsBoundedChainOrCochainComplex ) then
                  return false;
              fi;
              computed_objects_1 := ComputedObjectAts( C1 );
              computed_objects_2 := ComputedObjectAts( C2 );
              indices_1 := List( [ 1 .. Length( computed_objects_1 ) / 2 ], function ( i )
                      return computed_objects_1[2 * i - 1];
                  end );
              indices_2 := List( [ 1 .. Length( computed_objects_2 ) / 2 ], function ( i )
                      return computed_objects_2[2 * i - 1];
                  end );
              indices := Intersection( indices_1, indices_2 );
              for i in indices do
                  if not IsEqualForObjects( C1[i], C2[i] ) or not IsEqualForMorphismsOnMor( C1 ^ i, C2 ^ i ) then
                      return false;
                  fi;
              od;
              l := Minimum( ActiveLowerBound( C1 ), ActiveLowerBound( C2 ) );
              u := Maximum( ActiveUpperBound( C1 ), ActiveUpperBound( C2 ) );
              lu := [ l .. u ];
              SubtractSet( lu, indices );
              if lu = [  ] then
                  return true;
              fi;
              return false;
          end );
    else
        Error( "ObjectsEqualityForCache option can not be interpreted!" );
    fi;
    morphisms_equality_for_cache := ValueOption( "MorphismsEqualityForCache" );
    if morphisms_equality_for_cache in [ fail, 1 ] then
        Info( InfoComplexesCategories, 3, "Setting the default Caching for morphisms in ", Name( complex_cat ) );
        AddIsEqualForCacheForMorphisms( complex_cat, function ( m1, m2 )
              return IsIdenticalObj( m1, m2 );
          end );
    elif morphisms_equality_for_cache in [ 2 ] then
        AddIsEqualForCacheForMorphisms( complex_cat, function ( m1, m2 )
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
              indices_1 := List( [ 1 .. Length( computed_morphisms_1 ) / 2 ], function ( i )
                      return computed_morphisms_1[2 * i - 1];
                  end );
              indices_2 := List( [ 1 .. Length( computed_morphisms_2 ) / 2 ], function ( i )
                      return computed_morphisms_2[2 * i - 1];
                  end );
              indices := Intersection( indices_1, indices_2 );
              for i in indices do
                  if not IsEqualForMorphisms( m1[i], m2[i] ) then
                      return false;
                  fi;
              od;
              l := Minimum( Minimum( ActiveLowerBound( Source( m1 ) ), ActiveLowerBound( Range( m1 ) ) ), 
                 Minimum( ActiveLowerBound( Source( m2 ) ), ActiveLowerBound( Range( m2 ) ) ) );
              u := Maximum( Maximum( ActiveUpperBound( Source( m1 ) ), ActiveUpperBound( Range( m1 ) ) ),
                 Maximum( ActiveUpperBound( Source( m2 ) ), ActiveUpperBound( Range( m2 ) ) ) );
              lu := [ l .. u ];
              SubtractSet( lu, indices );
              if lu = [  ] then
                  return true;
              fi;
              return false;
          end );
    else
        Error( "MorphismsEqualityForCache option can not be interpreted!" );
    fi;
    AddIsEqualForObjects( complex_cat, function ( C1, C2 )
          local computed_objects_1, computed_objects_2, indices_1, indices_2, indices, l, u, lu, i;
          if IsIdenticalObj( C1, C2 ) then
              return true;
          fi;
          if not ForAll( [ C1, C2 ], IsBoundedChainOrCochainComplex ) then
              Error( "Complexes must be bounded" );
          fi;
          computed_objects_1 := ComputedObjectAts( C1 );
          computed_objects_2 := ComputedObjectAts( C2 );
          indices_1 := List( [ 1 .. Length( computed_objects_1 ) / 2 ], function ( i )
                  return computed_objects_1[2 * i - 1];
              end );
          indices_2 := List( [ 1 .. Length( computed_objects_2 ) / 2 ], function ( i )
                  return computed_objects_2[2 * i - 1];
              end );
          indices := Intersection( indices_1, indices_2 );
          for i in indices do
              if not IsEqualForObjects( C1[i], C2[i] ) or not IsEqualForMorphismsOnMor( C1 ^ i, C2 ^ i ) then
                  return false;
              fi;
          od;
          l := Minimum( ActiveLowerBound( C1 ), ActiveLowerBound( C2 ) );
          u := Maximum( ActiveUpperBound( C1 ), ActiveUpperBound( C2 ) );
          lu := [ l - 1 .. u + 1 ];
          SubtractSet( lu, indices );
          for i in lu do
              if not IsEqualForObjects( C1[i], C2[i] ) or not IsEqualForMorphismsOnMor( C1 ^ i, C2 ^ i ) then
                  return false;
              fi;
          od;
          return true;
      end );
    AddIsEqualForMorphisms( complex_cat, function ( m1, m2 )
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
          indices_1 := List( [ 1 .. Length( computed_morphisms_1 ) / 2 ], function ( i )
                  return computed_morphisms_1[2 * i - 1];
              end );
          indices_2 := List( [ 1 .. Length( computed_morphisms_2 ) / 2 ], function ( i )
                  return computed_morphisms_2[2 * i - 1];
              end );
          indices := Intersection( indices_1, indices_2 );
          for i in indices do
              if not IsEqualForMorphisms( m1[i], m2[i] ) then
                  return false;
              fi;
          od;
          l := Minimum( Minimum( ActiveLowerBound( Source( m1 ) ), ActiveLowerBound( Range( m1 ) ) ), Minimum( ActiveLowerBound( Source( m2 ) ), 
               ActiveLowerBound( Range( m2 ) ) ) );
          u := Maximum( Maximum( ActiveUpperBound( Source( m1 ) ), ActiveUpperBound( Range( m1 ) ) ), Maximum( ActiveUpperBound( Source( m2 ) ), 
                ActiveUpperBound( Range( m2 ) ) ) );
          lu := [ l - 1 .. u + 1 ];
          SubtractSet( lu, indices );
          for i in lu do
              if not IsEqualForMorphisms( m1[i], m2[i] ) then
                  return false;
              fi;
          od;
          return true;
      end );
    AddIsCongruentForMorphisms( complex_cat, function ( m1, m2 )
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
          indices_1 := List( [ 1 .. Length( computed_morphisms_1 ) / 2 ], function ( i )
                  return computed_morphisms_1[2 * i - 1];
              end );
          indices_2 := List( [ 1 .. Length( computed_morphisms_2 ) / 2 ], function ( i )
                  return computed_morphisms_2[2 * i - 1];
              end );
          indices := Intersection( indices_1, indices_2 );
          for i in indices do
              if not IsCongruentForMorphisms( m1[i], m2[i] ) then
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
          
          lu := [ l - 1 .. u + 1 ];
          SubtractSet( lu, indices );
          for i in lu do
              if not IsCongruentForMorphisms( m1[i], m2[i] ) then
                  return false;
              fi;
          od;
          return true;
      end );
    if CanCompute( cat, "IsWellDefinedForObjects" ) and CanCompute( cat, "IsWellDefinedForMorphisms" ) then
        AddIsWellDefinedForObjects( complex_cat, function ( C )
              if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( C ) ) then
                  Error( "the input should be a bounded complex!\n" );
              else
                  return IsWellDefined( C, -1 + ActiveLowerBound( C ), 1 + ActiveUpperBound( C ) );
              fi;
          end );
    fi;
    if CanCompute( cat, "IsWellDefinedForObjects" ) and CanCompute( cat, "IsWellDefinedForMorphisms" ) then
        AddIsWellDefinedForMorphisms( complex_cat, function ( phi )
              if not ( HasActiveLowerBound( phi ) and HasActiveUpperBound( phi ) ) then
                  Error( "The morphism must be bounded" );
              else
                  return IsWellDefined( phi, -1 + ActiveLowerBound( phi ), 1 + ActiveUpperBound( phi ) );
              fi;
          end );
    fi;
    
    add_methods :=
      function( list_of_operations, create_func_from_name )
        local name;
        
        for name in list_of_operations do
          if CanCompute( cat, name ) then
              ValueGlobal( Concatenation( "Add", name ) )( 
                  complex_cat, create_func_from_name( name ) );
          fi;
        od;
        
      end;
    
    ########################################################################
    list_of_operations :=
      [
        "IsZeroForObjects",
        "IsZeroForMorphisms",
        "IsMonomorphism",
        "IsEpimorphism",
        #"IsSplitEpimorphism",
        #"IsSplitMonomorphism",
        "IsIsomorphism"
      ];

    create_func_from_name :=
      function( name )
        local oper;
        
        oper := ValueGlobal( name );
        
        return
          function( cell )
            local computed_cells, lower_bound, upper_bound, n, indices;
            
            if IsCapCategoryObject( cell ) then
              
              computed_cells := ComputedObjectAts( cell );
              
              lower_bound := ActiveLowerBound( cell );
              
              upper_bound := ActiveLowerBound( cell );
              
            elif IsCapCategoryMorphism( cell ) then
              
              computed_cells := ComputedMorphismAts( cell );
              
              lower_bound := ActiveLowerBoundForSourceAndRange( cell );
              
              upper_bound := ActiveUpperBoundForSourceAndRange( cell );
              
            else
              
              Error( "Unexpected type, please let me know about this!\n" );
              
            fi;
              
            n := Length( computed_cells ) / 2;
              
            indices := List( [ 1 .. n ], i -> computed_cells[ 2 * i - 1 ] );
            
            computed_cells := List( [ 1 .. n ], i -> computed_cells[ 2 * i ] );
            
            if ForAny( computed_cells, c -> not oper( c ) ) then
              
              return false;
              
            fi;
            
            indices := Difference( [ lower_bound .. upper_bound ], indices );
            
            return ForAll( indices, i -> oper( cell[ i ] ) );
            
          end;
          
      end;
           
    add_methods( list_of_operations, create_func_from_name );
    
    ###################################################################
    
    list_of_operations :=
      [
       "ZeroObject",
       "TerminalObject",
       "InitialObject",
      ];

    create_func_from_name :=
      function( name )
        return
          function( )
            local functorial, result;
            
            functorial := ValueGlobal( Concatenation( name, "Functorial" ) );
            
            result := complex_constructor( [ functorial( cat ) ], 0 );
            
            SetUpperBound( result, 0 );
            
            SetLowerBound( result, 0 );
           
            return result;
            
          end;
      end;
        
    add_methods( list_of_operations, create_func_from_name );
    
    ###################################################################
      
    list_of_operations :=
      [
        "AdditionForMorphisms",
        "PreCompose",
        "PostCompose",
        "LiftAlongMonomorphism",
        "ColiftAlongEpimorphism",
        "AdditiveInverseForMorphisms",
        "InverseForMorphisms"
      ];
       
    create_func_from_name :=
      function( name )
        local oper, type;
        
        oper := ValueGlobal( name );
        
        type := CAP_INTERNAL_METHOD_NAME_RECORD.( name ).io_type;
        
        return
          function( arg )
            local src_rng, z_func;
            
            src_rng := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
            
            z_func := ApplyMap( List( arg, Morphisms ), oper );
            
            return morphism_constructor( src_rng[ 1 ], src_rng[ 2 ], z_func );
            
          end;
          
      end;
    
    add_methods( list_of_operations, create_func_from_name );
        
    ###################################################################
    
    list_of_operations :=
      [
        "IdentityMorphism",
        "ZeroMorphism"
      ];
    
    create_func_from_name :=
      function( name )
        local oper, type;
        
        oper := ValueGlobal( name );
        
        type := CAP_INTERNAL_METHOD_NAME_RECORD.( name ).io_type;
        
        return
          function( arg  )
            local src_rng, z_func;
            
            src_rng := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
            
            z_func := ApplyMap( List( arg, Objects ), oper );
            
            return morphism_constructor( src_rng[ 1 ], src_rng[ 2 ], z_func );
            
          end;
          
      end;
      
    add_methods( list_of_operations, create_func_from_name );   
    
    ###################################################################
   
    if HasIsAdditiveCategory( complex_cat ) and IsAdditiveCategory( complex_cat ) then
                
      if CanCompute( cat, "DirectSum" ) then
        AddDirectSum( complex_cat,
           function ( arg )
              local eval_arg, result, lower_bound, upper_bound;
              
              if IsList( arg[ 1 ] ) then
                
                arg := arg[ 1 ];
                
              fi;
              
              eval_arg := List( arg, Differentials );
              
              eval_arg := CombineZFunctions( eval_arg );
              
              eval_arg := ApplyMap( eval_arg, DirectSumFunctorial );
              
              result := complex_constructor( cat, eval_arg );
              
              lower_bound := Minimum( List( arg, ActiveLowerBound ) );
              
              upper_bound := Maximum( List( arg, ActiveUpperBound ) );
              
              SetLowerBound( result, lower_bound );
              
              SetUpperBound( result, upper_bound );
              
              return result;
              
           end );
          
        fi;
        
        ###################################################################
       
        list_of_operations :=
          [
            "DirectSumFunctorialWithGivenDirectSums" 
          ];
            
        create_func_from_name :=
          function( name )
            local oper, type;
            
            oper := ValueGlobal( name );
            
            type := CAP_INTERNAL_METHOD_NAME_RECORD.( name ).io_type;
           
            return
              function ( arg ) 
                local src_rng, source_diagram, morphisms, range_diagram;
                
                src_rng := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
               
                source_diagram := CombineZFunctions( List( arg[ 2 ], Objects ) );
                
                morphisms := CombineZFunctions( List( arg[ 3 ], Morphisms ) );
                
                range_diagram := CombineZFunctions( List( arg[ 4 ], Objects ) );
                
                morphisms := ApplyMap( [ Objects( src_rng[ 1 ] ), source_diagram, morphisms, range_diagram, Objects( src_rng[ 2 ] ) ], oper );
                
                return morphism_constructor( src_rng[ 1 ], src_rng[ 2 ], morphisms );
                
              end;
          
          end;
          
        add_methods( list_of_operations, create_func_from_name );
        
        ###################################################################
        
        list_of_operations :=
          [
            "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
            "ProjectionInFactorOfDirectSumWithGivenDirectSum"
          ];
        
        create_func_from_name :=
          function( name )
            local oper, type;
            
            oper := ValueGlobal( name );
            
            type := CAP_INTERNAL_METHOD_NAME_RECORD.( name ).io_type;
            
            return
              function ( arg )
                local src_rng, objects, morphisms;
                
                src_rng := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
                
                objects := List( arg[ 1 ], Objects );
                
                objects := CombineZFunctions( objects );
                
                objects := CombineZFunctions( [ objects, Objects( arg[ 3 ] ) ] );
                
                morphisms := ApplyMap( objects, l -> oper( l[ 1 ], arg[ 2 ], l[ 2 ] ) );
                
                return morphism_constructor( src_rng[ 1 ], src_rng[ 2 ], morphisms );
                  
              end;
              
          end;
    
        add_methods( list_of_operations, create_func_from_name );
        
        ###################################################################
        
        list_of_operations :=
          [
            "UniversalMorphismIntoDirectSumWithGivenDirectSum",
            "UniversalMorphismFromDirectSumWithGivenDirectSum"
          ];
          
        create_func_from_name :=
          function( name )
            local oper, type;
            
            oper := ValueGlobal( name );
            
            type := CAP_INTERNAL_METHOD_NAME_RECORD.( name ).io_type;
           
            return
              function( arg )
                local src_rng, objects, morphisms;
                
                src_rng := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
                
                objects := CombineZFunctions( List( arg[ 1 ], Objects ) );
                
                morphisms := CombineZFunctions( List( arg[ 3 ], Morphisms ) );
                
                morphisms := ApplyMap( [ objects, Objects( arg[ 2 ] ), morphisms, Objects( arg[ 4 ] ) ], oper );
                
                return morphism_constructor( src_rng[ 1 ], src_rng[ 2 ], morphisms );
                
              end;
              
          end;
          
        add_methods( list_of_operations, create_func_from_name );
        
        ###################################################################
        
        list_of_operations :=
          [
            "MorphismBetweenDirectSumsWithGivenDirectSums"
          ];
          
        create_func_from_name :=
          function( name )
            local oper, type;
            
            oper := ValueGlobal( name );
            
            type := CAP_INTERNAL_METHOD_NAME_RECORD.( name ).io_type;
            
            return
              function( arg )
                local src_rng, morphisms, source_diagram, range_diagram;
                
                src_rng := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
                
                morphisms := List( arg[ 3 ], r -> CombineZFunctions( List( r, Morphisms ) ) );
                
                morphisms := CombineZFunctions( morphisms );
                
                source_diagram := CombineZFunctions( List( arg[ 2 ], Objects ) );
                
                range_diagram := CombineZFunctions( List( arg[ 4 ], Objects ) );
                
                morphisms := ApplyMap( [ Objects( src_rng[ 1 ] ), source_diagram, morphisms, range_diagram, Objects( src_rng[ 2 ] ) ], oper );
                
                return morphism_constructor( src_rng[ 1 ], src_rng[ 2 ], morphisms );
                
              end;
            
          end;
          
        add_methods( list_of_operations, create_func_from_name );
        
        ###################################################################
        
    fi;
    
    if HasIsAbelianCategory( complex_cat ) and IsAbelianCategory( complex_cat ) then
        
        # Kernel & Cokernel should have a unified create_func_from_name!
        list_of_operations :=
          [
            "KernelObject",
          ];
          
        create_func_from_name :=
          function( name )
            local oper, info, functorial;
            
            oper := ValueGlobal( name );
            
            info := CAP_INTERNAL_METHOD_NAME_RECORD.( name );
            
            functorial := ValueGlobal( info.functorial );
            
            return
              function( arg )
                local mu, alpha_s, s, alpha_r, r, z_func, complex;
                
                mu := Differentials( Source( arg[ 1 ] ) );
                
                alpha_s := Morphisms( arg[ 1 ] );
                
                s := ApplyMap( alpha_s, oper );
                
                alpha_r := ApplyShift( alpha_s, shift_index );
                
                r := ApplyShift( s, shift_index );
                
                z_func := ApplyMap( [ s, alpha_s, mu, alpha_r, r ], functorial );
                
                complex := complex_constructor( cat, z_func );
                
                SetLowerBound( complex, ActiveLowerBoundForSourceAndRange( arg[ 1 ] ) );
                
                SetUpperBound( complex, ActiveUpperBoundForSourceAndRange( arg[ 1 ] ) );
                
                return complex;
                
              end;
          
          end;
        
        add_methods( list_of_operations, create_func_from_name );
       
        list_of_operations :=
          [
            "CokernelObject",
          ];
          
        create_func_from_name :=
          function( name )
            local oper, info, functorial;
            
            oper := ValueGlobal( name );
            
            info := CAP_INTERNAL_METHOD_NAME_RECORD.( name );
            
            functorial := ValueGlobal( info.functorial );
            
            return
              function( arg )
                local nu, alpha_s, s, alpha_r, r, z_func, complex;
                
                nu := Differentials( Range( arg[ 1 ] ) );
                
                alpha_s := Morphisms( arg[ 1 ] );
                
                s := ApplyMap( alpha_s, oper );
                
                alpha_r := ApplyShift( alpha_s, shift_index );
                
                r := ApplyShift( s, shift_index );
                
                z_func := ApplyMap( [ s, alpha_s, nu, alpha_r, r ], functorial );
                
                complex := complex_constructor( cat, z_func );
                
                SetLowerBound( complex, ActiveLowerBoundForSourceAndRange( arg[ 1 ] ) );
                
                SetUpperBound( complex, ActiveUpperBoundForSourceAndRange( arg[ 1 ] ) );
                
                return complex;
                
              end;
              
          end;
        
        add_methods( list_of_operations, create_func_from_name );
        
        list_of_operations :=
          [
            "KernelEmbeddingWithGivenKernelObject",
            "CokernelProjectionWithGivenCokernelObject"
          ];
        
        create_func_from_name :=
          function( name )
            local oper, type;
            
            oper := ValueGlobal( name );
            
            type := CAP_INTERNAL_METHOD_NAME_RECORD.( name ).io_type;
            
            return
              
              function( arg )
                local src_rng, morphisms;
                
                src_rng := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
                
                morphisms := ApplyMap( [ Morphisms( arg[ 1 ] ), Objects( arg[ 2 ] ) ], oper );
                
                return morphism_constructor( src_rng[ 1 ], src_rng[ 2 ], morphisms );
                
              end;
              
          end;
        
        add_methods( list_of_operations, create_func_from_name );
        
        list_of_operations :=
          [
            "KernelLiftWithGivenKernelObject",
            "CokernelColiftWithGivenCokernelObject",
          ];
        
        create_func_from_name :=
          function( name )
            local oper, type;
            
            oper := ValueGlobal( name );
            
            type := CAP_INTERNAL_METHOD_NAME_RECORD.( name ).io_type;
            
            return
              function ( arg )
                local src_rng, morphisms;
                
                src_rng := CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS( type, arg );
                
                morphisms := ApplyMap( [ Morphisms( arg[ 1 ] ), Objects( arg[2] ), Morphisms( arg[ 3 ] ), Objects( arg[ 4 ] ) ], oper );
                
                return morphism_constructor( src_rng[ 1 ], src_rng[ 2 ], morphisms );
                
              end;
          
          end;
        
        add_methods( list_of_operations, create_func_from_name );
        
    fi;
    
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
        AddIsProjective( complex_cat, function ( C )
              local i;
              if not IsBoundedChainOrCochainComplex( C ) then
                  Error( "The complex must be bounded" );
              fi;
              if not IsExact( C ) then
                  return false;
              fi;
              for i in [ ActiveLowerBound( C ) .. ActiveUpperBound( C ) ] do
                  if not IsProjective( C[i] ) then
                      return false;
                  fi;
              od;
              return true;
          end );
        AddProjectiveLift( complex_cat, function ( phi, pi )
              local P, H, l, XX;
              P := Source( phi );
              XX := Source( pi );
              H := AsZFunction( function ( i )
                      local id, m, n;
                      id := IdentityMorphism( P );
                      if i < ActiveLowerBound( P ) then
                          return ZeroMorphism( P[i], P[i + 1] );
                      elif i = ActiveLowerBound( P ) then
                          return ProjectiveLift( id[i], P ^ (i + 1) );
                      fi;
                      m := KernelLift( P ^ i, id[i] - PreCompose( P ^ i, H[(i - 1)] ) );
                      n := PreCompose( CoastrictionToImage( P ^ (i + 1) ), KernelLift( P ^ i, ImageEmbedding( P ^ (i + 1) ) ) );
                      return ProjectiveLift( m, n );
                  end );
              l := AsZFunction( function ( i )
                      return PreCompose( [ H[i], ProjectiveLift( phi[i + 1], pi[i + 1] ), XX ^ (i + 1) ] ) 
                        + PreCompose( [ P ^ i, H[(i - 1)], ProjectiveLift( phi[i], pi[i] ) ] );
                  end );
              return ChainMorphism( P, XX, l );
          end );
    fi;
    if CanCompute( cat, "Lift" ) and HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAbelianCategory( cat ) and IsAbelianCategory( cat )
        and shift_index = -1 then
        AddLift( complex_cat, function ( alpha, beta )
              local cat, U, P, N, M, alpha_, beta_, internal_hom_P_M, internal_hom_P_N, internal_hom_id_P_beta, k_internal_hom_id_P_beta_0, alpha_1, lift;
              cat := CapCategory( alpha );
              U := TensorUnit( cat );
              P := Source( alpha );
              N := Range( alpha );
              M := Source( beta );
              alpha_ := TensorProductToInternalHomAdjunctionMap( U, Source( alpha ), alpha );
              beta_ := TensorProductToInternalHomAdjunctionMap( U, Source( beta ), beta );
              internal_hom_id_P_beta := InternalHomOnMorphisms( IdentityMorphism( P ), beta );
              internal_hom_P_M := Source( internal_hom_id_P_beta );
              internal_hom_P_N := Range( internal_hom_id_P_beta );
              k_internal_hom_id_P_beta_0 := KernelLift( internal_hom_P_N ^ 0, PreCompose( CyclesAt( internal_hom_P_M, 0 ), internal_hom_id_P_beta[0] ) );
              alpha_1 := KernelLift( internal_hom_P_N ^ 0, alpha_[0] );
              lift := Lift( alpha_1, k_internal_hom_id_P_beta_0 );
              if lift = fail then
                  return fail;
              else
                  lift := ChainMorphism( U, internal_hom_P_M, [ PreCompose( lift, CyclesAt( internal_hom_P_M, 0 ) ) ], 0 );
                  return InternalHomToTensorProductAdjunctionMap( P, M, lift );
              fi;
              return;
          end );
        AddColift( complex_cat, function ( alpha, beta )
              local cat, U, P, N, M, alpha_, beta_, internal_hom_P_M, internal_hom_N_M, internal_hom_alpha_id_M, k_internal_hom_alpha_id_M_0, beta_1, lift;
              cat := CapCategory( alpha );
              U := TensorUnit( cat );
              P := Range( alpha );
              N := Source( alpha );
              M := Range( beta );
              alpha_ := TensorProductToInternalHomAdjunctionMap( U, Source( alpha ), alpha );
              beta_ := TensorProductToInternalHomAdjunctionMap( U, Source( beta ), beta );
              internal_hom_alpha_id_M := InternalHomOnMorphisms( alpha, IdentityMorphism( M ) );
              internal_hom_P_M := Source( internal_hom_alpha_id_M );
              internal_hom_N_M := Range( internal_hom_alpha_id_M );
              k_internal_hom_alpha_id_M_0 := KernelLift( internal_hom_N_M ^ 0, PreCompose( CyclesAt( internal_hom_P_M, 0 ), internal_hom_alpha_id_M[0] ) );
              beta_1 := KernelLift( internal_hom_N_M ^ 0, beta_[0] );
              lift := Lift( beta_1, k_internal_hom_alpha_id_M_0 );
              if lift = fail then
                  return fail;
              else
                  lift := ChainMorphism( U, internal_hom_P_M, [ PreCompose( lift, CyclesAt( internal_hom_P_M, 0 ) ) ], 0 );
                  return InternalHomToTensorProductAdjunctionMap( P, M, lift );
              fi;
              return;
          end );
    fi;
    if CanCompute( cat, "Lift" ) and HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAbelianCategory( cat ) and IsAbelianCategory( cat )
        and shift_index = 1 then
        AddLift( complex_cat, function ( alpha, beta )
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
              return;
          end );
        AddColift( complex_cat, function ( alpha, beta )
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
              return;
          end );
    fi;
    
    if CanCompute( cat, "DistinguishedObjectOfHomomorphismStructure" )
        and CanCompute( cat, "HomomorphismStructureOnObjects" )
          and CanCompute( cat, "HomomorphismStructureOnMorphismsWithGivenObjects" )
            and CanCompute( cat, "DistinguishedObjectOfHomomorphismStructure" )
              and CanCompute( cat, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" )
                and CanCompute( cat, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) 
                  and HasRangeCategoryOfHomomorphismStructure( cat ) then
        
      range_cat := RangeCategoryOfHomomorphismStructure( cat );
      
      if shift_index = -1 then
        
        if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
            SetRangeCategoryOfHomomorphismStructure( complex_cat, range_cat );
        elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
            SetRangeCategoryOfHomomorphismStructure( complex_cat, ValueGlobal( "FreydCategory" )( range_cat : FinalizeCategory := true ) );
        else
            if IsIdenticalObj( range_cat, cat ) then
                SetRangeCategoryOfHomomorphismStructure( complex_cat, complex_cat );
            else
                chains_range_cat := ChainComplexCategory( range_cat );
                if not IsFinalized( chains_range_cat ) then
                    Info( InfoWarning, 2, "For some reason the category", Name( chains_range_cat ), " has not been finalized!\n" );
                    Finalize( chains_range_cat );
                fi;
                SetRangeCategoryOfHomomorphismStructure( complex_cat, chains_range_cat );
            fi;
        fi;
        ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_FOR_CHAINS( complex_cat );
        ADD_HOM_STRUCTURE_ON_CHAINS( complex_cat );
        ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS( complex_cat );
        ADD_INTERPRET_CHAIN_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE( complex_cat );
        ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_CHAIN_MORPHISM( complex_cat );
      
      else
        
        if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
            SetRangeCategoryOfHomomorphismStructure( complex_cat, range_cat );
        elif IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2019.11.02" ) and ValueGlobal( "IsValidInputForFreydCategory" )( range_cat ) then
            SetRangeCategoryOfHomomorphismStructure( complex_cat, ValueGlobal( "FreydCategory" )( range_cat : FinalizeCategory := true ) );
        else
            if IsIdenticalObj( range_cat, cat ) then
                SetRangeCategoryOfHomomorphismStructure( complex_cat, complex_cat );
            else
                chains_range_cat := CochainComplexCategory( range_cat );
                if not HasIsFinalized( cochains_range_cat ) then
                    Info( InfoWarning, 2, "For some reason the category", Name( cochains_range_cat ), " has not been finalized!\n" );
                    Finalize( cochains_range_cat );
                fi;
                SetRangeCategoryOfHomomorphismStructure( complex_cat, cochains_range_cat );
            fi;
        fi;
        
        ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_FOR_COCHAINS( complex_cat );
        ADD_HOM_STRUCTURE_ON_COCHAINS( complex_cat );
        ADD_HOM_STRUCTURE_ON_COCHAINS_MORPHISMS( complex_cat );
        ADD_INTERPRET_COCHAIN_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE( complex_cat );
        ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_COCHAIN_MORPHISM( complex_cat );
       
      fi;
      
    fi;
        
    if CanCompute( cat, "MultiplyWithElementOfCommutativeRingForMorphisms" ) then
        AddMultiplyWithElementOfCommutativeRingForMorphisms( complex_cat, function ( r, phi )
              local mors;
              mors := Morphisms( phi );
              mors := ApplyMap( mors, function ( m )
                      return MultiplyWithElementOfCommutativeRingForMorphisms( r, m );
                  end );
              return ValueGlobal( "CHAIN_OR_COCHAIN_MORPHISM_BY_Z_FUNCTION" )( Source( phi ), Range( phi ), mors );
          end );
    fi;
     
    Finalize( complex_cat );
    
    return complex_cat;
end );

###########################################
#
#  Constructors of (Co)complexes category
#
###########################################

##
InstallMethod( ComplexCategoryByChains, [ IsCapCategory ], ChainComplexCategory );

##
InstallMethod( ChainComplexCategory, 
          [ IsCapCategory ],
          
  function( cat )
    local objects_equality, morphisms_equality;
    
    objects_equality := ValueOption( "ObjectsEqualityForCache" );
    
    morphisms_equality := ValueOption( "MorphismsEqualityForCache" );
     
    return CHAIN_OR_COCHAIN_COMPLEX_CATEGORY( cat, -1 : ObjectsEqualityForCache  := objects_equality,
                                                        MorphismsEqualityForCache := morphisms_equality );
  
end );

##
InstallMethod( ComplexCategoryByCochains, [ IsCapCategory ], CochainComplexCategory );

##
InstallMethod( CochainComplexCategory,
          [ IsCapCategory ],
          
  function( cat )
    local objects_equality, morphisms_equality;
    
    objects_equality := ValueOption( "objects_equality_for_cache" );
    
    morphisms_equality := ValueOption( "morphisms_equality_for_cache" );
    
    return CHAIN_OR_COCHAIN_COMPLEX_CATEGORY( cat, 1: ObjectsEqualityForCache := objects_equality,
                                                      MorphismsEqualityForCache := morphisms_equality );
  
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

        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( ) SetRightBound( d, ActiveUpperBound( C ) ); end ) );
        
        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( ) SetLeftBound( d, ActiveLowerBound( C ) ); end ) );
        
        AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAU_BOUND", true ] ], function( ) SetAboveBound( d, ActiveUpperBound( D ) ); end ) );
        
        AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAL_BOUND", true ] ], function( ) SetBelowBound( d, ActiveLowerBound( D ) ); end ) );

        return TotalComplex( d );

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
      
      AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( ) SetLeftBound( d, - ActiveUpperBound( C ) ); end ) );
      
      AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( ) SetRightBound( d, - ActiveLowerBound( C ) ); end ) );
      
      AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAU_BOUND", true ] ], function( ) SetAboveBound( d, ActiveUpperBound( D ) ); end ) );
      
      AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAL_BOUND", true ] ], function( ) SetBelowBound( d, ActiveLowerBound( D ) ); end ) );
      
      return TotalComplex( d );
      
      end );
  
end );


InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_CHAIN_MORPHISMS,
    function( category )
    
      AddTensorProductOnMorphismsWithGivenTensorProducts( category,
        
        function( S, phi, psi, T )
          
          local ss, tt, l;
       
          ss := S!.UnderlyingDoubleComplex;

          tt := T!.UnderlyingDoubleComplex;

          l := AsZFunction(
            
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
              
              end );
                                      
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

        l := AsZFunction(
          
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
            end );
                                    
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
      
      l := AsZFunction(
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
          
          end );
                                  
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
      
      l := AsZFunction(
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
           
        end );
      
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
      
      l := AsZFunction( 
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
           
        end );
                                   
       return ChainMorphism( tensor_A_B, C, l );
       
  end );
       
end );

##
InstallOtherMethod( \/,
          [ IsCapCategoryObject, IsChainComplexCategory ],
  function( a, chains )
    
    if not IsIdenticalObj( CapCategory( a ), UnderlyingCategory( chains ) ) then
      Error( "wronge input!\n" );
    fi;
    
    return StalkChainComplex( a, 0 );
    
end );

##
InstallOtherMethod( \/,
          [ IsCapCategoryObject, IsCochainComplexCategory ],
  function( a, cochains )
    
    if not IsIdenticalObj( CapCategory( a ), UnderlyingCategory( cochains ) ) then
      Error( "wronge input!\n" );
    fi;
    
    return StalkCochainComplex( a, 0 );
    
end );

##
InstallOtherMethod( \/,
          [ IsCapCategoryMorphism, IsChainComplexCategory ],
  function( alpha, chains )
    
    if not IsIdenticalObj( CapCategory( alpha ), UnderlyingCategory( chains ) ) then
      Error( "wronge input!\n" );
    fi;
    
    return StalkChainMorphism( alpha, 0 );
    
end );

##
InstallOtherMethod( \/,
          [ IsCapCategoryMorphism, IsCochainComplexCategory ],
  function( alpha, cochains )
    
    if not IsIdenticalObj( CapCategory( alpha ), UnderlyingCategory( cochains ) ) then
      Error( "wronge input!\n" );
    fi;
    
    return StalkCochainMorphism( alpha, 0 );
    
end );

##
InstallMethod( FullSubcategoryGeneratedByComplexesConcentratedInDegreeOp,
          [ IsChainOrCochainComplexCategory, IsInt ],
  function( cat, i )
    local name, r, full;
    
    name := Concatenation( "Full additive subcategory generated by complexes concentrated in degree ", String( i ) );
    
    r := RandomTextColor( Name( cat ) );
    
    name := Concatenation( r[ 1 ], name, " ( ", r[ 2 ], Name( cat ), r[ 1 ], " )", r[ 2 ] );
    
    full := ValueGlobal( "FullSubcategory" )( cat, name : FinalizeCategory := false, is_additive := true );
    
    AddIsWellDefinedForObjects( full,
      function( a )
        local c;
        
        c := ValueGlobal( "UnderlyingCell" )( a );
        
        return IsWellDefined( c ) and ActiveUpperBound( c ) = ActiveLowerBound( c ) and ActiveLowerBound( c ) = i;
        
    end );
    
    AddIsWellDefinedForMorphisms( full,
      function( alpha )
        local c;
        
        c := ValueGlobal( "UnderlyingCell" )( alpha );
        
        return IsWellDefined( c ) and ActiveUpperBound( c ) = ActiveLowerBound( c ) and ActiveLowerBound( c ) = i;
        
    end );
    
    Finalize( full );
    
    return full;
    
end );

##
InstallMethod( \.,
        [ IsChainComplexCategory, IsPosInt ],
   { C, string_as_int } -> ( UnderlyingCategory( C ).( NameRNam( string_as_int ) ) ) / C
);

##
InstallMethod( \.,
        [ IsCochainComplexCategory, IsPosInt ],
   { C, string_as_int } -> ( UnderlyingCategory( C ).( NameRNam( string_as_int ) ) ) / C
);
