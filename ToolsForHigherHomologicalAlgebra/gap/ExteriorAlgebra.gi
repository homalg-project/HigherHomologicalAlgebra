#
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#
##
InstallMethod( IndicesForBasisOfExteriorAlgebra,
          [ IsHomalgRing and IsExteriorRing ],
          
  function ( R )
    local func, new_l, l, n;
    
    n := Length( IndeterminatesOfExteriorRing( R ) ) - 1;
    
    l := Combinations( [ 0 .. n ] );
    
    func := function ( l, m )
      local new_l;
      
      new_l := List( l, function ( e )
            if Length( e ) = m then
                return e;
            else
                return [  ];
            fi;
            return;
        end );
        
      new_l := Set( new_l );
      
      Remove( new_l, 1 );
      
      return new_l;
      
    end;
    
    new_l := List( [ 1 .. n + 1 ], m -> func( l, m ) );
    
    Add( new_l, [ [ ] ], 1 );
    
    return Concatenation( new_l );
    
end );

##
ElementOfBasisOfExteriorAlgebraGivenByIndices :=
  function ( l, R )
    local s, i;
    
    s := "1*";
    
    for i in l do
        s := Concatenation( s, "e", String( i ), "*" );
    od;
    
    s := Concatenation( s, "1" );
    
    return RingElementConstructor( R )( s, R );
    
end;

DecompositionOfHomalgMatrixOverExteriorAlgebra :=
  function( mat )
    local R, n, l, coeff_list, v, reduction_element, temp_mat, m, r, M, coeff_element, u;
    
    mat := ShallowCopy( mat );
    
    R := HomalgRing( mat );
    
    n := Length( IndeterminatesOfExteriorRing( R ) ) - 1;
    
    l := IndicesForBasisOfExteriorAlgebra( R );
    
    coeff_list := [ ];
    
    for u in l do 
      
      v := [ 0 .. n ];
      
      SubtractSet( v, u );
      
      reduction_element := ElementOfBasisOfExteriorAlgebraGivenByIndices( v, R );
      
      temp_mat := mat * reduction_element;
      
      m := NrColumns( temp_mat );
      
      r := ElementOfBasisOfExteriorAlgebraGivenByIndices( Concatenation( u, v ), R );
      
      M := HomalgDiagonalMatrix( List( [ 1 .. m ], i -> r ), R );   
      
      coeff_element := RightDivide( temp_mat, M );
      
      Add( coeff_list, [ u, coeff_element ] );
      
      mat := mat - coeff_element * ElementOfBasisOfExteriorAlgebraGivenByIndices( u, R );
    
    od;
    
  return coeff_list;
  
end;

SomeLeftMagic :=
  function( A, m )
    local S, indices, d, zero_matrix, sigma, e_sigma;
    
    S := HomalgRing( A );
    
   indices := IndicesForBasisOfExteriorAlgebra( S );
    
    d := DecompositionOfHomalgMatrixOverExteriorAlgebra( A );
    
    zero_matrix := HomalgZeroMatrix( NrRows(A), NrColumns(A), S );
    
    sigma := indices[ m ];
    
    e_sigma := ElementOfBasisOfExteriorAlgebraGivenByIndices( sigma, S );
    
    return
    
    UnionOfColumns(
      
      List( indices,
        
        function( tau )
          local lambda, m;
                    
          if ( not IsSubset( sigma, tau ) ) or
              ( IsSubset( tau, sigma ) and
                Length( tau ) > Length( sigma ) ) then
                  
                  return zero_matrix;
          
          fi;
          
          if tau = sigma then
            
            return d[ 1 ][ 2 ];
          
          fi;
          
          lambda := ShallowCopy( sigma );
          
          SubtractSet( lambda, tau );
          
          m := Position( indices, lambda );
          
          return  ( ElementOfBasisOfExteriorAlgebraGivenByIndices( lambda, S ) * ElementOfBasisOfExteriorAlgebraGivenByIndices( tau, S ) / e_sigma ) * d[ m ][ 2 ];
          
        end )
      );
    
end;

##
LeftMagic :=
  function( sigma, A )
    local indices, p;
    
   indices := IndicesForBasisOfExteriorAlgebra(  HomalgRing( A )  );
    
    p := Position( indices, sigma );
    
    if HasIsOne( A ) and IsOne( A ) then
      
      return
        UnionOfColumns(
          [
            HomalgZeroMatrix( NrRows( A ), ( p - 1 ) * NrColumns( A ), HomalgRing( A ) ),
            A,
            HomalgZeroMatrix( NrRows( A ), ( Length( indices ) - p ) * NrColumns( A ), HomalgRing( A ) )
          
          ]
        );
    
    elif HasIsZero( A ) and IsZero( A ) then
      
      return HomalgZeroMatrix( NrRows( A ), NrColumns( A ) * Length( indices ), HomalgRing( A ) );
    
    else
      
      return SomeLeftMagic( A, p );
    
    fi;
  
end;

SomeRightMagic :=
  function( A, m )
    local R, indices, d, zero_matrix, sigma, e_sigma, list;
    
    R := HomalgRing( A );
    
    indices := IndicesForBasisOfExteriorAlgebra( R );
    
    d := DecompositionOfHomalgMatrixOverExteriorAlgebra( A );
    
    zero_matrix := HomalgZeroMatrix( NrRows( A ), NrColumns( A ), R );
    
    sigma := indices[ m ];
    
    e_sigma := ElementOfBasisOfExteriorAlgebraGivenByIndices( sigma, R );
    
    list := UnionOfRows(
              List( indices,
                function( tau )
                  local lambda, m;
                  
                  if ( not IsSubset( sigma, tau ) ) or
                      ( IsSubset( tau, sigma ) and Length( tau ) > Length( sigma ) ) then
                        
                        return zero_matrix;
                        
                  fi;
                  
                  if tau = sigma then
                    
                    return d[ 1 ][ 2 ];
                    
                  fi;
                  
                  lambda := ShallowCopy( sigma );
                  
                  SubtractSet( lambda, tau );
                  
                  m := Position( indices, lambda );
                  
                  return ( ElementOfBasisOfExteriorAlgebraGivenByIndices( tau, R ) * ( ElementOfBasisOfExteriorAlgebraGivenByIndices( lambda, R ) ) / e_sigma ) * d[ m ][ 2 ];
                  
                end )
                
              );
              
    return list;
    
