# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#
##
InstallOtherMethod_for_julia( CreateComplex,
          [ IsHomotopyCategory, IsJuliaObject, IsInt ] );

InstallOtherMethod_for_julia( CreateComplexMorphism,
          [ IsHomotopyCategory, IsHomotopyCategoryObject, IsJuliaObject, IsInt, IsHomotopyCategoryObject ] );

InstallOtherMethod_for_julia( CreateComplexMorphism,
          [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsJuliaObject, IsInt ] );

InstallOtherMethod_for_julia( IrreducibleMorphisms, [ IsCapFullSubcategory, IsJuliaObject ] );
InstallOtherMethod_for_julia( CompositeMorphisms, [ IsCapFullSubcategory, IsJuliaObject ] );
