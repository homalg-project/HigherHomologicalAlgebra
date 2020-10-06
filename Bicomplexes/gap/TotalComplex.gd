# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# Declarations
#

# These are only for internal use
DeclareGlobalFunction( "TOTAL_CHAIN_COMPLEX_GIVEN_ABOVE_RIGHT_BOUNDED_HOMOLOGICAL_BICOMPLEX" );
DeclareGlobalFunction( "TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_LEFT_BOUNDED_HOMOLOGICAL_BICOMPLEX" );
DeclareGlobalFunction( "TOTAL_CHAIN_COMPLEX_GIVEN_BELOW_ABOVE_BOUNDED_HOMOLOGICAL_BICOMPLEX" );
DeclareGlobalFunction( "TOTAL_CHAIN_COMPLEX_GIVEN_LEFT_RIGHT_BOUNDED_HOMOLOGICAL_BICOMPLEX" );

KeyDependentOperation( "IndicesUsedToComputeTotalComplexOfBicomplexAt", IsCapCategoryBicomplexObject, IsInt, ReturnTrue );

