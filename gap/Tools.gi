
DeclareGlobalFunction( "Compute_Homotopy" );

InstallGlobalFunction( Compute_Homotopy,

  function( phi, n )
  local A, B, ring, r, mat, j, k, l,i, current_mat, t, b, current_b, list, var, sol, union_of_columns, union_of_rows;

  A := Source( phi );

  B := Range( phi );

  ring := HomalgRing( UnderlyingMatrix( phi [ 1 ] ) );

  # Here we find which variables should be actually compute. h_i, x_i or y_i.

  var := [ ];

  for j in [ 2 .. n ] do 

    t := NrColumns( UnderlyingMatrix( A[ j ] ) )*NrColumns( UnderlyingMatrix( B[ j -1 ] ) );

    if t<>0 then Add( var, [ "h",j, [ NrColumns( UnderlyingMatrix( B[ j -1 ] ) ), NrColumns( UnderlyingMatrix( A[ j ] ) )  ] ] );fi;

  od;

  for k in [ 1 .. n ] do

    t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

    if t<>0 then Add( var, [ "x", k, [ NrRows( UnderlyingMatrix( phi[ k ] ) ), NrRows( UnderlyingMatrix( B[ k ] ) )  ] ] );fi;

  od;

  for l in [ 1 .. n - 1 ] do

    t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );

    if t<>0 then Add( var, [ "y", l, [ NrRows( UnderlyingMatrix( A[ l + 1 ] ) ), NrRows( UnderlyingMatrix( B[ l ] ) )  ] ] );fi;

  od;

  # the first equation
  mat := 0;
  b := 0;

  union_of_columns := function( m, n )
                      local new_m;
                      new_m := m;
                      if m=0 then new_m := HomalgZeroMatrix( NrRows( n ), 0, ring );fi;
                      return UnionOfColumns( new_m, n );
                      end;

  union_of_rows := function( m, n )
                      local new_m;
                      new_m := m;
                      if m=0 then new_m := HomalgZeroMatrix( 0, NrColumns( n ), ring );fi;
                      return UnionOfRows( new_m, n );
                      end;

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

       mat := union_of_columns( mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( phi[ 1 ] ) ), ring ), UnderlyingMatrix( A^1 ) ) );

    elif t <> 0 then 

       mat := union_of_columns( mat, HomalgZeroMatrix( r, t, ring ) );

    fi;

  od;


  for k in [ 1 .. n ] do 

    t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

    if k = 1 and t<>0 then 

    mat := union_of_columns( mat, KroneckerMat( Involution( UnderlyingMatrix( B[ 1 ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ 1 ] ) ), ring ) ) );
    elif t<>0 then

    mat := union_of_columns( mat, HomalgZeroMatrix( r, t, ring ) );
    fi;

  od;

  for l in [ 1 .. n - 1 ] do 
    t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
    if t<>0 then
    mat := union_of_columns( mat, HomalgZeroMatrix( r, t, ring ) );
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
          elif j = i + 1 and t<>0 then

             current_mat := UnionOfColumns( current_mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( phi[ i ] ) ), ring ), UnderlyingMatrix( A^i ) ) );
          elif t<>0 then

             current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
          fi;
      od;


      for k in [ 1 .. n ] do 

          t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

          if k = i and t<>0 then 

             current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ i ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ i ] ) ), ring ) ) );
          elif t<>0 then

             current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
          fi;

      od;

     for l in [ 1 .. n - 1 ] do 
         t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
         if t<>0 then
         mat := union_of_columns( mat, HomalgZeroMatrix( r, t, ring ) );
         fi;
     od;

  if not IsZero( current_mat ) then  mat := union_of_rows( mat, current_mat ); b := union_of_rows( b, current_b ); fi;

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
    elif t<> 0 then

       current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
    fi;

  od;


  for k in [ 1 .. n ] do 

    t := NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );

    if k = n and t<>0 then 

    current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ n ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( phi[ n ] ) ), ring ) ) );
    elif t<>0 then

    current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
    fi;

  od;

  for l in [ 1 .. n - 1 ] do 
         t := NrRows( UnderlyingMatrix( A[ l + 1 ] ) )*NrRows( UnderlyingMatrix( B[ l ] ) );
         if t<>0 then
         current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
         fi;
  od;

  if not IsZero( current_mat ) then  mat := union_of_rows( mat, current_mat ); b := union_of_rows( b, current_b ); fi;

  fi;

  # Now the equations that make sure that the maps h_i's are well defined

  for i in [ 1 .. n - 1 ] do

    r := NrRows( UnderlyingMatrix( A[ i + 1 ] ) ) * NrColumns( UnderlyingMatrix( B[ i ] ) );

    if r <> 0 then

    current_mat := HomalgZeroMatrix( r, 0, ring );

    for j in [ 2 .. n ] do 
      t := NrRows( UnderlyingMatrix( A[ i + 1 ] ) ) * NrColumns( UnderlyingMatrix( B[ i ] ) );

      if j = i + 1 and t<>0 then 

        current_mat := UnionOfColumns( current_mat, KroneckerMat( HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( B[ i ] ) ), ring ), UnderlyingMatrix( A[ i + 1 ] ) ) );
      elif t<>0 then

        current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
      fi;

    od;

    for k in [ 1 .. n ] do 
    t :=  NrRows( UnderlyingMatrix( phi[ k ] ) )* NrRows( UnderlyingMatrix( B[ k ] ) );
    if t<> 0 then 
    current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
    fi;
    od;

    for l in [ 1 .. n - 1 ] do
        t := NrRows( UnderlyingMatrix( A[ i + 1 ] ) )*NrRows( UnderlyingMatrix( B[ i ] ) );
        if l = i and t<>0 then

           current_mat := UnionOfColumns( current_mat, KroneckerMat( Involution( UnderlyingMatrix( B[ i ] ) ), HomalgIdentityMatrix( NrRows( UnderlyingMatrix( A[ i + 1 ] ) ), ring ) ) );
        elif t<>0 then

           current_mat := UnionOfColumns( current_mat, HomalgZeroMatrix( r, t, ring ) );
        fi;

    od;

  current_b := HomalgZeroMatrix( r, 1, ring );

  if not IsZero( current_mat ) then  mat := union_of_rows( mat, current_mat ); b := union_of_rows( b, current_b ); fi;

  fi;

  od;

