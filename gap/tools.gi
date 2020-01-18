
##
DeclareAttribute( "EntriesOfHomalgMatrixAttr", IsHomalgMatrix );
DeclareAttribute( "EntriesOfHomalgMatrixAsListListAttr", IsHomalgMatrix );

if not IsBound( FunctorFromLinearCategoryByTwoFunctions ) then
  
  DeclareOperation( "FunctorFromLinearCategoryByTwoFunctions",
    [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ] );

fi;

##
InstallMethod( EntriesOfHomalgMatrixAttr, [ IsHomalgMatrix ], EntriesOfHomalgMatrix );

##
InstallMethod( EntriesOfHomalgMatrixAsListListAttr, [ IsHomalgMatrix ], EntriesOfHomalgMatrixAsListList );

##
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ],
  function( name, source_cat, range_cat, object_func, morphism_func )
    local source_ring, range_ring, conv, F;
    
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
 
    #object_func := FunctionWithCache( object_func );
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
            
            Info( InfoDerivedCategories, 3, "\033[5mApplying the functor on a basis with ", Size( basis ), " element(s) ...\033[0m" );
            
            images := List( basis, morphism_func );
            
            Info( InfoDerivedCategories, 3, "Done!" );
            
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
    
    return F;
    
end );

