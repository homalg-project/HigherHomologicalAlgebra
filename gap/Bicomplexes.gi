#
# Bicomplexes: Bicomplexes for Abelian categories
#
# Implementations
#

##
InstallMethod( UnderlyingComplexOfComplexes,
        "for a list",
        [ IsList ],
        
  L -> List( L, UnderlyingComplexOfComplexes ) );

##
InstallMethod( UnderlyingComplexOfComplexes,
        "fallback method for an arbitrary GAP object",
        [ IsObject ],
        
  IdFunc );

####################################
#
# representations:
#
####################################

DeclareRepresentation( "IsCapCategoryBicomplexCellRep",
        IsCapCategoryBicomplexCell,
        [ ] );

DeclareRepresentation( "IsCapCategoryBicomplexObjectRep",
        IsCapCategoryBicomplexObject,
        [ ] );

DeclareRepresentation( "IsCapCategoryHomologicalBicomplexObjectRep",
        IsCapCategoryHomologicalBicomplex and IsCapCategoryBicomplexObjectRep,
        [ ] );

DeclareRepresentation( "IsCapCategoryCohomologicalBicomplexObjectRep",
        IsCapCategoryCohomologicalBicomplex and IsCapCategoryBicomplexObjectRep,
        [ ] );

DeclareRepresentation( "IsCapCategoryBicomplexMorphismRep",
        IsCapCategoryBicomplexMorphism,
        [ ] );

####################################
#
# families and types:
#
####################################

# new families:
BindGlobal( "TheFamilyOfBicomplexObjects",
        NewFamily( "TheFamilyOfBicomplexObjects" ) );

BindGlobal( "TheFamilyOfHomologicalBicomplexObjects",
        NewFamily( "TheFamilyOfHomologicalBicomplexObjects" ) );

BindGlobal( "TheFamilyOfCohomologicalBicomplexObjects",
        NewFamily( "TheFamilyOfCohomologicalBicomplexObjects" ) );


BindGlobal( "TheFamilyOfBicomplexMorphisms",
        NewFamily( "TheFamilyOfBicomplexMorphisms" ) );

# new types:
BindGlobal( "TheTypeBicomplexObject",
        NewType( TheFamilyOfBicomplexObjects,
                IsCapCategoryBicomplexObjectRep ) );

BindGlobal( "TheTypeHomologicalBicomplexObject",
        NewType( TheFamilyOfHomologicalBicomplexObjects,
                IsCapCategoryHomologicalBicomplexObjectRep ) );

BindGlobal( "TheTypeCohomologicalBicomplexObject",
        NewType( TheFamilyOfCohomologicalBicomplexObjects,
                IsCapCategoryCohomologicalBicomplexObjectRep ) );

BindGlobal( "TheTypeBicomplexMorphism",
        NewType( TheFamilyOfBicomplexMorphisms,
                IsCapCategoryBicomplexMorphismRep ) );

####################################
#
# methods for constructors:
#
####################################

