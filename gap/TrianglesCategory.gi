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

                AddToReasons( "IsWellDefinedForObjects: At least one of the objects in the (triangle) is not well-defined" );
                return false;
        fi;
    
        if not IsWellDefined( MorphismAt( T, 0 ) ) or 
            not IsWellDefined( MorphismAt( T, 1 ) ) or
            not IsWellDefined( MorphismAt( T,2 ) ) then

                AddToReasons( "IsWellDefinedForObjects: At least one of the morphisms in the (triangle) is not well-defined" );
                return false;
        fi;
    
        if not IsEqualForObjects( Range( MorphismAt( T, 0 ) ), Source( MorphismAt( T, 1 ) ) ) or
            not IsEqualForObjects( Range( MorphismAt( T, 1 ) ), Source( MorphismAt( T, 2 ) ) ) or
            not IsEqualForObjects( ShiftOfObject( Source( MorphismAt( T, 0 ) ) ), Range( MorphismAt( T, 2 ) ) ) then
                AddToReasons( "IsWellDefinedForObjects: At least two consecutive morphisms in the (triangle) are not compatible" );
                return false;
        fi;
    
        if not IsZeroForMorphisms( PreCompose( MorphismAt( T, 0), MorphismAt( T, 1 ) ) ) or
            not IsZeroForMorphisms( PreCompose( MorphismAt( T, 1), MorphismAt( T, 2 ) ) ) then
                AddToReasons( "IsWellDefinedForObjects: The composition of two consecutive morphisms in the (triangle) is not zero" );
                return false;
        fi;
    
        return true;

    end );
    
    AddIsWellDefinedForMorphisms( cat, 
        function( phi )
        local T1, T2;
        
        if not IsWellDefined( Source( phi ) ) or not IsWellDefined( Range( phi) ) then
            AddToReasons( "IsWellDefinedForMorphisms: The source or range is not well-defined" );
            return false;
        fi;

        if not ForAll( [ 0 .. 3 ], i -> IsWellDefined( phi[i] ) ) then
            AddToReasons( "IsWellDefinedForMorphisms: One of the vertical morphisms is not well-defined" );
            return false;
        fi;

        T1 := Source( phi );
        T2 := Range( phi );
        
        if not IsEqualForObjects( Source( MorphismAt( phi, 0 ) ), ObjectAt( T1, 0 ) ) or 
            not IsEqualForObjects( Range( MorphismAt( phi, 0 ) ), ObjectAt( T2, 0) )  then 
            
            AddToReasons( "IsWellDefinedForMorphisms: The morphism m0 is not compatible" );
            return false;
            
        fi;
        
        if not IsEqualForObjects( Source( MorphismAt( phi, 1 ) ), ObjectAt( T1, 1 ) ) or 
            not IsEqualForObjects( Range( MorphismAt( phi, 1 ) ), ObjectAt( T2, 1) )  then 
            
            AddToReasons( "IsWellDefinedForMorphisms: The morphism m1 is not compatible" );
            return false;
        
        fi;
        
        if not IsEqualForObjects( Source( MorphismAt( phi, 2 ) ), ObjectAt( T1, 2) ) or 
            not IsEqualForObjects( Range( MorphismAt( phi, 2 ) ), ObjectAt( T2, 2) )  then 
            
            AddToReasons( "IsWellDefinedForMorphisms: The morphism m2 is not compatible" );
            return false;
        
        fi;
    
        # Is the diagram commutative?

        if not IsCongruentForMorphisms( PreCompose( MorphismAt( T1, 0 ), MorphismAt( phi, 1 ) ), PreCompose( MorphismAt( phi, 0 ), MorphismAt( T2, 0) ) ) then
        
            AddToReasons( "IsWellDefinedForMorphisms: The first squar is not commutative" );
            return false;
            
        fi;
        
        if not IsCongruentForMorphisms( PreCompose( MorphismAt( T1, 1 ), MorphismAt( phi, 2 ) ), PreCompose( MorphismAt( phi, 1 ), MorphismAt( T2, 1) ) ) then
        
            AddToReasons( "IsWellDefinedForMorphisms: The second squar is not commutative" );
            return false;
            
        fi;
        
        if not IsCongruentForMorphisms( PreCompose( MorphismAt( T1, 2), MorphismAt( phi, 3 ) ), 
                                    PreCompose( MorphismAt( phi, 2 ), MorphismAt( T2, 2) ) ) then
            AddToReasons( "IsWellDefinedForMorphisms: The third squar is not commutative" );
            return false;
            
        fi;
        
        return true;
    
    end );
    
    AddDirectSum( cat, 
        function( L )
        local m, D, u, o;
        
        m := TransposedMat( List( L, l -> List( [ 0, 1, 2 ], i -> MorphismAt( l, i ) ) ) );
        
        o := List( L, l -> l[0] );

        m := List( [ 1, 2, 3 ], l -> DirectSumFunctorial( m[ l ] ) );
        
        D := CreateTriangle( m[ 1 ], m[ 2 ], PreCompose( m[ 3 ], ShiftFactoringIsomorphism( o ) ) );

        u := List( L, i-> [ i, "IsExactTriangle", true ] );

        AddToToDoList( ToDoListEntry( u, 
                    function( )
                    local iso_from_can_triangle, iso_into_can_triangle;

                    SetIsExactTriangle( D, true );

                    iso_into_can_triangle := function( L, D )
                        local can_D, i1, i2, k, can_L_k, ik_1, ik_2, mor;

                        can_D := UnderlyingStandardExactTriangle( D );
                        i1 := List( L, IsomorphismIntoStandardExactTriangle );
                        i2 := [ ];
                        for k in [ 1 .. Length( L ) ] do
                            can_L_k := UnderlyingStandardExactTriangle( L[ k ] );
                            ik_1 := InjectionOfCofactorOfDirectSum( List( L, l-> ObjectAt( l, 0 ) ), k );
                            ik_2 := InjectionOfCofactorOfDirectSum( List( L, l-> ObjectAt( l, 1 ) ), k );
                            Add( i2, CompleteToMorphismOfStandardExactTriangles( can_L_k, can_D, ik_1, ik_2 ) );
                        od;

                        i1 := List( i1, iso -> MorphismAt( iso, 2 ) );
                        i2 := List( i2, iso -> MorphismAt( iso, 2 ) );

                        mor := MorphismBetweenDirectSums( TransposedMat( [ List( [ 1 .. Length( L ) ], k -> PreCompose( i1[ k ], i2[ k ] ) ) ] ) );

                        return CreateTrianglesMorphism( D, can_D, IdentityMorphism( ObjectAt( D, 0 ) ), IdentityMorphism( ObjectAt( D, 1 ) ), mor );

                        end;

                    AddToUnderlyingLazyMethods( D, IsomorphismIntoStandardExactTriangle, iso_into_can_triangle, [ L, D ] );

                    iso_from_can_triangle := function( L, D )
                        local can_D, i1, i2, k, can_L_k, pk_1, pk_2, mor;

                        can_D := UnderlyingStandardExactTriangle( D );
                        i1 := List( L, IsomorphismFromStandardExactTriangle );
                        i2 := [ ];
                        for k in [ 1 .. Length( L ) ] do
                            can_L_k := UnderlyingStandardExactTriangle( L[ k ] );
                            pk_1 := ProjectionInFactorOfDirectSum( List( L, l-> ObjectAt( l, 0 ) ), k );
                            pk_2 := ProjectionInFactorOfDirectSum( List( L, l-> ObjectAt( l, 1 ) ), k );
                            Add( i2, CompleteToMorphismOfStandardExactTriangles( can_D, can_L_k, pk_1, pk_2 ) );
                        od;

                        i1 := List( i1, iso -> MorphismAt( iso, 2 ) );
                        i2 := List( i2, iso -> MorphismAt( iso, 2 ) );

                        mor := MorphismBetweenDirectSums( [ List( [ 1 .. Length( L ) ], k -> PreCompose( i2[ k ], i1[ k ] ) ) ] );

                        return CreateTrianglesMorphism( can_D, D, IdentityMorphism( ObjectAt( D, 0 ) ), IdentityMorphism( ObjectAt( D, 1 ) ), mor );

                        end;
                    
                    AddToUnderlyingLazyMethods( D, IsomorphismFromStandardExactTriangle, iso_from_can_triangle, [ L, D ] );
                    
                    end ) );

        return D;

    end );

    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat, 
        function( L, n, D )
        local objs0, objs1, objs2, i0, i1, i2;

        objs0 := List( L, l -> l[0] );
        objs1 := List( L, l -> l[1] );
        objs2 := List( L, l -> l[2] );

        i0 := InjectionOfCofactorOfDirectSum( objs0, n );
        i1 := InjectionOfCofactorOfDirectSum( objs1, n );
        i2 := InjectionOfCofactorOfDirectSum( objs2, n );

        return CreateTrianglesMorphism( L[ n ], D, i0, i1, i2 );

    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat, 
        function( L, n, D )
        local objs0, objs1, objs2, p0, p1, p2;

        objs0 := List( L, l -> l[0] );
        objs1 := List( L, l -> l[1] );
        objs2 := List( L, l -> l[2] );

        p0 := ProjectionInFactorOfDirectSum( objs0, n );
        p1 := ProjectionInFactorOfDirectSum( objs1, n );
        p2 := ProjectionInFactorOfDirectSum( objs2, n );

        return CreateTrianglesMorphism( D, L[ n ], p0, p1, p2 );

    end );

    Finalize( cat );
    
    return cat;
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( CreateTriangle, 
                [ IsCapCategoryMorphism, IsCapCategoryMorphism,IsCapCategoryMorphism ],
    
    function( mor1, mor2, mor3 )
    local  triangle;
    
    triangle:= rec( T0 := Source( mor1 ),
                    t0 := mor1,
                    T1 := Source( mor2 ),
                    t1 := mor2,
                    T2 := Source( mor3 ),
                    t2 := mor3,
                    T3 :=  Range( mor3 ),
                    UnderlyingLazyMethods := [ ]
                    );
    
    ObjectifyWithAttributes( triangle, TheTypeCapCategoryTriangle,
                             UnderlyingCapCategory, CapCategory( mor1 ) 
                            );
    
    AddObject( CategoryOfTriangles( CapCategory( mor1 ) ), triangle );
    
    AddToToDoList( ToDoListEntry( [ [ triangle, "IsExactTriangle", true ] ], 
                    function( )
                    SetFilterObj( triangle, IsCapCategoryExactTriangle );
                    end ) );

    AddToToDoList( ToDoListEntry( [ [ triangle, "IsStandardExactTriangle", true ] ], 
                    function( )
                    SetFilterObj( triangle, IsCapCategoryStandardExactTriangle );
                    SetIsExactTriangle( triangle, true );
                    end ) );

    return triangle;
    
end );

