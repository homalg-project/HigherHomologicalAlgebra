
##
InstallMethod( HomologyFunctorAt, 
               [ IsHomotopyCategory, IsCapCategory, IsInt ],
function( homotopy_category, cat, n )
  local functor, complex_cat, name, Hn;

  if not IsIdenticalObj( UnderlyingCategory( UnderlyingCapCategory( homotopy_category ) ), cat ) then

    Error( "The first argument should be the homotopy category of complex category of the second argument" );

  fi;
     
  complex_cat := UnderlyingCapCategory( homotopy_category );

  Hn := HomologyFunctorAt( complex_cat, cat, n );

  name := Concatenation( String( n ), "-th homology functor from ", Name( homotopy_category ), " to ", Name( cat ) );
     
  functor := CapFunctor( name, homotopy_category, cat );
 
  AddObjectFunction( functor, 
  
    function( complex )
    
      return ApplyFunctor( Hn, UnderlyingCell( complex ) );
  
  end );
     
  AddMorphismFunction( functor,

    function( new_source, map, new_range )

      return ApplyFunctor( Hn, UnderlyingCell( map ) );

  end );
  
  return functor;

end );

##
InstallMethod( ShiftFunctorAt, 
               [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local functor, complex_cat, name, T;
     
  complex_cat := UnderlyingCapCategory( homotopy_category ); 

  T := ShiftFunctor( complex_cat, n );

  name := Concatenation( "Shift by ", String( n ), " autoequivalence on ", Name( homotopy_category ) );
     
  functor := CapFunctor( name, homotopy_category, homotopy_category );

  AddObjectFunction( functor, 
  
    function( complex )
  
      return HomotopyCategoryObject( homotopy_category, ApplyFunctor( T, UnderlyingCell( complex ) ) );
  
  end );
     
  AddMorphismFunction( functor,

    function( new_source, map, new_range )

      return HomotopyCategoryMorphism( homotopy_category, ApplyFunctor( T, UnderlyingCell( map ) ) );

  end );

  return functor;
 
end );

##
InstallMethod( UnsignedShiftFunctorAt,
               [ IsHomotopyCategory, IsInt ],
function( homotopy_category, n )
  local functor, complex_cat, name, T;
     
  complex_cat := UnderlyingCapCategory( homotopy_category ); 

  T := UnsignedShiftFunctor( complex_cat, n );

  name := Concatenation( "Unsigned Shift by ", String( n ), " autoequivalence on ", Name( homotopy_category ) );
     
  functor := CapFunctor( name, homotopy_category, homotopy_category );

  AddObjectFunction( functor, 
  
  function( complex )
  
    return HomotopyCategoryObject( homotopy_category, ApplyFunctor( T, UnderlyingCell( complex ) ) );
  
  end );
     
  AddMorphismFunction( functor,

    function( new_source, map, new_range )

      return HomotopyCategoryMorphism( homotopy_category, ApplyFunctor( T, UnderlyingCell( map ) ) );

  end );

  return functor;
 
end );

##
InstallMethod( ExtendFunctorToHomotopyCategoryFunctor,
               [ IsCapFunctor ],
function( F )
  local S, T, functor, name;

  S := HomotopyCategory( AsCapCategory( Source( F ) ) );

  T := HomotopyCategory( AsCapCategory(  Range( F ) ) );

  name := Concatenation( "Extended version of ", Name( F ), " from ", Name( S ), " to ", Name( T ) );

  functor := CapFunctor( name, S, T );

  AddObjectFunction( functor,
    function( C )
      local diffs, functor_C;

      diffs := MapLazy( Differentials( C ), d -> ApplyFunctor( F, d ), 1 );
     
      functor_C := HomotopyCategoryObject( T, ChainComplex( AsCapCategory( Range( F ) ), diffs ) );
     
      TODO_LIST_TO_PUSH_BOUNDS( C, functor_C );

      AddToToDoList(
        ToDoListEntry( [ [ C, "IsZero", true ] ], 
          function( )

            if not HasIsZero( functor_C ) then 

              SetIsZero( functor_C, true );

            fi;

        end ) );

      return functor_C;

    end );

  AddMorphismFunction( functor,
    function( new_source, phi, new_range ) 
      local morphisms, functor_phi;

      morphisms := MapLazy( Morphisms( phi ), d -> ApplyFunctor( F, d ), 1 );
       
      functor_phi := HomotopyCategoryMorphism( T, ChainMorphism( new_source, new_range, morphisms ) );
       
      TODO_LIST_TO_PUSH_BOUNDS( phi, functor_phi );
                                                                  
      AddToToDoList(
        ToDoListEntry( [ [ phi, "IsZero", true ] ],
          function( )

            if not HasIsZero( functor_phi ) then

              SetIsZero( functor_phi, true );

            fi;

        end ) );

      return functor_phi;

     end );

  return functor;

end );

InstallMethod( EmbeddingInHomotopyCategoryOfTheFullSubcategoryGeneratedByProjectiveObjects,
          [ IsCapCategory ],
  function( cat )
    local projs, homotopy_category, name, F;
    
    if not IsAbelianCategoryWithEnoughProjectives( cat ) then
      
      Error( "The input should be abelian with enough projectives!\n" );
      
    fi;
  
    projs := ValueGlobal( "FullSubcategoryGeneratedByProjectiveObjects" )( cat );
    
    homotopy_category := HomotopyCategory( projs );
    
    name := "to be named";
    
    F := CapFunctor( name, cat, homotopy_category );
    
    ##
    AddObjectFunction( F,
      function( a )
        local p;
        
        p := AsChainComplex( ProjectiveResolution( a, true ) );
        
        p := AsComplexOverCapFullSubcategory( projs, p );
        
        return HomotopyCategoryObject( homotopy_category, p );
        
    end );
    
    ##
    AddMorphismFunction( F,
      function( s, phi, r )
        local psi;
        
        psi := MorphismBetweenProjectiveResolutions( phi, true );
        
        psi := AsChainMorphism( psi );
        
        psi := AsChainMorphismOverCapFullSubcategory( psi );
        
        return HomotopyCategoryMorphism( homotopy_category, psi );
        
    end );
    
    return F;
    
end );
