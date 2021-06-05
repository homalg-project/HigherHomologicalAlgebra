#! @Chunk stable_cat_by_projectives

#! 
#! If $\CC$ is an abelian category with enough projectives, then the set of all morphisms which factor through some projective object in $\CC$ defines a two-sided ideal $I$ of morphisms.
#! For every object $A$ in $\CC$, we fix an epimorphism $p_A:P_A \to A$ with $P_A$ a projective object.
#! One can easily verify that a morphism $\alpha:A \to B$ factors through some projective object if and only if it lifts along $p_B:P_B \to B$. The stable category $\CC/I$ is usually
#! called the stable category of $\CC$ by projectives. Let us illustrate this for the category of finitely presented $\mathbb{Z}$-modules.

#! @Example
LoadPackage( "FreydCategoriesForCAP" );
#! true
LoadPackage( "StableCategories" );
#! true
ZZ := HomalgRingOfIntegers( );
#! Z
ZZ_rows := CategoryOfRows( ZZ );
#! Rows( Z )
ZZ_mod := FreydCategory( ZZ_rows );
#! Freyd( Rows( Z ) )
f := m -> IsLiftable( m, EpimorphismFromSomeProjectiveObject( Range( m ) ) );
#! function( m ) ... end
ZZ_mod_by_projs := StableCategory( ZZ_mod, f );
#! Stable category( Freyd( Rows( Z ) ) ) defined by f
A := HomalgMatrix( [[0,0],[0,2],[0,3]], 3, 2, ZZ ) / ZZ_rows / ZZ_mod;
#! <An object in Freyd( Rows( Z ) )>
IsZero( A );
#! false
class_A := StableCategoryObject( ZZ_mod_by_projs, A );
#! <An object in Stable category( Freyd( Rows( Z ) ) ) defined by f>
IsZeroForMorphisms( IdentityMorphism( class_A ) );
#! true
IsZero( class_A );
#! true
IsProjective( A );
#! true
RangeCategoryOfHomomorphismStructure( ZZ_mod );
#! Freyd( Rows( Z ) )
HasRangeCategoryOfHomomorphismStructure( ZZ_mod_by_projs );
#! false
#! @EndExample

#!
#! In order to be able to lift the homomorphism structure from $\CC$ to $\CC/I$, we need to equip $\CC$ with more categorical operations (see the next section).

#! @Chunk stable_cat_by_projectives_as_lifting_objects

#! 
#!  We found earlier
#!  @LatexOnly in section \ref{Section_LNr1U3TyLS1Gj3vHSzvh}
#!  that the class of all $\EE$-projective objects in any exact category $(\CC,\EE)$ defines a system of lifting objects.
#!  Let us illustrate this for the category of finitely presented $\mathbb{Z}$-modules.

#! @Example
LoadPackage( "FreydCategoriesForCAP" );
#! true
LoadPackage( "StableCategories" );
#! true
ZZ := HomalgRingOfIntegers( );
#! Z
ZZ_rows := CategoryOfRows( ZZ );
#! Rows( Z )
ZZ_mod := FreydCategory( ZZ_rows );
#! Freyd( Rows( Z ) )
IsExactCategoryWithEnoughExactProjectives( ZZ_mod );
#! true
ZZ_mod_by_projs := StableCategoryBySystemOfLiftingObjects( ZZ_mod );
#! Stable category( Freyd( Rows( Z ) ) ) defined by a system of lifting objects
CongruencyTestFunction( ZZ_mod_by_projs );
#! <Property "IsLiftableAlongMorphismFromLiftingObject">
A := HomalgMatrix( [[0,0],[0,2],[0,3]], 3, 2, ZZ ) / ZZ_rows / ZZ_mod;
#! <An object in Freyd( Rows( Z ) )>
IsZero( A );
#! false
class_A := StableCategoryObject( ZZ_mod_by_projs, A );
#! <An object in Stable category( Freyd( Rows( Z ) ) ) defined by a system of
#! lifting objects>
IsZeroForMorphisms( IdentityMorphism( class_A ) );
#! true
IsZero( class_A );
#! true
IsProjective( A );
#! true
RangeCategoryOfHomomorphismStructure( ZZ_mod );
#! Freyd( Rows( Z ) )
HasRangeCategoryOfHomomorphismStructure( ZZ_mod_by_projs );
#! true
RangeCategoryOfHomomorphismStructure( ZZ_mod_by_projs );
#! Freyd( Rows( Z ) )
#! @EndExample

