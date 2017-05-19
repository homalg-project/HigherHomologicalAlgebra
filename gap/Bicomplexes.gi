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
