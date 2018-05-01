#
# Bicomplexes: Bicomplexes for Abelian categories
#
# Implementations
#

####################################
#
# representations:
#
####################################

# Cells
DeclareRepresentation( "IsCapCategoryBicomplexCellRep",
        IsCapCategoryBicomplexCell,
        [ ] );

# Objects
DeclareRepresentation( "IsCapCategoryBicomplexObjectRep",
        IsCapCategoryBicomplexObject,
        [ ] );

DeclareRepresentation( "IsCapCategoryHomologicalBicomplexObjectRep",
        IsCapCategoryHomologicalBicomplexObject and IsCapCategoryBicomplexObjectRep,
        [ ] );

DeclareRepresentation( "IsCapCategoryCohomologicalBicomplexObjectRep",
        IsCapCategoryCohomologicalBicomplexObject and IsCapCategoryBicomplexObjectRep,
        [ ] );

# Morphisms 
DeclareRepresentation( "IsCapCategoryBicomplexMorphismRep",
        IsCapCategoryBicomplexMorphism,
        [ ] );

DeclareRepresentation( "IsCapCategoryHomologicalBicomplexMorphismRep",
        IsCapCategoryHomologicalBicomplexMorphism and IsCapCategoryBicomplexMorphismRep,
        [ ] );

DeclareRepresentation( "IsCapCategoryCohomologicalBicomplexMorphismRep",
        IsCapCategoryCohomologicalBicomplexMorphism and IsCapCategoryBicomplexMorphismRep,
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

BindGlobal( "TheFamilyOfHomologicalBicomplexMorphisms",
        NewFamily( "TheFamilyOfHomologicalBicomplexMorphisms" ) );

BindGlobal( "TheFamilyOfCohomologicalBicomplexMorphisms",
        NewFamily( "TheFamilyOfCohomologicalBicomplexMorphisms" ) );


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

BindGlobal( "TheTypeHomologicalBicomplexMorphism",
        NewType( TheFamilyOfHomologicalBicomplexMorphisms,
                IsCapCategoryHomologicalBicomplexMorphismRep ) );

BindGlobal( "TheTypeCohomologicalBicomplexMorphism",
        NewType( TheFamilyOfCohomologicalBicomplexMorphisms,
                IsCapCategoryCohomologicalBicomplexMorphismRep ) );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( UnderlyingCapCategoryCell,
        "for a list",
        [ IsList ],
        
  L -> List( L, UnderlyingCapCategoryCell ) );

##
InstallMethod( UnderlyingCapCategoryCell,
        "fallback method for an arbitrary GAP object",
        [ IsObject ],
        
  IdFunc );

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
            
            eval_arg := UnderlyingCapCategoryCell( arg );
            
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
            
            return AssociatedBicomplexObject( result );
            
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
            
            eval_arg := List( arg, UnderlyingCapCategoryCell );
            
            result := CallFuncList( oper, eval_arg );
            
            return AssociatedBicomplexObject( result );
            
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
            
            eval_arg := List( arg, UnderlyingCapCategoryCell );
            
            result := CallFuncList( oper, eval_arg );
           
            return AssociatedBicomplexMorphism( result );
            
          end;
          
      end;
    
    ## e.g., CokernelColiftWithGivenCokernelObject
    create_func_universal_morphism :=
      function( name )
        local oper;
        
        oper := ValueGlobal( name );
        
        return
          function( arg )
            local eval_arg, result;
            
            eval_arg := List( arg, UnderlyingCapCategoryCell );
            
            result := CallFuncList( oper, eval_arg );
            
            return AssociatedBicomplexMorphism( result );
            
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
InstallMethod( AssociatedBicomplexObject, 
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
            UnderlyingCapCategoryCell, C
            );
   
   cat := AsCategoryOfBicomplexes( cat );
   
   Add( cat, B );
   
   TODOLIST_TO_PUSH_BOUNDS_TO_BICOMPLEXES( C, B );
   
   return B;

end );

