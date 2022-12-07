# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#

MakeReadWriteGlobal( "ENABLE_COLORS" );
ENABLE_COLORS := false;

InstallValue( ALL_FUNCTORS_METHODS, rec( ) );


##
InstallMethod( AddFunctor,
          [ IsObject, IsObject, IsFunction, IsFunction, IsString, IsString ],
          
  function( F1, F2, F3, F4, name, ID )
    
    AddFunctor( [ F1, F2, F3, F4, name, ID ] );
    
end );

##
InstallMethod( AddFunctor,
          [ IsDenseList ],
          
  function( F )
    
    if Size( F ) <> 6 then
      
      Error( "The list should contain 6 entries" );
      
    fi;
    
    if IsBound( ALL_FUNCTORS_METHODS.(F[6]) ) then
        Error( "A functor with ID: ", F[6], " already exists!" );
    fi;
    
    ALL_FUNCTORS_METHODS.(F[6]) := F;
    
end );

##
InstallMethod( PreComposeFunctorMethods,
    [ IsList, IsList, IsFunction, IsFunction ],

  function( F1, F2, first_checks, constructor )
    local F;
    
    F :=
      [
        F1[ 1 ],
        F2[ 2 ],
        function( sF1, rF2 )
          local category;
          
          if not first_checks( sF1, rF2 ) then
            return false;
          fi;
          
          category := constructor( sF1, rF2 );
          
          if not( F1[3]( sF1, category ) and F2[3]( category, rF2 ) ) then
            return false;
          fi;
          
          return true;
          
        end,
        function( sF1, rF2 )
          local category, I, J;
          category := constructor( sF1, rF2 );
          I := F1[ 4 ]( sF1, category );
          J := F2[ 4 ]( category, rF2 );
          return PreCompose( I, J );
        end,
        Concatenation(
          "PreComposition of the following two functors:\n",
          "     * ", F1[ 5 ], "\n     * ", F2[ 5 ]
        ),
        Concatenation( "PreComposition of ", F1[ 6 ], " and ", F2[ 6 ] )
      ];
      
      AddFunctor( F );
      
      return F;
      
end );

##
InstallMethod( ExtendFunctorMethod,
          [ IsDenseList, IsFunction, IsFunction, IsFunction, IsString ],
          
  function( F, filter, underlying_category, functor_constructor, name )
    local E;
    
    E :=
      [
        filter,
        filter,
        { category_1, category_2 } ->
              F[1]( underlying_category( category_1 ) ) and
              F[2]( underlying_category( category_2 ) ) and
              F[3]( underlying_category( category_1 ), underlying_category( category_2 ) ),
        { category_1, category_2 } ->
          functor_constructor(
                  F[ 4 ]( underlying_category( category_1 ), 
                  underlying_category( category_2 ) )
                ),
        Concatenation( "Apply ", name, " on ( ", F[ 5 ], " )" ),
        Concatenation( name, ":", F[ 6 ] )
      ];
    
    AddFunctor( E );
    
    return E;
    
end );

##
InstallMethod( ExtendFunctorMethodToAdditiveClosures,
          [ IsDenseList ],
          
  function( F )
  
    return
      ExtendFunctorMethod(
        F,
        ValueGlobal( "IsAdditiveClosureCategory" ),
        ValueGlobal( "UnderlyingCategory" ),
        ValueGlobal( "ExtendFunctorToAdditiveClosures" ),
        "ExtendFunctorToAdditiveClosures"
      );
    
end );

##
InstallMethod( KnownFunctors,
          [ IsCapCategory, IsCapCategory ],
          
  function( category_1, category_2 )
    local recs, positions, i;
    
    recs := RecNames( ALL_FUNCTORS_METHODS );
    
    positions := PositionsProperty(
                    recs,
                    function( F )
                      local i;
                      F := ALL_FUNCTORS_METHODS.(F);
                      return F[1]( category_1 ) and F[2]( category_2 ) and F[3]( category_1, category_2 );
                    end
                  );
    
    for i in [ 1 .. Size( positions ) ] do
      
      PrintFormattedString( Concatenation( String( i ), ": ", ALL_FUNCTORS_METHODS.( recs[ positions[ i ] ] )[ 5 ], "\n" ) );
      
    od;
    
end );

