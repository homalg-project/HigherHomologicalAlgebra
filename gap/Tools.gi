

DeclareGlobalFunction( "Compute_Homotopy" );

InstallGlobalFunction( Compute_Homotopy,

  function( phi, n )
  local A, B, ring, r, mat, j, k, l,i, current_mat;

  A := Source( phi );

  B := Range( phi );

  ring := HomalgRing( UnderlyingMatrix( phi [ 1 ] ) );

  # the first equation

  r := NrColumns( UnderlyingMatrix( phi[ 1 ] ) )* NrRows( UnderlyingMatrix( phi[ 1 ] ) );

  mat := HomalgZeroMatrix( r, 0, ring );

  for j in [ 2 .. n ] do

    if j = 2 then

       mat := UnionOfColumns( mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( phi[ 1 ] ) ), ring ), UnderlyingMatrix( A^1 ) ) );

    else

       mat := UnionOfColumns( mat, HomalgZeroMatrix( r, NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j -1 ] ) ), ring ) );

    fi;

  od;


  for k in [ 1 .. n ] do 

    if k = 1 then 

    mat := UnionOfColumns( mat, KroneckerMat( Involution( UnderlyingMatrix( B[ 1 ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ 1 ] ) ), ring ) ) );

    else

    mat := UnionOfColumns( mat, HomalgZeroMatrix( r, NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) ), ring ) );

    fi;

  od;

  for l in [ 1 .. n - 1 ] do 

    mat := UnionOfColumns( mat, HomalgZeroMatrix( r, NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) ), ring ) );

  od;


  for i in [ 2 .. n - 1 ] do

      r := NrColumns( UnderlyingMatrix( phi[ i ] ) )* NrRows( UnderlyingMatrix( phi[ i ] ) );

      current_mat := HomalgZeroMatrix( r, 0, ring );

      for j in [ 2 .. n ] do
          if j < i then
             current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j - 1 ] ) ), ring ) );
          elif j = i then
             current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B^(i - 1) ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ i ] ) ), ring ) ) );
          elif j = i + 1 then
             current_mat := UnionOfColumns( current_mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( phi[ i ] ) ), ring ), UnderlyingMatrix( A^i ) ) );
          else current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j - 1 ] ) ), ring ) );
          fi;
      od;


      for k in [ 1 .. n ] do 

          if k = i then 

             current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ i ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ i ] ) ), ring ) ) );

          else

             current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) ), ring ) );

          fi;

      od;

     for l in [ 1 .. n - 1 ] do 

        current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) ), ring ) );

     od;

  mat := UnionOfRows( mat, current_mat );

  od;

  #again for the last non-zero morphism

  r := NrColumns( UnderlyingMatrix( phi[ n ] ) )* NrRows( UnderlyingMatrix( phi[ n ] ) );

  current_mat := HomalgZeroMatrix( r, 0, ring );

  for j in [ 2 .. n ] do

    if j = n then

       current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B^(n-1) ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ n ] ) ), ring ) ) );

    else

       current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j -1 ] ) ), ring ) );

    fi;

  od;


  for k in [ 1 .. n ] do 

    if k = n then 

    current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ n ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ n ] ) ), ring ) ) );

    else

    current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) ), ring ) );

    fi;

  od;

  for l in [ 1 .. n - 1 ] do 

    current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) ), ring ) );

  od;


  mat := UnionOfRows( mat, current_mat );

return mat;

end );