##
InstallMethod( CreateExactTriangle, 
                [ IsCapCategoryMorphism, IsCapCategoryMorphism,IsCapCategoryMorphism ],
   
                       
    function( mor1, mor2, mor3 )
    local  triangle;
        
    triangle:= CreateTriangle( mor1, mor2, mor3 );
    
    SetFilterObj( triangle, IsCapCategoryExactTriangle );

    Assert( 5, IsExactTriangle( triangle ) );
    SetIsExactTriangle( triangle, true );
    
    return triangle;
    
end );

##
InstallMethod( CreateStandardExactTriangle, 
                [ IsCapCategoryMorphism, IsCapCategoryMorphism,IsCapCategoryMorphism ],
   
                       
    function( mor1, mor2, mor3 )
    local  triangle;
        
    triangle:= CreateTriangle( mor1, mor2, mor3 );
    
    SetFilterObj( triangle, IsCapCategoryStandardExactTriangle );
    Assert( 5, IsStandardExactTriangle( triangle ) );
    SetIsStandardExactTriangle( triangle, true );

    SetIsomorphismFromStandardExactTriangle( triangle, IdentityMorphism( triangle ) );
    SetIsomorphismIntoStandardExactTriangle( triangle, IdentityMorphism( triangle ) );

    return triangle;
    
end );