end;

##
RightMagic :=
  function( sigma, A )
    local p, indices;
    
   indices := IndicesForBasisOfExteriorAlgebra( HomalgRing( A ) );
    
    p := Position( indices, sigma );
    
    if HasIsOne( A ) and IsOne( A ) then
      
      return UnionOfRows(
              [
                HomalgZeroMatrix( ( p - 1) * NrRows( A ), NrColumns( A ), HomalgRing( A ) ),
                A,
                HomalgZeroMatrix( ( Length( indices ) - p ) * NrRows( A ), NrColumns( A ), HomalgRing( A ) )
              ]
            );
    
    elif HasIsZero( A ) and IsZero( A ) then
      
      return HomalgZeroMatrix( NrRows(A)*Length( indices ), NrColumns(A), HomalgRing( A ) );
    
    else
      
      return SomeRightMagic(A, p);
    
    fi;
  
end;

##
MoreMagic :=
  function( sigma, A, B )
    local R, r,s, AA, BB, Is_Kronecker_AA, BB_Kronecker_Ir;
    
    R := HomalgRing( A );
    
    r := NrRows( A );
    
    s := NrColumns( B );
    
    AA := LeftMagic( sigma, A );
    
    BB := RightMagic( sigma, B );
    
    Is_Kronecker_AA :=  KroneckerMat( HomalgIdentityMatrix( s, R ), AA );
    
    BB_Kronecker_Ir :=  KroneckerMat( Involution( BB ), HomalgIdentityMatrix( r, R ) );
    
    return UnionOfColumns( Is_Kronecker_AA, BB_Kronecker_Ir );
  
end;

##
ExtraMagic :=
  function( A, B )
    local S, n, indices;
    
    S := HomalgRing( A );
    
    n := Length( IndeterminatesOfExteriorRing( S ) ) - 1;
    
   indices := IndicesForBasisOfExteriorAlgebra( S );
    
    return UnionOfRows( List( indices, sigma -> MoreMagic( sigma, A, B ) ) );
  
end;

## Solves the equation AX+YB=C for X,Y where A, B, C are matrices over some exterior algebra
##
InstallMethod( SolveTwoSidedEquationOverExteriorAlgebra,
          [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ],
          
  function( A, B, C )
    local C_deco, C_deco_list, C_deco_list_vec, C_vec, N, sol,
      Q, R, l, m, s, r, n, x, y, U, V, indices;
    
    R := HomalgRing( A );
    
    if NrRows( A )= 0 or NrColumns( A ) = 0 then 
      
      return [ HomalgZeroMatrix( NrColumns(A), NrColumns(C), R ), RightDivide( C, B ) ];
      
    elif NrRows( B )= 0 or NrColumns( B ) = 0 then
      
      return [ LeftDivide( A, C ), HomalgZeroMatrix( NrRows(C), NrRows( B), R ) ];
    
    fi;
    
    l := Length( IndeterminatesOfExteriorRing( R ) );
    
   indices := IndicesForBasisOfExteriorAlgebra( R );
    
    Q := CoefficientsRing( R );
    
    C_deco := DecompositionOfHomalgMatrixOverExteriorAlgebra( C );
    
    C_deco_list := List( C_deco, i-> i[ 2 ] );
    
    C_deco_list_vec := List( C_deco_list, 
        c -> UnionOfRows( List( [ 1 .. NrColumns( C ) ], i -> CertainColumns( c, [ i ] ) ) )
      );
    
    C_vec := Q * UnionOfRows( C_deco_list_vec );
    
    N := Q * ExtraMagic( A, B );
    
    sol := LeftDivide( N, C_vec );
    
    if sol = fail then 
      
      return fail;
    
    fi;
    
    r := NrRows( A );
    
    m := NrColumns( A );
    
    s := NrColumns( C );
    
    n := NrRows( B );
    
    x := CertainRows( sol, [ 1 .. m * s * 2^l ] );
    
    y := CertainRows( sol, [ 1 + m * s * 2^l ..( m * s + r * n ) * 2^l ] );
    
    x := UnionOfColumns( List( [ 1 .. s ],
      i -> CertainRows( x, [ ( i - 1 ) * m * 2^l + 1 .. i * m * 2^l ] ) ) );
    
    y := UnionOfColumns( List( [ 1 .. n * 2^l ],
      i -> CertainRows( y, [ ( i - 1 ) * r + 1 .. i * r ] ) ) );
    
    x := Sum( List( [ 1 .. 2^l ],
      i -> ( R * CertainRows( x, [ ( i - 1 ) * m + 1 .. i * m ] ) ) *
        ElementOfBasisOfExteriorAlgebraGivenByIndices( indices[ i ], R ) ) );
    
    y := Sum( List( [ 1..2^l ],
      i-> ( R * CertainColumns( y, [ ( i - 1 ) * n + 1 .. i * n ] ) ) *
        ElementOfBasisOfExteriorAlgebraGivenByIndices( indices[ i ], R ) ) );
    
    return [ x, y ];
  
end );