##
InstallOtherMethod( Functor,
          [ IsCapCategory, IsCapCategory, IsInt, IsString ],
          
  function( category_1, category_2, n, name )
    local F;
    
    F := Functor( category_1, category_2, n );
    
    F!.Name := name;
    
    return F;
    
end );

##
InstallMethod( Functor,
          [ IsCapCategory, IsCapCategory, IsInt ],
          
  function( category_1, category_2, n )
    local recs, positions, i;
    
    recs := RecNames( ALL_FUNCTORS_METHODS );
    
    positions := PositionsProperty(
                    recs,
                    function( F )
                      local i;
                      F := ALL_FUNCTORS_METHODS.(F);
                      return F[1]( category_1 ) and F[2]( category_2 ) and F[3]( category_1, category_2 );
                    end
                  );
                     
    if n > Size( positions ) then
      
      return fail;
      
    fi;
    
    return ALL_FUNCTORS_METHODS.( recs[ positions[ n ] ] )[ 4 ]( category_1, category_2 );
    
end );

AddFunctor(
    IsCapCategory,
    IsCapCategory,
    { category_1, category_2 } -> IsIdenticalObj( category_1, category_2 ),
    { category_1, category_2 } -> IdentityFunctor( category_1 ),
    "Identity functor",
    "IdentityFunctor"
);

###################################
#
# Colors
#
###################################

##
InstallGlobalFunction( RandomTextColor,
  function ( name )
    local colors, colors_in_name, pos;
    if ENABLE_COLORS <> true then
      return [ "", "" ];
    else
      colors := [ "\033[32m", "\033[33m", "\033[34m", "\033[35m" ];
      colors_in_name := List( colors, c -> PositionSublist( name, c ) );
      pos := Positions( colors_in_name, fail );
      if Size( pos ) = 1 then
        pos := [ ];
      fi;
      if not IsEmpty( pos ) then
        return [ colors[ Random( pos ) ], "\033[0m" ];
      else
        return [ colors[ Position( colors_in_name, Maximum( colors_in_name ) ) ], "\033[0m" ];
      fi;
    fi;
end );

##
InstallGlobalFunction( RandomBoldTextColor,
  function (  )
    if ENABLE_COLORS <> true then
      return [ "", "" ];
    else
      return [ Random( [ "\033[1m\033[31m" ] ), "\033[0m" ];
    fi;
end );

##
InstallGlobalFunction( RandomBackgroundColor,
  function (  )
    if ENABLE_COLORS <> true then
      return [ "", "" ];
    else
      return [ Random( [ "\033[43m", "\033[42m", "\033[44m", "\033[45m", "\033[46m" ] ), "\033[0m" ];
    fi;
end );

##
InstallGlobalFunction( CreateDisplayNameWithColorsForFunctor,
  function( name, source, range )
    local r;
    
    r := RandomBoldTextColor( );
    
    return Concatenation( name, r[ 1 ],  ":", r[ 2 ], "\n\n",
                          Name( source ), "\n", r[ 1 ],
                          "  |\n  ", TEXTMTRANSLATIONS.curlyvee, r[ 2 ], "\n",
                          Name( range ), "\n" );
  
end );


##
InstallMethod( CallFuncList,
          [ IsCapFunctor, IsList ],
          
  { F, a } -> ApplyFunctor( F, a[ 1 ] )
);

##
InstallGlobalFunction( CheckFunctoriality,
  function( F, alpha, beta )
    local bool, source_cat;
          
    bool := IsCongruentForMorphisms(
            ApplyFunctor( F, PreCompose( alpha, beta ) ),
            PreCompose( ApplyFunctor( F, alpha ), ApplyFunctor( F, beta ) )
            );
    
    source_cat := SourceOfFunctor( F );
    
    if HasIsAbCategory( source_cat ) and IsAbCategory( source_cat ) then
      
      if IsZero( alpha ) or IsZero( beta ) then
        
        Info( InfoWarning, 1, "Be carefull: At least one of the morphisms is zero!" );
        
      fi;
      
    fi;
    
    return bool;
    
end );

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
InstallMethod( Display,
          [ IsCapFunctor ],
          
  function( F )
    
    Print( CreateDisplayNameWithColorsForFunctor( Name( F ), SourceOfFunctor( F ), RangeOfFunctor( F ) ) );
    
end );

