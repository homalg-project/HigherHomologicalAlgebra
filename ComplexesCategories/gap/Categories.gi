


DeclareGlobalVariable( "CAP_INTERNAL_METHOD_NAME_LIST_FOR_COCHAIN_COMPLEXES_CATEGORY" );

InstallValue( CAP_INTERNAL_METHOD_NAME_LIST_FOR_COCHAIN_COMPLEXES_CATEGORY,
        [
          "AdditionForMorphisms",
          "AdditiveInverseForMorphisms",
          "CoastrictionToImage",
          "CoastrictionToImageWithGivenImageObject",
          #"Coequalizer",
          #"CoequalizerFunctorialWithGivenCoequalizers",
          "CokernelColift",
          "CokernelColiftWithGivenCokernelObject",
          "CokernelObject",
          "CokernelObjectFunctorialWithGivenCokernelObjects",
          "CokernelProjection",
          "CokernelProjectionWithGivenCokernelObject",
          "ColiftAlongEpimorphism",
          "ComponentOfMorphismFromDirectSum",
          "ComponentOfMorphismIntoDirectSum",
          "Coproduct",
          "CoproductFunctorialWithGivenCoproducts",
          "DirectProduct",
          "DirectProductFunctorialWithGivenDirectProducts",
          "DirectSum",
          "DirectSumCodiagonalDifference",
          "DirectSumDiagonalDifference",
          "DirectSumFunctorialWithGivenDirectSums",
          "DirectSumProjectionInPushout",
          #"EmbeddingOfEqualizer",
          #"EmbeddingOfEqualizerWithGivenEqualizer",
          #"Equalizer",
          #"EqualizerFunctorialWithGivenEqualizers",
          "FiberProduct",
          "FiberProductEmbeddingInDirectSum",
          "FiberProductFunctorialWithGivenFiberProducts",
          "IdentityMorphism",
          "ImageEmbedding",
          "ImageEmbeddingWithGivenImageObject",
          #"ImageObject",
          "InitialObject",
          "InitialObjectFunctorial",
          "InjectionOfCofactorOfCoproduct",
          "InjectionOfCofactorOfCoproductWithGivenCoproduct",
          "InjectionOfCofactorOfDirectSum",
          "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
          "InjectionOfCofactorOfPushout",
          "InjectionOfCofactorOfPushoutWithGivenPushout",
          "InverseForMorphisms",
          #"IsomorphismFromCoequalizerOfCoproductDiagramToPushout",
          "IsomorphismFromCokernelOfDiagonalDifferenceToPushout",
          "IsomorphismFromCoproductToDirectSum",
          "IsomorphismFromDirectProductToDirectSum",
          "IsomorphismFromDirectSumToCoproduct",
          "IsomorphismFromDirectSumToDirectProduct",
          "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
          #"IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
          "IsomorphismFromFiberProductToKernelOfDiagonalDifference",
          "IsomorphismFromInitialObjectToZeroObject",
          "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
          #"IsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
          "IsomorphismFromPushoutToCokernelOfDiagonalDifference",
          "IsomorphismFromTerminalObjectToZeroObject",
          "IsomorphismFromZeroObjectToInitialObject",
          "IsomorphismFromZeroObjectToTerminalObject",
          "IsEpimorphism",
          "IsIsomorphism",
          "IsMonomorphism",
          "IsZeroForMorphisms",
          "IsZeroForObjects",
          "KernelEmbedding",
          "KernelEmbeddingWithGivenKernelObject",
          "KernelLift",
          "KernelLiftWithGivenKernelObject",
          "KernelObject",
          "KernelObjectFunctorialWithGivenKernelObjects",
          "LiftAlongMonomorphism",
          ##"MorphismBetweenDirectSumsWithGivenDirectSums",
          ##"MorphismFromFiberProductToSink", # use their derivation
          ##"MorphismFromFiberProductToSinkWithGivenFiberProduct", # use their derivation
          "MorphismFromSourceToPushout",
          "MorphismFromSourceToPushoutWithGivenPushout",
          "MultiplyWithElementOfCommutativeRingForMorphisms",
          "PostCompose",
          "PreCompose",
          "ProjectionInFactorOfDirectProduct",
          "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
          "ProjectionInFactorOfDirectSum",
          "ProjectionInFactorOfDirectSumWithGivenDirectSum",
          "ProjectionInFactorOfFiberProduct",
          "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
          #"ProjectionOntoCoequalizer",
          #"ProjectionOntoCoequalizerWithGivenCoequalizer",
          "Pushout",
          "PushoutFunctorialWithGivenPushouts",
          "SubtractionForMorphisms",
          "TerminalObject",
          "TerminalObjectFunctorial",
          #"UniversalMorphismFromCoequalizer",
          #"UniversalMorphismFromCoequalizerWithGivenCoequalizer",
          "UniversalMorphismFromCoproduct",
          "UniversalMorphismFromCoproductWithGivenCoproduct",
          "UniversalMorphismFromDirectSum",
          "UniversalMorphismFromDirectSumWithGivenDirectSum",
          "UniversalMorphismFromImage",
          "UniversalMorphismFromImageWithGivenImageObject",
          "UniversalMorphismFromInitialObject",
          "UniversalMorphismFromInitialObjectWithGivenInitialObject",
          "UniversalMorphismFromPushout",
          "UniversalMorphismFromPushoutWithGivenPushout",
          "UniversalMorphismFromZeroObject",
          "UniversalMorphismFromZeroObjectWithGivenZeroObject",
          "UniversalMorphismIntoDirectProduct",
          "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
          "UniversalMorphismIntoDirectSum",
          "UniversalMorphismIntoDirectSumWithGivenDirectSum",
          #"UniversalMorphismIntoEqualizer",
          #"UniversalMorphismIntoEqualizerWithGivenEqualizer",
          "UniversalMorphismIntoFiberProduct",
          "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
          "UniversalMorphismIntoTerminalObject",
          "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
          "UniversalMorphismIntoZeroObject",
          "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
          "ZeroMorphism",
          "ZeroObject",
          "ZeroObjectFunctorial",
         ] );

