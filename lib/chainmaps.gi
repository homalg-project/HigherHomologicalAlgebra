########################################
#
# Representations, families and types
#
########################################


DeclareRepresentation( "IsChainMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfChainMorphisms",
            NewFamily( "chain morphisms" ) );

BindGlobal( "TheTypeOfChainMorphism",
            NewType( FamilyOfChainMorphisms, 
                     IsChainMorphism and IsChainMorphismRep ) );

DeclareRepresentation( "IsCochainMorphismRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfCochainMorphisms",
            NewFamily( "cochain morphisms" ) );

BindGlobal( "TheTypeOfCochainMorphism",
            NewType( FamilyOfCochainMorphisms, 
                     IsCochainMorphism and IsCochainMorphismRep ) );

#########################################
#
# (Co)chain morphisms constructors 
#
#########################################

BindGlobal( "CHAIN_OR_COCHAIN_MORPHISM_BY_LIST",
     function( C1, C2, morphisms )
     local map;

     map := rec( );

     if ForAll( [ C1, C2 ], IsChainComplex ) then 

           ObjectifyWithAttributes( map, TheTypeOfChainMorphism,

                           Source, C1,

                           Range, C2,

                           Morphisms, morphisms );
        
           if ForAll( [ C1, C2 ], IsFiniteChainComplex ) then 
          
              SetFilterObj( map, IsFiniteChainMorphism );

           fi;

     elif ForAll( [ C1, C2 ], IsCochainComplex ) then 

        ObjectifyWithAttributes( map, TheTypeOfCochainMorphism,

                           Source, C1,

                           Range, C2,

                           Morphisms, morphisms );

        if ForAll( [ C1, C2 ], IsFiniteCochainComplex ) then 
          
           SetFilterObj( map, IsFiniteCochainMorphism );

        fi;

     else

        Error( "first and second argument should be both chains or cochains" );

     fi;

     Add( CapCategory( C1 ), map );

     map!.ListOfComputedMorphisms := [ ];
     
     return map;

end );


