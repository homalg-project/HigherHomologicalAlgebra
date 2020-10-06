# SPDX-License-Identifier: GPL-2.0-or-later
# BBGG: Beilinson monads and derived categories for coherent sheaves over P^n
#
# Declarations
#

#! @Arguments S
#! The input is a graded polynomial ring $S=k[x_0,\dots,x_m]$ and the output is the category of coherent sheaves over $\mathbb{P}^m$. 
#! @Returns a CAP category
DeclareAttribute( "CoherentSheavesOverProjectiveSpace", IsHomalgGradedRing );

DeclareAttribute( "SheafificationFunctor", IsCapCategory );

KeyDependentOperation( "TwistedStructureSheaf", IsHomalgGradedRing, IsInt, ReturnTrue );

DeclareOperation( "BasisBetweenTwistedStructureSheaves",
      [ IsHomalgGradedRing, IsInt, IsInt ] );

KeyDependentOperation( "TwistedCotangentSheaf", IsHomalgGradedRing, IsInt, ReturnTrue );

DeclareOperation( "BasisBetweenTwistedCotangentSheaves",
      [ IsHomalgGradedRing, IsInt, IsInt ] );


DeclareAttribute( "FullSubcategoryGeneratedByTwistsOfStructureSheaf",
      IsHomalgGradedRing );

DeclareAttribute( "FullSubcategoryGeneratedByTwistedCotangentSheaves",
      IsHomalgGradedRing );

