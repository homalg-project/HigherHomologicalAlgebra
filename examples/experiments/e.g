ReadPackage( "DerivedCategories", "examples/pre_settings.g" );
######################### start example #################################
SetInfoLevel( InfoDerivedCategories, 3 );
SetInfoLevel( InfoHomotopyCategories, 3 );
SetInfoLevel( InfoComplexCategoriesForCAP, 3 );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x0..2" );
graded_lp := GradedLeftPresentations( S );
BB := BeilinsonFunctor3( S );
omegas := UnderlyingCategory( DefiningCategory( AsCapCategory( Range( BB ) ) ) );
collection := CreateExceptionalCollection( omegas : name_for_underlying_quiver := "quiver{Ω^2(2)-{3}->Ω^1(1)-{3}->Ω^0(0)}",
                                                    name_for_endomorphism_algebra := "End( ⊕ {Ω^i(i)|i=0,1,2} )"
                                                  );
algebroid := Algebroid( collection );
DeactivateCachingForCertainOperations( algebroid, operations_to_deactivate );
iso := IsomorphismIntoAlgebroid( collection );
iso := ExtendFunctorToAdditiveClosures( iso );
iso := ExtendFunctorToHomotopyCategories( iso );
BB := PreCompose( BB, iso );
################## start ##################################

o := TwistedGradedFreeModule( S, 0 );
L := List( [ -2, -1, 0 ], i -> ApplyFunctor( BB, o[ i ] ) );
name_for_quiver := "quiver{𝓞 (-2) -{3}-> 𝓞 (-1) -{3}-> 𝓞 (0)}";
name_for_algebra := "End( ⊕ {𝓞 (i)|i=-2,-1,0} )";
collection := CreateExceptionalCollection( L : name_for_underlying_quiver := name_for_quiver,
                                              name_for_endomorphism_algebra := name_for_algebra
                                          );

C := AmbientCategory( collection );
D := DefiningCategory( C );
A := UnderlyingCategory( D );
AssignSetOfObjects( A, "P_" );
AssignSetOfGeneratingMorphisms( A );

L := EmbeddingFunctorFromAmbientCategoryIntoDerivedCategory( collection );

F := ConvolutionFunctor( collection );
G := ReplacementFunctor( collection );


d_3 := [
  [ 
    -6 * (s1_s2_3) - 6 * (s1_s2_2) - 2 * (s1_s2_1),
    -12/5 * PreCompose(s1_s2_2,s2_s3_3) - 21/5 * PreCompose(s1_s2_1,s2_s3_3) - 17/5 * PreCompose(s1_s2_1,s2_s3_2),
    ZeroMorphism( P_1, P_1 ),
    1*(s1_s2_3) + 1*(s1_s2_2) + 2*(s1_s2_1)
    ],
  [ 
    ZeroMorphism( P_3, P_2 ),
    ZeroMorphism( P_3, P_3 ),
    ZeroMorphism( P_3, P_1 ),
    ZeroMorphism( P_3, P_2 )
    ],
  [
    -14*IdentityMorphism( P_2 ), 
    -8/5 * (s2_s3_3) + 4 * (s2_s3_2) + 38/5 * (s2_s3_1),
    ZeroMorphism( P_2, P_1 ),
    4 * IdentityMorphism( P_2 )
    ] 
];

d_2 := [ 
  [
    ZeroMorphism( P_2, P_1 ),
    2*(s2_s3_2) + 3*(s2_s3_1),
    ZeroMorphism( P_2, P_1 )
    ],
  [
    ZeroMorphism( P_3, P_1 ),
    5 * IdentityMorphism( P_3 ),
    ZeroMorphism( P_3, P_1 )
    ],
  [
    -5 * IdentityMorphism( P_1 ),
    2 * PreCompose(s1_s2_2,s2_s3_3) + 3*PreCompose(s1_s2_1,s2_s3_2),
    5 * IdentityMorphism( P_1 )
    ],
  [
    ZeroMorphism( P_2, P_1 ),
    2*(s2_s3_3) + 2*(s2_s3_2) + 1*(s2_s3_1),
    ZeroMorphism( P_2, P_1 )
    ]
];