##
InstallMethod( CreateTrianglesMorphism, 
               [ IsCapCategoryTriangle, IsCapCategoryTriangle,
               IsCapCategoryMorphism, IsCapCategoryMorphism, 
                       IsCapCategoryMorphism ], 
               
   function( T1, T2, morphism0, morphism1, morphism2 )
   local morphism;
 
   morphism := rec( m0 := morphism0,
                    
                    m1 := morphism1,
                    
                    m2 := morphism2,
                            
                    UnderlyingLazyMethods := [ ] );
                  
   ObjectifyWithAttributes( morphism, TheTypeCapCategoryTrianglesMorphism,
                            Source, T1,
                            Range, T2,
                            UnderlyingCapCategory, CapCategory( morphism0 )
                          );
   
   AddMorphism( CategoryOfTriangles( CapCategory( morphism0 ) ), morphism );
   
   return morphism;
   
end );


##
InstallMethod( MorphismAtOp, 
                [ IsCapCategoryTriangle, IsInt ],
    function( T, i )
    
    if i = 0 then return T!.t0;
    
    elif i = 1 then return T!.t1;
    
    elif i = 2 then return T!.t2;
    
    else Error( "The second entry should be 0, 1 or 2" );
    
    fi;

end );

##
InstallMethod( ObjectAtOp, 
                [ IsCapCategoryTriangle, IsInt ],
    function( T, i )
    
    if i = 0 then return T!.T0;
    
    elif i = 1 then return T!.T1;
    
    elif i = 2 then return T!.T2;
    
    elif i = 3 then return T!.T3;
    
    else Error( "The second entry should be 0, 1, 2 or 3" );
    
    fi;

end );

