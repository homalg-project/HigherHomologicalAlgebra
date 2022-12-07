# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of graded (co)chain complexes of an additive category
#
# Declarations
#

####################

DeclareCategory( "IsDgChainOrCochainComplexCategory", IsCapCategory );
DeclareCategory( "IsBoundedDgChainOrCochainComplexCategory", IsDgChainOrCochainComplexCategory );

DeclareCategory( "IsDgChainComplexCategory", IsDgChainOrCochainComplexCategory );
DeclareCategory( "IsDgBoundedChainComplexCategory", IsBoundedDgChainOrCochainComplexCategory );

DeclareCategory( "IsDgCochainComplexCategory", IsDgChainOrCochainComplexCategory );
DeclareCategory( "IsDgBoundedCochainComplexCategory", IsBoundedDgChainOrCochainComplexCategory );

####################

DeclareAttribute( "DgChainComplexCategory", IsCapCategory );

DeclareAttribute( "DgCochainComplexCategory", IsCapCategory );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsDgChainOrCochainComplexCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareGlobalFunction( "ADD_BASIC_FUNCTIONS_TO_DG_COCHAIN_COMPLEX_CATEGORY" );
