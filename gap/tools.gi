BindGlobal( "DISABLE_ALL_SANITY_CHECKS_AND_LOGIC", [ false, false ] );
BindGlobal( "DISABLE_COLORS", [ true ] );

##
InstallGlobalFunction( Time,
  function( command, arguments )
    local t0, t1;
    
    t0 := NanosecondsSinceEpoch( );
    
    CallFuncList( command, arguments );
    
    t1 := NanosecondsSinceEpoch( );
    
    return Float( ( t1 - t0 ) / 10^9 );
    
end );

##
InstallMethod( CallFuncList,
          [ IsCapFunctor, IsList ],
  { F, a } -> ApplyFunctor( F, a[ 1 ] )
);

##
InstallGlobalFunction( CheckNaturality,
  function( eta, alpha )
    local S, R;
    
    S := Source( eta );
    
    R := Range( eta );
    
    return IsCongruentForMorphisms(
              PreCompose( ApplyFunctor( S, alpha ), ApplyNaturalTransformation( eta, Range( alpha ) ) ),
              PreCompose( ApplyNaturalTransformation( eta, Source( alpha ) ), ApplyFunctor( R, alpha ) )
            );
end );
  
##
InstallMethod( CallFuncList,
          [ IsCapNaturalTransformation, IsList ],
  { nat, a } -> ApplyNaturalTransformation( nat, a[ 1 ] )
);

##
InstallGlobalFunction( CheckFunctoriality,
  function( F, alpha, beta )
    local bool, source_cat;
          
    bool := IsCongruentForMorphisms(
            ApplyFunctor( F, PreCompose( alpha, beta ) ),
            PreCompose( ApplyFunctor( F, alpha ), ApplyFunctor( F, beta ) )
            );
    
    source_cat := AsCapCategory( Source( F ) );
    
    if HasIsAbCategory( source_cat ) and IsAbCategory( source_cat ) then
      
      if IsZero( alpha ) or IsZero( beta ) then
        
        Info( InfoWarning, 1, "Be carefull: At least one of the morphisms is zero!" );
        
      fi;
      
    fi;
    
    return bool;
    
end );


#############################################

InstallMethod( Finalize,
          [ IsCapCategory ],
  function( category )
    local o;
    
    o := ValueOption( "disable_sanity_checks_and_logic" );
    
    if o = false then
      TryNextMethod( );
    fi;
    
    Finalize( category: disable_sanity_checks_and_logic := false );
    
    if DISABLE_ALL_SANITY_CHECKS_AND_LOGIC[ 1 ] = false then
      return;
    else
      DisableSanityChecks( category );
    fi;
    
    if DISABLE_ALL_SANITY_CHECKS_AND_LOGIC[ 2 ] = false then
      return;
    else
      CapCategorySwitchLogicOff( category );
    fi;
    
end, 5000 );


#############################################

