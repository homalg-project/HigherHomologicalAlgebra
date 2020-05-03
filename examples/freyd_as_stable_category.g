LoadPackage( "DerivedCategories" );

Q := HomalgFieldOfRationalsInSingular( );
S := GradedRing( Q * "x,y,z" );

rows := CategoryOfGradedRows( S );
freyd := FreydCategory( rows );
chains := ChainComplexCategory( rows );
arrows := FullSubcategory( chains, Concatenation( "Arrows( ", Name( rows ), " )" ) : FinalizeCategory := false, is_additive := true );

AddColiftingObject( arrows,
  function( a )
    a := UnderlyingCell( a );
    return ChainComplex( [ MorphismBetweenDirectSums( [ [ IdentityMorphism( a[0] ) ], [ a^1 ] ] ) ], 1 ) / arrows;
end );

AddMorphismIntoColiftingObjectWithGivenColiftingObject( arrows,
  function( a, colifting_obj_a )
    a := UnderlyingCell( a );
    colifting_obj_a := UnderlyingCell( colifting_obj_a );
    return ChainMorphism(
            a,
            colifting_obj_a,
            [ 
              IdentityMorphism( a[ 0 ] ),
              MorphismBetweenDirectSums( [ [ ZeroMorphism( a[ 1 ], a[ 0 ] ), IdentityMorphism( a[ 1 ] ) ] ] )
            ],
            0
          ) / arrows;
end );

Finalize( arrows );

stable := StableCategoryByColiftingStructure( arrows );
quit;

a := RandomMorphism( rows, 4 );
b := RandomMorphism( rows, 4 );
HomStructure( a/freyd, b/freyd );
HomStructure( ChainComplex([a],1)/arrows/stable, ChainComplex([b],1)/arrows/stable );
