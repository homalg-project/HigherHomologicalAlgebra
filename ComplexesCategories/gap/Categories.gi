# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#


BindGlobal( "INTEGERS_CAT",
  
  function ( )
    local category;
     
    if IsPackageMarkedForLoading( "Locales", ">= 2023.05-05" ) then
        
        return ValueGlobal( "TotalOrderAsCategory" )( "IsInt", {a,b} -> a >= b );
        
    else
        
        category := CreateCapCategory( "TotalOrderAsCategory( \"IsInt\" )" );
        category!.category_as_first_argument := true;
        
        AddObjectConstructor( category, { cat, i } -> CreateCapCategoryObjectWithAttributes( cat, ObjectDatum, i ) );
        AddMorphismConstructor( category, { cat, s, datum, r } -> CreateCapCategoryMorphismWithAttributes( cat, s, r ) );
        
        AddPreCompose( category, { cat, u, v } -> MorphismConstructor( cat, Source( u ), true, Range( v ) ) );
        AddIdentityMorphism( category, { cat, u } -> MorphismConstructor( cat, Source( u ), true, Range( u ) ) );
        
        AddIsWellDefinedForMorphisms( category, { cat, u } -> ObjectDatum( Source( u ) ) >= ObjectDatum( Range( u ) ) );
        
        AddIsEqualForObjects( category, { cat, i, j } -> IsIdenticalObj( ObjectDatum( i ), ObjectDatum( j ) ) );
        AddIsEqualForMorphisms( category, { cat, u, v } -> IsEqualForObjects( Source( u ), Source( u ) ) and IsEqualForObjects( Range( u ), Range( u ) ) );
        
        Finalize( category );
        
        return category;
        
    fi;
    
end ( ) );

BindGlobal( "INTEGERS_CAT_OBJS",
  
  AsZFunction( i -> ObjectConstructor( INTEGERS_CAT, i ) )
);

BindGlobal( "INTEGERS_CAT_MORS",
  
  AsZFunction( i -> MorphismConstructor( INTEGERS_CAT, INTEGERS_CAT_OBJS[i+1], true, INTEGERS_CAT_OBJS[i] ) )
);