##
InstallMethod( AsCategoryOfBicomplexes,
        [ IsCapCategory ],
        
  function( C )
    local name, BC, recnames, func, pos, create_func_bool,
          create_func_object0, create_func_object, create_func_morphism,
          create_func_universal_morphism, info, add;
    
    if HasName( C ) then
        name := Concatenation( Name( C ), " as bicomplexes" );
        BC := CreateCapCategory( name );
    else
        BC := CreateCapCategory( );
    fi;
    
    ## TODO: should be replaced later by a sync process
    if HasIsAbelianCategory( C ) then
        SetIsAbelianCategory( BC, IsAbelianCategory( C ) );
    fi;
    
    SetUnderlyingCategoryOfComplexesOfComplexes( BC, C );
    
    for name in ListKnownCategoricalProperties( C ) do
        name := ValueGlobal( name );
        Setter( name )( BC, true );
    od;
    
    ## TODO: remove `Primitively' for performance?
    recnames := ShallowCopy( ListPrimitivelyInstalledOperationsOfCategory( C ) );
    
    create_func_bool :=
      function( name )
        local oper;
        
        oper := ValueGlobal( name );
        
        return
          function( arg )
            local eval_arg;
            
            eval_arg := UnderlyingComplexOfComplexes( arg );
            
            return CallFuncList( oper, eval_arg );
            
          end;
          
        end;
    
    ## e.g., ZeroObject
    create_func_object0 :=
      function( name )
        local oper;
        
        oper := ValueGlobal( name );
        
        return
          function( )
            local result;
            
            result := oper( C );
            
            result := AssociatedBicomplex( result );
            
            return result;
            
          end;
          
      end;
    
    ## e.g., DirectSum
    create_func_object :=
      function( name )
        local oper;
        
        oper := ValueGlobal( name );
        
        return ## a constructor for universal objects
          function( arg )
            local eval_arg, result;
            
            eval_arg := List( arg, UnderlyingComplexOfComplexes );
            
            result := CallFuncList( oper, eval_arg );
            
            return AssociatedBicomplex( result );
            
          end;
          
      end;
    
    ## e.g., AdditionForMorphisms
    create_func_morphism :=
      function( name )
        local oper;
        
        oper := ValueGlobal( name );
        
        return
          function( arg )
            local eval_arg, result;
            
            eval_arg := List( arg, UnderlyingComplexOfComplexes );
            
            result := CallFuncList( oper, eval_arg );
           
            return AssociatedBicomplex( result );
            
          end;
          
      end;
    
    ## e.g., CokernelColiftWithGivenCokernelObject
    create_func_universal_morphism :=
      function( name )
        local info, oper, context;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
        
        if not info.with_given_without_given_name_pair[2] = name then
            Error( name, " is not the constructor of a universal morphism with a given universal object\n" );
        fi;
        
        oper := ValueGlobal( name );
        
        return
          function( arg )
            local l, universal_object, eval_arg, result;
            
            l := Length( arg );
            
            universal_object := arg[l];
            
            eval_arg := List( arg, UnderlyingComplexOfComplexes );
            
            result := CallFuncList( oper, eval_arg );
            
            return AssociatedBicomplex( result );
            
          end;
          
      end;
    
    for name in recnames do
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
        
        if info.return_type = "bool" then
            func := create_func_bool( name );
        elif info.return_type = "object" and info.filter_list = [ "category" ] then
            func := create_func_object0( name );
        elif info.return_type = "object" then
            func := create_func_object( name );
        elif info.return_type = "morphism" or info.return_type = "morphism_or_fail" then
            if not IsBound( info.io_type ) then
                ## if there is no io_type we cannot do anything
                continue;
            elif IsList( info.with_given_without_given_name_pair ) and
              name = info.with_given_without_given_name_pair[1] then
                ## do not install universal morphisms but their
                ## with-given-universal-object counterpart
                Add( recnames, info.with_given_without_given_name_pair[2] );
                continue;
            elif IsBound( info.universal_object ) and
              Position( recnames, info.universal_object ) = fail then
                ## add the corresponding universal object
                ## at the end of the list for its method to be installed
                Add( recnames, info.universal_object );
            fi;
            
            if IsList( info.with_given_without_given_name_pair ) then
                func := create_func_universal_morphism( name );
            else
                func := create_func_morphism( name );
            fi;
        else
            Error( "unkown return type of the operation ", name );
        fi;
        
        add := ValueGlobal( Concatenation( "Add", name ) );
        
        add( BC, func );
        
    od;
    
    Finalize( BC );
    
    IdentityFunctor( BC )!.UnderlyingFunctor := IdentityFunctor( C );
    
    return BC;
    
end );


##
InstallMethod( AssociatedBicomplex, 
               [ IsChainOrCochainComplex ],
   function( C )
   local B, cat, type;

   cat := CapCategory( C );
   
   if IsChainComplexCategory( cat ) and IsChainComplexCategory( UnderlyingCategory( cat ) ) then 
      type := TheTypeHomologicalBicomplexObject;
   elif IsCochainComplexCategory( cat ) and IsCochainComplexCategory( UnderlyingCategory( cat ) ) then
      type := TheTypeCohomologicalBicomplexObject;
   else 
      Error( "not yet implemented" );
   fi;
   
   B := rec( IndicesOfTotalComplex := rec( ) );
   
   ObjectifyWithAttributes(
            B, type,
            UnderlyingComplexOfComplexes, C
            );
   
   cat := AsCategoryOfBicomplexes( CapCategory( C ) );
   
   Add( cat, B );
   
   TODOLIST_TO_PUSH_BOUNDS_TO_BICOMPLEX( C, B );
   
   return B;

end );

##
InstallMethod( HomologicalBicomplex,
               [ IsChainComplex ],
    AssociatedBicomplex );

InstallMethod( CohomologicalBicomplex,
               [ IsCochainComplex ],
    AssociatedBicomplex );

