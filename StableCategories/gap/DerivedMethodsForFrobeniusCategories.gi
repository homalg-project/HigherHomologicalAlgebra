# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# Implementations
#
AddDerivationToCAP( ExactKernelObjectFunctorialWithGivenExactKernelObjects,
                    "ExactKernelObjectFunctorialWithGivenExactKernelObjects using the universality of the kernel",
                    [ [ ExactKernelLift, 1 ],
                      [ PreCompose, 1 ],
                      [ ExactKernelEmbedding, 1 ] ],
                      
  function( cat, kernel_alpha, pi_1, mu, pi_2, kernel_pi_2 )
    
    return ExactKernelLift( cat,
                pi_2,
                PreCompose( cat, ExactKernelEmbedding( cat, pi_1 ), mu )
              );
    
end );

##
AddDerivationToCAP( ExactCokernelObjectFunctorialWithGivenExactCokernelObjects,
                    "ExactCokernelObjectFunctorialWithGivenExactCokernelObjects using the universality of the cokernel",
                    [ [ ExactCokernelColift, 1 ],
                      [ PreCompose, 1 ],
                      [ ExactCokernelProjection, 1 ] ],
                      
  function( cat, cokernel_alpha, iota_1, nu, iota_2, cokernel_iota_2 )
    
    return ExactCokernelColift( cat,
                iota_1,
                PreCompose( cat, nu, ExactCokernelProjection( cat, iota_2 ) )
              );
    
end );

##
AddFinalDerivationBundle( # IsConflationPair
                    [
                      [ IsMonomorphism, 1 ],
                      [ IsEpimorphism, 1 ],
                      [ IsIsomorphism, 2 ],
                      [ KernelLift, 1 ],
                      [ CokernelColift, 1 ],
                      [ FiberProduct, 1 ],
                      [ ProjectionInFactorOfFiberProduct, 1 ],
                      [ UniversalMorphismIntoFiberProduct, 1 ],
                      [ Pushout, 1 ],
                      [ InjectionOfCofactorOfPushout, 1 ],
                      [ UniversalMorphismFromPushout, 1 ],
                      [ KernelObject, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ KernelEmbeddingWithGivenKernelObject, 1 ],
                      [ LiftAlongMonomorphism, 1 ],
                      [ CokernelObject, 1 ],
                      [ CokernelProjection, 1 ],
                      [ CokernelProjectionWithGivenCokernelObject, 1 ],
                      [ ColiftAlongEpimorphism, 1 ],
                    ],
                    [
                      IsConflationPair,
                      IsInflation,
                      IsDeflation,
                      ExactKernelObject,
                      ExactKernelEmbedding,
                      ExactKernelEmbeddingWithGivenExactKernelObject,
                      ExactKernelLift,
                      LiftAlongInflation,
                      ExactCokernelObject,
                      ExactCokernelProjection,
                      ExactCokernelProjectionWithGivenExactCokernelObject,
                      ExactCokernelColift,
                      ColiftAlongDeflation,
                      ExactFiberProduct,
                      ProjectionInFirstFactorOfExactFiberProduct,
                      ProjectionInSecondFactorOfExactFiberProduct,
                      UniversalMorphismIntoExactFiberProduct,
                      ExactPushout,
                      InjectionOfFirstCofactorOfExactPushout,
                      InjectionOfSecondCofactorOfExactPushout,
                      UniversalMorphismFromExactPushout
                    ],
[
  IsConflationPair,
  { cat, iota, pi } ->
      IsIsomorphism( KernelLift( pi, iota ) )
        and IsIsomorphism( CokernelColift( iota, pi ) )
],
[
  IsInflation,
    { cat, iota } -> IsMonomorphism( iota )
],
[
  IsDeflation,
    { cat, pi } -> IsEpimorphism( pi )
],
[ 
  ExactKernelObject,
    { cat, pi } -> KernelObject( cat, pi )
],
[
  ExactKernelEmbedding,
    { cat, pi } -> KernelEmbedding( cat, pi ) 
],
[ ExactKernelEmbeddingWithGivenExactKernelObject,
    { cat, pi, ker } -> KernelEmbeddingWithGivenKernelObject( cat, pi, ker )
],
[
  ExactKernelLift,
    { cat, pi, tau } -> KernelLift( cat, pi, tau )
],
[
  LiftAlongInflation,
    { cat, iota, tau } -> LiftAlongMonomorphism( cat, iota, tau )
],
[
  ExactCokernelObject,
    { cat, iota } -> CokernelObject( cat, iota )
],
[
  ExactCokernelProjection,
    { cat, iota } -> CokernelProjection( cat, iota )
],
[
  ExactCokernelProjectionWithGivenExactCokernelObject,
    { cat, iota, coker } -> CokernelProjectionWithGivenCokernelObject( cat, iota, coker )
],
[
  ExactCokernelColift,
    { cat, iota, tau } -> CokernelColift( cat, iota, tau )
],
[
  ColiftAlongDeflation,
    { cat, pi, tau } -> ColiftAlongEpimorphism( cat, pi, tau )
],
[
  ExactFiberProduct,
    { cat, pi, alpha } -> FiberProduct( cat, [ pi, alpha ] )
],
[
  ProjectionInFirstFactorOfExactFiberProduct,
    { cat, pi, alpha } -> ProjectionInFactorOfFiberProduct( cat, [ pi, alpha ], 1 )
],
[ 
  ProjectionInSecondFactorOfExactFiberProduct,
    { cat, pi, alpha } -> ProjectionInFactorOfFiberProduct( cat, [ pi, alpha ], 2 )
],
[
  UniversalMorphismIntoExactFiberProduct,
    { cat, pi, alpha, p_A, p_B }
      -> UniversalMorphismIntoFiberProduct( cat, [ pi, alpha ], [ p_A, p_B ] )
],
[
  ExactPushout,
    { cat, inf, alpha } -> Pushout( cat, [ inf, alpha ] )
],
[
  InjectionOfFirstCofactorOfExactPushout,
    { cat, inf, alpha } -> InjectionOfCofactorOfPushout( cat, [ inf, alpha ], 1 )
],
[
  InjectionOfSecondCofactorOfExactPushout,
    { cat, inf, alpha } -> InjectionOfCofactorOfPushout( cat, [ inf, alpha ], 2 )
],
[
  UniversalMorphismFromExactPushout,
    { cat, inf, alpha, inf_prime, alpha_prime } 
      -> UniversalMorphismFromPushout( cat, [ inf, alpha ], [ inf_prime, alpha_prime ] )
]
:
  FunctionCalledBeforeInstallation :=
    function( cat )
      SetIsExactCategory( cat, true );
    end,
  CategoryFilter := IsAbelianCategory,
  Description := "Adding exact structure to abelian categories"
);