##
InstallGlobalFunction( COMPLEXES_CATEGORY_BY_COCHAINS_AS_TOWER,
  
  function ( cat )
    local presh_cat, category_filter, category_object_filter, category_morphism_filter, commutative_ring, properties, object_constructor,
          object_datum, morphism_constructor, morphism_datum, union_of_supports, list_of_operations_to_install, create_func_bool,
          create_func_object, create_func_morphism, supports_empty_limits, name, modeling_cat;
    
    presh_cat := PreSheaves( INTEGERS_CAT, cat : overhead := false );
    
    name := Concatenation( "Bounded ", Name( presh_cat ) );
    
    category_filter := IsCapCategory;
    category_object_filter := IsCapCategoryObject;
    category_morphism_filter := IsCapCategoryMorphism;
    
    if HasCommutativeRingOfLinearCategory( presh_cat ) then
        commutative_ring := CommutativeRingOfLinearCategory( presh_cat );
    else
        commutative_ring := fail;
    fi;
    
    properties := ListKnownCategoricalProperties( presh_cat );
    
    # e.g., datum = Pair( presheaf, Pair( lower_bound, upper_bound ) )
    object_constructor :=
      { coch_cat, datum } -> CreateCapCategoryObjectWithAttributes( coch_cat, ObjectDatum, datum );
    
    object_datum := { coch_cat, o } -> ObjectDatum( o );
    
    # e.g., datum = presheaf_morphism
    morphism_constructor :=
      { coch_cat, S, datum, R } -> CreateCapCategoryMorphismWithAttributes( coch_cat, S, R, MorphismDatum, datum );
    
    morphism_datum := { coch_cat, m } -> MorphismDatum( m );
    
    union_of_supports :=
      function ( supports )
        
        if supports = [ ] then
            return Pair( 0, 0 );
        else
            return Pair( Minimum( List( supports, s -> s[1] ) ), Maximum( List( supports, s -> s[2] ) ) );
        fi;
        
    end;
    
    list_of_operations_to_install := Filtered( ListPrimitivelyInstalledOperationsOfCategory( presh_cat ), name -> CAP_INTERNAL_METHOD_NAME_RECORD.(name).return_type <> "bool" );
    
    create_func_bool := "default"; # this function will never be used
    
    create_func_object :=
      function ( name, coch_cat )
          local info;
          
          info := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
          
          return
            ReplacedStringViaRecord(
            """
            function( input_arguments... )
              local presh_cat, i_arg;
              
              presh_cat := UnderlyingCategory( cat );
              
              i_arg := NTuple( number_of_arguments, input_arguments... );
              
              return ObjectConstructor( cat, Pair( operation_name( sequence_of_arguments... ), bounds ) );
              
            end
            """,
            rec( sequence_of_arguments :=
              List( [ 1 .. Length( info.filter_list ) ],
                function ( j )
                  local type;
                  
                  type := info.filter_list[j];
                  
                  if j = 1 and type = "category" then
                      return "presh_cat";
                  elif type = "object" then
                      return Concatenation( "ObjectDatum( i_arg[", String( j ), "] )[1]" );
                  elif type = "morphism" then
                      return Concatenation( "MorphismDatum( i_arg[", String( j ), "] )" );
                  elif type = "list_of_objects" then
                      return Concatenation( "List( i_arg[", String( j ), "],  o -> ObjectDatum( cat, o )[1] )" );
                  elif type = "list_of_morphisms" then
                      return Concatenation( "List( i_arg[", String( j ), "],  m -> MorphismDatum( cat, m ) )" );
                  else
                      Error( "can only deal with 'object', 'morphism', 'list_of_objects', 'list_of_morphisms'" );
                  fi;
                  
            end ),
            bounds :=
               (function()
                  local types;
                  
                  types := info.filter_list;
                  
                  if types = [ "category" ] then # e.g., ZeroObject, InitialObject, TerminalObject, ...
                      return "Pair( 0, 0 )";
                  elif types[2] = "object" then # e.g., (Co)Equalizer, ...
                      return "ObjectDatum( cat, i_arg[2] )[2]";
                  elif types[2] = "morphism" then # e.g., (Co)KernelObject, (Co)ImageObject, ...
                      return Concatenation( String( union_of_supports ), "( List( [ Source( i_arg[2] ), Range( i_arg[2] ) ], c -> ObjectDatum( cat, c )[2] ) )" );
                  elif types[2] = "list_of_objects" then # e.g., Coproduct, DirectProduct, DirectSum, ...
                      return Concatenation( String( union_of_supports ), "( List( i_arg[2], c -> ObjectDatum( cat, c )[2] ) )" );
                  elif types[2] = "list_of_morphisms" then # Pushout, FiberProduct, ...
                      return Concatenation( String( union_of_supports ), "( List( Concatenation( List( i_arg[2], m -> Source( m ) ), List( i_arg[2], m -> Range( m ) ) ), c -> ObjectDatum( cat, c )[2] ) )" );
                  else
                      Error( "can only deal with 'object', 'morphism', 'list_of_objects', 'list_of_morphisms'" );
                  fi;
                  
                end)( ) ) );
                
      end;
    
    create_func_morphism :=
      function ( name, cat )
        local info;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
        
        return
          ReplacedStringViaRecord(
          """
          function ( input_arguments... )
            local presh_cat, i_arg;
            
            presh_cat := UnderlyingCategory( cat );
            
            i_arg := NTuple( number_of_arguments, input_arguments... );
            
            return MorphismConstructor( cat, top_source, operation_name( sequence_of_arguments... ), top_range );
            
        end
        """,
        rec( sequence_of_arguments :=
             List( [ 1 .. Length( info.filter_list ) ],
                   function( j )
                     local type;
                     
                     type := info.filter_list[j];
                     
                     if j = 1 and type = "category" then
                        return "presh_cat";
                     elif type in [ "integer", "element_of_commutative_ring_of_linear_structure" ] then
                        return Concatenation( "i_arg[", String( j ), "]" );
                     elif type = "object" then
                        return Concatenation( "ObjectDatum( cat, i_arg[", String( j ), "] )[1]" );
                     elif type = "morphism" then
                        return Concatenation( "MorphismDatum( i_arg[", String( j ), "] )" );
                     elif type = "list_of_objects" then
                        return Concatenation( "List( i_arg[", String( j ), "], o -> ObjectDatum( cat, o )[1] )" );
                     elif type = "list_of_morphisms" then
                        return Concatenation( "List( i_arg[", String( j ), "], m -> MorphismDatum( cat, m ) )" );
                     elif type = "pair_of_morphisms" then
                        return Concatenation( "Pair( ", "MorphismDatum( cat, i_arg[", String( j ), "][1] )", ", MorphismDatum( cat, i_arg[", String( j ), "][2] )", " )" );
                     else
                        Error( "can only deal with 'integer', 'object', 'morphism', 'list_of_objects', 'list_of_morphisms', 'pair_of_morphisms'" );
                     fi;
                     
                  end ) ) );
    
    end;
    
    supports_empty_limits := true;
    
    modeling_cat := CategoryConstructor(
                      rec( name := name,
                           category_filter := category_filter,
                           category_object_filter := category_object_filter,
                           category_morphism_filter := category_morphism_filter,
                           commutative_ring_of_linear_category := commutative_ring,
                           properties := properties,
                           object_constructor := object_constructor,
                           object_datum := object_datum,
                           morphism_constructor := morphism_constructor,
                           morphism_datum := morphism_datum,
                           underlying_category_getter_string := "UnderlyingCategory",
                           list_of_operations_to_install := list_of_operations_to_install,
                           supports_empty_limits := supports_empty_limits,
                           create_func_bool := create_func_bool,
                           create_func_object := create_func_object,
                           create_func_morphism := create_func_morphism ) : overhead := false );
    
    SetUnderlyingCategory( modeling_cat, presh_cat );
    
    modeling_cat!.is_computable := false;
    
    Finalize( modeling_cat );
    
    return modeling_cat;
    
end );