##
InstallMethod( HomologicalBicomplex,
               [ IsCapCategory, IsZList, IsZList ],
  function( A, h, v )
  local chains_cat, C;
  
  chains_cat := ChainComplexCategory( A );
  
  C := ChainComplex( chains_cat, MapLazy( IntegersList, 
                                                function( i )
                                                local source, range, diff;

                                                if i mod 2 = 0 then 
                                                
                                                   source := ChainComplex( A, MapLazy( IntegersList, j -> v[ i ][ j ], 1 ) );
                                                
                                                   range := ChainComplex( A, MapLazy( IntegersList, j-> AdditiveInverseForMorphisms( v[ i - 1 ][ j ] ), 1 ) );
                                                
                                                else
                                                
                                                   source := ChainComplex( A, MapLazy( IntegersList, j -> AdditiveInverseForMorphisms( v[ i ][ j ] ), 1 ) );
                                                
                                                   range := ChainComplex( A, MapLazy( IntegersList, j-> v[ i - 1 ][ j ], 1 ) );
                                                
                                                fi;
                                                
                                                diff := MapLazy( IntegersList, j -> h[ j ][ i ], 1 );
                                                
                                                return ChainMorphism( source, range, diff );
                                                
                                                end, 1 ) );
                                                
   return HomologicalBicomplex( C );

end );

##
InstallMethod( CohomologicalBicomplex,
               [ IsCapCategory, IsZList, IsZList ],
  function( A, h, v )
  local cochains_cat, C;
  
  cochains_cat := CochainComplexCategory( A );
  
  C := CochainComplex( cochains_cat, MapLazy( IntegersList, 
                                                function( i )
                                                local source, range, diff;

                                                if i mod 2 = 0 then 
                                                
                                                   source := CochainComplex( A, MapLazy( IntegersList, j -> v[ i ][ j ], 1 ) );
                                                
                                                   range := CochainComplex( A, MapLazy( IntegersList, j-> AdditiveInverseForMorphisms( v[ i + 1 ][ j ] ), 1 ) );
                                                
                                                else
                                                
                                                   source := CochainComplex( A, MapLazy( IntegersList, j -> AdditiveInverseForMorphisms( v[ i ][ j ] ), 1 ) );
                                                
                                                   range := CochainComplex( A, MapLazy( IntegersList, j-> v[ i + 1 ][ j ], 1 ) );
                                                
                                                fi;
                                                
                                                diff := MapLazy( IntegersList, j -> h[ j ][ i ], 1 );
                                                
                                                return CochainMorphism( source, range, diff );
                                                
                                                end, 1 ) );
                                                
   return CohomologicalBicomplex( C );

end );

##
InstallMethod( HomologicalBicomplex, 
               [ IsCapCategory, IsFunction, IsFunction ],
    function( A, H, V )
    local h, v;
   
    h := MapLazy( IntegersList, j -> MapLazy( IntegersList, i -> H( i, j ), 1 ), 1 );

    v := MapLazy( IntegersList, i -> MapLazy( IntegersList, j -> V( i, j ), 1 ), 1 );
    
    return HomologicalBicomplex( A, h, v );

end );

##
InstallMethod( CohomologicalBicomplex, 
               [ IsCapCategory, IsFunction, IsFunction ],
    function( A, H, V )
    local h, v;
   
    h := MapLazy( IntegersList, j -> MapLazy( IntegersList, i -> H( i, j ), 1 ), 1 );

    v := MapLazy( IntegersList, i -> MapLazy( IntegersList, j -> V( i, j ), 1 ), 1 );
    
    return CohomologicalBicomplex( A, h, v );

end );


##
InstallMethod( ObjectAt,
               [ IsCapCategoryBicomplexObject, IsInt, IsInt ],
    function( B, i, j )
       return UnderlyingComplexOfComplexes( B )[ i ][ j ];
end );

##
InstallMethod( HorizontalDifferentialAt, 
               [ IsCapCategoryBicomplexObject, IsInt, IsInt ],
    function( B, i, j )
    local d;
    d := UnderlyingComplexOfComplexes( B )^i;
    return d[ j ];
end );

##
InstallMethod( VerticalDifferentialAt, 
               [ IsCapCategoryBicomplexObject, IsInt, IsInt ],
    function( B, i, j )
       if i mod 2 = 0 then
          return UnderlyingComplexOfComplexes( B )[ i ]^j;
       else
          return AdditiveInverseForMorphisms( UnderlyingComplexOfComplexes( B )[ i ]^j );
       fi;
end );

