ReadPackage( "StableCategories", "examples/doc/CategoryOfArrows-0.g" );
LoadPackage( "DerivedCategories", ">= 2021.11-01" );

Q := HomalgFieldOfRationalsInSingular( );
S := GradedRing( Q * "x,y,z" );

rows := CategoryOfGradedRows( S );
freyd := FreydCategory( rows );
arrows := CategoryOfArrows( rows );
stable := StableCategoryBySystemOfColiftingObjects( arrows );

a := RandomMorphism( rows, 5 );
b := RandomMorphism( rows, 5 );

a_stable := AsObjectInFunctorCategory( Source( arrows ), [ Source(a), Range(a) ], [a] )/stable;
b_stable := AsObjectInFunctorCategory( Source( arrows ), [ Source(b), Range(b) ], [b] )/stable;

a_freyd := a/freyd;
b_freyd := b/freyd;