##
##
InstallMethod( ComplexesCategoryByCochains,
        "for a CAP category",
        [ IsCapCategory ],
        
  function ( cat )
    local modeling_cat, object_constructor, object_datum, morphism_constructor, morphism_datum, modeling_tower_object_constructor, modeling_tower_object_datum,
      modeling_tower_morphism_constructor, modeling_tower_morphism_datum, coch_cat, category_filter, category_object_filter, category_morphism_filter;
    
    ## building the categorical tower
    
    modeling_cat := COMPLEXES_CATEGORY_BY_COCHAINS_AS_TOWER( cat );
    
    ##
    object_constructor := { coch_cat, datum } -> CreateCapCategoryObjectWithAttributes( coch_cat,
                                                            Objects, datum[1],
                                                            Differentials, datum[2],
                                                            LowerBound, datum[3],
                                                            UpperBound, datum[4] );

    
    ##
    object_datum := { coch_cat, o } -> NTuple( 4, Objects( o ), Differentials( o ), LowerBound( o ), UpperBound( o ) );
    
    ##
    morphism_constructor := { coch_cat, S, datum, R }  -> CreateCapCategoryMorphismWithAttributes( coch_cat,
                                                            S, R,
                                                            Morphisms, datum );
    
    ##
    morphism_datum := { coch_cat, m } -> Morphisms( m );
    
    ## from the raw object data to the object in the highest stage of the tower
    modeling_tower_object_constructor :=
      function( coch_cat, datum )
        local modeling_cat, presh_cat, presheaf_on_objects, presheaf_on_morphisms, presheaf;
        
        modeling_cat := ModelingCategory( coch_cat );
        presh_cat := UnderlyingCategory( modeling_cat );
        
        presheaf_on_objects := i -> datum[1][ObjectDatum( i )];
        presheaf_on_morphisms := {s, i, r} -> datum[2][ObjectDatum( Range( i ) )];
        
        presheaf := ObjectConstructor( presh_cat, Pair( presheaf_on_objects, presheaf_on_morphisms ) );
        
        return ObjectConstructor( modeling_cat, Pair( presheaf, Pair( datum[3], datum[4] ) ) );
        
    end;
    
    ## from the object in the highest stage of the tower to the raw object datum
    modeling_tower_object_datum :=
      function( coch_cat, obj )
        local presheaf, objs, mors;
        
        presheaf := ObjectDatum( obj )[1];
        
        objs := AsZFunction( i -> PairOfFunctionsOfPreSheaf( presheaf )[1]( INTEGERS_CAT_OBJS[i] ) );
        mors := AsZFunction( i -> PairOfFunctionsOfPreSheaf( presheaf )[2]( objs[i], INTEGERS_CAT_MORS[i], objs[i+1] ) );
        
        return NTuple( 4, objs, mors, ObjectDatum( obj )[2][1], ObjectDatum( obj )[2][2] );
        
    end;
    
    ## from the raw morphism datum to the morphism in the highest stage of the tower
    modeling_tower_morphism_constructor :=
      function( coch_cat, source, datum, range )
        local modeling_cat, presh_cat, nat_trans_on_objs, presheaf_morphism;
        
        modeling_cat := ModelingCategory( coch_cat );
        presh_cat := UnderlyingCategory( modeling_cat );
        
        nat_trans_on_objs := {s, i, r} -> datum[ObjectDatum( i )];
        presheaf_morphism := MorphismConstructor( presh_cat, ObjectDatum( source )[1], nat_trans_on_objs, ObjectDatum( range )[1] );
        
        return MorphismConstructor( modeling_cat, source, presheaf_morphism, range );
        
    end;
    
    ## from the morphism in the highest stage of the tower to the raw morphism datum
    modeling_tower_morphism_datum :=
      function( ch_cat, mor )
        
        return AsZFunction(
                  function ( i )
                    local presheaf_mor;
                    
                    i := INTEGERS_CAT_OBJS[i];
                    presheaf_mor := MorphismDatum( mor );
                    
                    return FunctionOfPreSheafMorphism( presheaf_mor )(
                                PairOfFunctionsOfPreSheaf( Source( presheaf_mor ) )[1]( i ),
                                i,
                                PairOfFunctionsOfPreSheaf( Range ( presheaf_mor ) )[1]( i ) );
                    
                  end );
        
    end;
    
    ##
    coch_cat :=
      ReinterpretationOfCategory( modeling_cat,
              rec( name := Concatenation( "Complexes category by cochains( ", Name( cat ), " )" ),
                   category_filter := IsComplexesCategoryByCochains,
                   category_object_filter := IsCochainComplex,
                   category_morphism_filter := IsCochainMorphism,
                   object_constructor := object_constructor,
                   object_datum := object_datum,
                   morphism_datum := morphism_datum,
                   morphism_constructor := morphism_constructor,
                   modeling_tower_object_constructor := modeling_tower_object_constructor,
                   modeling_tower_object_datum := modeling_tower_object_datum,
                   modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum := modeling_tower_morphism_datum,
                   only_primitive_operations := true ) : FinalizeCategory := false );
    
    SetUnderlyingCategory( coch_cat, cat );
    
    ADD_FUNCTIONS_OF_EQUALITIES_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_LINEARITY_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_HOMOMORPHISM_STRUCTURE_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_WELL_DEFINEDNESS_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_RANDOM_METHODS_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    
    Finalize( coch_cat );
    
    return coch_cat;
    
end );



