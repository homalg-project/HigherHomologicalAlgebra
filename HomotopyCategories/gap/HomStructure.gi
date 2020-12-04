# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Implementations
#

##
InstallGlobalFunction( ADD_HOM_STRUCTURE_TO_HOMOTOPY_CATEGORY_OVER_CHAINS,

  function( homotopy_category )
    local chains, cat, range_cat, distinguished_object;
    
    chains := UnderlyingCategory( homotopy_category );
    
    cat := UnderlyingCategory( chains );
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );

    if HasIsAbelianCategory( range_cat ) and IsAbelianCategory( range_cat ) then
      
      AddDistinguishedObjectOfHomomorphismStructure( homotopy_category,
        
        {} -> distinguished_object
      );
      
      AddHomomorphismStructureOnObjects( homotopy_category,
        function ( C, D )
          local d;
          
          d := DoubleChainComplexByHomStructure(
                  UnderlyingCell( C ),
                  UnderlyingCell( D )
                );
                
          return HomologyAt( TotalComplex( d ), 0 );
          
      end );
      
      AddHomomorphismStructureOnMorphismsWithGivenObjects( homotopy_category,
        
        function( s, phi, psi, r )
          local dSource, dRange, dMap, tMap;
          
          dSource := DoubleChainComplexByHomStructure(
                        UnderlyingCell( Range( phi ) ),
                        UnderlyingCell( Source( psi ) )
                      );
                      
          dRange := DoubleChainComplexByHomStructure(
                        UnderlyingCell( Source( phi ) ),
                        UnderlyingCell( Range( psi ) )
                      );
                      
          dMap := DoubleChainMorphism(
                      dSource,
                      dRange,
                      { i, j } -> HomStructure( phi[ -i ], psi[ j ] )
                    );
                    
          tMap := TotalMorphism( dMap );
          
          return HomologyFunctorialAt( tMap, 0 );
          
        end );
      
      AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( homotopy_category,
        function( phi )
          local l, u, morphisms, morphism, T, inc, i;
          
          l := ActiveLowerBoundForSourceAndRange( UnderlyingCell( phi ) );
          
          u := ActiveUpperBoundForSourceAndRange( UnderlyingCell( phi ) );
          
          morphisms:= [  ];
          
          for i in Reversed( [ l .. u ] ) do
            
            Add( morphisms,
                InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( phi[ i ] )
              );
          
          od;
          
          if IsEmpty( morphisms) then
            
            morphism := UniversalMorphismIntoZeroObject(  );
            
          else
            
            morphism := MorphismBetweenDirectSums( [ morphisms] );
            
          fi;
          
          T := TotalComplex(
                  DoubleChainComplexByHomStructure(
                        UnderlyingCell( Source( phi ) ),
                        UnderlyingCell( Range( phi ) )
                      )
                );
                
          Assert( 3, IsZero( PreCompose( morphism, T^0 ) ) );
          
          inc := KernelLift( T^0, BoundariesAt( T, 0 ) );
          
          return PreCompose(
                    KernelLift( T^0, morphism ),
                    CokernelProjection( inc )
                  );
                  
      end );
      
      AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( homotopy_category,
        
        function( C, D, psi )
          local l, u, T, phi, struc_on_objects, indices, L, i;
          
          l := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) );
          
          u := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) );
          
          T := TotalComplex(
                    DoubleChainComplexByHomStructure(
                        UnderlyingCell( C ),
                        UnderlyingCell( D )
                      )
                  );
          
          phi := PreCompose( psi, HonestRepresentative( GeneralizedEmbeddingOfHomologyAt( T, 0 ) ) );
          
          struc_on_objects := [  ];
          
          indices := Reversed( [ l .. u ] );
          
          for i in indices do
            
            Add( struc_on_objects, HomomorphismStructureOnObjects( C[ i ], D[ i ] ) );
            
          od;
          
          L := List( [ 1 .. Length( indices ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );
          
          L := List( L, l -> PreCompose( phi, l ) );
          
          L := List( [ 1 .. Length( indices ) ],
                 i -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C[ indices[i] ], D[ indices[i] ], L[i] ) );
                 
          return HomotopyCategoryMorphism( C, D, Reversed( L ), l );
          
      end );
      
    fi;
    
end );
