

DeclareGlobalFunction( "Compute_Homotopy" );

InstallGlobalFunction( Compute_Homotopy,

  function( phi, n )
  local A, B, ring, r, mat, j, k, l,i, current_mat, t, b, current_b, list, var, sol;

  A := Source( phi );

  B := Range( phi );

  ring := HomalgRing( UnderlyingMatrix( phi [ 1 ] ) );

  var := [ ];

  # the first equation

  r := NrColumns( UnderlyingMatrix( phi[ 1 ] ) )* NrRows( UnderlyingMatrix( phi[ 1 ] ) );

  if r<>0 then

  list := List( [ 1 .. NrColumns( UnderlyingMatrix( phi[ 1 ] ) ) ], c -> CertainColumns( UnderlyingMatrix( phi[ 1 ] ), [ c ] ) );
  if Length( list ) = 1 then 
     b := list[ 1 ];
  else
     b := Iterated( UnionOfRows, list );
  fi;

  mat := HomalgZeroMatrix( r, 0, ring );

  for j in [ 2 .. n ] do

    t := NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j -1 ] ) );

    if j = 2 and t <>0 then

       mat := UnionOfColumns( mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( phi[ 1 ] ) ), ring ), UnderlyingMatrix( A^1 ) ) );
       var := Set( Concatenation( var, [ Concatenation( "h", String( j ) ) ] ) );

    elif t <> 0 then 

       mat := UnionOfColumns( mat, HomalgZeroMatrix( r, t, ring ) );
       var := Set( Concatenation( var, [ Concatenation( "h", String( j ) ) ] ) );

    fi;

  od;


  for k in [ 1 .. n ] do 

    t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

    if k = 1 and t<>0 then 

    mat := UnionOfColumns( mat, KroneckerMat( Involution( UnderlyingMatrix( B[ 1 ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ 1 ] ) ), ring ) ) );
    var := Set( Concatenation( var, [ Concatenation( "x", String( k ) ) ] ) );
    elif t<>0 then

    mat := UnionOfColumns( mat, HomalgZeroMatrix( r, t, ring ) );
    var := Set( Concatenation( var, [ Concatenation( "x", String( k ) ) ] ) );
    fi;

  od;

  for l in [ 1 .. n - 1 ] do 
    t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
    if t<>0 then
    mat := UnionOfColumns( mat, HomalgZeroMatrix( r, t, ring ) );
    var := Set( Concatenation( var, [ Concatenation( "y", String( l ) ) ] ) );
    fi;
  od;

  fi;

  for i in [ 2 .. n - 1 ] do

      r := NrColumns( UnderlyingMatrix( phi[ i ] ) )* NrRows( UnderlyingMatrix( phi[ i ] ) );

      if r <> 0 then 

         list := List( [ 1 .. NrColumns( UnderlyingMatrix( phi[ i ] ) ) ], c -> CertainColumns( UnderlyingMatrix( phi[ i ] ), [ c ] ) );
         if Length( list ) = 1 then 
            current_b := list[ 1 ];
         else
            current_b := Iterated( UnionOfRows, list );
         fi;

      current_mat := HomalgZeroMatrix( r, 0, ring );

      for j in [ 2 .. n ] do

          t := NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j - 1 ] ) );

          if j = i and t<>0 then

             current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B^(i - 1) ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ i ] ) ), ring ) ) );
             var := Set( Concatenation( var, [ Concatenation( "h", String( j ) ) ] ) );
          elif j = i + 1 and t<>0 then

             current_mat := UnionOfColumns( current_mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( phi[ i ] ) ), ring ), UnderlyingMatrix( A^i ) ) );
             var := Set( Concatenation( var, [ Concatenation( "h", String( j ) ) ] ) );
          elif t<>0 then

             current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
             var := Set( Concatenation( var, [ Concatenation( "h", String( j ) ) ] ) );
          fi;
      od;


      for k in [ 1 .. n ] do 

          t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

          if k = i and t<>0 then 

             current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ i ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ i ] ) ), ring ) ) );
             var := Set( Concatenation( var, [ Concatenation( "x", String( k ) ) ] ) );
          elif t<>0 then

             current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
             var := Set( Concatenation( var, [ Concatenation( "x", String( k ) ) ] ) );
          fi;

      od;

     for l in [ 1 .. n - 1 ] do 
         t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
         if t<>0 then
         mat := UnionOfColumns( mat, HomalgZeroMatrix( r, t, ring ) );
         var := Set( Concatenation( var, [ Concatenation( "y", String( l ) ) ] ) );
         fi;
     od;

  if not IsZero( current_mat ) then  mat := UnionOfRows( mat, current_mat ); b := UnionOfRows( b, current_b ); fi;

  fi;

  od;

  #again for the last non-zero morphism

  r := NrColumns( UnderlyingMatrix( phi[ n ] ) )* NrRows( UnderlyingMatrix( phi[ n ] ) );

  if r<>0 then 

         list := List( [ 1 .. NrColumns( UnderlyingMatrix( phi[ n ] ) ) ], c -> CertainColumns( UnderlyingMatrix( phi[ n ] ), [ c ] ) );
         if Length( list ) = 1 then 
            current_b := list[ 1 ];
         else
            current_b := Iterated( UnionOfRows, list );
         fi;

  current_mat := HomalgZeroMatrix( r, 0, ring );

  for j in [ 2 .. n ] do

    t := NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j -1 ] ) );

    if j = n and t<>0 then

       current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B^(n-1) ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ n ] ) ), ring ) ) );
       var := Set( Concatenation( var, [ Concatenation( "h", String( j ) ) ] ) );
    elif t<> 0 then

       current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
       var := Set( Concatenation( var, [ Concatenation( "h", String( j ) ) ] ) );
    fi;

  od;


  for k in [ 1 .. n ] do 

    t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

    if k = n and t<>0 then 

    current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ n ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ n ] ) ), ring ) ) );
    var := Set( Concatenation( var, [ Concatenation( "x", String( k ) ) ] ) );
    elif t<>0 then

    current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
    var := Set( Concatenation( var, [ Concatenation( "x", String( k ) ) ] ) );
    fi;

  od;

  for l in [ 1 .. n - 1 ] do 
         t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
         if t<>0 then
         mat := UnionOfColumns( mat, HomalgZeroMatrix( r, t, ring ) );
         var := Set( Concatenation( var, [ Concatenation( "y", String( l ) ) ] ) );
         fi;
  od;

  if not IsZero( current_mat ) then  mat := UnionOfRows( mat, current_mat ); b := UnionOfRows( b, current_b ); fi;

  fi;

  # Now the equations that make sure that the maps h_i's are well defined

  for i in [ 1 .. n - 1 ] do

    r := NrRows( UnderlyingMatrix( A[ i + 1 ] ) ) * NrColumns( UnderlyingMatrix( B[ i ] ) );

    if r <> 0 then

    current_mat := HomalgZeroMatrix( r, 0, ring );

    for j in [ 2 .. n ] do 
      t := NrRows( UnderlyingMatrix( A[ i + 1 ] ) ) * NrColumns( UnderlyingMatrix( B[ i ] ) );

      if j = i + 1 and t<>0 then 

        current_mat := UnionOfColumns( current_mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( B[ i ] ) ), ring ), UnderlyingMatrix( A[ i +1 ] ) ) );
        var := Set( Concatenation( var, [ Concatenation( "h", String( j ) ) ] ) );
      elif t<>0 then

        current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
        var := Set( Concatenation( var, [ Concatenation( "h", String( j ) ) ] ) );
      fi;

    od;

    for k in [ 1 .. n ] do 
    t :=  NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );
    if t<> 0 then 
    current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
    var := Set( Concatenation( var, [ Concatenation( "x", String( k ) ) ] ) );
    fi;
    od;

    for l in [ 1 .. n - 1 ] do
        t := NrRows( UnderlyingMatrix( A[ i +1 ] ) )*NrRows( UnderlyingMatrix( B[ i ] ) );
        if l = i and t<>0 then

           current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ i ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( A[ i + 1 ] ) ), ring ) ) );
           var := Set( Concatenation( var, [ Concatenation( "y", String( l ) ) ] ) );
        elif t<>0 then

           current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
           var := Set( Concatenation( var, [ Concatenation( "y", String( l ) ) ] ) );
        fi;

    od;

  current_b := HomalgZeroMatrix( r, 1, ring );

  if not IsZero( current_mat ) then  mat := UnionOfRows( mat, current_mat ); b := UnionOfRows( b, current_b ); fi;

  fi;

  od;

sol := LeftDivide(mat, b);

if sol = fail then 
   return [ sol, mat, b, var ];
else 
   return [ sol, var ]; 
fi;

end );