##
InstallMethod( CreateAdditiveFunctorByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ],
          
  function( name, source_cat, range_cat, object_func, morphism_func )
    local source_ring, range_ring, conv, images_of_objects, images_of_morphisms, new_object_func, new_morphism_func, F;
        
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
          
        elif IsEqualToZeroMorphism( alpha ) then
          
          return ZeroMorphism( s, r );
          
        elif IsEqualToIdentityMorphism( alpha ) then
          
          return IdentityMorphism( s );
          
        fi;
        
        alpha := morphism_func( alpha );
        
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
        
        coeffs := CoefficientsOfMorphism( alpha );
        
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
            
        output := List( coeffs{ pos }, conv ) * images;
        
        return output;
        
    end );
    
    F!.images_of_objects := images_of_objects;
    
    F!.images_of_morphisms := images_of_morphisms;
    
    DeactivateCachingObject( ObjectCache( F ) );
    
    DeactivateCachingObject( MorphismCache( F ) );
    
    return F;
    
end );

##
InstallMethodWithCache( AdditiveFunctorByTwoFunctionsData,
        [ IsCapCategory, IsCapCategory, IsFunction, IsFunction ],
        
  function( source, range, object_func, morphism_func )
    local F, values_on_objects, values_on_bases_elements, bases_of_source_category, functor_object_function, functor_morphism_function,data, full_functor, preinverse_data, preinverse_object_function, preinverse_morphism_function, hom_cat, distinguished_obj;
    
    if not ( ForAll( [ source, range ], IsLinearCategoryOverCommutativeRing )
              and IsIdenticalObj( CommutativeRingOfLinearCategory( source ), CommutativeRingOfLinearCategory( range ) ) ) then
      
      Error( "the source and range categories must be linear over the same commutative ring!\n" );
      
    fi;
    
    values_on_objects := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "values_on_objects", [[],[]] );
    values_on_bases_elements := [[],[]];
    bases_of_source_category := [[],[]];
    
    functor_object_function :=
      function( object )
        local i, value;
        
        i := PositionProperty( values_on_objects[1], x -> IsIdenticalObj( x, object ) or IsEqualForObjects( x, object ) );
        
        if i = fail then
          
          value := object_func( object );
          
          Add( values_on_objects[1], object );
          
          Add( values_on_objects[2], value );
          
          i := Length( values_on_objects[2] );
          
        fi;
        
        return values_on_objects[2][i];
        
    end;
    
    functor_morphism_function :=
      function( FS, phi, FR )
        local S, R, s, r, coeffs, positions, p;
        
        S := Source( phi );
        R := Range( phi );
        
        s := PositionProperty( values_on_bases_elements[1], x -> IsIdenticalObj( x, S ) );
        
        if s = fail then
          
          Add( bases_of_source_category[1], S );
          Add( bases_of_source_category[2], [] );
          
          Add( values_on_bases_elements[1], S );
          Add( values_on_bases_elements[2], [] );
          
          s := Length( values_on_bases_elements[1] );
          
        fi;
        
        r := PositionProperty( values_on_bases_elements[2][s], x -> IsIdenticalObj( x[1], R ) );
        
        if r = fail then
          
          Add( bases_of_source_category[2][s], [ R, BasisOfExternalHom( source, S, R ) ] );
          Add( values_on_bases_elements[2][s], [ R, [], false ] );
          
          r := Length( values_on_bases_elements[2][s] );
          
        fi;
        
        coeffs := CoefficientsOfMorphism( source, phi );
        
        positions := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if not values_on_bases_elements[2][s][r][3] then
          
          for p in positions do
            
            if not IsBound( values_on_bases_elements[2][s][r][2][p] ) then
              values_on_bases_elements[2][s][r][2][p] := morphism_func( FS, bases_of_source_category[2][s][r][2][p], FR );
            fi;
          
          od;
          
          if IsDenseList( values_on_bases_elements[2][s][r][2] ) and Length( values_on_bases_elements[2][s][r][2] ) = Length( bases_of_source_category[2][s][r][2] ) then
            values_on_bases_elements[2][s][r][3] := true;
          fi;
        
        fi;
        
        return SumOfMorphisms( range, FS, ListN( coeffs{positions}, values_on_bases_elements[2][s][r][2]{positions}, {c,f} -> MultiplyWithElementOfCommutativeRingForMorphisms( range, c, f ) ), FR );
    
    end;
    
    data := [ functor_object_function, functor_morphism_function ];
    
    full_functor := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "full_functor", false );
    
    if full_functor then
      
      hom_cat := RangeCategoryOfHomomorphismStructure( range );
      distinguished_obj := DistinguishedObjectOfHomomorphismStructure( hom_cat );
      
      preinverse_object_function :=
        function( o )
          local p;
          
          p := PositionProperty( values_on_objects[2], object -> IsIdenticalObj( o, object ) or IsEqualForObjects( o, object ) );
          
          if p = fail then
            Error( "please make sure you applied the 'full' functor on all relevant objects in the source category!\n" );
          fi;
          
          return values_on_objects[1][p];
          
      end;
      
      preinverse_data := [[],[]];
      
      preinverse_morphism_function :=
        function( S, phi, R )
          local s, r, positions, H_SR, tau, u, coeffs, p;
          
          s := PositionProperty( values_on_bases_elements[1], x -> IsIdenticalObj( x, S ) );
          
          if s = fail then
            
            Add( bases_of_source_category[1], S );
            Add( bases_of_source_category[2], [] );
            
            Add( values_on_bases_elements[1], S );
            Add( values_on_bases_elements[2], [] );
            
            s := Length( values_on_bases_elements[1] );
            
          fi;
          
          if not IsBound( preinverse_data[1][s] ) then
            preinverse_data[1][s] := S;
            preinverse_data[2][s] := [];
          fi;
          
          r := PositionProperty( values_on_bases_elements[2][s], x -> IsIdenticalObj( x[1], R ) );
          
          if r = fail then
            
            Add( bases_of_source_category[2][s], [ R, BasisOfExternalHom( source, S, R ) ] );
            Add( values_on_bases_elements[2][s], [ R, [], false ] );
            
            r := Length( values_on_bases_elements[2][s] );
            
          fi;
          
          if not IsBound( preinverse_data[2][s][r] ) then
            
            positions := PositionsProperty( [ 1 .. Length( bases_of_source_category[2][s][r][2] ) ], p -> not IsBound( values_on_bases_elements[2][s][r][2][p] ) );
            
            for p in positions do
              values_on_bases_elements[2][s][r][2][p] := morphism_func( Source( phi ), bases_of_source_category[2][s][r][2][p], Range( phi ) );
            od;
            
            values_on_bases_elements[2][s][r][3] := true;
            
            H_SR := HomomorphismStructureOnObjects( range, Source( phi ), Range( phi ) );
            
            tau := List( values_on_bases_elements[2][s][r][2], m -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( range, distinguished_obj, m, H_SR ) );
            
            u := UniversalMorphismFromDirectSum( hom_cat, ListWithIdenticalEntries( Length( tau ), distinguished_obj ), H_SR, tau );
            
            u := PreInverseForMorphisms( hom_cat, u );
            
            preinverse_data[2][s][r] := [ R, u, H_SR ];
            
          fi;
          
          H_SR := preinverse_data[2][s][r][3];
          
          coeffs := PreCompose( hom_cat, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( range, distinguished_obj, phi, H_SR ), preinverse_data[2][s][r][2] );
          
          coeffs := CoefficientsOfMorphism( hom_cat, coeffs );
          
          return SumOfMorphisms( source, S, ListN( coeffs , bases_of_source_category[2][s][r][2], { c, m } -> MultiplyWithElementOfCommutativeRingForMorphisms( source, c, m ) ), R );
          
        end;
        
        Add( data, preinverse_object_function );
        Add( data, preinverse_morphism_function );
        
    fi;
    
    return data;
    
end );

