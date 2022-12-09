# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#



InstallOtherMethod_for_julia( CreateComplex,
          [ IsChainOrCochainComplexCategory, IsJuliaObject, IsInt ] );

InstallOtherMethod_for_julia( CreateComplexMorphism,
          [ IsChainOrCochainComplexCategory, IsChainOrCochainComplex, IsChainOrCochainComplex, IsJuliaObject, IsInt ] );

InstallOtherMethod_for_julia( CreateComplexMorphism,
          [ IsChainOrCochainComplex, IsChainOrCochainComplex, IsJuliaObject, IsInt ] );