##
InstallMethod( HomologicalBicomplex,
               [ IsChainComplex ],
    AssociatedBicomplexObject );

InstallMethod( CohomologicalBicomplex,
               [ IsCochainComplex ],
    AssociatedBicomplexObject );

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
InstallOtherMethod( ObjectAt,
               [ IsCapCategoryBicomplexObject, IsInt, IsInt ],
    function( B, i, j )
       return UnderlyingCapCategoryCell( B )[ i ][ j ];
end );

##
InstallMethod( HorizontalDifferentialAt, 
               [ IsCapCategoryBicomplexObject, IsInt, IsInt ],
    function( B, i, j )
    local d;
    d := UnderlyingCapCategoryCell( B )^i;
    return d[ j ];
end );

##
InstallMethod( VerticalDifferentialAt, 
               [ IsCapCategoryBicomplexObject, IsInt, IsInt ],
    function( B, i, j )
       if i mod 2 = 0 then
          return UnderlyingCapCategoryCell( B )[ i ]^j;
       else
          return AdditiveInverseForMorphisms( UnderlyingCapCategoryCell( B )[ i ]^j );
       fi;
end );

##
InstallMethod( RowAsComplexOp,
               [ IsCapCategoryBicomplexObject, IsInt ],
    function( B, j )
    local C, A;
    C := UnderlyingCapCategoryCell( B );
    
    A := UnderlyingCategory( UnderlyingCategory( CapCategory( C ) ) );
    
    if IsCapCategoryHomologicalBicomplexObject( B ) then
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
    C := UnderlyingCapCategoryCell( B );
    
    A := UnderlyingCategory( UnderlyingCategory( CapCategory( C ) ) );
    
    if IsCapCategoryHomologicalBicomplexObject( B ) then
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

InstallGlobalFunction( TODOLIST_TO_PUSH_BOUNDS_TO_BICOMPLEXES,
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
# Bicomplex morphism
#
######################################

InstallMethod( AssociatedBicomplexMorphism, 
               [ IsChainOrCochainMorphism ],
   function( phi )
   local cat, type, psi;
   
   cat := CapCategory( phi );
   
   if IsChainComplexCategory( cat ) and IsChainComplexCategory( UnderlyingCategory( cat ) ) then 
      type := TheTypeHomologicalBicomplexMorphism;
   elif IsCochainComplexCategory( cat ) and IsCochainComplexCategory( UnderlyingCategory( cat ) ) then
      type := TheTypeCohomologicalBicomplexMorphism;
   else 
      Error( "not yet implemented" );
   fi;
   
   psi := rec( );
   
   ObjectifyWithAttributes(
            psi, type,
            Source, AssociatedBicomplexObject( Source( phi ) ),
            Range, AssociatedBicomplexObject( Range( phi ) ),
            UnderlyingCapCategoryCell, phi
            );
   
   cat := AsCategoryOfBicomplexes( CapCategory( phi ) );
   
   AddMorphism( cat, psi );
   
   TODOLIST_TO_PUSH_BOUNDS_TO_BICOMPLEXES( phi, psi );
   
   return psi;

end );

##
InstallMethod( BicomplexMorphism,
               [ IsChainOrCochainMorphism ],
    AssociatedBicomplexMorphism );

##
InstallMethod( BicomplexMorphism,
               [ IsCapCategoryBicomplexObject, IsCapCategoryBicomplexObject, IsZList ],
    function( s, t, l )
    local ss, tt, phi;
    
    if not IsIdenticalObj( CapCategory( s ), CapCategory( t ) ) then 
       Error( "The source and range should be in the same category" );
    fi;
    
    if IsCapCategoryHomologicalBicomplexObject( s ) then 
       phi := ChainMorphism( UnderlyingCapCategoryCell( s ), UnderlyingCapCategoryCell( t ), l );
    else
       phi := CochainMorphism( UnderlyingCapCategoryCell( s ), UnderlyingCapCategoryCell( t ), l );
    fi;
    
    return AssociatedBicomplexMorphism( phi );
    
end );

##
InstallMethod( BicomplexMorphism,
               [ IsCapCategoryBicomplexObject, IsCapCategoryBicomplexObject, IsFunction ],
    function( s, t, f )
    local l, ss, tt, phi;
    
    if not IsIdenticalObj( CapCategory( s ), CapCategory( t ) ) then 
       Error( "The source and range should be in the same category" );
    fi;
    
    l := MapLazy( IntegersList, i -> MapLazy( IntegersList, j -> f( i, j ), 1 ), 1 );
    
    return BicomplexMorphism( s, t, l );
    
end );


InstallOtherMethod( MorphismAt, 
               [ IsCapCategoryBicomplexMorphism, IsInt, IsInt ],
   function( psi, i, j )
   return UnderlyingCapCategoryCell( psi )[ i ][ j ];
end );

##
InstallMethod( AssociatedBicomplexFunctor,
               [ IsCapFunctor, IsString ],
    function( F, name )
    local S, R, BF;
    
    S := AsCategoryOfBicomplexes( AsCapCategory( Source( F ) ) );
    R := AsCategoryOfBicomplexes( AsCapCategory( Range( F ) ) );
    
    BF := CapFunctor( name, S, R );
    
    AddObjectFunction( BF, function( obj )
                             return AssociatedBicomplexObject( ApplyFunctor( F, UnderlyingCapCategoryCell( obj ) ) );
                           end );
                           
    AddMorphismFunction( BF, function( s, phi, r )
                               return AssociatedBicomplexObject( ApplyFunctor( F, UnderlyingCapCategoryCell( phi ) ) );
                             end );
    return BF;
    
end );

##
InstallMethod( AssociatedBicomplexFunctor,
               [ IsCapFunctor ],
    function( F )
    local name;
    name := Concatenation( "Associated bicomplex functor of ", Name( F ) );
    return AssociatedBicomplexFunctor( F, name );
end );

######################################
#
# Functors
#
######################################

#DeclareOperation( "CohomologicalToHomologicalBicomplexsFunctor", [ IsCapCategory, IsCapCategory ] );
InstallMethod( CohomologicalToHomologicalBicomplexsFunctor,
                [ IsCapCategory, IsCapCategory ],
    function( CohCat, HoCat )
    local A, F;

    A := UnderlyingCategoryOfComplexesOfComplexes( CohCat );
    A := UnderlyingCategory( A );
    A := UnderlyingCategory( A );

    F := CapFunctor( "Cohomological to homological bicomplexes functor", CohCat, HoCat );

    AddObjectFunction( F, 
        function( CohB )
        local H, V, HB;

        H := function( i, j ) return HorizontalDifferentialAt( CohB, -i, -j ); end;
        V := function( i, j ) return VerticalDifferentialAt( CohB, -i, -j ); end;
        HB := HomologicalBicomplex( A, H, V );
        
        AddToToDoList( ToDoListEntry( 
                [ [ CohB, "Above_Bound" ] ], 
                    function( ) 
                    SetBelow_Bound( HB, -Above_Bound( CohB ) );
                    end ) );
        AddToToDoList( ToDoListEntry( 
                [ [ CohB, "Below_Bound" ] ], 
                    function( ) 
                    SetAbove_Bound( HB, -Below_Bound( CohB ) );
                    end ) );
        AddToToDoList( ToDoListEntry( 
                [ [ CohB, "Right_Bound" ] ], 
                    function( ) 
                    SetLeft_Bound( HB, -Right_Bound( CohB ) );
                    end ) );
        AddToToDoList( ToDoListEntry( 
                [ [ CohB, "Left_Bound" ] ], 
                    function( ) 
                    SetRight_Bound( HB, -Left_Bound( CohB ) );
                    end ) );
                
        return HB;
        
    end );
    
    AddMorphismFunction( F,
        function( new_source, f, new_range )
        local mor;
        mor := function( i, j ) return MorphismAt( f, -i, -j ); end;
        return BicomplexMorphism( new_source, new_range, mor );
    end );

    return F;
end );

##
InstallMethod( HomologicalToCohomologicalBicomplexsFunctor,
                [ IsCapCategory, IsCapCategory ],
    function( HoCat, CohCat )
    local A, F;

    A := UnderlyingCategoryOfComplexesOfComplexes( CohCat );
    A := UnderlyingCategory( A );
    A := UnderlyingCategory( A );

    F := CapFunctor( "Homological to cohomological bicomplexes functor",HoCat, CohCat );

    AddObjectFunction( F, 
        function( HB )
        local H, V, CohB;

        H := function( i, j ) return HorizontalDifferentialAt( HB, -i, -j ); end;
        V := function( i, j ) return VerticalDifferentialAt( HB, -i, -j ); end;
        CohB := CohomologicalBicomplex( A, H, V );
        
        AddToToDoList( ToDoListEntry( 
                [ [ HB, "Above_Bound" ] ], 
                    function( ) 
                    SetBelow_Bound( CohB, -Above_Bound( HB ) );
                    end ) );
        AddToToDoList( ToDoListEntry( 
                [ [ HB, "Below_Bound" ] ], 
                    function( ) 
                    SetAbove_Bound( CohB, -Below_Bound( HB ) );
                    end ) );
        AddToToDoList( ToDoListEntry( 
                [ [ HB, "Right_Bound" ] ], 
                    function( ) 
                    SetLeft_Bound( CohB, -Right_Bound( HB ) );
                    end ) );
        AddToToDoList( ToDoListEntry( 
                [ [ HB, "Left_Bound" ] ], 
                    function( ) 
                    SetRight_Bound( CohB, -Left_Bound( HB ) );
                    end ) );
                
        return CohB;
        
    end );
    
    AddMorphismFunction( F,
        function( new_source, f, new_range )
        local mor;
        mor := function( i, j ) return MorphismAt( f, -i, -j ); end;
        return BicomplexMorphism( new_source, new_range, mor );
    end );

    return F;
end );

######################################
#
# View, Display
#
######################################

InstallMethod( ViewObj,
               [ IsCapCategoryBicomplexCell ],
 function( B )
 
 if IsCapCategoryHomologicalBicomplexObject( B ) then 
    Print( "<A homological bicomplex in " );
 elif IsCapCategoryCohomologicalBicomplexObject( B ) then
    Print( "<A cohomological bicomplex in " );
 elif IsCapCategoryHomologicalBicomplexMorphism( B ) then 
    Print( "<A homological bicomplex morphism in " );
 elif IsCapCategoryCohomologicalBicomplexMorphism( B ) then
    Print( "<A cohomological bicomplex morphism in " );
 else 
    Error( "Unexpected error occurred!" );
 fi;
 
 Print( Name( UnderlyingCategory( UnderlyingCategory( UnderlyingCategoryOfComplexesOfComplexes( CapCategory( B ) ) ) ) ) );
 Print( " concentrated in window [ " );

 if HasLeft_Bound( B ) then 
    Print( Left_Bound( B ), " .. " );
 else 
    Print( "-inf", " .. " );
 fi;
 
 if HasRight_Bound( B ) then 
    Print( Right_Bound( B ), " ] x " );
 else 
    Print( "inf", " ] x " );
 fi;
 
 Print( "[ " );
 if HasBelow_Bound( B ) then 
    Print( Below_Bound( B ), " .. " );
 else 
    Print( "-inf", " .. " );
 fi;
 
 if HasAbove_Bound( B ) then 
    Print( Above_Bound( B ), " ]" );
 else 
    Print( "inf", " ]" );
 fi;
 
 Print( ">" );
 end );