##
InstallMethod( ComplexesCategoryByCochains,
        [ IsCapCategory and IsAbCategory ],
        
  function ( cat )
    local coch_cat, name, list_of_operations,
          object_constructor, object_datum, morphism_constructor, morphism_datum,
          create_func_bool, create_func_object, create_func_morphism,
          list_of_operations_to_install, skip, func, pos, commutative_ring,
          properties, preinstall, supports_empty_limits, prop;
    
    name := Concatenation( "Complexes category by cochains( ", Name( cat ), " )" );
    
    ##
    object_constructor := { coch_cat, datum } -> CreateCapCategoryObjectWithAttributes( coch_cat,
                                                            Objects, datum[1],
                                                            Differentials, datum[2],
                                                            LowerBound, datum[3],
                                                            UpperBound, datum[4] );

    
    ##
    object_datum := { coch_cat, o } -> [ Objects( o ), Differentials( o ), LowerBound( o ), UpperBound( o ) ];
    
    ##
    morphism_constructor := { coch_cat, S, datum, R }  -> CreateCapCategoryMorphismWithAttributes( coch_cat,
                                                            S, R,
                                                            Morphisms, datum[1],
                                                            LowerBound, datum[2],
                                                            UpperBound, datum[3] );
    
    ##
    morphism_datum := { coch_cat, m } -> [ Morphisms( m ), LowerBound( m ), UpperBound( m ) ];
    
    ## operations to be installed
    ##
    list_of_operations := ShallowCopy( CAP_INTERNAL_METHOD_NAME_LIST_FOR_COCHAIN_COMPLEXES_CATEGORY );
    
    list_of_operations_to_install := ShallowCopy( ListInstalledOperationsOfCategory( cat ) );
    
    list_of_operations_to_install := Intersection( list_of_operations_to_install, list_of_operations );
    
    skip := [ "MultiplyWithElementOfCommutativeRingForMorphisms",
              ];
    
    for func in skip do
        
        pos := Position( list_of_operations_to_install, func );
        
        if IsInt( pos ) then
            Remove( list_of_operations_to_install, pos );
        fi;
        
    od;
    
    if HasCommutativeRingOfLinearCategory( cat ) then
        commutative_ring := CommutativeRingOfLinearCategory( cat );
    else
        commutative_ring := fail;
    fi;
    
    properties := [ "IsAbCategory",
                    "IsLinearCategoryOverCommutativeRing",
                    "IsAdditiveCategory",
                    "IsPreAbelianCategory",
                    "IsAbelianCategory",
                    ];
    
    properties := Intersection( ListKnownCategoricalProperties( cat ), properties );
    
    create_func_bool :=
          function ( name, coch_cat )
            return
              """
              function( input_arguments... )
                local L;
                
                L := NTuple( number_of_arguments, input_arguments... );
                
                return ForAll( [ LowerBound( L[2] ) .. UpperBound( L[2] ) ], i -> operation_name( L[2][i] ) );
                
              end
              """;
          end;
    
    create_func_object :=
      function ( name, coch_cat )
        local info, functorial;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
        
        if not IsBound( info.functorial ) then
            Error( "the method record entry ", name, ".functorial is not bound\n" );
        fi;
        
        functorial := CAP_INTERNAL_METHOD_NAME_RECORD.(info.functorial);
        
        if name in [ "TerminalObject", "InitialObject", "ZeroObject" ] then
            
            return ## a constructor for universal objects: TerminalObject
              ReplacedStringViaRecord(
              """
              function ( input_arguments... )
                local underlying_cat, objects, morphisms;
                
                underlying_cat := UnderlyingCategory( cat );
                
                objects := AsZFunction( i -> operation_name( underlying_cat ) );
                
                morphisms := AsZFunction( i -> functorial( underlying_cat ) );
                
                return ObjectConstructor( cat, [ objects, morphisms, 0, 0 ] );
                
              end
              """,
            rec( functorial := info.functorial ) );
            
        elif name in [ "FiberProduct", "Pushout" ] then
            
            return ## a constructor for universal objects: FiberProduct
              ReplacedStringViaRecord(
              """
              function ( input_arguments... )
                local underlying_cat, i_arg, D, l_D, u_D, objs, diffs, l;
                
                underlying_cat := UnderlyingCategory( cat );
                
                i_arg := NTuple( number_of_arguments, input_arguments... );
                
                D := i_arg[2];
                
                l_D := Minimum( List( D, LowerBoundOfSourceAndRange ) );
                u_D := Maximum( List( D, UpperBoundOfSourceAndRange ) );
                
                objs := AsZFunction( i -> operation_name( underlying_cat, List( D, m -> MorphismAt( m, i ) ) ) );
                
                diffs :=
                  AsZFunction(
                    function ( i )
                      local l;
                      
                      #
                      #                     S^i
                      #            S[i] -------- > S[i+1]
                      #             |                |
                      #      eta[i] |                | eta[i+1]
                      #             v                v
                      #            R[i] -------- > R[i+1]
                      #                     R^i
                      
                      l := List( D, m -> [ MorphismAt( m, i ), DifferentialAt( Source( m ), i ), DifferentialAt( Range( m ), i ), MorphismAt( m, i+1 ) ] );
                      
                      l := TransposedMat( l );
                      
                      return _complexes_functorial( underlying_cat, objs[i], l[1], l[2], l[3], l[4], objs[i+1] );
                      
                    end );
                
                return ObjectConstructor( cat, [ objs, diffs, l_D, u_D ] );
                
              end
              """,
            rec( functorial := functorial.with_given_without_given_name_pair[2] ) );
            
        elif name in [ "DirectProduct", "Coproduct", "DirectSum" ] then
            
            return ## a constructor for universal objects: DirectSum
              ReplacedStringViaRecord(
              """
              function ( input_arguments... )
                local underlying_cat, i_arg, D, l_D, u_D, objs, diffs;
                
                underlying_cat := UnderlyingCategory( cat );
                
                i_arg := NTuple( number_of_arguments, input_arguments... );
                
                D := i_arg[2];
                
                if IsEmpty( D ) then
                  l_D := 0;
                  u_D := 0;
                else
                  l_D := Minimum( List( D, LowerBound ) );
                  u_D := Maximum( List( D, UpperBound ) );
                fi;
                
                objs := AsZFunction( i -> operation_name( underlying_cat, List( D, o -> ObjectAt( o, i ) ) ) );
                
                diffs := AsZFunction( i -> functorial( underlying_cat, objs[i], List( D, o -> DifferentialAt( o, i ) ), objs[i+1] ) );
                
                return ObjectConstructor( cat, [ objs, diffs, l_D, u_D ] );
                
              end
              """,
            rec( functorial := functorial.with_given_without_given_name_pair[2] ) );
            
        elif name in [ "KernelObject", "CokernelObject", "ImageObject", "CoimageObject" ] then
            
            return ## a constructor for universal objects: KernelObject
              ReplacedStringViaRecord(
              """
              function ( input_arguments... )
                local underlying_cat, i_arg, m, objs, diffs;
                
                underlying_cat := UnderlyingCategory( cat );
                
                i_arg := NTuple( number_of_arguments, input_arguments... );
                
                m := i_arg[2];
                
                objs := AsZFunction( i -> operation_name( underlying_cat, m[i] ) );
                
                diffs := AsZFunction( i -> _complexes_functorial( underlying_cat, objs[i], MorphismAt( m, i ), DifferentialAt( Source( m ), i ), DifferentialAt( Range( m ), i ), MorphismAt( m, i+1 ), objs[i+1] ) );
                
                return ObjectConstructor( cat, [ objs, diffs, LowerBoundOfSourceAndRange(m), UpperBoundOfSourceAndRange(m) ] );
                
              end
              """,
            rec( functorial := functorial.with_given_without_given_name_pair[2] ) );
            
        else
            
            Print( "WARNING: the category constructor CochainComplexCategory cannot deal with ", name, " yet\n" );
            return "ReturnNothing";
        fi;
        
    end;
    
    ## e.g., IdentityMorphism, PreCompose
    create_func_morphism :=
      function ( name, cat )
        local info;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
        
        return
          ReplacedStringViaRecord(
          """
          function ( input_arguments... )
            local underlying_cat, i_arg, l, u, mors;
            
            underlying_cat := UnderlyingCategory( cat );
            
            i_arg := NTuple( number_of_arguments, input_arguments... );
            
            l := Maximum( List( [ top_source, top_range ], LowerBound ) );
            u := Minimum( List( [ top_source, top_range ], UpperBound ) );
            
            mors := AsZFunction( i -> operation_name( underlying_cat, sequence_of_arguments... ) );
            
            return MorphismConstructor( cat, top_source, [ mors, l, u ], top_range );
            
        end
        """,
        rec( sequence_of_arguments :=
             List( [ 2 .. Length( info.filter_list ) ],
                   function( j )
                     local type;
                     
                     type := info.filter_list[j];
                     
                     if type = IsInt then
                         return Concatenation( "i_arg[", String( j ), "]" );
                     elif type = "object" then
                         return Concatenation( "ObjectAt( i_arg[", String( j ), "], i )" );
                     elif type = "morphism" then
                         return Concatenation( "MorphismAt( i_arg[", String( j ), "], i )" );
                     elif type = "list_of_objects" then
                         return Concatenation( "List( i_arg[", String( j ), "], o -> ObjectAt( o, i ) )" );
                     elif type = "list_of_morphisms" then
                         return Concatenation( "List( i_arg[", String( j ), "], m -> MorphismAt( m, i ) )" );
                     else
                         Error( "can only deal with IsInt, \"object\", \"morphism\", \"list_of_objects\", \"list_of_morphisms\"" );
                     fi;
                     
                  end ) ) );
    
    end;
    
    if IsBound( cat!.supports_empty_limits ) then
        supports_empty_limits := cat!.supports_empty_limits;
    else
        supports_empty_limits := false;
    fi;
    
    coch_cat := CategoryConstructor(
                rec( name := name,
                     category_filter := IsCochainComplexCategory,
                     category_object_filter := IsCochainComplex,
                     category_morphism_filter := IsCochainMorphism,
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
                     create_func_morphism := create_func_morphism ) );
    
    SetUnderlyingCategory( coch_cat, cat );
    
    ADD_FUNCTIONS_OF_LINEARITY_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_HOMOMORPHISM_STRUCTURE_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_EQUALITIES_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_WELL_DEFINEDNESS_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_RANDOM_METHODS_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    
    Finalize( coch_cat );
    
    return coch_cat;
    
end );

