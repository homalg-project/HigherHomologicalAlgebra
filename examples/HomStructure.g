LoadPackage( "LinearAlgebraForCAP" );
LoadPackage( "NConvex" );
LoadPackage( "GradedModuleP" );
LoadPackage( "ComplexesForCAP" );
LoadPackage( "Frey" );

add_random_methods_to_graded_rows := function( S )
  local category;
  
  category := CAPCategoryOfGradedRows( S: FinalizeCategory := false );
  
  AddRandomObjectByList( category,
    function( category, L )
      local degree_list;
      degree_list := List( [ 1 .. L[1] ], i -> [ Random( L[2] ), 1 ] );
      return GradedRow( degree_list, S );
  end );
  
  AddRandomMorphismWithFixedSourceByList( category,
    function( a, L )
      local degrees_a, degrees_b, b, mat;
      degrees_a := UnzipDegreeList( a );
      degrees_b := List( L, l -> [ l, 1 ] );
      b := GradedRow( degrees_b, S );
      degrees_b := UnzipDegreeList( b );
      mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
      return GradedRowOrColumnMorphism( a, mat, b );
    end );

  AddRandomMorphismWithFixedRangeByList( category,
    function( b, L )
      local degrees_a, degrees_b, a, mat;
      degrees_b := UnzipDegreeList( b );
      degrees_a := List( L, l -> [ l, 1 ] );
      a := GradedRow( degrees_a, S );
      degrees_a := UnzipDegreeList( a );
      mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
      return GradedRowOrColumnMorphism( a, mat, b );
    end );
  
  AddRandomMorphismWithFixedSourceAndRangeByList( category,
    function( a, b, L )
      local degrees_a, degrees_b, mat;
      degrees_a := UnzipDegreeList( a );
      degrees_b := UnzipDegreeList( b );
      mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
      return GradedRowOrColumnMorphism( a, mat, b );
    end );
  
  AddRandomMorphismByList( category,
    function( category, L )
      local degrees_a, degrees_b, a, b, mat;
      degrees_a := List( [ 1 .. L[ 1 ] ], i -> [ Random( L[ 3 ] ), 1 ] );
      degrees_b := List( [ 1 .. L[ 2 ] ], i -> [ Random( L[ 4 ] ), 1 ] );
      a := GradedRow( degrees_a, S );
      b := GradedRow( degrees_b, S );
      degrees_a := UnzipDegreeList( a );
      degrees_b := UnzipDegreeList( b );
      mat := S!.random_matrix_between_free_left_presentations_func( -degrees_a, -degrees_b );
      return GradedRowOrColumnMorphism( a, mat, b );
    end );
    
end;


DeclareOperation( "BasisOfExternalHom", [ IsCapCategoryObject, IsCapCategoryObject ] );
DeclareAttribute( "FieldOfExternalHom", IsCapCategory );
DeclareAttribute( "CoefficientsOfLinearMorphism", IsCapCategoryMorphism );
DeclareOperation( "MultiplyWithHomalgRingElement", [ IsMultiplicativeElement, IsCapCategoryMorphism ] );

##
AddHomomorphismStructureOnCategory :=
  function( cat )
    local field;
    
    field := FieldOfExternalHom( cat );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
      function( a, b )
        local dimension;
        
        dimension := Length( BasisOfExternalHom( a, b ) );
        
        return VectorSpaceObject( dimension, field );
    
    end );
    
    #          alpha
    #      a --------> a'     s = H(a',b) ---??--> r = H(a,b')
    #      |           |
    # alpha.h.beta     h
    #      |           |
    #      v           v
    #      b' <------- b
    #          beta
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
      function( s, alpha, beta, r )
        local B, mat;
        
        B := BasisOfExternalHom( Range( alpha ), Source( beta ) );
        
        B := List( B, b -> PreCompose( [ alpha, b, beta ] ) );
        
        B := List( B, CoefficientsOfLinearMorphism );
        
        # Improve this
        if Dimension( s ) * Dimension( r ) = 0 then
          
          mat := HomalgZeroMatrix( Dimension( s ), Dimension( r ), field );
        
        else
          
          mat := HomalgMatrix( B, Dimension( s ), Dimension( r ), field );
        
        fi;
        
        return VectorSpaceMorphism( s, mat, r );
    
    end );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
      function( )
        
        return VectorSpaceObject( 1, field );
    
    end );
    
    ##
    AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( cat,
      function( alpha )
        local coeff, D;
        
        coeff := CoefficientsOfLinearMorphism( alpha );
        
        coeff := HomalgMatrix( coeff, 1, Length( coeff ), field );
        
        D := VectorSpaceObject( 1, field );
        
        return VectorSpaceMorphism( D, coeff, VectorSpaceObject( NrCols( coeff ), field ) );
    
    end );
    
    AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( cat,
      function( a, b, iota )
        local mat, coeff, B, L;
        
        mat := UnderlyingMatrix( iota );
        
        coeff := EntriesOfHomalgMatrix( mat );
        
        B := BasisOfExternalHom( a, b );
        
        L := List( [ 1 .. Length( coeff ) ], i -> MultiplyWithHomalgRingElement( coeff[ i ], B[ i ] ) );
        
        if L = [  ] then
          
          return ZeroMorphism( a, b );
        
        else
          
          return Sum( L );
        
        fi;
    
    end );