sol := LeftDivide(mat, b);

if sol = fail then 
   return [ sol, mat, b, var ];
else 
   return [ sol, var ]; 
fi;

end );


InstallMethod( ComputeHomotopy, 
               [ IsChainOrCochainMorphism, IsInt, IsInt ],

function( phi, m, n )
local cat, underlying_cat, T, psi, sol, new_var;

cat := CapCategory( phi );

underlying_cat := UnderlyingCategory( cat );

if IsCochainComplexCategory( cat ) then 

   T := UnsignedShiftFunctor( cat, m - 1 );

   psi := ApplyFunctor( T, phi );
   
   sol := ShallowCopy( Compute_Homotopy( psi, n - m + 1 ) );

   new_var := sol[ Length( sol ) ];

   new_var := List( new_var, i-> [ i[1],i[2] + m - 1, i[3] ] );

   sol[ Length( sol ) ] := new_var;

   return sol;
   
elif IsChainComplexCategory( cat ) then 

   T := ChainToCochainComplexFunctor( underlying_cat  );

   psi := ApplyFunctor( T, phi );

   sol := ShallowCopy( ComputeHomotopy( psi, -n, -m ) );

   new_var := sol[ Length( sol ) ];

   new_var := List( new_var, i-> [ i[1],-i[2], i[3] ] );

   sol[ Length( sol ) ] := new_var;

   return sol;

fi;

end );