##
InstallMethod( MorphismAtOp, 
                [ IsCapCategoryTrianglesMorphism, IsInt ],
    function( phi, i )
    
    if i = 0 then return phi!.m0;
    
    elif i = 1 then return phi!.m1;
    
    elif i = 2 then return phi!.m2;
    
    elif i = 3 then return ShiftOfMorphism( phi!.m0 );
    
    else
        Error( "Index can be 0,1,2 or 3" );
    fi;

end );

##
InstallMethod( \^, [ IsCapCategoryTriangle, IsInt ],
    function( T, i )
    return MorphismAt( T, i );

end );

##
InstallMethod( \[\], [ IsCapCategoryTriangle, IsInt ],
    function( T, i )
    return ObjectAt( T, i );

end );

##
InstallMethod( \[\], [ IsCapCategoryTrianglesMorphism, IsInt ],
    function( phi, i )
    return MorphismAt( phi, i );

end );

##
InstallMethod( AddToUnderlyingLazyMethods, 
            [ IsCapCategoryCell, IsOperation, IsFunction, IsList ],
    function( C, method_name, F, l )
    
    Add( C!.UnderlyingLazyMethods, method_name );
    Add( C!.UnderlyingLazyMethods, F );
    Add( C!.UnderlyingLazyMethods, l );

end );

##
InstallMethod( ExtendFunctorToTrianglesCategory, [ IsCapFunctor ],

    function( F )
    local source, range, name, functor;
    
    # Note: F must commute with the Shift functor.

    source := AsCapCategory( Source( F ) );
    range := AsCapCategory( Range( F ) );
    
    source := CategoryOfTriangles( source );
    range := CategoryOfTriangles( range );
    
    name := Concatenation( "Extension of ", Name( F ) );
    
    functor := CapFunctor( name, source, range );

    AddObjectFunction( functor, 
    
        function( T )
          
        return CreateTriangle( ApplyFunctor(F, T^0), ApplyFunctor(F, T^1), ApplyFunctor(F, T^2) );
          
        end );
          
    AddMorphismFunction( functor, 
    
        function( new_source, phi, new_range )
          
        return CreateTrianglesMorphism( new_source, new_range, ApplyFunctor(F,phi[0]), ApplyFunctor(F,phi[1]), ApplyFunctor(F,phi[2]) );
          
        end );
          
    return functor;

end );

##
InstallMethod( MappingCone,
                [ IsCapCategoryMorphism ],

    function( phi )
    local T1, T2, t0, t1, t2;

    T1 := Source( phi );
    
    T2 := Range( phi );
    
    t0 := MorphismBetweenDirectSums( 
                                    [
                                        [ AdditiveInverse( T1^1 ), phi[1] ],
                                        [ ZeroMorphism( T2[0], T1[2]), T2^0]
                                    ]
                                    );
    t1 := MorphismBetweenDirectSums( 
                                    [
                                        [ AdditiveInverse( T1^2 ), phi[2] ],
                                        [ ZeroMorphism( T2[1], T1[3]), T2^1]
                                    ]
                                    );
    t2 := MorphismBetweenDirectSums( 
                                    [
                                        [ AdditiveInverse( ShiftOfMorphism( T1^0 ) ), ShiftOfMorphism( phi[0] ) ],
                                        [ ZeroMorphism( T2[2], ShiftOfObject( T1[1]) ) , T2^2]
                                    ]
                                    );
    return CreateTriangle( t0, t1, t2 );

end );
##############################
##
##  View
##
##############################

