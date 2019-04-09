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

    SetRangeCategoryOfHomomorphismStructure( cat, MatrixCategory( field ) );

    AddDistinguishedObjectOfHomomorphismStructure( cat,
       function( )
         
         return VectorSpaceObject( 1, field );
    
    end );
    
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

#  function( M )
#    local S, weights, n, variables, G, dG, positions, L, mats, current_mat, U, i;
#
#    S := UnderlyingHomalgGradedRing( M );
#    weights := DuplicateFreeList( WeightsOfIndeterminates( S ) );
#    n := Length( weights );
#    variables := List( weights,  w -> Filtered( Indeterminates( S ), ind -> Degree( ind ) =   w ) );
#    weights := List( weights, w -> 
#                 List( EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( w ) ) ), HomalgElementToInteger ) );
#    
#    G := UnzipDegreeList( M );
#    G := List( G, UnderlyingMorphism );
#    G := List( G, MatrixOfMap );
#    G := List( G, EntriesOfHomalgMatrix );
#    G := List( G, g -> List( g, HomalgElementToInteger ) );
#    dG := DuplicateFreeList( G );
#    dG := List( dG, g -> SolutionIntMat( weights, g ) );
#    dG := List( dG, function( g )
#                      if ForAny( g, i -> i < 0 ) then
#                        return  [ [ Zero( S )  ] ];
#                      fi;
#                      return List( [ 1 .. n ], 
#                               i -> List( UnorderedTuples( variables[ i ], g[ i ] ),
#                                      l -> Product( l ) * One( S ) ) );
#                    end );
#    dG := List( dG, g ->
#             Iterated( g, 
#               function( l1, l2 )
#                 return ListX( l1, l2, \* );
#               end ) );
#
#    positions := List( DuplicateFreeList( G ), d -> Positions( G, d ) );
#    L := ListWithIdenticalEntries( Length( G ), 0 );
#    List( [ 1 .. Length( dG ) ], i -> List( positions[ i ], function( p ) L[p] := dG[i]; return 0; end ) );
#    
#    mats := [  ];
#    
#    for i in [ 1 .. Length( L ) ] do
#      
#      current_mat := ListWithIdenticalEntries( Length( G ), [ Zero( S ) ] );
#      
#      current_mat[ i ] := L[ i ];
#      
#      if not IsZero( current_mat ) then
#        
#        mats := Concatenation( mats, Cartesian( current_mat ) );
#      
#      fi;
#    
#    od;
#    
#    return mats;
#end 
#
##
#BasisOfExternalHom2 :=
#  function( a, b )
#    local S, hom_a_b, mats;
#    S := UnderlyingHomalgGradedRing( a );
#    hom_a_b := InternalHomOnObjects( a, b );
#    mats := basis_of_external_hom_from_tensor_unit2( hom_a_b );
#    return List( mats, mat -> GradedRowOrColumnMorphism( a, HomalgMatrix( mat, Rank( a ), Rank( b ), S ), b ) );
#end;

DeclareOperation( "BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW", [ IsGradedRow ] );

InstallMethodWithCrispCache( BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW,
            [ IsGradedRow ],
function( M )
  local S, indeterminates, weights_of_indeterminates, D, G, dG, func, positions, L, mats, current_mat, i;
  
  if Rank( M ) = 0 then
    return [  ];
  fi;
  
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
            local solutions, new_degree;
            
            if not IsList( degree ) then
              new_degree := [ degree ];
            else
              new_degree := degree;
            fi;

            solutions := 4ti2Interface_zsolve_equalities_and_inequalities_in_positive_orthant( D, new_degree, [], [] )[ 1 ];
            solutions := List( solutions, sol -> Product( ListN( indeterminates, sol, \^ )  ) );

            if HasIsExteriorRing( S ) and IsExteriorRing( S ) then

              solutions := Filtered( solutions, sol -> not IsZero( sol ) );

            fi;

            return  solutions;

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

end );

