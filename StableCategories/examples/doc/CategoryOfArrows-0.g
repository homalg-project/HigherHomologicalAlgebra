LoadPackage( "StableCategories" );
LoadPackage( "FunctorCategories" );

DeclareAttribute( "CategoryOfArrows", IsCapCategory );

InstallMethod( CategoryOfArrows,
          [ IsCapCategory ],
          
  function( C )
    local quiver, ring, algebra, over_Z, algebroid, arrows;
    
    quiver := RightQuiver( "q(1,2)[m:1->2]" );
    
    ring := CommutativeRingOfLinearCategory( C );
    
    if HasIsFieldForHomalg( ring ) and IsFieldForHomalg( ring ) then
      
      algebra := PathAlgebra( ring, quiver );
      
      over_Z := false;
      
    else
      
      algebra := PathAlgebra( HomalgFieldOfRationals( ), quiver );
      
      over_Z := true;
      
    fi;
    
    algebroid := Algebroid( algebra, over_Z );
    
    algebroid!.Name := "Algebroid( q(2)[m:1->2] )";
    
    arrows := Hom( algebroid, C : FinalizeCategory := false );
    
    ## Defining the system of colifting objects
    
    AddIsColiftingObject( arrows,
      { category, F } -> IsSplitEpimorphism( F( algebroid.r ) )
    );
    
    ##
    AddColiftingObject( arrows,
      function( category, A )
        local A_1, A_2, QA_1, QA_2, A_m, QA_m;
        
        A_1 := A( algebroid.1 );
        A_2 := A( algebroid.2 );
        
        QA_1 := DirectSum( A_1, A_2 );
        QA_2 := A_2;
        
        A_m := A( algebroid.m );
        
        QA_m := [
                  MorphismBetweenDirectSums(
                    [
                      [ A_m ],
                      [ IdentityMorphism( A_2 ) ]
                    ]
                  )
                ];
        
        return AsObjectInHomCategory( algebroid, [ QA_1, QA_2 ], QA_m );
    end );
    
    ##
    AddMorphismToColiftingObjectWithGivenColiftingObject( arrows,
      function( category, A, QA )
        local A_1, A_2, qA_1, qA_2;
        
        A_1 := A( algebroid.1 );
        
        A_2 := A( algebroid.2 );
        
        qA_1 := MorphismBetweenDirectSums(
                  [
                    [ IdentityMorphism( A_1 ), ZeroMorphism( A_1, A_2 ) ]
                  ]
                );
        
        qA_2 := IdentityMorphism( A_2 );
        
        return AsMorphismInHomCategory( A, [ qA_1, qA_2 ], QA );
        
      end );
      
    AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject( arrows,
      function( category, A, QA )
        local A_1, A_2, alpha, gamma, rA_1, rA_2;
        
        A_1 := A( algebroid.1 );
        
        A_2 := A( algebroid.2 );
        
        alpha := A( algebroid.m );
        
        gamma := SectionForMorphisms( alpha );
        
        rA_1 := MorphismBetweenDirectSums(
                  [
                    [ IdentityMorphism( A_1 ) ],
                    [ gamma ]
                  ]
                );
        
        rA_2 := IdentityMorphism( A_2 );
        
        return AsMorphismInHomCategory( QA, [ rA_1, rA_2 ], A );
        
      end );
    
    ##
    AddColiftingMorphismWithGivenColiftingObjects( arrows,
      function( category, QA, phi, QB )
        local phi_1, phi_2, Qphi_1, Qphi_2;
        
        phi_1 := phi( algebroid.1 );
        
        phi_2 := phi( algebroid.2 );
        
        Qphi_1 := DirectSumFunctorial( [ phi_1, phi_2 ] );
        
        Qphi_2 := phi_2;
        
        return AsMorphismInHomCategory( QA, [ Qphi_1, Qphi_2 ], QB );
        
      end );
      
    Finalize( arrows );
    
    return arrows;
    
end );


##
DeclareOperation( "CategoryOfArrowsObject",
  [ IsCapCategory, IsCapCategoryMorphism ] );

InstallMethod( CategoryOfArrowsObject,
          [ IsCapCategory, IsCapCategoryMorphism ],
          
  function( category, alpha )
    local 1_m_2;
    
    1_m_2 := Source( category );
    
    return AsObjectInHomCategory( 1_m_2, [ Source( alpha ), Range( alpha ) ], [ alpha ] );
    
end );

##
DeclareOperation( "CategoryOfArrowsMorphism",
  [ IsCapCategoryObject, IsCapCategoryMorphism,
      IsCapCategoryMorphism, IsCapCategoryObject ] );

InstallMethod( CategoryOfArrowsMorphism,
          [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ],
          
  function( A, phi_1, phi_2, B )
    
    return AsMorphismInHomCategory( A, [ phi_1, phi_2 ], B );
    
end );
