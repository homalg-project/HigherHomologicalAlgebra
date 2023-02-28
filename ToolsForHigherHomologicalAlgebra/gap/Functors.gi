# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#

##
InstallMethod( CallFuncList,
          [ IsCapFunctor, IsList ],
  
  { F, a } -> ApplyFunctor( F, a[ 1 ] )
);

##
InstallGlobalFunction( CheckFunctoriality,
  
  { F, alpha, beta } -> IsCongruentForMorphisms( ApplyFunctor( F, PreCompose( alpha, beta ) ), PreCompose( ApplyFunctor( F, alpha ), ApplyFunctor( F, beta ) ) )
);

##
InstallGlobalFunction( CheckNaturality,
  
  { eta, alpha } -> IsCongruentForMorphisms(
                        PreCompose( ApplyFunctor( Source( eta ), alpha ), ApplyNaturalTransformation( eta, Range( alpha ) ) ),
                        PreCompose( ApplyNaturalTransformation( eta, Source( alpha ) ), ApplyFunctor( Range( eta ), alpha ) ) )
);

##
InstallMethod( CallFuncList,
          [ IsCapNaturalTransformation, IsList ],
  
  { nat, a } -> ApplyNaturalTransformation( nat, a[ 1 ] )
);

##
InstallMethod( Display,
          [ IsCapFunctor ],
  
  function ( F )
    
    Print( Concatenation( Name( F ), ":", "\n\n",
                          Name( SourceOfFunctor( F ) ), "\n",
                          "  |\n",
                          "  V\n", # TEXTMTRANSLATIONS.curlyvee
                          Name( RangeOfFunctor( F ) ), "\n" ) );
    
end );

##
InstallMethodWithCache( AdditiveFunctorByTwoFunctionsData,
        [ IsCapCategory, IsCapCategory, IsFunction, IsFunction ],
  
  function ( source, range, object_func, morphism_func )
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