##
AddFinalDerivationBundle( # IsExactProjectiveObject
              [
                [ IsProjective, 1 ],
                [ SomeProjectiveObject, 1 ],
                [ EpimorphismFromSomeProjectiveObject, 1 ],
                [ ProjectiveLift, 1 ]
              ],
              [
                IsExactProjectiveObject,
                SomeExactProjectiveObject,
                DeflationFromSomeExactProjectiveObject,
                ExactProjectiveLift
              ],
[
  IsExactProjectiveObject,
  { cat, o } -> IsProjective( cat, o ) ],
[ 
  SomeExactProjectiveObject,
  { cat, o } -> SomeProjectiveObject( o ) ],
[ 
  DeflationFromSomeExactProjectiveObject,
  { cat, o } -> EpimorphismFromSomeProjectiveObject( cat, o ) ],
[ 
  ExactProjectiveLift, 
  { cat, alpha, def } -> ProjectiveLift( cat, alpha, def )
] : ConditionsListComplete := false,
  FunctionCalledBeforeInstallation :=
    function( cat )
      SetIsExactCategoryWithEnoughExactProjectives( cat, true );
    end,
  CategoryFilter := IsAbelianCategoryWithEnoughProjectives,
  Description := "Adding enough exact projectives to exact categories"
);

