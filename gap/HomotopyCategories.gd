############################################################################
#                                     GAP package
#
#  Copyright 2017,                    Kamal Saleh
#                                     Siegen University
#
#! @Chapter HomotopyCategories
#
#############################################################################


DeclareCategory( "IsHomotopyCategory",
                 IsStableCategory );

DeclareAttribute( "HomotopyCategory", IsCapCategory );

DeclareAttribute( "TotalComplexUsingMappingCone", IsChainComplex );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_CHAINS_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_ON_CHAINS_MORPHISMS_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_INTERPRET_MORPHISM_AS_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_INTERPRET_MORPHISM_FROM_DISTINGUISHED_OBJECT_TO_HOMOMORPHISM_STRUCTURE_AS_MORPHISM_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_DISTINGUISHED_OBJECT_OF_HOMOMORPHISM_STRUCTURE_IN_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "ADD_HOM_STRUCTURE_TO_HOMOTOPY_CATEGORY" );

DeclareGlobalFunction( "IS_COLIFTABLE_THROUGH_COLIFTING_OBJECT_IN_HOMOTOPY_CATEGORY" );

if not IsBound( RANDOM_TEXT_ATTR ) then
  
  ##
  DeclareGlobalFunction( "RANDOM_TEXT_ATTR" );
  
  ##
  InstallGlobalFunction( RANDOM_TEXT_ATTR,
    function (  )
      return [ Random( [ "\033[31m", "\033[32m", "\033[33m", "\033[34m", "\033[35m",
                #" \033[41m", " \033[42m", " \033[43m", " \033[44m", " \033[45m", " \033[46m", " \033[4m"
                ] ), "\033[0m" ];
  end );
  
fi;