#! 
#! In the following we create two $\mathbb{Z}$-modules $A$ and $B$
#! In the following, we constructe a nonzero morphism $\alpha:A \to B$ with $[\alpha]\sim 0$.

#! @Example
mat_A := HomalgMatrix(
                [ [    0,    4,  -10,    6 ],
                  [   10,   -8,   10,  -10 ],
                  [    1,    5,  -14,    5 ] ] , 3, 4, ZZ
        );;
A := mat_A / ZZ_rows / ZZ_mod;
#! <An object in Freyd( Rows( Z ) )>
class_A := StableCategoryObject( ZZ_mod_by_projs, A );
#! <An object in Stable category( Freyd( Rows( Z ) ) ) defined by a system of
#! lifting objects>
mat_B := HomalgMatrix(
                [ [   8,  -6,  -9 ],
                  [   8,  -4,  -9 ] ] , 2, 3, ZZ
        );;
B := mat_B / ZZ_rows / ZZ_mod;
#! <An object in Freyd( Rows( Z ) )>
class_B := StableCategoryObject( ZZ_mod_by_projs, B );
#! <An object in Stable category( Freyd( Rows( Z ) ) ) defined by a system of
#! lifting objects>
mat_alpha := HomalgMatrix(
                [ [       1899716,        264976,   90332035416 ],
                  [       2974213,        474929,  241963187751 ],
                  [       2974213,        474929,   87104606157 ],
                  [       2974213,        209953,  -16134448239 ] ] , 4, 3, ZZ
        );;
alpha := FreydCategoryMorphism( A, mat_alpha / ZZ_rows, B );
#! <A morphism in Freyd( Rows( Z ) )>
IsZero( alpha );
#! false
class_alpha := StableCategoryMorphism( class_A, alpha, class_B );
#! <A morphism in Stable category( Freyd( Rows( Z ) ) ) defined by a system of
#! lifting objects>
IsZero( class_alpha );
#! true
#! @EndExample

#! 
#! This means $\alpha$ lifts along $\ell_B:L_B \to B$. In the following, we compute a lift morphism of $\alpha$ along $\ell_B$.

#! @Example
IsLiftableAlongMorphismFromLiftingObject( alpha );
#! true
lambda := WitnessForBeingLiftableAlongMorphismFromLiftingObject( alpha );
#! <A morphism in Freyd( Rows( Z ) )>
Display( lambda );
#! 
#! --------------------------------
#! Source:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 3
#! 
#! Matrix: 
#! [ [    0,    4,  -10,    6 ],
#!   [   10,   -8,   10,  -10 ],
#!   [    1,    5,  -14,    5 ] ]
#! 
#! Range: 
#! A row module over Z of rank 4
#! 
#! A morphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! Morphism datum:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 4
#! 
#! Matrix: 
#! [ [   -44715405386652,    89250478674756,    50395165232580 ],
#!   [  -119773407285675,   239063782164525,   134987049730125 ],
#!   [   -43118426622843,    86062961579229,    48595337902845 ],
#!   [     7984893819045,   -15937585477635,    -8999136648675 ] ]
#! 
#! Range: 
#! A row module over Z of rank 3
#! 
#! A morphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! Range:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 0
#! 
#! Matrix: 
#! (an empty 0 x 3 matrix)
#! 
#! Range: 
#! A row module over Z of rank 3
#! 
#! A zero, split monomorphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#! 
#! A morphism in Freyd( Rows( Z ) )
#! 
ell_B := MorphismFromLiftingObject( B );
#! <A morphism in Freyd( Rows( Z ) )>
Display( ell_B );
#! 
#! --------------------------------
#! Source:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 0
#! 
#! Matrix: 
#! (an empty 0 x 3 matrix)
#! 
#! Range: 
#! A row module over Z of rank 3
#! 
#! A zero, split monomorphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! Morphism datum:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 3
#! 
#! Matrix: 
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ],
#!   [  0,  0,  1 ] ]
#! 
#! Range: 
#! A row module over Z of rank 3
#! 
#! An identity morphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! Range:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 2
#! 
#! Matrix: 
#! [ [   8,  -6,  -9 ],
#!   [   8,  -4,  -9 ] ]
#! 
#! Range: 
#! A row module over Z of rank 3
#! 
#! A morphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#! 
#! A morphism in Freyd( Rows( Z ) )
#! 
IsCongruentForMorphisms( PreCompose( lambda, ell_B ), alpha );
#! true
#! @EndExample