AddFinalDerivationBundle( # IsExactInjectiveObject
              [
                [ IsInjective, 1 ],
                [ SomeInjectiveObject, 1 ],
                [ MonomorphismIntoSomeInjectiveObject, 1 ],
                [ InjectiveColift, 1 ]
              ],
              [
                IsExactInjectiveObject,
                SomeExactInjectiveObject,
                InflationIntoSomeExactInjectiveObject,
                ExactInjectiveColift
              ],
[ IsExactInjectiveObject, { cat, o } -> IsInjective( cat, o ) ],
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
AddFinalDerivationBundle( # IsLiftableAlongDeflationFromSomeExactProjectiveObject
            [
              [ IsLiftable, 1 ],
              [ Lift, 1 ],
              [ DeflationFromSomeExactProjectiveObject, 1 ],
            ],
            [
              IsLiftableAlongDeflationFromSomeExactProjectiveObject,
              LiftAlongDeflationFromSomeExactProjectiveObject
            ],
  [
    IsLiftableAlongDeflationFromSomeExactProjectiveObject,
    { category, alpha } -> IsLiftable( alpha, DeflationFromSomeExactProjectiveObject( Range( alpha ) ) )
  ],
  [
    LiftAlongDeflationFromSomeExactProjectiveObject,
    { category, alpha } -> Lift( alpha, DeflationFromSomeExactProjectiveObject( Range( alpha ) ) )
  ] : Description := "Derivation of (IsLiftable/Lift)AlongDeflationFromSomeExactProjectiveObject via (Is)Lift(able)"
);

##
AddFinalDerivationBundle( # IsColiftableAlongInflationIntoSomeExactInjectiveObject,
            [
              [ IsColiftable, 1 ],
              [ Colift, 1 ],
              [ InflationIntoSomeExactInjectiveObject, 1 ],
            ],
            [
              IsColiftableAlongInflationIntoSomeExactInjectiveObject,
              ColiftAlongInflationIntoSomeExactInjectiveObject
            ],
  [
    IsColiftableAlongInflationIntoSomeExactInjectiveObject,
    { category, alpha } -> IsColiftable( InflationIntoSomeExactInjectiveObject( Source( alpha ) ), alpha )
  ],
  [
    ColiftAlongInflationIntoSomeExactInjectiveObject,
    { category, alpha } -> Colift( InflationIntoSomeExactInjectiveObject( Source( alpha ) ), alpha )
  ] : Description := "Derivation of (IsColiftable/Colift)AlongInflationIntoSomeExactInjectiveObject via (Is)Colift(able)"
);

##
AddFinalDerivationBundle( # ColiftingObject
                [
                  [ InflationIntoSomeExactInjectiveObject, 2 ],
                  [ IsExactInjectiveObject, 1 ],
                  [ PreCompose, 1 ],
                  [ ExactInjectiveColift, 1 ],
                  [ IsColiftableAlongInflationIntoSomeExactInjectiveObject, 1 ],
                  [ ColiftAlongInflationIntoSomeExactInjectiveObject, 1 ]
                ],
                [
                  ColiftingObject,
                  IsColiftingObject,
                  MorphismToColiftingObject,
                  MorphismToColiftingObjectWithGivenColiftingObject,
                  ColiftingMorphismWithGivenColiftingObjects,
                  IsColiftableAlongMorphismToColiftingObject,
                  WitnessForBeingColiftableAlongMorphismToColiftingObject
                ],
[ ColiftingObject, { category, o } -> Range( InflationIntoSomeExactInjectiveObject( o ) ) ],
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
AddFinalDerivationBundle( # LiftingObject,
                [
                  [ DeflationFromSomeExactProjectiveObject, 2 ],
                  [ IsExactProjectiveObject, 1 ],
                  [ PreCompose, 1 ],
                  [ ExactProjectiveLift, 1 ],
                  [ IsLiftableAlongDeflationFromSomeExactProjectiveObject, 1 ],
                  [ LiftAlongDeflationFromSomeExactProjectiveObject, 1 ]
                ],
                [
                  LiftingObject,
                  IsLiftingObject,
                  MorphismFromLiftingObject,
                  MorphismFromLiftingObjectWithGivenLiftingObject,
                  LiftingMorphismWithGivenLiftingObjects,
                  IsLiftableAlongMorphismFromLiftingObject,
                  WitnessForBeingLiftableAlongMorphismFromLiftingObject
                ],
[ LiftingObject, { category, o } -> Range( DeflationFromSomeExactProjectiveObject( o ) ) ],
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