##
InstallGlobalFunction( ADD_FUNCTIONS_OF_LINEARITY_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    
    
    if HasIsLinearCategoryOverCommutativeRing( ch_cat ) then
        
        AddMultiplyWithElementOfCommutativeRingForMorphisms( ch_cat,
          function( ch_cat, r, phi )
            local cat;
            
            cat := UnderlyingCategory( ch_cat );
             
            return CreateComplexMorphism(
                        ch_cat,
                        Source( phi ),
                        ApplyMap( Morphisms( phi ), m -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, m ) ),
                        Range( phi ) );
        
        end );
    
    fi;
    
end );

InstallGlobalFunction( ADD_FUNCTIONS_OF_EQUALITIES_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    
    AddIsEqualForCacheForObjects( ch_cat,
      function ( ch_cat, B, C )
        
        return IsIdenticalObj( B, C );
        
    end );
    
    AddIsEqualForObjects( ch_cat,
      function ( ch_cat, B, C )
        local cat, lC, uC;
        
        cat := UnderlyingCategory( ch_cat );
        
        if IsIdenticalObj( B, C ) then
          return true;
        fi;
        
        lC := Minimum( LowerBound( B ), LowerBound( C ) );
        uC := Maximum( UpperBound( B ), UpperBound( C ) );
        
        return ForAll( [ lC .. uC ], i -> IsEqualForObjects( cat, B[i], C[i] ) ) and
                  ForAll( [ lC .. uC ], i -> IsEqualForMorphisms( cat, B^i, C^i ) );
        
    end );
    
    AddIsEqualForCacheForMorphisms( ch_cat,
      function ( ch_cat, phi, psi )
        
        return IsIdenticalObj( phi, psi );
        
    end );
    
    AddIsEqualForMorphisms( ch_cat,
      function ( ch_cat, phi, psi )
        local cat, l, u;
        
        cat := UnderlyingCategory( ch_cat );
        
        if IsIdenticalObj( phi, psi ) then
          return true;
        fi;
        
        l := Minimum( LowerBound( phi ), LowerBound( psi ) );
        u := Maximum( UpperBound( phi ), UpperBound( psi ) );
        
        return IsEqualForObjects( ch_cat, Source( phi ), Source( psi ) ) and
                  IsEqualForObjects( ch_cat, Range( phi ), Range( phi ) ) and
                      ForAll( [ l .. u ], i -> IsEqualForMorphisms( cat, phi[i], psi[i] ) );
        
    end );
    
    AddIsCongruentForMorphisms( ch_cat,
      function ( ch_cat, phi, psi )
        local cat, l, u;
        
        cat := UnderlyingCategory( ch_cat );
        
        if IsIdenticalObj( phi, psi ) then
          return true;
        fi;
        
        l := Minimum( LowerBound( phi ), LowerBound( psi ) );
        u := Maximum( UpperBound( phi ), UpperBound( psi ) );
        
        return IsEqualForObjects( ch_cat, Source( phi ), Source( psi ) ) and
                  IsEqualForObjects( ch_cat, Range( phi ), Range( phi ) ) and
                      ForAll( [ l .. u ], i -> IsCongruentForMorphisms( cat, phi[i], psi[i] ) );
        
    end );

end );
##
InstallGlobalFunction( ADD_FUNCTIONS_OF_WELL_DEFINEDNESS_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    
    AddIsWellDefinedForObjects( ch_cat,
      function( ch_cat, C )
        
        return ForAll( [ LowerBound( C ) .. UpperBound( C ) ], i -> IsWellDefined( C[i] ) and
                  IsWellDefined( C^i ) and
                    IsZeroForMorphisms( PreCompose( C^i, C^(i+1) ) ) );
        
    end );
    
    AddIsWellDefinedForMorphisms( ch_cat,
      function( ch_cat, phi )
        local B, C;
        
        B := Source( phi );
        C := Range( phi );
        
        return IsWellDefinedForObjects( ch_cat, B ) and
                  IsWellDefinedForObjects( ch_cat, C ) and
                      ForAll( [ LowerBound( phi ) .. UpperBound( phi ) ], i -> IsCongruentForMorphisms( PreCompose( B^i, phi[ i + 1 ] ), PreCompose( phi[ i ], C^i ) ) );
    end );
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_OF_RANDOM_METHODS_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    local range_cat;
    
    if CanCompute( UnderlyingCategory( ch_cat ), "RandomMorphismWithFixedSourceByList" ) then
      
      ##
      AddRandomObjectByList( ch_cat,
        
        function ( ch_cat, L )
          local cat, diffs, i, pi;
          
          if Length( L ) <> 3 or not ForAll( L{[1,2]}, IsInt ) or not IsList( L[3] ) then
            Error("the input should be a list consisting of two integers and a list!\n");
          fi;
          
          cat := UnderlyingCategory( ch_cat );
          
          if L[1] > L[2] then
            
            return ZeroObject( ch_cat );
            
          else
            
            diffs := [ RandomMorphismWithFixedSourceByList( cat, ZeroObject( cat ) , L[3] ) ];
            
            for i in [ 2 .. L[2] - L[1]  + 1 ] do
              
              pi := ValueGlobal( "WeakCokernelProjection" )( cat, diffs[i-1] );
              
              Add( diffs, PreCompose( cat, pi, RandomMorphismWithFixedSourceByList( cat, Range( pi ), L[3] ) ) );
              
            od;
            
            return CreateComplex( ch_cat, diffs, L[1] );
            
          fi;
          
      end );
    
    fi;
    
    if CanCompute( UnderlyingCategory( ch_cat ), "RandomMorphismWithFixedSourceByInteger" ) then
      
      ##
      AddRandomObjectByInteger( ch_cat,
        
        function ( ch_cat, n )
          local cat, diffs, i, pi;
          
          if IsNegInt( n ) then
            Error("the integer passed to 'RandomObjectByInteger' in ", Name( ch_cat ), " should be a non-negative integer!\n" );
          fi;
          
          cat := UnderlyingCategory( ch_cat );
          
          if n = 0 then
            
            return ZeroObject( ch_cat );
            
          else
            
            diffs := [ RandomMorphismByInteger( cat, 1 + Log2Int( n ) ) ];
            
            for i in [ 2 .. n ] do
              
              pi :=  ValueGlobal( "WeakCokernelProjection" )( cat, diffs[i-1] );
              
              Add( diffs, PreCompose( cat, pi, RandomMorphismWithFixedSourceByInteger( cat, Range( pi ), 1 + Log2Int( n ) ) ) );
              
            od;
            
            return CreateComplex( ch_cat, diffs, -Int( n/2 ) );
            
          fi;
          
      end );
    
    fi;
    
    if HasRangeCategoryOfHomomorphismStructure( ch_cat ) then
      
      range_cat := RangeCategoryOfHomomorphismStructure( ch_cat );
      
      if CanCompute( range_cat, "RandomMorphismWithFixedSourceAndRangeByList" ) then
        
        ##
        AddRandomMorphismWithFixedSourceAndRangeByList( ch_cat,
          
          function ( ch_cat, S, R, L )
            local range_cat, hom_SR, distinguished_object, ell;
            
            range_cat := RangeCategoryOfHomomorphismStructure( ch_cat );
            
            hom_SR := HomomorphismStructureOnObjects( ch_cat, S, R );
            
            distinguished_object := DistinguishedObjectOfHomomorphismStructure( ch_cat );
            
            ell := RandomMorphismWithFixedSourceAndRangeByList( range_cat, distinguished_object, hom_SR, L );
            
            return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( ch_cat, S, R, ell );
            
        end );
        
      fi;
      
      if CanCompute( range_cat, "RandomMorphismWithFixedSourceAndRangeByInteger" ) then
      
        ##
        AddRandomMorphismWithFixedSourceAndRangeByInteger( ch_cat,
          
          function ( ch_cat, S, R, n )
            local range_cat, hom_SR, distinguished_object, ell;
            
            range_cat := RangeCategoryOfHomomorphismStructure( ch_cat );
            
            hom_SR := HomomorphismStructureOnObjects( ch_cat, S, R );
            
            distinguished_object := DistinguishedObjectOfHomomorphismStructure( ch_cat );
            
            ell := RandomMorphismWithFixedSourceAndRangeByInteger( range_cat, distinguished_object, hom_SR, n );
            
            return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( ch_cat, S, R, ell );
            
        end );
        
      fi;
      
    fi;
    
end );

