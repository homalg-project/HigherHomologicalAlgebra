




##
AddFinalDerivation( IsConflationPair,
                    [
                      [ IsMonomorphism, 1 ],
                      [ IsEpimorphism, 1 ],
                      [ IsZeroForMorphisms, 1 ],
                      [ LiftAlongMonomorphism, 1 ],
                      [ ColiftAlongEpimorphism, 1 ],
                      [ FiberProduct, 1 ],
                      [ ProjectionInFactorOfFiberProduct, 1 ],
                      [ UniversalMorphismIntoFiberProduct, 1 ],
                      [ Pushout, 1 ],
                      [ InjectionOfCofactorOfPushout, 1 ],
                      [ UniversalMorphismFromPushout, 1 ],
                      [ PreCompose, 1 ]
                    ],
                    [
                      IsConflationPair,
                      CompleteDeflationToConflation,
                      CompleteInflationToConflation,
                      LiftAlongInflation,
                      ColiftAlongDeflation,
                      ExactFiberProduct,
                      ProjectionInFactorOfExactFiberProduct,
                      UniversalMorphismIntoExactFiberProduct,
                      ExactPushout,
                      InjectionOfCofactorOfExactPushout,
                      UniversalMorphismFromExactPushout
                    ],
  
  { cat, alpha, beta } ->
      IsMonomorphism( alpha )
        and IsEpimorphism( beta )
          and IsZeroForMorphisms( PreCompose( alpha, beta ) ),

[ CompleteDeflationToConflation, { cat, def } -> KernelEmbedding( cat, def )  ],
[ CompleteInflationToConflation, { cat, inf } -> CokernelProjection( cat, inf ) ],
[ LiftAlongInflation, { cat, inf, tau } -> LiftAlongMonomorphism( cat, inf, tau ) ],
[ ColiftAlongDeflation, { cat, def, tau } -> ColiftAlongEpimorphism( cat, def, tau ) ],
[ ExactFiberProduct, { cat, alpha_1, alpha_2 } -> FiberProduct( cat, [ alpha_1, alpha_2 ] ) ],
[ ProjectionInFactorOfExactFiberProduct, { cat, alpha_1, alpha_2, n } -> ProjectionInFactorOfFiberProduct( cat, [ alpha_1, alpha_2 ], n ) ],
[ UniversalMorphismIntoExactFiberProduct, { cat, alpha_1, alpha_2, u_1, u_2 } -> UniversalMorphismIntoFiberProduct( cat, [ alpha_1, alpha_2 ], [ u_1, u_2 ] ) ],
[ ExactPushout, { cat, alpha_1, alpha_2 } -> Pushout( cat, [ alpha_1, alpha_2 ] ) ],
[ InjectionOfCofactorOfExactPushout, { cat, alpha_1, alpha_2, n } -> InjectionOfCofactorOfPushout( cat, [ alpha_1, alpha_2 ], n ) ],
[ UniversalMorphismFromExactPushout, { cat, alpha_1, alpha_2, u_1, u_2 } -> UniversalMorphismFromPushout( cat, [ alpha_1, alpha_2 ], [ u_1, u_2 ] ) ]
: ConditionsListComplete := true,
  FunctionCalledBeforeInstallation :=
    function( cat )
      SetIsExactCategory( cat, true );
    end,
  CategoryFilter := IsAbelianCategory,
  Description := "Adding exact structure to abelian categories"
);

AddFinalDerivation( IsExactProjectiveObject,
              [
                [ IsProjective, 1 ],
                [ EpimorphismFromSomeProjectiveObject, 1 ],
                [ ProjectiveLift, 1 ]
              ],
              [
                IsExactProjectiveObject,
                DeflationFromSomeExactProjectiveObject,
                ExactProjectiveLift
              ],
  { cat, o } -> IsProjective( cat, o ),
[ SomeExactProjectiveObject, { cat, o } -> SomeProjectiveObject( o ) ],
[ DeflationFromSomeExactProjectiveObject, { cat, o } -> EpimorphismFromSomeProjectiveObject( cat, o ) ],
[ ExactProjectiveLift, { cat, alpha, def } -> ProjectiveLift( cat, alpha, def ) ]
: ConditionsListComplete := false,
  FunctionCalledBeforeInstallation :=
    function( cat )
      SetIsExactCategoryWithEnoughExactProjectives( cat, true );
    end,
  CategoryFilter := IsAbelianCategoryWithEnoughProjectives,
  Description := "Adding enough exact projectives to exact categories"
);

AddFinalDerivation( IsExactInjectiveObject,
              [
                [ IsInjective, 1 ],
                [ MonomorphismIntoSomeInjectiveObject, 1 ],
                [ InjectiveColift, 1 ]
              ],
              [
                IsExactInjectiveObject,
                InflationIntoSomeExactInjectiveObject,
                ExactInjectiveColift
              ],
  { cat, o } -> IsInjective( cat, o ),
[ SomeExactInjectiveObject, { cat, o } -> SomeInjectiveObject( o ) ],
[ InflationIntoSomeExactInjectiveObject, { cat, o } -> MonomorphismIntoSomeInjectiveObject( cat, o ) ],
[ ExactInjectiveColift, { cat, inf, alpha } -> InjectiveColift( cat, inf, alpha ) ]
: ConditionsListComplete := false,
  FunctionCalledBeforeInstallation :=
    function( cat )
      SetIsExactCategoryWithEnoughExactInjectives( cat, true );
    end,
  CategoryFilter := IsAbelianCategoryWithEnoughInjectives,
  Description := "Adding enough exact injectives to exact categories"
);

