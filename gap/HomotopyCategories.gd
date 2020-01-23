############################################################################
#                                     GAP package
#
#  Copyright 2020,                    Kamal Saleh
#                                     Siegen University
#
#! @Chapter HomotopyCategories
#
#############################################################################

InfoHomotopyCategories := NewInfoClass( "InfoHomotopyCategories" );

SetInfoLevel( InfoHomotopyCategories, 1 );

DeclareCategory( "IsHomotopyCategory",
                 IsStableCategory );

DeclareAttribute( "HomotopyCategory", IsCapCategory );

DeclareAttribute( "DefiningCategory", IsHomotopyCategory );

DeclareAttribute( "TotalComplexUsingMappingCone", IsChainComplex );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_CHAINS_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_TO_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "IS_COLIFTABLE_THROUGH_COLIFTING_OBJECT_IN_HOMOTOPY_CATEGORY" );

