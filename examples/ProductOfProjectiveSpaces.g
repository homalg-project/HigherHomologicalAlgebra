LoadPackage( "GradedRingForHomalg" );
LoadPackage( "Freyd" );
LoadPackage( "GradedModulePresentations" );

ReadPackage( "StableCategories", "/examples/HomStructureForGradedRows.g" );


CoxRingOfProductOfProjectiveSpaces := function( L )
  local homalg_field, variables, variables_strings, factor_rings, weights, S, irrelevant_ideal, ring_maps;

  homalg_field := HomalgFieldOfRationalsInSingular(  );

  if Length( L ) > 7 then
    return fail;
  fi;

  variables := [ "x_", "y_", "z_", "s_", "t_", "u_", "w_" ];

  ring_maps := List( [ 1 .. Length( L ) ],
  
    k -> JoinStringsWithSeparator( Concatenation( List( [ 1 .. Length( L ) ],
    
        i -> List( [ 0 .. L[ i ] ], function( j )
        
                                      if i = k then

                                        return Concatenation( variables[ i ], String( j ) );

                                      else
                                        
                                        return "1";
                                      
                                      fi;

                                    end ) ) ), "," ) );

  variables_strings := List( [ 1 .. Length( L ) ],
        i -> List( [ 0 .. L[ i ] ], j -> Concatenation( variables[ i ], String( j ) ) ) );
  
  variables := List( variables_strings, v -> JoinStringsWithSeparator(v,",") );
  
  factor_rings := List( variables, v -> GradedRing( homalg_field * v ) );
  
  weights := IdentityMat( Length( L ) );
  
  weights := List( [ 1 .. Length( L ) ], i -> List( [ 0 .. L[ i ] ], j -> weights[ i ] ) );
  
  weights := Concatenation( weights );
  
  variables := JoinStringsWithSeparator( variables, "," );
  
  S := GradedRing( homalg_field * variables );
  
  List( factor_rings, WeightsOfIndeterminates );
  
  S!.factor_rings := factor_rings;
  
  SetWeightsOfIndeterminates( S, weights );
  
  variables := List( variables_strings, V -> List( V, v -> v/S ) );
  
  irrelevant_ideal := Iterated( variables, function( V1, V2 ) return ListX( V1, V2, \* ); end );
  
  S!.irrelevant_ideal := HomalgMatrix( irrelevant_ideal, Length( irrelevant_ideal ), 1, S );
  
  ring_maps := List( [ 1 .. Length( L ) ], k -> HomalgMatrix( ring_maps[ k ], Sum( L ) + Length( L ), 1, S!.factor_rings[ k ]  ) );
  
  ring_maps := List( [ 1 .. Length( L ) ], k -> RingMap( ring_maps[ k ], S, S!.factor_rings[ k ] ) );
  
  S!.ring_maps := ring_maps;
  
  return S;
  
end;

DeclareAttribute( "AnnihilatorOfGradedLeftPresentation", IsGradedLeftPresentation );

InstallMethod( AnnihilatorOfGradedLeftPresentation,
  [ IsGradedLeftPresentation ],
function( M )
  local mat, S, F, n, Id, L, ann, f, g;

  mat := UnderlyingMatrix( M );
  S := UnderlyingHomalgRing( M );
  F := FreeLeftPresentation( 1, S );
  n := NrCols( mat );
  Id := HomalgIdentityMatrix( n, S );
  L := List( [ 1 .. n ], i -> CertainRows( Id, [ i ] ) );
  L := List( L, l -> PresentationMorphism( F, l, UnderlyingPresentationObject( M ) ) );
  ann := List( L, KernelEmbedding );
  ann := List( ann, UnderlyingMatrix );

  if ForAny( ann, a -> NrRows( a ) = 0 ) then

    return HomalgZeroMatrix( 0, 1, S );

  else

    f := ann[ 1 ];
    for g in ann{ [ 2 .. n ] } do
      f := SyzygiesOfRows( g, f ) * g;
    od;
    return f;

  fi;

end );


S := CoxRingOfProductOfProjectiveSpaces( [1,2] );
TRY_TO_ENHANCE_HOMALG_GRADED_RING_WITH_RANDOM_FUNCTIONS2( S );