## Try number 0
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ],
  function( name, source_cat, range_cat, object_func, morphism_func, n )
    local source_ring, range_ring, conv, F;
    
    if n <> 0 then
      
      TryNextMethod( );
      
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( source_cat )
        and IsLinearCategoryOverCommutativeRing( source_cat ) ) or
          not ( HasIsLinearCategoryOverCommutativeRing( range_cat )
            and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        Error( "Wrong input!\n" );
        
    fi;
    
    source_ring := CommutativeRingOfLinearCategory( source_cat );
    
    range_ring := CommutativeRingOfLinearCategory( range_cat );
    
    if not IsIdenticalObj( source_ring, range_ring ) then
       
      conv := a -> a / range_ring;
      
    else
      
      conv := IdFunc;
      
    fi;
 
    object_func := FunctionWithCache( object_func );
    #morphism_func := FunctionWithCache( morphism_func );
    
    F := CapFunctor( name, source_cat, range_cat );
    
    F!.ValuesForObjects := [ [ ], [ ] ];
    F!.ValuesForMorphisms := [ [ ], [ ] ];
    
    AddObjectFunction( F,
      function( a )
        local p, Fa;
        
        p := Position( F!.ValuesForObjects[ 1 ], a );
         
        if p = fail then
          
          Fa := object_func( a );
          
          Add( F!.ValuesForObjects[ 1 ], a );
          Add( F!.ValuesForObjects[ 2 ], Fa );
          
          return Fa;
          
        else
          
          return F!.ValuesForObjects[ 2 ][ p ];
          
        fi;
        
    end );
      
    AddMorphismFunction( F,
      function( s, alpha, r )
        local a, b, p, basis, images, coeffs, pos;
        
        a := Source( alpha );
        
        b := Range( alpha );
        
        p := Position( F!.ValuesForMorphisms[ 1 ], [ a, b ] );

        if p = fail then
          
          basis := BasisOfExternalHom( a, b );
          
          images := [ ];
          
          if not IsEmpty( basis ) then
            
            Info( InfoComplexCategoriesForCAP, 3, "\033[5mApplying the functor on a basis with ", Size( basis ), " element(s) ...\033[0m" );
            
            images := List( basis, morphism_func );
            
            Info( InfoComplexCategoriesForCAP, 3, "Done!" );
            
          fi;
          
          Add( F!.ValuesForMorphisms[ 1 ], [ a, b ] );
          
          Add( F!.ValuesForMorphisms[ 2 ], images );
          
        else
          
          images := F!.ValuesForMorphisms[ 2 ][ p ];
          
        fi; 
        
        if IsEmpty( images ) then
          
          return ZeroMorphism( s, r );
          
        fi;
        
        coeffs := CoefficientsOfMorphism( alpha );
        
        pos := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if IsEmpty( pos ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return List( coeffs{ pos }, conv ) * images{ pos };
          
        fi;
        
    end );
    
    DeactivateCachingObject( ObjectCache( F ) );
    
    DeactivateCachingObject( MorphismCache( F ) );
    
    return F;
    
end );

## Try number 1, better, you are wellcome to improve it.
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ],
  function( name, source_cat, range_cat, object_func, morphism_func, n )
    local source_ring, range_ring, conv, cached_object_func, cached_morphism_func, F;
    
    if n <> 1 then
      
      TryNextMethod( );
      
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( source_cat )
        and IsLinearCategoryOverCommutativeRing( source_cat ) ) or
          not ( HasIsLinearCategoryOverCommutativeRing( range_cat )
            and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        Error( "Wrong input!\n" );
        
    fi;
    
    source_ring := CommutativeRingOfLinearCategory( source_cat );
    
    range_ring := CommutativeRingOfLinearCategory( range_cat );
    
    if not IsIdenticalObj( source_ring, range_ring ) then
       
      conv := a -> a / range_ring;
      
    else
      
      conv := IdFunc;
      
    fi;
 
    cached_object_func := FunctionWithCache( object_func );
    
    cached_morphism_func := FunctionWithCache( morphism_func );
    
    F := CapFunctor( name, source_cat, range_cat );
    
    AddObjectFunction( F, cached_object_func );
      
    AddMorphismFunction( F,
      function( s, alpha, r )
        local a, b, basis, coeffs, pos;
        
        a := Source( alpha );
        
        b := Range( alpha );
        
        basis := BasisOfExternalHom( a, b );
        
        coeffs := CoefficientsOfMorphism( alpha );
        
        pos := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if IsEmpty( pos ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return List( coeffs{ pos }, conv ) * List( basis{ pos }, cached_morphism_func );
          
        fi;
        
    end );
    
    DeactivateCachingObject( ObjectCache( F ) );
    
    DeactivateCachingObject( MorphismCache( F ) );
    
    return F;
    
end );

##
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ],
  function( name, source_cat, range_cat, object_func, morphism_func, n )
    local source_ring, range_ring, conv, cached_object_func, cached_morphism_func, F;
    
    if n <> 2 then
      
      TryNextMethod( );
      
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( source_cat )
        and IsLinearCategoryOverCommutativeRing( source_cat ) ) or
          not ( HasIsLinearCategoryOverCommutativeRing( range_cat )
            and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        Error( "Wrong input!\n" );
        
    fi;
    
    source_ring := CommutativeRingOfLinearCategory( source_cat );
    
    range_ring := CommutativeRingOfLinearCategory( range_cat );
    
    if not IsIdenticalObj( source_ring, range_ring ) then
       
      conv := a -> a / range_ring;
      
    else
      
      conv := IdFunc;
      
    fi;
 
    cached_object_func := FunctionWithCache( object_func );
    
    cached_morphism_func := FunctionWithCache(
      function( alpha )
        local s, r;
        
        s := object_func( Source( alpha ) );
        
        r := object_func( Range( alpha ) );
        
        if HasIsZero( alpha ) and IsZero( alpha ) then
          
          return ZeroMorphism( s, r );
          
        elif IsIdenticalToZeroMorphism( alpha ) then
          
          return ZeroMorphism( s, r );
          
        elif IsIdenticalToIdentityMorphism( alpha ) then
          
          return IdentityMorphism( s );
          
        fi;
        
        Info( InfoComplexCategoriesForCAP, 3, "\033[5mApplying ", name, " on a morphism ...\033[0m" );
        alpha := morphism_func( alpha );
        Info( InfoComplexCategoriesForCAP, 3, "Done!" );
        
        return alpha;
        
      end );
   
    F := CapFunctor( name, source_cat, range_cat );
    
    AddObjectFunction( F, cached_object_func );
      
    AddMorphismFunction( F,
      function( s, alpha, r )
        local a, b, basis, coeffs, pos;
        
        a := Source( alpha );
        
        b := Range( alpha );
        
        basis := BasisOfExternalHom( a, b );
        
        coeffs := CoefficientsOfMorphism( alpha );
        
        pos := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if IsEmpty( pos ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return List( coeffs{ pos }, conv ) * List( basis{ pos }, cached_morphism_func );
          
        fi;
        
    end );
    
    DeactivateCachingObject( ObjectCache( F ) );
    
    DeactivateCachingObject( MorphismCache( F ) );
    
    return F;
    
end );

##
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ],
  function( name, source_cat, range_cat, object_func, morphism_func, n )
    local source_ring, range_ring, conv, images_of_objects, images_of_morphisms, new_object_func, new_morphism_func, F;
    
    if n <> 3 then
      
      TryNextMethod( );
      
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( source_cat )
        and IsLinearCategoryOverCommutativeRing( source_cat ) ) or
          not ( HasIsLinearCategoryOverCommutativeRing( range_cat )
            and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        Error( "Wrong input!\n" );
        
    fi;
    
    source_ring := CommutativeRingOfLinearCategory( source_cat );
    
    range_ring := CommutativeRingOfLinearCategory( range_cat );
    
    if not IsIdenticalObj( source_ring, range_ring ) then
      
      conv := a -> a / range_ring;
      
    else
      
      conv := IdFunc;
      
    fi;
    
    images_of_objects := [ [ ], [ ] ];
     
    new_object_func :=
      function( a )
        local p, image_a;
        
        p := Position( images_of_objects[ 1 ], a );
         
        if p = fail then
          
          image_a := object_func( a );
          
          Add( images_of_objects[ 1 ], a );
          
          Add( images_of_objects[ 2 ], image_a );
          
          return image_a;
          
        else
          
          return images_of_objects[ 2 ][ p ];
          
        fi;

      end;
    
    images_of_morphisms := [ [ ], [ ] ];
    
    new_morphism_func :=
      function( alpha )
        local s, r;
        
        s := new_object_func( Source( alpha ) );
        
        r := new_object_func( Range( alpha ) );
        
        if HasIsZero( alpha ) and IsZero( alpha ) then
          
          return ZeroMorphism( s, r );
          
        elif IsIdenticalToZeroMorphism( alpha ) then
          
          return ZeroMorphism( s, r );
          
        elif IsIdenticalToIdentityMorphism( alpha ) then
          
          return IdentityMorphism( s );
          
        fi;
         
        Info( InfoComplexCategoriesForCAP, 3, "\033[5mApplying \033[0m", name, " on a morphism ..." );
        alpha := morphism_func( alpha );
        Info( InfoComplexCategoriesForCAP, 3, "Done!" );
        
        return alpha;
        
      end;
     
    F := CapFunctor( name, source_cat, range_cat );
    
    AddObjectFunction( F, new_object_func );
      
    AddMorphismFunction( F,
      function( s, alpha, r )
        local a, b, p, basis, coeffs, pos, images, output;
        
        a := Source( alpha );
        
        b := Range( alpha );
        
        p := Position( images_of_morphisms[ 1 ], [ a, b ] );
        
        if p = fail then
          
          Add( images_of_morphisms[ 1 ], [ a, b ] );
          
          Add( images_of_morphisms[ 2 ], [ ] );
          
          p := Size( images_of_morphisms[ 1 ] );
          
        fi;
        
        basis := BasisOfExternalHom( a, b );
        
        if IsEmpty( basis ) then
          
          return ZeroMorphism( s, r );
          
        fi;
        
        coeffs := CoefficientsOfMorphismWithGivenBasisOfExternalHom( alpha, basis );
        
        pos := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if IsEmpty( pos ) then
          
          return ZeroMorphism( s, r );
          
        fi;
        
        images :=
          List( pos,
            function( i )
            
              if not IsBound( images_of_morphisms[ 2 ][ p ][ i ] ) then
                 
                images_of_morphisms[ 2 ][ p ][ i ] := new_morphism_func( basis[ i ] );
                
              fi;
              
              return images_of_morphisms[ 2 ][ p ][ i ];
            
            end );
        
        output := coeffs{ pos } * images;
               
        return output;
        
    end );
    
    F!.images_of_objects := images_of_objects;
    
    F!.images_of_morphisms := images_of_morphisms;
    
    DeactivateCachingObject( ObjectCache( F ) );
    
    DeactivateCachingObject( MorphismCache( F ) );
    
    return F;
    
end );