##
AddFinalDerivation( IsLiftableAlongDeflationFromSomeExactProjectiveObject,
            [
              [ IsLiftable, 1 ],
              [ Lift, 1 ],
              [ DeflationFromSomeExactProjectiveObject, 1 ],
            ],
            [
              IsLiftableAlongDeflationFromSomeExactProjectiveObject,
              LiftAlongDeflationFromSomeExactProjectiveObject
            ],
  { category, alpha } -> IsLiftable( alpha, DeflationFromSomeExactProjectiveObject( Range( alpha ) ) )
,
  [
    LiftAlongDeflationFromSomeExactProjectiveObject,
    { category, alpha } -> Lift( alpha, DeflationFromSomeExactProjectiveObject( Range( alpha ) ) )
  ] : Description := "Derivation of (IsLiftable/Lift)AlongDeflationFromSomeExactProjectiveObject via (Is)Lift(able)"
);

##
AddFinalDerivation( IsColiftableAlongInflationIntoSomeExactInjectiveObject,
            [
              [ IsColiftable, 1 ],
              [ Colift, 1 ],
              [ InflationIntoSomeExactInjectiveObject, 1 ],
            ],
            [
              IsColiftableAlongInflationIntoSomeExactInjectiveObject,
              ColiftAlongInflationIntoSomeExactInjectiveObject
            ],
  { category, alpha } -> IsColiftable( InflationIntoSomeExactInjectiveObject( Source( alpha ) ), alpha )
,
  [
    ColiftAlongInflationIntoSomeExactInjectiveObject,
    { category, alpha } -> Colift( InflationIntoSomeExactInjectiveObject( Source( alpha ) ), alpha )
  ] : Description := "Derivation of (IsColiftable/Colift)AlongInflationIntoSomeExactInjectiveObject via (Is)Colift(able)"
);

##
AddFinalDerivation( ColiftingObject,
                [
                  [ InflationIntoSomeExactInjectiveObject, 1 ],
                  [ IsExactInjectiveObject, 1 ],
                  [ ExactInjectiveColift, 1 ],
                  [ IsColiftableAlongInflationIntoSomeExactInjectiveObject, 1 ],
                  [ ColiftAlongInflationIntoSomeExactInjectiveObject, 1 ]
                ],
                [
                  ColiftingObject,
                  IsColiftingObject,
                  MorphismToColiftingObject,
                  ColiftingMorphismWithGivenColiftingObjects,
                  IsColiftableAlongMorphismToColiftingObject,
                  WitnessForBeingColiftableAlongMorphismToColiftingObject
                ],
  { category, o } -> Range( InflationIntoSomeExactInjectiveObject( o ) ),
[ MorphismToColiftingObjectWithGivenColiftingObject, { category, o, r } -> InflationIntoSomeExactInjectiveObject( o ) ],
[ IsColiftingObject, { category, o } -> IsExactInjectiveObject( o ) ],
[ ColiftingMorphismWithGivenColiftingObjects,
    { category, s, alpha, r }
        -> ExactInjectiveColift(
            InflationIntoSomeExactInjectiveObject( Source( alpha ) ),
            PreCompose( alpha, InflationIntoSomeExactInjectiveObject( Range( alpha ) ) )
          ) ],
[ IsColiftableAlongMorphismToColiftingObject, { category, alpha } -> IsColiftableAlongInflationIntoSomeExactInjectiveObject( alpha ) ],
[ WitnessForBeingColiftableAlongMorphismToColiftingObject, { category, alpha } -> ColiftAlongInflationIntoSomeExactInjectiveObject( alpha ) ]
: FunctionCalledBeforeInstallation :=
    function( cat )
      return;
    end,
CategoryFilter := IsExactCategoryWithEnoughExactInjectives,
Description := "Derivation of a system of colifting objects via exact structure with enough injectives"
);

##
AddFinalDerivation( LiftingObject,
                [
                  [ DeflationFromSomeExactProjectiveObject, 1 ],
                  [ IsExactProjectiveObject, 1 ],
                  [ ExactProjectiveLift, 1 ],
                  [ IsLiftableAlongDeflationFromSomeExactProjectiveObject, 1 ],
                  [ IsLiftableAlongDeflationFromSomeExactProjectiveObject, 1 ]
                ],
                [
                  LiftingObject,
                  IsLiftingObject,
                  MorphismFromLiftingObject,
                  LiftingMorphismWithGivenLiftingObjects,
                  IsLiftableAlongMorphismFromLiftingObject,
                  WitnessForBeingLiftableAlongMorphismFromLiftingObject
                ],
  { category, o } -> Range( DeflationFromSomeExactProjectiveObject( o ) ),
[ MorphismFromLiftingObjectWithGivenLiftingObject, { category, o, r } -> DeflationFromSomeExactProjectiveObject( o ) ],
[ IsLiftingObject, { category, o } -> IsExactProjectiveObject( o ) ],
[ LiftingMorphismWithGivenLiftingObjects,
    { category, s, alpha, r }
        -> ExactProjectiveLift(
            PreCompose( DeflationFromSomeExactProjectiveObject( Source( alpha ) ), alpha ),
            DeflationFromSomeExactProjectiveObject( Range( alpha ) ) ) ],
[ IsLiftableAlongMorphismFromLiftingObject, { category, alpha } -> IsLiftableAlongDeflationFromSomeExactProjectiveObject( alpha ) ],
[ WitnessForBeingLiftableAlongMorphismFromLiftingObject, { category, alpha } -> LiftAlongDeflationFromSomeExactProjectiveObject( alpha ) ]
: FunctionCalledBeforeInstallation :=
    function( cat )
      return;
    end,
CategoryFilter := IsExactCategoryWithEnoughExactProjectives,
Description := "Derivation of a system of colifting objects via exact structure with enough injectives"
);
