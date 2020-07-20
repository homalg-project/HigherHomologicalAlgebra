

##
InstallMethod( \.,
        [ IsHomotopyCategory, IsPosInt ],
   { C, string_as_int } -> ( UnderlyingCategory( C ).( NameRNam( string_as_int ) ) ) / C
);

##
BindGlobal( "_StRiNg",
  function( i )
    
    if i < 0 then
      
      return ReplacedString( String( i ), "-", "m" );
      
    else
      
      return String( i );
      
    fi;
    
end );

##
InstallMethod( CreateDiagramInHomotopyCategory,
          [ IsList, IsList, IsList, IsList ],
          
  function( objects, morphisms, relations, bounds )
    
    return CreateDiagramInHomotopyCategory( HomalgFieldOfRationals( ), objects, morphisms, relations, bounds );
    
end );

##
InstallMethod( CreateDiagramInHomotopyCategory,
          [ IsHomalgRing, IsList, IsList, IsList, IsList ],
  function( field, objects, morphisms, relations, bounds )
    local N, vertices, arrows, o, monomial, index_first_term, index_last_term, Q, kQ, C, AC, ChAC, complexes, I, complexes_morphisms, map, h, kQ_mod_I, kQ_mod_I_oid, P, k, m, rel, t, H;
    
    bounds := [ bounds[ 1 ], bounds[ Size( bounds ) ] ];
    
    N := bounds[ 2 ] - bounds[ 1 ] + 1;
    
    vertices :=
    List( Cartesian(
              objects,
              List( [ bounds[1] .. bounds[2] ], i -> _StRiNg( i ) )
            ),
          s -> JoinStringsWithSeparator( s, "^" )
        );
    
    arrows := [ ];
    
    for k in [ 1 .. Size( objects ) ] do
      
      o := objects[ k ];
      
      arrows :=
        Concatenation( arrows, List( [ bounds[1] .. bounds[2] - 1 ],
              i -> Concatenation(
                      "d", o, "^", _StRiNg( i ), ":",
                      vertices[ N * ( k - 1) - bounds[ 1 ] + i + 1 ],
                      "->",
                      vertices[ N * ( k - 1) - bounds[ 1 ] + i + 2 ]
                    )
                  )
                );
     
    od;
    
    for m in morphisms do
      arrows :=
        Concatenation( arrows, List( [ bounds[ 1 ] .. bounds[ 2 ] ],
              i -> Concatenation(
                      m[ 1 ], "^", _StRiNg( i ), ":",
                      vertices[ ( m[ 2 ] - 1 ) * N - bounds[ 1 ] + i + 1 ],
                      "->", vertices[ ( m[ 3 ] - 1 ) * N -bounds[ 1 ] + i + 1 ]
                    )
                  )
                );
    od;

    for rel in relations do
      
      if rel[ 2 ] = "0" then
        
        continue;
        
      fi;
      
      monomial := rel[ 1 ][ 1 ][ 2 ];
      
      index_first_term := morphisms[ PositionProperty( morphisms, m -> m[ 1 ] = monomial[ 1 ] ) ][ 2 ];
      
      index_last_term := morphisms[ PositionProperty( morphisms, m -> m[ 1 ] = monomial[ Size( monomial ) ] ) ][ 3 ];
      
      arrows :=
        Concatenation( arrows, List( [ bounds[ 1 ] + 1 .. bounds[ 2 ] ],
              i -> Concatenation(
                      rel[ 2 ], "^", _StRiNg( i ), ":",
                      vertices[ ( index_first_term - 1 ) * N - bounds[ 1 ] + i + 1 ],
                      "->", vertices[ ( index_last_term - 1 ) * N - bounds[ 1 ] + i ]
                    )
                  )
                );
      
      
    od;
    
    vertices := JoinStringsWithSeparator( vertices, "," );
    
    arrows := JoinStringsWithSeparator( arrows, "," );
    
    Q := RightQuiver( Concatenation( "Q(", vertices, ")[", arrows, "]" ) );
    
    kQ := PathAlgebra( field, Q );
    
    C := Algebroid( kQ );
    
    AC := AdditiveClosure( C );
    
    ChAC := CochainComplexCategory( AC );
    
    complexes := [ ];
     
    for o in objects do
      
      Add( complexes,
          CochainComplex(
              List( [ bounds[ 1 ] .. bounds[ 2 ] - 1 ], i -> C.( Concatenation( "d", o, "^", _StRiNg( i ) ) )/AC ),
              bounds[ 1 ]
            )
         );
      
    od;
    
    I := Concatenation(
          List( complexes, c -> List( [ bounds[ 1 ] .. bounds[ 2 ] - 2 ],
            i -> UnderlyingQuiverAlgebraElement( MorphismMatrix( PreCompose( c^i, c^( i + 1 ) ) )[ 1, 1 ] ) )
          )
        );
    
    complexes_morphisms := [ ];
    
    for m in morphisms do
      
      Add( complexes_morphisms,
        CochainMorphism(
            complexes[ m[ 2 ] ],
            complexes[ m[ 3 ] ],
            List( [ bounds[ 1 ] .. bounds[ 2 ] ], i -> kQ.( Concatenation( m[ 1 ], "^", _StRiNg( i ) ) )/C/AC ),
            bounds[ 1 ]
          )
      );
      
    od;
    
    I := Concatenation( I, Concatenation(
          List( complexes_morphisms, m -> List( [ bounds[ 1 ] .. bounds[ 2 ] - 1 ],
              function( i )
                local f;
                
                f := PreCompose( Source( m )^i, m[ i + 1 ] ) - PreCompose( m[ i ], Range( m )^i );
                
                if IsZero( f ) then
                  
                  return Zero( kQ );
                  
                else
                  
                  return UnderlyingQuiverAlgebraElement( MorphismMatrix( f )[ 1, 1 ] );
                  
                fi;
                
              end )
          )
        )
      );
    
    for rel in relations do
       
      map := Sum( List( rel[ 1 ],
              r -> r[ 1 ] * PreCompose(
                List( r[ 2 ],
                  function( s )
                    local p;
                    
                    p := PositionProperty( morphisms, m -> m[ 1 ] = s );
                    
                    if p <> fail then
                      
                      return complexes_morphisms[ p ];
                    
                    fi;
                    
                    p := Position( objects, s );
                    
                    if p <> fail then
                      
                      return IdentityMorphism( complexes[ p ] );
                      
                    fi;
                    
                  end ) ) 
                )
              );
      
      h := rel[ 2 ];
      
      if h <> "0" then
        
        Add( I,
          UnderlyingQuiverAlgebraElement(
            MorphismMatrix( 
              map[ bounds[ 1 ] ] - PreCompose( Source( map ) ^ bounds[ 1 ], C.( Concatenation( h, "^", _StRiNg( bounds[1] + 1 ) ) ) /AC ) 
                )[ 1, 1 ]
              )
            );
        
        for t in [ bounds[ 1 ] + 1 .. bounds[ 2 ] - 1 ] do
          
         Add( I,
          UnderlyingQuiverAlgebraElement(
            MorphismMatrix( 
              map[ t ]
              - PreCompose( Source( map ) ^ t, C.( Concatenation( h, "^", _StRiNg( t + 1 ) ) ) / AC )
              - PostCompose( Range( map ) ^ ( t - 1 ), C.( Concatenation( h, "^", _StRiNg( t ) ) ) /AC )
                )[ 1, 1 ]
              )
            );
         
        od;
        
        Add( I,
          UnderlyingQuiverAlgebraElement(
            MorphismMatrix( 
              map[ bounds[ 2 ] ] - PostCompose( Range( map ) ^ ( bounds[ 2 ] - 1 ), C.( Concatenation( h, "^", _StRiNg( bounds[ 2 ] ) ) ) /AC ) 
                )[ 1, 1 ]
              )
            );
        
      else
        
        Add( I,
          UnderlyingQuiverAlgebraElement(
            MorphismMatrix( 
              map[ bounds[ 1 ] ]
                )[ 1, 1 ]
              )
            );
        
        for t in [ bounds[ 1 ] + 1 .. bounds[ 2 ] - 1 ] do
          
         Add( I,
          UnderlyingQuiverAlgebraElement(
            MorphismMatrix( 
              map[ t ]
                )[ 1, 1 ]
              )
            );
         
        od;
        
        Add( I,
          UnderlyingQuiverAlgebraElement(
            MorphismMatrix( 
              map[ bounds[ 2 ] ] 
                )[ 1, 1 ]
              )
            );

      fi;
      
    od;
    
    kQ_mod_I := kQ / I;
    
    kQ_mod_I_oid := Algebroid( kQ_mod_I );
    
    kQ_mod_I_oid!.Name := "algebroid";
    
    P := ProjectionFromAlgebroidOfPathAlgebra( kQ_mod_I_oid );
    
    P := ExtendFunctorToAdditiveClosures( P );

    H := HomotopyCategory( RangeOfFunctor( P ), true );
    
    P := ExtendFunctorToCochainComplexCategories( P );
    
    for k in [ 1 .. Size( complexes ) ] do
      
      MakeReadWriteGlobal( objects[ k ] );
      
      DeclareSynonym( objects[ k ], P( complexes[ k ] ) / H );
      
    od;
    
    for k in [ 1 .. Size( complexes_morphisms ) ] do
      
      MakeReadWriteGlobal( morphisms[ k ][ 1 ] );
      
      DeclareSynonym( morphisms[ k ][ 1 ], P( complexes_morphisms[ k ] ) / H );
      
    od;
    
    return H;
    
end );
