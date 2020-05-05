LoadPackage( "StableCategories" );
LoadPackage( "FunctorCategories" );
LoadPackage( "DerivedCategories" );

##
DeclareAttribute( "CategoryOfArrows", IsCapCategory );

##
InstallMethod( CategoryOfArrows,
          [ IsCapCategory ],
  function( C )
    local quiver, A, over_Z, ring, algebroid, arrows, finalize_category;
    
    quiver := RightDynkinQuiver( "A", 2 );
    
    A := PathAlgebra( HomalgFieldOfRationals( ), quiver );
     
    over_Z := true;
    
    if HasIsLinearCategoryOverCommutativeRing( C ) and IsLinearCategoryOverCommutativeRing( C ) then
      
      ring := CommutativeRingOfLinearCategory( C );
      
      if IsFieldForHomalg( ring ) then
        
        over_Z := false;
        
      fi;
      
    fi;
    
    algebroid := Algebroid( A, over_Z );
    
    arrows := Hom( algebroid, C : FinalizeCategory := false );
    
    AddIsColiftingObject( arrows,
      function( F )
        local mor_vals;
        
        mor_vals := ValuesOnAllGeneratingMorphisms( F );
        
        return IsSplitEpimorphism( mor_vals[ 1 ] );
        
    end );
    
    AddColiftingObject( arrows,
      function( F )
        local obj_vals, mor_vals;
        
        obj_vals := ValuesOnAllObjects( F );
        
        obj_vals := [ DirectSum( obj_vals[ 2 ], obj_vals[ 1 ] ), obj_vals[ 2 ] ];
        
        mor_vals := ValuesOnAllGeneratingMorphisms( F );
        
        mor_vals := [
                      MorphismBetweenDirectSums(
                        [
                          [ IdentityMorphism( obj_vals[ 2 ] ) ],
                          [ mor_vals[ 1 ] ]
                        ]
                      )
                    ];
        
        return AsObjectInHomCategory( Source( arrows ), obj_vals, mor_vals );
        
    end );
    
    AddMorphismIntoColiftingObjectWithGivenColiftingObject( arrows,
      function( F, G )
        local obj_vals, mor;
        
        obj_vals := ValuesOnAllObjects( F );
        
        mor := [
                 MorphismBetweenDirectSums(
                      [
                        [ ZeroMorphism( obj_vals[ 1 ], obj_vals[ 2 ] ), IdentityMorphism( obj_vals[ 1 ] ) ]
                      ]
                   ),
                 IdentityMorphism( obj_vals[ 2 ] )
               ];
                
        return AsMorphismInHomCategory( F, mor, G );
        
    end );
    
    AddColiftingMorphismWithGivenColiftingObjects( arrows,
      function( s, alpha, r )
        local obj_vals, mor;
        
        obj_vals := ValuesOnAllObjects( alpha );
        
        mor := [
                DirectSumFunctorial( [ obj_vals[ 2 ], obj_vals[ 1 ] ] ),
                obj_vals[ 2 ]
               ];
        
        AsMorphismInHomCategory( s, mor, r );
        
    end );
    
    Finalize( arrows );
    
    return arrows;

end );

quit;

Q := HomalgFieldOfRationalsInSingular( );
S := GradedRing( Q * "x,y,z" );

rows := CategoryOfGradedRows( S );
freyd := FreydCategory( rows );
arrows := CategoryOfArrows( rows );
stable := StableCategoryBySystemOfColiftingObjects( arrows );

a := RandomMorphism( rows, 5 );
b := RandomMorphism( rows, 5 );

a_stable := AsObjectInHomCategory( Source( arrows ), [ Source(a), Range(a) ], [a] )/stable;
b_stable := AsObjectInHomCategory( Source( arrows ), [ Source(b), Range(b) ], [b] )/stable;

a_freyd := a/freyd;
b_freyd := b/freyd;


