
#
InstallMethod( HomologyFunctor, 
               [ IsHomotopyCategory, IsCapCategory, IsInt ],
function( H_cat, cat, n )
local functor, complex_cat, name, Hn;

     if not IsIdenticalObj( UnderlyingCategory( UnderlyingCategory( H_cat ) ), cat ) then

        Error( "The first argument should be the homotopy category of complex category of the second argument" );

     fi;
     
     complex_cat := UnderlyingCategory( H_cat ); 

     if IsChainComplexCategory( complex_cat ) then

       Hn := HomologyFunctor( complex_cat, cat, n );

       name := Concatenation( String( n ), "-th homology functor" );
     
     else
     
       Error( "the underlying category should be chain complex category, not cochain complex category" );

     fi;
     
     functor := CapFunctor( name, H_cat, cat );
 
     AddObjectFunction( functor, 
  
     function( complex )
  
     return ApplyFunctor( Hn, UnderlyingObject( complex ) );
  
     end );
     
     AddMorphismFunction( functor,

     function( new_source, map, new_range )

     return ApplyFunctor( Hn, UnderlyingMorphism( map ) );

     end );


    return functor;

end );

#
InstallMethod( CohomologyFunctor, 
               [ IsHomotopyCategory, IsCapCategory, IsInt ],
function( H_cat, cat, n )
local functor, complex_cat, name, Hn;

     if not IsIdenticalObj( UnderlyingCategory( UnderlyingCategory( H_cat ) ), cat ) then

        Error( "The first argument should be the homotopy category of complex category of the second argument" );

     fi;
     
     complex_cat := UnderlyingCategory( H_cat ); 

     if IsCochainComplexCategory( complex_cat ) then

       Hn := CohomologyFunctor( complex_cat, cat, n );

       name := Concatenation( String( n ), "-th cohomology functor" );
     
     else
     
       Error( "the underlying category should be cochain complex category, not chain complex category" );

     fi;
     
     functor := CapFunctor( name, H_cat, cat );

     AddObjectFunction( functor, 
  
     function( complex )
  
     return ApplyFunctor( Hn, UnderlyingObject( complex ) );
  
     end );
     
     AddMorphismFunction( functor,

     function( new_source, map, new_range )

     return ApplyFunctor( Hn, UnderlyingMorphism( map ) );

     end );

     return functor;
 
end );

#
InstallMethod( ShiftFunctor, 
               [ IsHomotopyCategory, IsInt ],
function( H_cat, n )
local functor, complex_cat, name, T;
     
     complex_cat := UnderlyingCategory( H_cat ); 

     T := ShiftFunctor( complex_cat, n );

     name := "To Do";
     
     functor := CapFunctor( name, H_cat, H_cat );

     AddObjectFunction( functor, 
  
     function( complex )
  
       return AsHomotopyCategoryObject( ApplyFunctor( T, UnderlyingObject( complex ) ) );
  
     end );
     
     AddMorphismFunction( functor,

     function( new_source, map, new_range )

       return AsHomotopyCategoryMorphism( ApplyFunctor( T, UnderlyingMorphism( map ) ) );

     end );

     return functor;
 
end );


#
InstallMethod( UnsignedShiftFunctor, 
               [ IsHomotopyCategory, IsInt ],
function( H_cat, n )
local functor, complex_cat, name, T;
     
     complex_cat := UnderlyingCategory( H_cat ); 

     T := UnsignedShiftFunctor( complex_cat, n );

     name := "To Do";
     
     functor := CapFunctor( name, H_cat, H_cat );

     AddObjectFunction( functor, 
  
     function( complex )
  
       return AsHomotopyCategoryObject( ApplyFunctor( T, UnderlyingObject( complex ) ) );
  
     end );
     
     AddMorphismFunction( functor,

     function( new_source, map, new_range )

       return AsHomotopyCategoryMorphism( ApplyFunctor( T, UnderlyingMorphism( map ) ) );

     end );

     return functor;
 
end );

#
InstallMethod( CochainToChainComplexFunctor,
               [ IsHomotopyCategory, IsHomotopyCategory ],

function( H1, H2)
local functor, complex_cat1,complex_cat2, name, T;
      
     complex_cat1 := UnderlyingCategory( H1 );

     complex_cat2 := UnderlyingCategory( H2 );

     T := CochainToChainComplexFunctor( complex_cat1, complex_cat2 );

     name := "To Do";

     functor := CapFunctor( name, H1, H2 );

     AddObjectFunction( functor,

     function( complex )

       return AsHomotopyCategoryObject( ApplyFunctor( T, UnderlyingObject( complex ) ) );

     end );

     AddMorphismFunction( functor,

     function( new_source, map, new_range )

       return AsHomotopyCategoryMorphism( ApplyFunctor( T, UnderlyingMorphism( map ) ) );

     end );

     return functor;

end );

#
InstallMethod( ChainToCochainComplexFunctor,
               [ IsHomotopyCategory, IsHomotopyCategory ],

function( H1, H2)
local functor, complex_cat1,complex_cat2, name, T;
      
     complex_cat1 := UnderlyingCategory( H1 );

     complex_cat2 := UnderlyingCategory( H2 );

     T := ChainToCochainComplexFunctor( complex_cat1, complex_cat2 );

     name := "To Do";

     functor := CapFunctor( name, H1, H2 );

     AddObjectFunction( functor,

     function( complex )

       return AsHomotopyCategoryObject( ApplyFunctor( T, UnderlyingObject( complex ) ) );

     end );

     AddMorphismFunction( functor,

     function( new_source, map, new_range )

       return AsHomotopyCategoryMorphism( ApplyFunctor( T, UnderlyingMorphism( map ) ) );

     end );

     return functor;

end );