end;


## Examples: Matrix category
InstallMethodWithCrispCache( BasisOfExternalHom,
            [ IsVectorSpaceObject, IsVectorSpaceObject ],
  function( a, b )
    local field, dim_a, dim_b, L, i;
    
    field := UnderlyingFieldForHomalg( a );
    
    dim_a := Dimension( a );
    
    dim_b := Dimension( b );
    
    L := List( [ 1 .. dim_a * dim_b ],
           i -> ListWithIdenticalEntries( dim_a * dim_b, Zero( field ) ) );
    
    for i in [ 1 .. dim_a * dim_b ] do
      
      L[ i ][ i ] := One( field );
    
    od;
    
    L := List( L, l -> HomalgMatrix( l, dim_a, dim_b, field ) );
    
    L := List( L, l -> VectorSpaceMorphism( a, l, b ) );
    
    return L;
    
end );

InstallMethodWithCrispCache( CoefficientsOfLinearMorphism,
            [ IsVectorSpaceMorphism ],
  function( alpha )
    local mat;
    
    mat := UnderlyingMatrix( alpha );
    
    return EntriesOfHomalgMatrix( mat );
    
end );

InstallMethod( MultiplyWithHomalgRingElement,
            [ IsMultiplicativeElement, IsVectorSpaceMorphism ],
  function( e, alpha )
    
    return e * alpha;
    
end );

Q := HomalgFieldOfRationals(  );
cat := MatrixCategory( Q : FinalizeCategory := false );
SetFieldOfExternalHom( cat, Q );

AddHomomorphismStructureOnCategory( cat );
Finalize( cat );

## Example: Graded rows over Cox ring of product of projective spaces
LoadPackage( "FreydCategoriesForCAP" );

basis_of_external_hom_from_tensor_unit2 := function( M )
  local S, indeterminates, weights_of_indeterminates, D, G, dG, func, positions, L, mats, current_mat, U, i;
  
  S := UnderlyingHomalgGradedRing( M );
  indeterminates := Indeterminates( S );

  weights_of_indeterminates := WeightsOfIndeterminates( S );
  D := List( weights_of_indeterminates, UnderlyingMorphism );
  D := List( D, d -> MatrixOfMap( d ) );
  D := Involution( UnionOfRows( D ) );
  D := EntriesOfHomalgMatrixAsListList( D );
 
  G := UnzipDegreeList( M );
  G := List( G, UnderlyingMorphism );
  G := List( G, MatrixOfMap );
  G := List( G, EntriesOfHomalgMatrix );
  G := List( G, g -> List( g, HomalgElementToInteger ) );
  dG := DuplicateFreeList( G );

  func := function( degree )
            local solutions;
            solutions := 4ti2Interface_zsolve_equalities_and_inequalities_in_positive_orthant( D, degree, [], [] )[ 1 ];
            return List( solutions, sol -> Product( ListN( indeterminates, sol, \^ )  ) );
        end;

  dG := List( dG, d -> func( d ) );

  positions := List( DuplicateFreeList( G ), d -> Positions( G, d ) );
  L := ListWithIdenticalEntries( Length( G ), 0 );
  List( [ 1 .. Length( dG ) ], i -> List( positions[ i ], function( p ) L[p] := dG[i]; return 0; end ) );
  
  mats := [  ];

  for i in [ 1 .. Length( L ) ] do
    
    current_mat := ListWithIdenticalEntries( Length( G ), [ Zero( S ) ] );

    current_mat[ i ] := L[ i ];

    if not IsZero( current_mat ) then

      mats := Concatenation( mats, Cartesian( current_mat ) );

    fi;

  od;

  return mats;

end;


