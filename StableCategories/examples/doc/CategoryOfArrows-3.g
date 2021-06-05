ReadPackage( "StableCategories", "examples/doc/CategoryOfArrows.g" );
LoadPackage( "DerivedCategories" );

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