#
InstallMethodWithCrispCache( BasisOfExternalHom,
            [ IsGradedRowOrColumn, IsGradedRowOrColumn ],
  function( a, b )
    local S, degrees_a, degrees_b, degrees, hom_a_b, mats;

    S := UnderlyingHomalgGradedRing( a );
    
    degrees_a := UnzipDegreeList( a );

    degrees_b := UnzipDegreeList( b );

    degrees := Concatenation( List( degrees_a, a -> List( degrees_b, b -> -a + b ) ) );

    degrees := List( degrees, d -> [ d, 1 ] );
    
    # This is the same as the internal hom, but this works for all graded rows.
    hom_a_b := GradedRow( degrees, S );

    mats := BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW( hom_a_b );

    return List( mats, mat -> GradedRowOrColumnMorphism( a, HomalgMatrix( mat, Rank( a ), Rank( b ), S ), b ) );

end );

##
InstallMethod( CoefficientsOfLinearMorphism,
            [ IsGradedRowOrColumnMorphism ],
  function( phi )
    local category, K, S, a, b, U, degrees_a, degrees_b, degrees, hom_a_b, mat, psi, B, A, sol, list_of_entries,
    position_of_non_zero_entry, current_coeff, current_coeff_mat, current_mono, position_in_basis,
    current_term, current_entry;
    
    category := CapCategory( phi );
    
    K := FieldOfExternalHom( category );
   
    S := UnderlyingHomalgGradedRing( phi );

    a := Source( phi );
    
    b := Range( phi );
    
    if Rank( a ) = 0 or Rank( b ) = 0 then
      
      return [  ];
    
    fi;
    
    degrees_a := UnzipDegreeList( a );

    degrees_b := UnzipDegreeList( b );

    degrees := Concatenation( List( degrees_a, a -> List( degrees_b, b -> -a + b ) ) );

    degrees := List( degrees, d -> [ d, 1 ] );

    hom_a_b := GradedRow( degrees, S );
    
    A := UnderlyingHomalgMatrix( phi );

    list_of_entries := ShallowCopy( EntriesOfHomalgMatrix( A ) );

    B := BASIS_OF_EXTERNAL_HOM_FROM_TENSOR_UNIT_TO_GRADED_ROW( hom_a_b );
    
    if B = [  ] then
      
      return [  ];

    fi;
    
    # XB = A
    # RightDivide takes a lot time to send the matrix to singular and then to solve it
    # or I fall in recursion trap, because of call of union of rows or cols.

    sol := ListWithIdenticalEntries( Length( B ), Zero( K) );

    while PositionProperty( list_of_entries, a -> not IsZero( a ) ) <> fail do

      position_of_non_zero_entry := PositionProperty( list_of_entries, a -> not IsZero( a ) );
      current_entry := list_of_entries[ position_of_non_zero_entry ];
      current_coeff_mat := Coefficients( EvalRingElement( current_entry ) );
      current_coeff := MatElm( current_coeff_mat, 1, 1 );
      current_mono := current_coeff_mat!.monomials[1]/S;
      current_term := current_coeff/S * current_mono;
      position_in_basis := PositionProperty( B, b -> b[ position_of_non_zero_entry ] = current_mono );
      sol[ position_in_basis ] := current_coeff/K;
      list_of_entries[ position_of_non_zero_entry ] := list_of_entries[ position_of_non_zero_entry ] - current_term;

    od;
    
    return sol;

end );

##
InstallMethod( MultiplyWithHomalgRingElement,
            [ IsMultiplicativeElement, IsGradedRowOrColumnMorphism ],
  function( e, alpha )
    local S, mat;
    
    S := UnderlyingHomalgGradedRing( alpha );
    
    mat := e/S * UnderlyingHomalgMatrix( alpha );
    
    return GradedRowOrColumnMorphism( Source( alpha ), mat, Range( alpha ) );
    
end );

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

S := GradedRing( HomalgFieldOfRationalsInSingular(  )*"x_0,x_1,x_2,y_0,y_1" );
weights := InputFromUser( "weights?" );
SetWeightsOfIndeterminates( S, weights );

rows := CAPCategoryOfGradedRows( S : FinalizeCategory := false );
SetFieldOfExternalHom( rows, UnderlyingNonGradedRing( CoefficientsRing( S ) ) );
AddHomomorphismStructureOnCategory( rows );
add_random_methods_to_graded_rows( S );
Finalize( rows );