##
InstallMethod( RowAsComplexOp,
               [ IsCapCategoryBicomplexObject, IsInt ],
    function( B, j )
    local C, A;
    C := UnderlyingComplexOfComplexes( B );
    
    A := UnderlyingCategory( UnderlyingCategory( CapCategory( C ) ) );
    
    if IsCapCategoryHomologicalBicomplex( B ) then
       return ChainComplex( A, MapLazy( IntegersList, i-> HorizontalDifferentialAt( B, i, j ), 1 ) );
    else
       return CochainComplex( A, MapLazy( IntegersList, i-> HorizontalDifferentialAt( B, i, j ), 1 ) );
    fi;
end );

##
InstallMethod( ColumnAsComplexOp,
               [ IsCapCategoryBicomplexObject, IsInt ],
    function( B, i )
    local C, A;
    C := UnderlyingComplexOfComplexes( B );
    
    A := UnderlyingCategory( UnderlyingCategory( CapCategory( C ) ) );
    
    if IsCapCategoryHomologicalBicomplex( B ) then
       return ChainComplex( A, MapLazy( IntegersList, j -> VerticalDifferentialAt( B, i, j ), 1 ) );
    else
       return CochainComplex( A, MapLazy( IntegersList, j -> VerticalDifferentialAt( B, i, j, 1 ) ) );
    fi;
end );

############################################
#
# Transport bounds from com(com ) to bi com 
#
############################################

InstallGlobalFunction( TODOLIST_TO_PUSH_BOUNDS_TO_BICOMPLEX,
   function( C, B )

   AddToToDoList( ToDoListEntry( [ [ C, "FAU_BOUND" ] ], function( ) 
                                                         SetRight_Bound( B, ActiveUpperBound( C ) );
                                                         end ) );

   AddToToDoList( ToDoListEntry( [ [ C, "FAL_BOUND" ] ], function( ) 
                                                         SetLeft_Bound( B, ActiveLowerBound( C ) );
                                                         end ) );

   AddToToDoList( ToDoListEntry( [ [ C, "FAL_BOUND" ], [ C, "FAU_BOUND" ] ], 
                                 function( )
                                 local l, ll, lu;
                                 if ActiveLowerBound( C ) >= ActiveUpperBound( C ) then
                                            SetAbove_Bound( B, 0 );
                                            SetBelow_Bound( B, 0 );
                                 fi;
                                 l := [ ActiveLowerBound( C ) + 1.. ActiveUpperBound( C ) - 1];
                                 lu := List( l, u -> [ C[ u ], "FAU_BOUND" ] );
                                 ll := List( l, u -> [ C[ u ], "FAL_BOUND" ] );
                                 AddToToDoList( ToDoListEntry( lu, function( ) 
                                                                   SetAbove_Bound( B, Maximum( List( l, u -> ActiveUpperBound( C[ u ] ) ) ) );
                                                                   end ) );
                                 AddToToDoList( ToDoListEntry( ll, function( ) 
                                                                   SetBelow_Bound( B, Minimum( List( l, u -> ActiveLowerBound( C[ u ] ) ) ) );
                                                                   end ) );
                                 end ) );
end );
    
######################################
#
# View, Display
#
######################################

InstallMethod( ViewObj,
               [ IsCapCategoryBicomplexObject ],
 function( B )
 if IsCapCategoryHomologicalBicomplex( B ) then 
    Print( "<A homological bicomplex in " );
 else
    Print( "<A cohomological bicomplex in " );
 fi;
 Print( Name( CapCategory( B ) ) );
 Print( " concentrated in window [ " );

 if HasLeft_Bound( B ) then 
    Print( Left_Bound( B ), " ... " );
 else 
    Print( "-inf", " ... " );
 fi;
 
 if HasRight_Bound( B ) then 
    Print( Right_Bound( B ), " ] x " );
 else 
    Print( "inf", " ] x " );
 fi;
 
 Print( "[ " );
 if HasBelow_Bound( B ) then 
    Print( Below_Bound( B ), " ... " );
 else 
    Print( "-inf", " ... " );
 fi;
 
 if HasAbove_Bound( B ) then 
    Print( Above_Bound( B ), " ]" );
 else 
    Print( "inf", " ]" );
 fi;
 
 Print( ">" );
 end );