InstallMethod( ViewObj,
               
               [ IsCapCategoryTriangle ], 
               
    function( triangle )

    if IsCapCategoryStandardExactTriangle( triangle ) then 
        Print( "<A canonical exact triangle in ", Name( CapCategory( ObjectAt( triangle, 0 ) ) ), ">" );
    elif IsCapCategoryExactTriangle( triangle ) then 
        if HasIsStandardExactTriangle( triangle ) and not IsStandardExactTriangle( triangle ) then
            Print( "<An exact (not canonical) triangle in ", Name( CapCategory( ObjectAt( triangle, 0) ) ), ">");
        else
            Print( "<An exact triangle in ", Name( CapCategory( ObjectAt( triangle, 0 ) ) ), ">");
        fi;
    else
        Print( "<A triangle in ", Name( CapCategory( ObjectAt( triangle, 0 ) ) ), ">" );
    fi;

end );
  
InstallMethod( ViewObj, 

               [ IsCapCategoryTrianglesMorphism ], 
               
    function( morphism )
  
        Print( "<A morphism of triangles in ", CapCategory( MorphismAt( morphism, 0 ) ), ">" );
  
end );


##############################
##
##  Display
##
##############################


InstallMethod( Display,

        [ IsCapCategoryTriangle ],

    function( triangle )
    if IsCapCategoryStandardExactTriangle( triangle ) then
        Print( "A standard exact triangle given by the sequence\n\n");
    elif IsCapCategoryExactTriangle( triangle ) then
        Print( "An exact triangle given by the sequence\n\n");
    else
        Print( "A triangle given by the sequence\n\n" );
    fi;

    Print( "     τ0         τ1         τ2           \n");
    Print( "T0 ------> T1 ------> T2 ------> Σ(T0)\n" );
    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\n\nT0:\n\n" , TextAttr.reset );
    Display( ObjectAt( triangle, 0 ) );
    Print(      "\n------------------------------------\n\n" );
    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "τ0:\n\n", TextAttr.reset );
    Display( MorphismAt( triangle, 0 ) );
    Print(      "\n------------------------------------\n\n" );
    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "T1:\n\n" , TextAttr.reset );
    Display( ObjectAt( triangle, 1 ) );
    Print(      "\n------------------------------------\n\n" );
    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "τ1:\n\n", TextAttr.reset );
    Display( MorphismAt( triangle, 1 ) );
    Print(      "\n------------------------------------\n\n" );
    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "T2:\n\n" , TextAttr.reset );
    Display( ObjectAt( triangle, 2 ) );
    Print(      "\n------------------------------------\n\n" );
    Print(  TextAttr.bold, TextAttr.1, TextAttr.underscore,     "τ2:\n\n", TextAttr.reset );
    Display( MorphismAt( triangle, 2 ) );
    Print(      "\n------------------------------------\n\n" );
    Print(     TextAttr.bold, TextAttr.1, TextAttr.underscore,  "Σ(T0):\n\n" , TextAttr.reset );
    Display( ShiftOfObject( ObjectAt( triangle, 0 ) ) );

end, 5 );

##
InstallMethod( Display,
        [ IsCapCategoryTrianglesMorphism ],

    function( morphism )

    Print( "A morphism of triangles:\n");

    Print( "          τ0         τ1         τ2             \n" );
    Print( "Tr1: T0 ------> T1 ------> T2 ------> Σ(T0)    \n" );
    Print( "     |          |          |            |      \n" );
    Print( "     | m0       | m1       | m2         | Σ(m0)\n" );
    Print( "     |          |          |            |      \n" );
    Print( "     V          V          V            V      \n" );
    Print( "Tr2: T0 ------> T1 ------> T2 ------> Σ(T0)    \n" );
    Print( "          τ0         τ1         τ2             \n" );
    Print( "\n---------------------------------------------\n" );
    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\nm0:\n\n" );
    Display( MorphismAt( morphism, 0 ) );
    Print( "-----------------------------------------------\n" );
    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\nm1:\n\n" );
    Display( MorphismAt( morphism, 1 ) );
    Print( "-----------------------------------------------\n" );
    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\nm2:\n\n" );
    Display( MorphismAt( morphism, 2 ) );
    Print( "-----------------------------------------------\n" );
    Print( TextAttr.bold, TextAttr.1, TextAttr.underscore, "\nΣ(m0):\n\n" );
    Display( MorphismAt( morphism, 3 ) );
    Print( "-----------------------------------------------\n" );

 end );