InstallGlobalFunction( ADD_FUNCTIONS_OF_LINEARITY_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    
    
    if HasIsLinearCategoryOverCommutativeRing( ch_cat ) then
        
        AddMultiplyWithElementOfCommutativeRingForMorphisms( ch_cat,
          function( ch_cat, r, phi )
            local cat;
            
            cat := UnderlyingCategory( ch_cat );
             
            return MorphismConstructor(
                        ch_cat,
                        Source( phi ),
                        [ ApplyMap( Morphisms( phi ), m -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, m ) ), LowerBound( phi ), UpperBound( phi ) ],
                        Range( phi ) );
        
        end );
    
    fi;
    
end );

InstallGlobalFunction( ADD_FUNCTIONS_OF_EQUALITIES_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    
    AddIsEqualForObjects( ch_cat,
      function ( ch_cat, B, C )
        local cat, l_BC, u_BC;
        
        cat := UnderlyingCategory( ch_cat );
        
        if IsIdenticalObj( B, C ) then
          return true;
        fi;
        
        l_BC := Minimum( LowerBound( B ), LowerBound( C ) );
        u_BC := Maximum( UpperBound( B ), UpperBound( C ) );
        
        return ForAll( [ l_BC .. u_BC ], i -> IsEqualForObjects( cat, B[i], C[i] ) ) and
                  ForAll( [ l_BC .. u_BC ], i -> IsEqualForMorphisms( cat, B^i, C^i ) );
        
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
                      ForAll( [ LowerBoundOfSourceAndRange( phi ) .. UpperBoundOfSourceAndRange( phi ) ], i -> IsCongruentForMorphisms( PreCompose( B^i, phi[ i + 1 ] ), PreCompose( phi[ i ], C^i ) ) );
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
    object_datum := { ch_cat, o } -> [ Objects( o ), Differentials( o ), LowerBound( o ), UpperBound( o ) ];
    
    ##
    morphism_constructor := { ch_cat, S, datum, R }  -> CreateCapCategoryMorphismWithAttributes( ch_cat,
                                                            S, R,
                                                            Morphisms, datum[1],
                                                            LowerBound, datum[2],
                                                            UpperBound, datum[3] );
    
    ##
    morphism_datum := { ch_cat, m } -> [ Morphisms( m ), LowerBound( m ), UpperBound( m ) ];
    
    ## building the categorical tower
    
    coch_cat := ComplexesCategoryByCochains( cat );
    
    ## from the raw object data to the object in the highest stage of the tower
    modeling_tower_object_constructor :=
      function( ch_cat, datum )
        local coch_cat;
        
        coch_cat := ModelingCategory( ch_cat );
        
        return ObjectConstructor( coch_cat, [ Reflection( datum[1] ), Reflection( datum[2] ), -datum[4], -datum[3] ] );
        
    end;
    
    ## from the object in the highest stage of the tower to the raw object datum
    modeling_tower_object_datum :=
      function( ch_cat, obj )
        local coch_cat, datum;
        
        coch_cat := ModelingCategory( ch_cat );
        
        datum := ObjectDatum( coch_cat, obj );
        
        return [ Reflection( datum[1] ), Reflection( datum[2] ), -datum[4], -datum[3] ];
        
    end;
    
    ## from the raw morphism datum to the morphism in the highest stage of the tower
    modeling_tower_morphism_constructor :=
      function( ch_cat, source, datum, range )
        local coch_cat;
        
        coch_cat := ModelingCategory( ch_cat );
        
        return MorphismConstructor( coch_cat,
                       source,
                       [ Reflection( datum[1] ), -datum[3], -datum[2] ],
                       range );
        
    end;
    
    ## from the morphism in the highest stage of the tower to the raw morphism datum
    modeling_tower_morphism_datum :=
      function( ch_cat, mor )
        local coch_cat, datum;
        
        coch_cat := ModelingCategory( ch_cat );
        
        datum := MorphismDatum( coch_cat, mor );
        
        return [ Reflection( datum[1] ), -datum[3], -datum[2] ];
        
    end;
    
    ##
    ch_cat :=
      WrapperCategory( coch_cat,
              rec( name := Concatenation( "Complexes category by chains( ", Name( cat ), " )" ),
                   category_filter := IsChainComplexCategory,
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

####################################
#
# compatibility methods for "multiple morphisms"-case below:
#
####################################

##
BindGlobal( "_complexes_FiberProductFunctorialWithGivenFiberProducts",
  function ( cat, source, Lsource, LmorS, LmorT, Ltarget, target )
    
    #% CAP_JIT_RESOLVE_FUNCTION
    return FiberProductFunctorialWithGivenFiberProducts( cat, source, Lsource, LmorS, Ltarget, target );
    
end );

##
BindGlobal( "_complexes_PushoutFunctorialWithGivenPushouts",
  function ( cat, source, Lsource, LmorS, LmorT, Ltarget, target )
    
    #% CAP_JIT_RESOLVE_FUNCTION
    return PushoutFunctorialWithGivenPushouts( cat, source, Lsource, LmorT, Ltarget, target );
    
end );

##
BindGlobal( "_complexes_KernelObjectFunctorialWithGivenKernelObjects",
  function ( cat, s, alpha, mu, nu, alpha_prime, r )
    
    return KernelObjectFunctorialWithGivenKernelObjects( cat, s, alpha, mu, alpha_prime, r );
    
end );

##
BindGlobal( "_complexes_CokernelObjectFunctorialWithGivenCokernelObjects",
  function ( cat, s, alpha, mu, nu, alpha_prime, r )
    
    return CokernelObjectFunctorialWithGivenCokernelObjects( cat, s, alpha, nu, alpha_prime, r );
    
end );

##
BindGlobal( "_complexes_ImageObjectFunctorialWithGivenImageObjects",
  function ( cat, s, alpha, mu, nu, alpha_prime, r )
    
    return ImageObjectFunctorialWithGivenImageObjects( cat, s, alpha, nu, alpha_prime, r ); 
    
end );

##
BindGlobal( "_complexes_CoimageObjectFunctorialWithGivenCoimageObjects",
  function ( cat, s, alpha, mu, nu, alpha_prime, r )
    
    return CoimageObjectFunctorialWithGivenCoimageObjects( cat, s, alpha, mu, alpha_prime, r );
    
end );

