# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#


EnhancePackage( "LinearAlgebraForCAP" );

##
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
    
    AddObjectRepresentation( arrows, IsCapCategoryObjectInHomCategory and IsCategoryOfArrowsObject );
    
    AddMorphismRepresentation( arrows, IsCapCategoryMorphismInHomCategory and IsCategoryOfArrowsMorphism );
    
    arrows!.Name := Concatenation( "Arrows( ", Name( C ), " )" );
    
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
        
        QA_m := MorphismBetweenDirectSums(
                    [
                      [ A_m ],
                      [ IdentityMorphism( A_2 ) ]
                    ]
                  );
        
        return CategoryOfArrowsObject( arrows, QA_m );
        
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
        
        return CategoryOfArrowsMorphism( A, qA_1, qA_2, QA );
        
      end );
    
    ##
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
        
        return CategoryOfArrowsMorphism( QA, rA_1, rA_2, A );
        
      end );
    
    ##
    AddColiftingMorphismWithGivenColiftingObjects( arrows,
      function( category, QA, phi, QB )
        local phi_1, phi_2, Qphi_1, Qphi_2;
        
        phi_1 := phi( algebroid.1 );
        
        phi_2 := phi( algebroid.2 );
        
        Qphi_1 := DirectSumFunctorial( [ phi_1, phi_2 ] );
        
        Qphi_2 := phi_2;
        
        return CategoryOfArrowsMorphism( QA, Qphi_1, Qphi_2, QB );
        
      end );
    
    Finalize( arrows );
    
    return arrows;
    
end );

##
InstallMethod( CategoryOfArrowsObject,
          [ IsCapCategory, IsCapCategoryMorphism ],
          
  function( category, alpha )
    local 1_m_2, arrow;
    
    1_m_2 := Source( category );
    
    arrow := AsObjectInHomCategory( 1_m_2, [ Source( alpha ), Range( alpha ) ], [ alpha ] );
    
    SetFilterObj( arrow, IsCategoryOfArrowsObject );
    
    return arrow;
    
end );

##
InstallMethod( CategoryOfArrowsMorphism,
          [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ],
          
  function( A, phi_1, phi_2, B )
    local eta;
    
    eta := AsMorphismInHomCategory( A, [ phi_1, phi_2 ], B );
    
    SetFilterObj( eta, IsCategoryOfArrowsMorphism );
    
    return eta;
    
end );

##
InstallMethod( LaTeXStringOp,
          [ IsCategoryOfArrowsObject ],
          10^6,
  function( o )
    local 1_m_2;
    
    1_m_2 := Source( CapCategory( o ) );
    
    return LaTeXStringOp( o( 1_m_2.m ) );
    
end );

##
InstallMethod( LaTeXStringOp,
          [ IsCategoryOfArrowsMorphism ],
          10^6,
  function( phi )
    local 1_m_2, A1, A, OnlyDatum, A2, tail, phi_11, phi_, phi_22, head, B1, B, B2, body;
    
    1_m_2 := Source( CapCategory( phi ) );
    
    A1 := LaTeXStringOp( Source( phi )( 1_m_2.1 ) );
    A := LaTeXStringOp( Source( phi )( 1_m_2.m ) : OnlyDatum := true );
    A := Concatenation( "\\xrightarrow{", A, "}" );
    A2 := LaTeXStringOp( Source( phi )( 1_m_2.2 ) );
    
    A := JoinStringsWithSeparator( [ A1, A, A2 ], "\&" );
        
    tail := "\\vert \& \& \\vert";
    
    phi_11 := LaTeXStringOp( phi( 1_m_2.1 ) : OnlyDatum := true );
    phi_ := "";
    phi_22 := LaTeXStringOp( phi( 1_m_2.2 ) : OnlyDatum := true );
  
    phi_ := JoinStringsWithSeparator( [ phi_11, phi_, phi_22 ], "\&" );
    
    head := "\\downarrow \& \& \\downarrow";
    
    B1 := LaTeXStringOp( Range( phi )( 1_m_2.1 ) );
    B := LaTeXStringOp( Range( phi )( 1_m_2.m ) : OnlyDatum := true );
    B := Concatenation( "\\xrightarrow{", B, "}" );
    B2 := LaTeXStringOp( Range( phi )( 1_m_2.2 ) );
    
    B := JoinStringsWithSeparator( [ B1, B, B2 ], "\&" );
    
    body := JoinStringsWithSeparator( [ A, tail, phi_, head, B ], "\\\\" );
    
    return Concatenation(
              "\\begin{array}{ccc}\n",
              body,
              "\\end{array}"
            );

end );

##
InstallMethod( LaTeXStringOp,
          [ IsCapCategoryObjectInHomCategory ],
          
  function( F )
    local objects, g_morphisms, s, o, m;
    
    objects := List( SetOfObjects( F ), o -> [ o, ApplyCell( F, o ) ] );
    
    g_morphisms := List( SetOfGeneratingMorphisms( F ), m -> [ m, ApplyCell( F, m ) ] );
    
    s := "\\begin{array}{ccc}\n ";
    
    for o in objects do
      
      s := Concatenation(
              s,
              LaTeXStringOp( o[ 1 ] ),
              " & \\mapsto & ",
              LaTeXStringOp( o[ 2 ] ),
              " \\\\ "
            );
      
    od;
    
    s := Concatenation( s, "\\hline & & \\\\" );
    
    for m in g_morphisms do
      
      s := Concatenation(
              s,
              LaTeXStringOp( m[ 1 ] : OnlyDatum := true ),
              " & \\mapsto & ",
              LaTeXStringOp( m[ 2 ] : OnlyDatum := true ),
              " \\\\ & & \\\\"
            );
    od;
   
    s := Concatenation( s, "\\end{array}" );
    
    return s;
    
end );

##
InstallMethod( LaTeXStringOp,
          [ IsCapCategoryMorphismInHomCategory ],
          
  function( eta )
    local morphisms, only_datum, s, OnlyDatum, o;
    
    morphisms := List( SetOfObjects( eta ), o -> [ o, ApplyCell( eta, o ) ] );
     
    only_datum := ValueOption( "OnlyDatum" );
    
    s := "\\begin{array}{ccc}\n";
    
    if only_datum <> true then
      
      for o in morphisms do
        
        s := Concatenation(
                s,
                LaTeXStringOp( o[ 2 ] : OnlyDatum := true ),
                " \\\\ & & \\\\"
              );
        
      od;
      
    else
      
      for o in morphisms do
        
        s := Concatenation(
                s,
                LaTeXStringOp( o[ 1 ] ),
                " & \\mapsto & ",
                LaTeXStringOp( o[ 2 ] : OnlyDatum := true ),
                " \\\\ & & \\\\"
              );
        
      od;
    
    fi;
    
    s := Concatenation( s, "\\end{array}" );
    
    s := Concatenation( "{\\color{blue}", s, "}" );
     
    if only_datum = true then
      
      return s;
      
    else
      
      return Concatenation(
                LaTeXStringOp( Source( eta ) ),
                "\\xrightarrow{",
                s,
                "}",
                LaTeXStringOp( Range( eta ) )
              );
      
    fi;
    
end );