d_1 := [
  [
    -8/5 * PreCompose(s1_s2_2, s2_s3_3) - 4/5 * PreCompose(s1_s2_1, s2_s3_3) - 8/5 * PreCompose(s1_s2_1, s2_s3_2),
    -2 * IdentityMorphism( P_1 ),
    2 * IdentityMorphism( P_1 ),
    4 * IdentityMorphism( P_1 ),
    ],
  [
    ZeroMorphism( P_3, P_3 ),
    ZeroMorphism( P_3, P_1 ),
    ZeroMorphism( P_3, P_1 ),
    ZeroMorphism( P_3, P_1 )
    ],
  [
    -8/5 * PreCompose(s1_s2_2, s2_s3_3) - 4/5 * PreCompose(s1_s2_1, s2_s3_3) - 8/5 * PreCompose(s1_s2_1, s2_s3_2),
    -2 * IdentityMorphism( P_1 ),
    2 * IdentityMorphism( P_1 ),
    4 * IdentityMorphism( P_1 ),
    ]
];

d_0 := [
  [
    ZeroMorphism( P_3, P_1 ),
    5 * IdentityMorphism( P_3 ),
    5 * IdentityMorphism( P_3 )
    ],
  [
    ZeroMorphism( P_1, P_1 ),
    1 * PreCompose( s1_s2_2, s2_s3_3) + 4 * PreCompose( s1_s2_1, s2_s3_3),
    3 * PreCompose( s1_s2_1, s2_s3_3) + 2 * PreCompose( s1_s2_1, s2_s3_2)
    ],
  [
    ZeroMorphism( P_1, P_1 ),
    1 * PreCompose( s1_s2_2, s2_s3_3) + 2 * PreCompose( s1_s2_1, s2_s3_3) + 2 * PreCompose( s1_s2_1, s2_s3_2),
    2 * PreCompose( s1_s2_2, s2_s3_3) + 1 * PreCompose( s1_s2_1, s2_s3_3) + 2 * PreCompose( s1_s2_1, s2_s3_2)
    ],
  [
    ZeroMorphism( P_1, P_1 ),
    2 * PreCompose( s1_s2_2, s2_s3_3) + 2 * PreCompose( s1_s2_1, s2_s3_3) + 1 * PreCompose( s1_s2_1, s2_s3_2),
    1 * PreCompose( s1_s2_2, s2_s3_3) + 2 * PreCompose( s1_s2_1, s2_s3_3) + 2 * PreCompose( s1_s2_1, s2_s3_2)
    ]
];

d_m1 := [
  [
    ZeroMorphism( P_1, P_1 ),
    -2*(s1_s2_3) - 1*(s1_s2_2) - 1*(s1_s2_1),
    2*(s1_s2_3) + 1*(s1_s2_2) + 1*(s1_s2_1)
    ],
  [
    ZeroMorphism( P_3, P_1 ),
    ZeroMorphism( P_3, P_2 ),
    ZeroMorphism( P_3, P_2 )
    ],
  [
    ZeroMorphism( P_3, P_1 ),
    ZeroMorphism( P_3, P_2 ),
    ZeroMorphism( P_3, P_2 )
    ]
];

d_m2 := [
  [
    4 * IdentityMorphism( P_1 ),
    3*(s1_s2_3) + 1*(s1_s2_2),
    4 * IdentityMorphism( P_1 ),
    ],
  [
    ZeroMorphism( P_2, P_1 ),
    4 * IdentityMorphism( P_2 ),
    ZeroMorphism( P_2, P_1 ),
    ],
  [
    ZeroMorphism( P_2, P_1 ),
    4 * IdentityMorphism( P_2 ),
    ZeroMorphism( P_2, P_1 ),
    ]
];

a := ChainComplex( [ d_m2 / D, d_m1 / D, d_0 / D, d_1 / D, d_2 / D, d_3 / D ], -2 ) / C;

