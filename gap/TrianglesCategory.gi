#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2018,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################


InstallMethod( CategoryOfTriangles, 
                [ IsCapCategory and IsTriangulatedCategory ],
    function( category )
    local name, cat;
    
    name := Concatenation( "Category of triangles in ", Name( category ) );
    
    cat := CreateCapCategory( name );
    
    AddIsEqualForObjects( cat,
        function( T1, T2 )
        return IsEqualForObjects( ObjectAt( T1, 0 ), ObjectAt( T2, 0 ) ) and 
                IsEqualForObjects( ObjectAt( T1, 1 ), ObjectAt( T2, 1 ) ) and
                 IsEqualForObjects( ObjectAt( T1, 2 ), ObjectAt( T2, 2 ) ) and
                  IsEqualForMorphisms( MorphismAt( T1, 0 ), MorphismAt( T2, 0 ) ) and 
                   IsEqualForMorphisms( MorphismAt( T1, 1 ), MorphismAt( T2, 1 ) ) and
                    IsEqualForMorphisms( MorphismAt( T1, 2 ), MorphismAt( T2, 2 ) );
        end );
        
    AddIsEqualForMorphisms( cat,
        function( phi1, phi2 )
        return IsEqualForMorphisms( MorphismAt( phi1, 0 ), MorphismAt( phi2, 0 ) ) and 
                  IsEqualForMorphisms( MorphismAt( phi1, 1 ), MorphismAt( phi2, 1 ) ) and
                    IsEqualForMorphisms( MorphismAt( phi1, 2 ), MorphismAt( phi2, 2 ) );
        end );

    AddIsCongruentForMorphisms( cat,
        function( phi1, phi2 )
        return IsCongruentForMorphisms( MorphismAt( phi1, 0 ), MorphismAt( phi2, 0 ) ) and 
                  IsCongruentForMorphisms( MorphismAt( phi1, 1 ), MorphismAt( phi2, 1 ) ) and
                    IsCongruentForMorphisms( MorphismAt( phi1, 2 ), MorphismAt( phi2, 2 ) );
        end );
    
    AddIsZeroForObjects( cat, 
        function( T )
        return ForAll( [ 0,1,2,3 ], i -> IsZeroForObjects( ObjectAt( T, i ) ) );
        end );
        
    AddIsZeroForMorphisms( cat, 
        function( phi )
        return ForAll( [ 0,1,2,3 ], i -> IsZeroForMorphisms( MorphismAt( phi, i ) ) );
        end );
        
    AddIdentityMorphism( cat, 
        function( T )
        local m;
        
        m := List( [0,1,2], i -> IdentityMorphism( ObjectAt( T, i ) ) );
        
        return CreateTrianglesMorphism( T, T, m[1], m[2], m[3] );
        
        end );
    
    AddPreCompose( cat, 
        function( phi1, phi2 )
        local m1, m2;
        
        m1 := List( [ 0, 1, 2 ], i -> MorphismAt( phi1, i ) );
        
        m2 := List( [ 0, 1, 2 ], i -> MorphismAt( phi2, i ) );
        
        return CreateTrianglesMorphism( Source( phi1 ), Range( phi2 ), 
                                            PreCompose( m1[1], m2[1] ),
                                            PreCompose( m1[2], m2[2] ),
                                            PreCompose( m1[3], m2[3] ) );
        
    end );
    
    
    AddPostCompose( cat, 
        function( phi1, phi2 )
        local m1, m2;
        
        m1 := List( [ 0, 1, 2 ], i -> MorphismAt( phi1, i ) );
        
        m2 := List( [ 0, 1, 2 ], i -> MorphismAt( phi2, i ) );
        
        return CreateTrianglesMorphism( Source( phi1 ), Range( phi2 ), 
                                            PostCompose( m1[1], m2[1] ),
                                            PostCompose( m1[2], m2[2] ),
                                            PostCompose( m1[3], m2[3] ) );
    
    end );

    AddIsWellDefinedForObjects( cat, 
        function( T )
    
        if not IsWellDefined( ObjectAt( T, 0 ) ) or 
            not IsWellDefined( ObjectAt( T, 1 ) ) or
            not IsWellDefined( ObjectAt( T, 2 ) ) or
            not IsWellDefined( ObjectAt( T, 3 ) ) then 
                return false;
        fi;
    
        if not IsWellDefined( MorphismAt( T, 0 ) ) or 
            not IsWellDefined( MorphismAt( T, 1 ) ) or
            not IsWellDefined( MorphismAt( T,2 ) ) then 
                return false;
        fi;
    
        if not IsEqualForObjects( Range( MorphismAt( T, 0 ) ), Source( MorphismAt( T, 1 ) ) ) or
            not IsEqualForObjects( Range( MorphismAt( T, 1 ) ), Source( MorphismAt( T, 2 ) ) ) or
            not IsEqualForObjects( ShiftOfObject( Source( MorphismAt( T, 0 ) ) ), Range( MorphismAt( T, 2 ) ) ) then
                return false;
        fi;
    
        if not IsZeroForMorphisms( PreCompose( MorphismAt( T, 0), MorphismAt( T, 1 ) ) ) or
            not IsZeroForMorphisms( PreCompose( MorphismAt( T, 1), MorphismAt( T, 2 ) ) ) then 
                return false;
        fi;
    
        return true;

    end );
    
    AddIsWellDefinedForMorphisms( cat, 
        function( phi )
        local T1, T2;
        
        T1 := Source( phi );
        T2 := Range( phi );
        
        if not IsEqualForObjects( Source( MorphismAt( phi, 0 ) ), ObjectAt( T1, 0 ) ) or 
            not IsEqualForObjects( Range( MorphismAt( phi, 0 ) ), ObjectAt( T2, 0) )  then 
            
            Error( "The morphism m0 is not compatible" );
            
        fi;
        
        if not IsEqualForObjects( Source( MorphismAt( phi, 1 ) ), ObjectAt( T1, 1 ) ) or 
            not IsEqualForObjects( Range( MorphismAt( phi, 1 ) ), ObjectAt( T2, 1) )  then 
            
            Error( "The morphism m1 is not compatible" );
        
        fi;
        
        if not IsEqualForObjects( Source( MorphismAt( phi, 2 ) ), ObjectAt( T1, 2) ) or 
            not IsEqualForObjects( Range( MorphismAt( phi, 2 ) ), ObjectAt( T2, 2) )  then 
            
            Error( "The morphism m2 is not compatible" );
        
        fi;
    
        # Is the diagram commutative?

        if not IsCongruentForMorphisms( PreCompose( MorphismAt( T1, 0 ), MorphismAt( phi, 1 ) ), PreCompose( MorphismAt( phi, 0 ), MorphismAt( T2, 0) ) ) then
        
            Error( "The first squar is not commutative" );
            
        fi;
        
        if not IsCongruentForMorphisms( PreCompose( MorphismAt( T1, 1 ), MorphismAt( phi, 2 ) ), PreCompose( MorphismAt( phi, 1 ), MorphismAt( T2, 1) ) ) then
        
            Error( "The second squar is not commutative" );
            
        fi;
        
        if not IsCongruentForMorphisms( PreCompose( MorphismAt( T1, 2), MorphismAt( phi, 3 ) ), 
                                    PreCompose( MorphismAt( phi, 2 ), MorphismAt( T2, 2) ) ) then
        
            Error( "The third squar is not commutative" );
            
        fi;
        
        return true;
    
    end );
    
    AddDirectSum( cat, 
        function( L )
        local m, D, u;
        
        m := TransposedMat( List( L, l -> List( [ 0, 1, 2 ], i -> MorphismAt( l, i ) ) ) );
        
        m := List( [ 1, 2, 3 ], l -> DirectSumFunctorial( m[ l ] ) );
        
        D := CreateTriangle( m[ 1 ], m[ 2 ], m[ 3 ] );
        
        u := List( L, i-> [ i, "IsExactTriangle", true ] );

        AddToToDoList( ToDoListEntry( u, 
                    function( )
                        SetIsExactTriangle( D, true );
                    end ) );

        u := List( L, i-> [ i, "IsomorphismToCanonicalExactTriangle" ] );
        AddToToDoList( ToDoListEntry( u, 
                    function( )
                    local can_D, isos, mors, mor;
                    SetIsExactTriangle( D, true );
                    can_D := UnderlyingCanonicalExactTriangle( D );
                    isos := List( L, IsomorphismToCanonicalExactTriangle );
                    mors := List( [ 1 .. Length( L ) ], 
                                    function( k )
                                    local can_L_k, i1, i2;
                                    can_L_k := UnderlyingCanonicalExactTriangle( L[ k ] );
                                    i1 := InjectionOfCofactorOfDirectSum( List( L, l-> ObjectAt( l, 0 ) ), k );
                                    i2 := InjectionOfCofactorOfDirectSum( List( L, l-> ObjectAt( l, 1 ) ), k );
                                    return CompleteToMorphismOfCanonicalExactTriangles( can_L_k, can_D, i1, i2 );
                                    end );
                    isos := List( isos, iso -> MorphismAt( iso, 2 ) );
                    mors := List( mors, mor -> MorphismAt( mor, 2 ) );

                    mor := MorphismBetweenDirectSums( TransposedMat( [ List( [ 1 .. Length( L ) ], k -> PreCompose( isos[ k ], mors[ k ] ) ) ] ) );
                    
                    mor := CreateTrianglesMorphism( D, can_D, IdentityMorphism( ObjectAt( D, 0 ) ), IdentityMorphism( ObjectAt( D, 1 ) ), mor ); 
                    
                    SetIsomorphismToCanonicalExactTriangle( D, mor );
                    
                    end ) );
        return D;

    end );
    
    Finalize( cat );
    
    return cat;
    
end );