#!
#! Let us compute $\mathrm{Hom}(A,B)$ and $\mathrm{Hom}([A],[B])$ as $\mathbb{Z}$-modules a generating set of morphisms for $\mathrm{Hom}([A],[B])$.

#! @Example
RangeCategoryOfHomomorphismStructure( ZZ_mod );
#! Freyd( Rows( Z ) )
RangeCategoryOfHomomorphismStructure( ZZ_mod_by_projs );
#! Freyd( Rows( Z ) )
Hom_AB := HomStructure( A, B );
#! <An object in Freyd( Rows( Z ) )>
Display( Hom_AB );
#! --------------------------------
#! Relation morphism:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 8
#! 
#! Matrix: 
#! [ [   -7,    6,    0,    1,    0,   16,    0,    1,    0 ],
#!   [   -2,    4,    0,    1,    0,    4,   10,    0,    1 ],
#!   [    8,    0,    0,   12,    0,   -8,    0,    5,    0 ],
#!   [    9,    0,    0,    8,    4,    0,   -8,    0,    5 ],
#!   [  -17,    8,    0,  -16,    0,   18,    0,  -14,    0 ],
#!   [  -23,    8,    0,   -4,  -10,    8,   10,    0,  -14 ],
#!   [   12,    6,    9,    6,    0,  -10,    0,    5,    0 ],
#!   [   13,    4,    9,    0,    6,    0,  -10,    0,    5 ] ]
#! 
#! Range: 
#! A row module over Z of rank 9
#! 
#! A morphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#! 
#! An object in Freyd( Rows( Z ) )
#! 
Sim_Hom_AB := SimplifyObject( Hom_AB, infinity );
#! <An object in Freyd( Rows( Z ) )>
Display( Sim_Hom_AB );
#! --------------------------------
#! Relation morphism:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 3
#! 
#! Matrix: 
#! [ [  2,  0,  0,  0 ],
#!   [  0,  2,  0,  0 ],
#!   [  0,  0,  2,  0 ] ]
#! 
#! Range: 
#! A row module over Z of rank 4
#! 
#! A morphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#! 
#! An object in Freyd( Rows( Z ) )
#! 
Hom_class_A_class_B := HomStructure( class_A, class_B );
#! <An object in Freyd( Rows( Z ) )>
Display( Hom_class_A_class_B );
#! 
#! --------------------------------
#! Relation morphism:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 11
#! 
#! Matrix: 
#! [ [     -7,      6,      0,       1,     0,     16,     0,     1,     0 ],
#!   [     -2,      4,      0,       1,     0,      4,    10,     0,     1 ],
#!   [      8,      0,      0,      12,     0,     -8,     0,     5,     0 ],
#!   [      9,      0,      0,       8,     4,      0,    -8,     0,     5 ],
#!   [    -17,      8,      0,     -16,     0,     18,     0,   -14,     0 ],
#!   [    -23,      8,      0,      -4,   -10,      8,    10,     0,   -14 ],
#!   [     12,      6,      9,       6,     0,    -10,     0,     5,     0 ],
#!   [     13,      4,      9,       0,     6,      0,   -10,     0,     5 ],
#!   [  56694,   5395,   9550,  156285,     0,  -9550,     0,     0,     0 ],
#!   [  11665,   1110,   1965,   32156,     0,  -1965,     0,     0,     0 ],
#!   [ -11191,  -1064,  -1885,  -30848,     0,   1886,     0,     0,     0 ] ]
#! 
#! Range: 
#! A row module over Z of rank 9
#! 
#! A morphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#! 
#! An object in Freyd( Rows( Z ) )
#! 
Sim_Hom_class_A_class_B := SimplifyObject( Hom_class_A_class_B, infinity );
#! <An object in Freyd( Rows( Z ) )>
Display( Sim_Hom_class_A_class_B );
#! 
#! --------------------------------
#! Relation morphism:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 2
#! 
#! Matrix: 
#! [ [  2,  0 ],
#!   [  0,  2 ] ]
#!
#! Range: 
#! A row module over Z of rank 2
#!
#! A morphism in Rows( Z )
#!
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#!
#! An object in Freyd( Rows( Z ) )
#!
#! @EndExample