basis_of_external_hom_from_tensor_unit := function( M )
  local S, weights, n, variables, G, dG, positions, L, mats, current_mat, U, i;

  S := UnderlyingHomalgGradedRing( M );
  weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
  n := Length( weights );
  variables := List( weights,  w -> Filtered( Indeterminates( S ), ind -> Degree( ind ) =   w ) );
  weights := List( weights, w -> 
               List( EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( w ) ) ), HomalgElementToInteger ) );
  
  G := UnzipDegreeList( M );
  G := List( G, UnderlyingMorphism );
  G := List( G, MatrixOfMap );
  G := List( G, EntriesOfHomalgMatrix );
  G := List( G, g -> List( g, HomalgElementToInteger ) );
  dG := DuplicateFreeList( G );
  dG := List( dG, g -> SolutionIntMat( weights, g ) );
  dG := List( dG, function( g )
                    if ForAny( g, i -> i < 0 ) then
                      return  [ [ Zero( S )  ] ];
                    fi;
                    return List( [ 1 .. n ], 
                             i -> List( UnorderedTuples( variables[ i ], g[ i ] ),
                                    l -> Product( l ) * One( S ) ) );
                  end );
  dG := List( dG, g ->
           Iterated( g, 
             function( l1, l2 )
               return ListX( l1, l2, \* );
             end ) );

  positions := List( DuplicateFreeList( G ), d -> Positions( G, d ) );
  L := ListWithIdenticalEntries( Length( G ), 0 );
  List( [ 1 .. Length( dG ) ], i -> List( positions[ i ], function( p ) L[p] := dG[i]; return 0; end ) );
  
  mats := [  ];

  for i in [ 1 .. Length( L ) ] do
    
    current_mat := ListWithIdenticalEntries( Length( G ), [ Zero( S ) ] );

    current_mat[ i ] := L[ i ];

    if not IsZero( current_mat ) then

      mats := Concatenation( mats, Cartesian( current_mat ) );

    fi;

  od;

  U := TensorUnit( CapCategory( M ) );

  return List( mats, mat -> GradedRowOrColumnMorphism( U, HomalgMatrix( mat, Rank( U ), Rank( M ), S ), M ) );
end;

#
InstallMethod( BasisOfExternalHom,
            [ IsGradedRowOrColumn, IsGradedRowOrColumn ],
  function( a, b )
    local hom_a_b, B;
    hom_a_b := InternalHomOnObjects( a, b );
    B := basis_of_external_hom_from_tensor_unit( hom_a_b );
    return List( B, mor -> InternalHomToTensorProductAdjunctionMap( a, b, mor) );
end );

InstallMethod( CoefficientsOfLinearMorphism,
            [ IsGradedRowOrColumnMorphism ],
  function( phi )
    local category, K, a, b, U, psi, hom_a_b, B, A, sol;
    
    category := CapCategory( phi );
    
    K := FieldOfExternalHom( category );
    
    a := Source( phi );
    
    b := Range( phi );
    
    if Rank( a ) = 0 or Rank( b ) = 0 then
      
      return [  ];
    
    fi;
    
    U := TensorUnit( category );
    
    psi := TensorProductToInternalHomAdjunctionMap( U, a, phi );
    
    hom_a_b := Range( psi );
    
    B := BasisOfExternalHom( U, hom_a_b );
    
    if B = [  ] then
      
      return [  ];

    fi;
    
    B := UnionOfRows( List( B, UnderlyingHomalgMatrix) );
    
    A := UnderlyingHomalgMatrix( psi );
    
    # XB = A
    sol := RightDivide( A, B );
    
    sol := EntriesOfHomalgMatrix( sol );
    
    return List( sol, s -> s/K );
    
end );

InstallMethod( MultiplyWithHomalgRingElement,
            [ IsMultiplicativeElement, IsGradedRowOrColumnMorphism ],
  function( e, alpha )
    local S, mat;
    
    S := UnderlyingHomalgGradedRing( alpha );
    
    mat := e/S * UnderlyingHomalgMatrix( alpha );
    
    return GradedRowOrColumnMorphism( Source( alpha ), mat, Range( alpha ) );
    
end );

hom_struc_on_objects := function( C, D )
          local chains, cat, H, V, d;
          
          chains := CapCategory( C );
          cat := UnderlyingCategory( chains );
          if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( D ) ) then 
             if not ( HasActiveUpperBound( C ) and HasActiveLowerBound( D ) ) then
                if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( C ) ) then
                    if not ( HasActiveLowerBound( D ) and HasActiveUpperBound( D ) ) then
                       Error( "The complexes should be bounded" );
                    fi;
                fi;
             fi;
          fi;
          
          H := function( i, j )
                 if ( i + j  + 1 ) mod 2 = 0 then 
                   return  HomomorphismStructureOnMorphisms( C^( -i + 1 ), IdentityMorphism( D[ j ] ) );
                 else
                   return AdditiveInverse( HomomorphismStructureOnMorphisms( C^( -i + 1 ), IdentityMorphism( D[ j ] ) ) );
                 fi;
               end;
          
          V := function( i, j )
                 return HomomorphismStructureOnMorphisms( IdentityMorphism( C[ -i ] ), D^j );
               end;
          
          d := DoubleChainComplex( MatrixCategory( FieldOfExternalHom( cat ) ), H, V );
          
          AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ], function( ) SetLeftBound( d, -ActiveUpperBound( C ) + 1 ); end ) );
          AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ], function( ) SetRightBound( d, -ActiveLowerBound( C ) - 1 ); end ) );
          AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAU_BOUND", true ] ], function( ) SetAboveBound( d, ActiveUpperBound( D ) - 1 ); end ) );
          AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAL_BOUND", true ] ], function( ) SetBelowBound( d, ActiveLowerBound( D ) + 1 ); end ) );
      
      return TotalChainComplex( d );