## Always pick the last version, which "should" be the best.
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ],
  { name, source_cat, range_cat, object_func, morphism_func }
    -> FunctorFromLinearCategoryByTwoFunctions( name, source_cat, range_cat, object_func, morphism_func, 3 )
);

##
InstallGlobalFunction( DeactivateCachingForCertainOperations,
  function( category, list_of_operations )
    local current_name;
    
    for current_name in list_of_operations do
      
      SetCaching( category, current_name, "none" );
      
    od;
    
end );

##
InstallMethod( FinalizeCategory,
          [ IsCapCategory, IsBool ],
  function( cat, bool )
    
    if bool then
      
      Finalize( cat );
      
    fi;
    
end );


##
InstallGlobalFunction( RandomTextColor,
  function (  )
    if DISABLE_COLORS[ 1 ] then
      return [ "", "" ];
    else
      return [ Random( [ "\033[32m", "\033[33m", "\033[34m", "\033[35m" ] ), "\033[0m" ];
    fi;
end );

##
InstallGlobalFunction( RandomBoldTextColor,
  function (  )
    if DISABLE_COLORS[ 1 ] then
      return [ "", "" ];
    else
      return [ Random( [ "\033[1m\033[31m" ] ), "\033[0m" ];
    fi;
end );

##
InstallGlobalFunction( RandomBackgroundColor,
  function (  )
    return [ Random( [ "\033[43m", "\033[42m", "\033[44m", "\033[45m", "\033[46m" ] ), "\033[0m" ];
end );