#! 
#! This means $\mathrm{Hom}(A,B) \cong \mathbb{Z}/2\mathbb{Z} \oplus \mathbb{Z}/2\mathbb{Z} \oplus \mathbb{Z}/2\mathbb{Z} \oplus \mathbb{Z}$ and $\mathrm{Hom}([A],[B]) \cong \mathbb{Z}/2\mathbb{Z} \oplus \mathbb{Z}/2\mathbb{Z}$.

#! @Example
eta := SimplifyObject_IsoToInputObject( Hom_class_A_class_B, infinity );
#! <A morphism in Freyd( Rows( Z ) )>
IsEqualForObjects( Source( eta ), Sim_Hom_class_A_class_B );
#! true
IsEqualForObjects( Range( eta ), Hom_class_A_class_B );
#! true
IsIsomorphism( eta );
#! true
Display( MorphismDatum( eta ) );
#! Source: 
#! A row module over Z of rank 2
#! 
#! Matrix: 
#! [ [   0,   0,   0,  -1,   1,  -1,  -1,   1,   0 ],
#!   [   0,   0,   0,   0,   1,  -1,   0,   0,   1 ] ]
#! 
#! Range: 
#! A row module over Z of rank 9
#! 
#! A morphism in Rows( Z )
#!
D := DistinguishedObjectOfHomomorphismStructure( ZZ_mod_by_projs );
#! <A projective object in Freyd( Rows( Z ) )>
g1 := HomalgMatrix( [[1,0]], 1, 2, ZZ );
#! <A 1 x 2 matrix over an internal ring>
g1 := FreydCategoryMorphism( D, g1 / ZZ_rows, Sim_Hom_class_A_class_B );
#! <A morphism in Freyd( Rows( Z ) )>
g1 := PreCompose( g1, eta );
#! <A morphism in Freyd( Rows( Z ) )>
g1 :=
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
            class_A, class_B, g1 );
#! <A morphism in Stable category( Freyd( Rows( Z ) ) ) defined by a system of
#! lifting objects>
IsEqualForObjects( Source( g1 ), class_A );
#! true
IsEqualForObjects( Range( g1 ), class_B );
#! true
Display( MorphismDatum( UnderlyingCell( g1 ) ) );
#! Source: 
#! A row module over Z of rank 4
#! 
#! Matrix: 
#! [ [   224824,   217054,   810891 ],
#!   [   893412,   362992,  1844424 ],
#!   [   274828,   165777,   716643 ],
#!   [  -168860,    57774,        0 ] ]
#! 
#! Range: 
#! A row module over Z of rank 3
#! 
#! A morphism in Rows( Z )
#! 
IsZero( AdditionForMorphisms( g1, g1 ) );
#! true
g2 := HomalgMatrix( [[0,1]], 1, 2, ZZ );
#! <A 1 x 2 matrix over an internal ring>
g2 := FreydCategoryMorphism( D, g2 / ZZ_rows, Sim_Hom_class_A_class_B );
#! <A morphism in Freyd( Rows( Z ) )>
g2 := PreCompose( g2, eta );
#! <A morphism in Freyd( Rows( Z ) )>
g2 :=
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
            class_A, class_B, g2 );
#! <A morphism in Stable category( Freyd( Rows( Z ) ) ) defined by a system of
#! lifting objects>
IsEqualForObjects( Source( g2 ), class_A );
#! true
IsEqualForObjects( Range( g2 ), class_B );
#! true
Display( MorphismDatum( UnderlyingCell( g2 ) ) );
#! Source: 
#! A row module over Z of rank 4
#! 
#! Matrix: 
#! [ [   457088,   441291,  1648629 ],
#!   [  1816402,   737986,  3749904 ],
#!   [   558754,   337038,  1457010 ],
#!   [  -343310,   117463,        0 ] ]
#! 
#! Range: 
#! A row module over Z of rank 3
#! 
#! A morphism in Rows( Z )
#!
IsZero( AdditionForMorphisms( g2, g2 ) );
#! true
#! @EndExample