end;


hom_struc_on_morphisms :=
         function( phi, psi )
           local source, range, ss, rr, l;
           
           source := hom_struc_on_objects( Range( phi ), Source( psi ) );
           
           range := hom_struc_on_objects( Source( phi ), Range( psi ) );
           
           ss := source!.UnderlyingDoubleComplex;
           
           rr := range!.UnderlyingDoubleComplex;
           
           l := MapLazy( IntegersList, function( m )
                                         local ind_s, ind_t, morphisms, obj;
                                         
                                         obj := ObjectAt( source, m );
                                         obj := ObjectAt( range, m );
                                         ind_s := ss!.IndicesOfTotalComplex.( String( m ) );
                                         ind_t := rr!.IndicesOfTotalComplex.( String( m ) );
                                         morphisms := List( [ ind_s[ 1 ] .. ind_s[ 2 ] ], 
                                                              function( i )
                                                                return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                                                                             function( j )
                                                                               if i=j then 
                                                                                 return HomomorphismStructureOnMorphisms( phi[ -i ], psi[ m - i ] );
                                                                               else
                                                                                 return ZeroMorphism( ObjectAt( ss, i, m - i ), ObjectAt( rr, j, m - j ) );
                                                                               fi;
                                                                             end );
                                                              end );
                                         return MorphismBetweenDirectSums( morphisms );
                                       end, 1 );

           return ChainMorphism( source, range, l );
         
end;

morphism_to_dis_to_hom_struc :=
      function( phi )
        local C, D, lower_bound, upper_bound, morphisms_from_distinguished_object, morphism, hom_C_D, i;
        
        C := Source( phi );
        D := Range( phi );
        
        lower_bound := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) ) + 1;
        upper_bound := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) ) - 1;
        
        morphisms_from_distinguished_object := [  ];
        
        for i in [ lower_bound .. upper_bound ] do
          
          Add( morphisms_from_distinguished_object, InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( phi[ i ] ) );
        
        od;
        
        morphism := MorphismBetweenDirectSums( [ morphisms_from_distinguished_object ] );
        
        hom_C_D := hom_struc_on_objects( C, D );

        return KernelLift( hom_C_D^0, morphism );   
    
end;

dis_to_hom_struc_to_morphism :=
    function( C, D, psi )
      local lower_bound, upper_bound, hom_C_D, phi, struc_on_objects, L, i;

      lower_bound := Minimum( ActiveLowerBound( C ), ActiveLowerBound( D ) ) + 1;
      upper_bound := Maximum( ActiveUpperBound( C ), ActiveUpperBound( D ) ) - 1;

      hom_C_D := hom_struc_on_objects( C, D );

      phi := PreCompose( psi, CyclesAt( hom_C_D, 0 ) );

      struc_on_objects := [  ];

      for i in [ lower_bound .. upper_bound ] do

        Add( struc_on_objects, HomomorphismStructureOnObjects( C[ i ], D[ i ] ) );

      od;

      L := List( [ 1 .. Length( struc_on_objects ) ], i -> ProjectionInFactorOfDirectSum( struc_on_objects, i ) );

      L := List( L, l -> PreCompose( phi, l ) );

      L := List( L, l -> InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( l ) );

      return ChainMorphism( C, D, L );
end;


convert_to_graded_rows := function( S )
  local graded_lp_cat, rows, F;

  graded_lp_cat := GradedLeftPresentations( S );

  rows := CAPCategoryOfGradedRows( S );
  
  F := CapFunctor( "to be named", graded_lp_cat, rows );

  AddObjectFunction( F,
    
    function( M )

      return GradedRow( List( -GeneratorDegrees( M ), d -> [ d, 1 ] ), S );

  end );

  AddMorphismFunction( F,

    function( source, phi, range )

      return GradedRowOrColumnMorphism( source, UnderlyingMatrix( phi ), range );

    end );

  return F;

end;

S := GradedRing( HomalgFieldOfRationalsInSingular(  )*"x_0,x_1,y_0,y_1" );
SetWeightsOfIndeterminates( S, [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1] ] );

cat_rows := CAPCategoryOfGradedRows( S : FinalizeCategory := false );
SetFieldOfExternalHom( cat_rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
AddHomomorphismStructureOnCategory( cat_rows );
add_random_methods_to_graded_rows( S );
Finalize( cat_rows );


