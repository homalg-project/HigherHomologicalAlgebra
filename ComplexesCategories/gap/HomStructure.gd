# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#

DeclareOperation( "DoubleChainComplexByHomStructure", [ IsChainComplex, IsChainComplex ] );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_CHAINS" );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS" );

DeclareGlobalFunction( "ADD_INTERPRET_CHAIN_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE" );

DeclareGlobalFunction( "ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_CHAIN_MORPHISM" );

DeclareGlobalFunction( "ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_FOR_CHAINS" );

DeclareOperation( "DoubleCochainComplexByHomStructure", [ IsCochainComplex, IsCochainComplex ] );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_COCHAINS" );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_COCHAINS_MORPHISMS" );

DeclareGlobalFunction( "ADD_INTERPRET_COCHAIN_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE" );

DeclareGlobalFunction( "ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_COCHAIN_MORPHISM" );

DeclareGlobalFunction( "ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_FOR_COCHAINS" );
