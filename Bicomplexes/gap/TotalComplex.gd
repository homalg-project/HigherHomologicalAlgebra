# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# Declarations
#



DeclareAttribute( "TotalComplex", IsChainOrCochainBicomplex );
DeclareOperation( "TotalComplexFunctorial", [ IsChainOrCochainComplex, IsChainOrCochainBicomplexMorphism, IsChainOrCochainComplex ] );
