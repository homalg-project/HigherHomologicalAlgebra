
if IsPackageMarkedForLoading( "NConvex", ">= 2019.12.01" ) then
  
  ##
  InstallMethod( MonomialsOfDegree,
          [ IsHomalgGradedRing, IsHomalgModuleElement ],
  function( S, degree )
    local indeterminates, n, weights, matrix, equations, polyhedron, solutions;
    
    indeterminates := Indeterminates( S );
    
    n := Size( indeterminates );
    
    degree := UnderlyingMorphism( degree );
    
    degree := MatrixOfMap( degree );
    
    degree := EntriesOfHomalgMatrix( degree );
    
    degree := List( degree, HomalgElementToInteger );
    
    weights := WeightsOfIndeterminates( S );
    
    matrix := List( weights, UnderlyingMorphism );
    
    matrix := List( matrix, d -> MatrixOfMap( d ) );
    
    matrix := TransposedMatrix( UnionOfRows( matrix ) );
    
    matrix := EntriesOfHomalgMatrixAsListList( matrix );
    
    equations := ListN( degree, matrix, { e, d } -> Concatenation( [ -e ], d ) );
    
    equations := Concatenation( equations, -equations );
    
    equations := Concatenation( equations, IdentityMat( n + 1 ){ [ 2 .. n + 1 ] } );
    
    polyhedron := PolyhedronByInequalities( equations );
    
    solutions := LatticePointsGenerators( polyhedron )[ 1 ];
    
    solutions := List( solutions, sol -> Product( ListN( indeterminates, sol, \^ )  ) );
    
    if HasIsExteriorRing( S ) and IsExteriorRing( S ) then
      
      solutions := Filtered( solutions, sol -> not IsZero( sol ) );
      
    fi;
    
    return solutions;
    
  end );
  
  BindGlobal( "BASIS_OF_EXTERNAL_HOM_FROM_S_TO_DIRECT_SUM_OF_TWISTS_OF_S",
  function( M )
    local S, twists, df_twists, positions, L, mats, current_mat, i;
    
    S := UnderlyingHomalgRing( M );
    
    twists := -GeneratorDegrees( M );
    
    if IsEmpty( twists ) then
      
      return [ ];
      
    fi;
    
    df_twists := DuplicateFreeList( twists );
    
    df_twists := List( df_twists, d -> MonomialsOfDegree( S, d ) );
    
    positions := List( DuplicateFreeList( twists ), d -> Positions( twists, d ) );
    
    L := [ ];
    
    List( [ 1 .. Length( df_twists ) ],
      i -> List( positions[ i ],
            function( p )
              L[ p ] := df_twists[ i ];
              return 0;
            end )
      );
    
    mats := [  ];
    
    for i in [ 1 .. Length( L ) ] do
      
      if not IsEmpty( L[ i ] ) then
        
        current_mat := ListWithIdenticalEntries( Length( twists ), [ Zero( S ) ] );
        
        current_mat[ i ] := L[ i ];
        
        mats := Concatenation( mats, Cartesian( current_mat ) );
        
      fi;
      
    od;
    
    return mats;
    
  end );
 
fi;