rows := CAPCategoryOfGradedRows( S : FinalizeCategory := false );
SetFieldForHomomorphismStructure( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
AddHomomorphismStructureOnCategory( rows );
AddRandomMethodsToGradedRows( rows );
SetIsProjective( DistinguishedObjectOfHomomorphismStructure( rows ), true );
Finalize( rows );

graded_lp_cat := GradedLeftPresentations( S );

#KeyDependentOperation( "EmbeddingOfPowerOfIrrelevantIdeal", IsHomalgGradedRing, IsInt, ReturnTrue );
#InstallMethod( EmbeddingOfPowerOfIrrelevantIdealOp,
#  [ IsHomalgGradedRing, IsInt ],
#  function( S, n )
#    local F, irr, syz, func, entries, degrees, range, power;
#
#    F := GradedRow( [ [ Degree( One( S ) ), 1 ] ], S );
#    
#    irr := S!.irrelevant_ideal;
#    
#    syz := SyzygiesOfRows( irr );
#    
#    func := function( e )
#              local ev, list_of_coeff, monomials;
#              if IsZero( e ) then
#                return e;
#              fi;
#              ev := EvalRingElement( e );
#              list_of_coeff := EntriesOfHomalgMatrix( Coefficients( ev ) );
#              list_of_coeff := List( list_of_coeff, c -> String(c)/S );
#              monomials := List( Coefficients( ev )!.monomials, m -> String( m )/S );
#              monomials := List( monomials, m -> m^n );
#              return list_of_coeff * monomials;
#            end;
#            
#    entries := EntriesOfHomalgMatrix( syz );
#    
#    entries := List( entries, func );
#    
#    syz := HomalgMatrix( entries, NrRows( syz ), NrCols( syz ), S );
#
#    entries := EntriesOfHomalgMatrix( irr );
#    
#    entries := List( entries, e -> e^n );
#    
#    irr := HomalgMatrix( entries, NrRows( irr ), NrCols( irr ), S );
#    
#    degrees := ListWithIdenticalEntries( NrCols( syz ), -Degree( MatElm( irr, 1, 1 ) ) );
#    
#    range := GradedRow( List( degrees, d -> [ d, 1 ] ),  S );
#    
#    power := DeduceSomeMapFromMatrixAndRangeForGradedRows( syz, range );
#    
#    irr := GradedRowOrColumnMorphism( range, irr, F );
#    
#    return FreydCategoryMorphism( FreydCategoryObject( power ), irr,  AsFreydCategoryObject( F ) );
#    
#end );
#
## the embedding of B^n+1 in B^n, B^0 = S
#
#KeyDependentOperation( "EmbeddingOfSuccessivePowersOfIrrelevantIdeal", IsHomalgGradedRing, IsInt, ReturnTrue );
#InstallMethod( EmbeddingOfSuccessivePowersOfIrrelevantIdealOp,
#  [ IsHomalgGradedRing, IsInt ],
#
#  function( S, n )
#    local irr, H, a, b;
#    
#    if n = 0 then
#      
#      return EmbeddingOfPowerOfIrrelevantIdeal( S, 1 );
#      
#    fi;
#    
#    irr := EntriesOfHomalgMatrix( S!.irrelevant_ideal );
#    
#    H := HomalgDiagonalMatrix( irr );
#    
#    a := Source( EmbeddingOfPowerOfIrrelevantIdeal( S, n + 1 ) );
#    
#    b := Source( EmbeddingOfPowerOfIrrelevantIdeal( S, n ) );#
#    
#    H := GradedRowOrColumnMorphism( Range( RelationMorphism( a ) ), H, Range( RelationMorphism( b ) ) );
#    
#    return FreydCategoryMorphism( a, H, b );
#    
#end );
#
#
#test_sat_cochain :=
#     function( M )
#       local S, maps;
#
#       S := UnderlyingHomalgGradedRing( RelationMorphism( M ) );
#       
#       maps := MapLazy( IntegersList,
#          
#          function( i )
#
#            if i <= -1 then
#              
#              return fail;
#
#            else
#
#              return HomomorphismStructureOnMorphisms( EmbeddingOfSuccessivePowersOfIrrelevantIdealOp( S, i ), IdentityMorphism( M ) );
#
#            fi; end, 1 );
#
#      return maps;
#end;