##
InstallMethod( ComplexesCategoryByChains,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( cat )
    local object_constructor, object_datum, morphism_constructor, morphism_datum, coch_cat, modeling_tower_object_constructor, modeling_tower_object_datum, modeling_tower_morphism_constructor, modeling_tower_morphism_datum, ch_cat, category_filter, category_object_filter, category_morphism_filter, only_primitive_operations;
    
    ##
    object_constructor := { ch_cat, datum } -> CreateCapCategoryObjectWithAttributes( ch_cat,
                                                            Objects, datum[1],
                                                            Differentials, datum[2],
                                                            LowerBound, datum[3],
                                                            UpperBound, datum[4] );

    
    ##
    object_datum := { ch_cat, o } -> NTuple( 4, Objects( o ), Differentials( o ), LowerBound( o ), UpperBound( o ) );
    
    ##
    morphism_constructor := { ch_cat, S, datum, R }  -> CreateCapCategoryMorphismWithAttributes( ch_cat,
                                                            S, R,
                                                            Morphisms, datum );
    
    ##
    morphism_datum := { ch_cat, m } -> Morphisms( m );
    
    ## building the categorical tower
    
    coch_cat := ComplexesCategoryByCochains( cat );
    
    ## from the raw object data to the object in the highest stage of the tower
    modeling_tower_object_constructor :=
      function( ch_cat, datum )
        local coch_cat;
        
        coch_cat := ModelingCategory( ch_cat );
        
        return CreateComplex( coch_cat, Reflection( datum[1] ), Reflection( datum[2] ), -datum[4], -datum[3] );
        
    end;
    
    ## from the object in the highest stage of the tower to the raw object datum
    modeling_tower_object_datum :=
      function( ch_cat, obj )
        
        return [ Reflection( Objects( obj ) ), Reflection( Differentials( obj ) ), -UpperBound( obj ), -LowerBound( obj ) ];
        
    end;
    
    ## from the raw morphism datum to the morphism in the highest stage of the tower
    modeling_tower_morphism_constructor :=
      function( ch_cat, source, datum, range )
        local coch_cat;
        
        coch_cat := ModelingCategory( ch_cat );
        
        return CreateComplexMorphism( coch_cat, source, Reflection( datum ), range );
        
    end;
    
    ## from the morphism in the highest stage of the tower to the raw morphism datum
    modeling_tower_morphism_datum :=
      function( ch_cat, mor )
        
        return Reflection( Morphisms( mor ) );
        
    end;
    
    ##
    ch_cat :=
      ReinterpretationOfCategory( coch_cat,
              rec( name := Concatenation( "Complexes category by chains( ", Name( cat ), " )" ),
                   category_filter := IsComplexesCategoryByChains,
                   category_object_filter := IsChainComplex,
                   category_morphism_filter := IsChainMorphism,
                   object_constructor := object_constructor,
                   object_datum := object_datum,
                   morphism_datum := morphism_datum,
                   morphism_constructor := morphism_constructor,
                   modeling_tower_object_constructor := modeling_tower_object_constructor,
                   modeling_tower_object_datum := modeling_tower_object_datum,
                   modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum := modeling_tower_morphism_datum,
                   only_primitive_operations := true ) : FinalizeCategory := false );
    
    SetUnderlyingCategory( ch_cat, cat );
     
    ## random methods by lists
    ##
    if CanCompute( coch_cat, "RandomObjectByList" ) then
    
      AddRandomObjectByList( ch_cat,
        
        { ch_cat, L } -> ObjectConstructor( ch_cat, modeling_tower_object_datum( ch_cat, RandomObjectByList( ModelingCategory( ch_cat ), [ -L[2], -L[1], L[3] ] ) ) )
      );
    
    fi;
    
    if CanCompute( coch_cat, "RandomMorphismWithFixedSourceAndRangeByList" ) then
      
      AddRandomMorphismWithFixedSourceAndRangeByList( ch_cat,
        { ch_cat, S, R, L } -> MorphismConstructor(
                                  ch_cat,
                                  S,
                                  modeling_tower_morphism_datum(
                                      ch_cat,
                                      RandomMorphismWithFixedSourceAndRangeByList(
                                          ModelingCategory( ch_cat ),
                                          modeling_tower_object_constructor( ch_cat, ObjectDatum( S ) ),
                                          modeling_tower_object_constructor( ch_cat, ObjectDatum( R ) ),
                                          L ) ),
                                  R ) );
    fi;
    ##
    ##########################
    
    Finalize( ch_cat );
    
    return ch_cat;
    
end );

