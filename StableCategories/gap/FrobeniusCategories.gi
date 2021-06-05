


#######################################
##
## Representations
##
#######################################


DeclareRepresentation( "IsCapCategoryShortSequenceRep",
                        IsCapCategoryShortSequence and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryShortExactSequenceRep",

                        IsCapCategoryShortExactSequence and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryConflationRep",

                        IsCapCategoryConflation and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryMorphismOfShortSequencesRep",

                        IsCapCategoryMorphismOfShortSequences and IsAttributeStoringRep,
                        [ ] );


##############################
##
## Family and type
##
##############################

BindGlobal( "CapCategoryShortSequencesFamily",
  NewFamily( "CapCategoryShortSequencesFamily", IsObject ) );

BindGlobal( "CapCategoryShortExactSequencesFamily",
  NewFamily( "CapCategoryShortExactSequencesFamily", IsCapCategoryShortSequence ) );

BindGlobal( "CapCategoryConflationsFamily",
  NewFamily( "CapCategoryConflationsFamily", IsCapCategoryConflation ) );

BindGlobal( "CapCategoryMorphismsOfShortSequencesFamily",
  NewFamily( "CapCategoryMorphismsOfShortSequencesFamily", IsObject ) );

BindGlobal( "TheTypeCapCategoryShortSequence",
  NewType( CapCategoryShortSequencesFamily,
                      IsCapCategoryShortSequenceRep ) );

BindGlobal( "TheTypeCapCategoryShortExactSequence",
  NewType( CapCategoryShortExactSequencesFamily,
                      IsCapCategoryShortExactSequenceRep ) );

BindGlobal( "TheTypeCapCategoryConflation",
  NewType( CapCategoryConflationsFamily,
                      IsCapCategoryConflationRep ) );

BindGlobal( "TheTypeCapCategoryMorphismOfShortSequences",
  NewType( CapCategoryMorphismsOfShortSequencesFamily,
                      IsCapCategoryMorphismOfShortSequencesRep ) );

###############################
##
##  Records and methods
##
###############################

InstallValue( CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS, rec( ) );

InstallValue( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD, rec(

IsInflation := rec(
filter_list := [ "category", "morphism" ],
return_type := "bool" ),

IsDeflation := rec(
filter_list := [ "category", "morphism" ],
return_type := "bool" ),

IsConflationPair := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "bool" ),

ExactCokernelObject := rec(
filter_list := [ "category", "morphism" ],
return_type := "object" ),

ExactCokernelProjection := rec(
io_type := [ [ "iota" ], [ "iota_range", "K" ] ],
with_given_object_position := "Range",
universal_type := "Colimit",
filter_list := [ "category", "morphism" ],
return_type := "morphism" ),

ExactCokernelProjectionWithGivenExactCokernelObject := rec(
filter_list := [ "category", "morphism", "object" ],
return_type := "morphism" ),

ExactCokernelColift := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

ColiftAlongDeflation := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

ExactKernelObject := rec(
filter_list := [ "category", "morphism" ],
return_type := "object" ),

ExactKernelEmbedding := rec(
io_type := [ [ "iota" ], [ "K", "iota_source" ] ],
with_given_object_position := "Source",
universal_type := "Limit",
filter_list := [ "category", "morphism" ],
return_type := "morphism" ),

ExactKernelEmbeddingWithGivenExactKernelObject := rec(
filter_list := [ "category", "morphism", "object" ],
return_type := "morphism" ),

ExactKernelLift := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

LiftAlongInflation := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

ExactFiberProduct:= rec(
filter_list := [ "category", "morphism" , "morphism" ],
return_type := "object" ),

ProjectionInFirstFactorOfExactFiberProduct := rec(

filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

ProjectionInSecondFactorOfExactFiberProduct := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

UniversalMorphismIntoExactFiberProduct:= rec(
filter_list := [ "category", "morphism", "morphism", "morphism", "morphism" ],
with_given_object_position := "Range",
return_type := "morphism" ),

UniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct := rec(
filter_list := [ "category", "morphism", "morphism", "morphism", "morphism", "object" ],
return_type := "morphism" ),

ExactPushout:= rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "object" ),

InjectionOfFirstCofactorOfExactPushout := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

InjectionOfSecondCofactorOfExactPushout := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

UniversalMorphismFromExactPushout := rec(
filter_list := [ "category", "morphism", "morphism", "morphism", "morphism" ],
with_given_object_position := "Source",
return_type := "morphism" ),

UniversalMorphismFromExactPushoutWithGivenExactPushout := rec(
filter_list := [ "category", "morphism", "morphism", "morphism", "morphism", "object" ],
return_type := "morphism" ),

IsExactProjectiveObject := rec(
filter_list := [ "category", "object" ],
return_type := "bool" ),

IsExactInjectiveObject := rec(
filter_list := [ "category", "object" ],
return_type := "bool" ),

SomeExactProjectiveObject := rec(
filter_list := [ "category", "object" ],
return_type := "object" ),

DeflationFromSomeExactProjectiveObject := rec(
filter_list := [ "category", "object" ],
return_type := "morphism" ),

SomeExactInjectiveObject := rec(
filter_list := [ "category", "object" ],
return_type := "object" ),

InflationIntoSomeExactInjectiveObject := rec(
filter_list := [ "category", "object" ],
return_type := "morphism" ),

ExactProjectiveLift := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

ExactInjectiveColift := rec(
filter_list := [ "category", "morphism", "morphism" ],
return_type := "morphism" ),

IsColiftableAlongInflationIntoSomeExactInjectiveObject := rec(
filter_list := [ "category", "morphism" ],
return_type := "bool" ),

IsLiftableAlongDeflationFromSomeExactProjectiveObject := rec(
filter_list := [ "category", "morphism" ],
return_type := "bool" ),

##
ColiftAlongInflationIntoSomeExactInjectiveObject := rec(
filter_list := [ "category", "morphism" ],
return_type := "morphism" ),

##
LiftAlongDeflationFromSomeExactProjectiveObject := rec(
filter_list := [ "category", "morphism" ],
return_type := "morphism" )

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD );

########################################
##
## Properties logic
##
########################################

InstallTrueMethod( IsExactCategory, IsFrobeniusCategory );

InstallTrueMethod( IsAdditiveCategory, IsExactCategory );

########################################
##
##  Constructors
##
########################################

InstallMethod( CategoryOfShortSequences,
                [ IsCapCategory ],
  function( category )
  local name, cat;

  name := Concatenation( "Category of short sequences of the ", Name( category ) );

  cat := CreateCapCategory( name );

  AddIsWellDefinedForObjects( cat,

  function( S )
  local alpha, beta;

  alpha := S^0;

  beta := S^1;

    if not IsZeroForMorphisms( PreCompose( alpha, beta ) ) then

      return false;

    fi;

  return true;

  end );

  AddIsEqualForObjects( cat,
      function( S1, S2 )
      return IsEqualForObjects( ObjectAt( S1, 0 ), ObjectAt( S2, 0 ) ) and
              IsEqualForObjects( ObjectAt( S1, 1 ), ObjectAt( S2, 1 ) ) and
               IsEqualForObjects( ObjectAt( S1, 2 ), ObjectAt( S2, 2 ) ) and
                IsEqualForMorphisms( MorphismAt( S1, 0 ), MorphismAt( S2, 0 ) ) and
                 IsEqualForMorphisms( MorphismAt( S1, 1 ), MorphismAt( S2, 1 ) );
      end );

  Finalize( cat );

  return cat;

end );

InstallMethod( CreateShortSequence,

               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],

   function( alpha, beta )
   local s;

   if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then

     Error( "Range of the first morphism should equal the Source of the second morphism" );

   fi;

   s := rec( o0:= Source( alpha ),

             m0:= alpha,

             o1 := Range( alpha ),

             m1 := beta,

             o2 := Range( beta ) );

    ObjectifyWithAttributes( s, TheTypeCapCategoryShortSequence );

    AddObject( CategoryOfShortSequences( CapCategory( alpha ) ), s );
    return s;

end );

InstallMethod( CreateShortExactSequence,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
          
  function( alpha, beta )
    local s;
    
    s := CreateShortSequence( alpha, beta );
    
    SetFilterObj( s, IsCapCategoryShortExactSequence );
    
    return s;
    
end );

##
InstallMethod( CreateConflation,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
          
  function( alpha, beta )
    local s;
    
    s := CreateShortExactSequence( alpha, beta );
    
    SetFilterObj( s, IsCapCategoryConflation );
    
    return s;
    
end );

##
InstallMethod( ObjectAtOp, [ IsCapCategoryShortSequence, IsInt ],
  function( seq, i )
    if i = 0 then
      return seq!.o0;
    elif i = 1 then
      return seq!.o1;
    elif i = 2 then
      return seq!.o2;
    else
      Error( "The integer must be 0, 1 or 2" );
    fi;
end );

##
InstallMethod( \[\], [ IsCapCategoryShortSequence, IsInt ],
  function( seq, i )
    return ObjectAt( seq, i );
end );

##
InstallMethod( MorphismAtOp, [ IsCapCategoryShortSequence, IsInt ],
  function( seq, i )
    if i = 0 then
      return seq!.m0;
    elif i = 1 then
      return seq!.m1;
    else
      Error( "The integer must be 0 or 1" );
    fi;
end );

##
InstallMethod( \^, [ IsCapCategoryShortSequence, IsInt ],
  function( seq, i )
    return MorphismAt( seq, i );
end );

##############################
##
## View
##
##############################

InstallMethod( ViewObj,

               [ IsCapCategoryShortSequence ],

  function( seq )

    if IsCapCategoryConflation( seq ) then

       Print( "<A Conflation in ", CapCategory( seq ), ">" );

    elif IsCapCategoryShortExactSequence( seq ) then

       Print( "<A short exact sequence in ", CapCategory( seq ), ">" );

    else

       Print( "<A short sequence in ", CapCategory( seq ), ">" );

    fi;

end );

#################################
##
## Display
##
#################################

InstallMethod( Display,
          [ IsCapCategoryShortSequence ],
          
  function( seq )
    
    if IsCapCategoryConflation( seq ) then
      
      Print( "A Conflation in ", CapCategory( seq ), " given by:\n" );
      
    elif IsCapCategoryShortExactSequence( seq ) then
      
      Print( "A short exact sequence in ", CapCategory( seq ), " given by:\n" );
      
    else
      
      Print( "A short sequence in ", CapCategory( seq ), " given by :\n" );
      
    fi;
    
    Print( "\n     m0          m1     " );
    Print( "\no0 ------> o1 ------> o2\n\n" );
    
    Print( "\no0 is\n\n" ); Display( seq[ 0 ] );
    Print( "\n------------------------------------\n" );
    Print( "\nm0 is\n\n" ); Display( seq^0 );
    Print( "\n------------------------------------\n" );
    Print( "\no1 is\n\n" ); Display( seq[ 1 ] );
    Print( "\n------------------------------------\n" );
    Print( "\nm1 is\n\n" ); Display( seq^1 );
    Print( "\n------------------------------------\n" );
    Print( "\no2 is\n\n" ); Display( seq[ 2 ] );
    
end );

#####################################
##
## Operations
##
#####################################

#           f1        g1
#        A ----> I1 -----> B1
#
#
#        A ----> I2 -----> B2
#           f2        g2
#
#        SchanuelsIsomorphism : I2 𐌈 B1 ----> I1 𐌈 B2
# In the stable category,  B1 ------> I2 𐌈 B1 -------> I1 𐌈 B2 -------> B2 is also supposed to be isomorphism.

##
InstallMethod( SchanuelsIsomorphism,
            [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsString ],
            
  function( inf_1, def_1, inf_2, def_2, string )
    local I1, B1, I2, B2, phi_1, phi_2, h1, h2, i_phi_1, i_phi_2, alpha, beta, m;
    
    if not string = "left" then
      TryNextMethod();
    fi;
    
    if not IsEqualForObjects( Source( inf_1 ), Source( inf_2 ) ) then
      Error( "Wrong input!" );
    fi;
    
    I1 := Source( def_1 );
    
    B1 := Range( def_1 );
    
    I2 := Source( def_2 );
    
    B2 := Range( def_2 );
    
    phi_1 := InjectionOfFirstCofactorOfExactPushout( inf_1, inf_2 );
    
    phi_2 := InjectionOfSecondCofactorOfExactPushout( inf_1, inf_2 );
    
    h1 := UniversalMorphismFromExactPushout( inf_1, inf_2, def_1, ZeroMorphism( I2, B1  ) );
    
    h2 := UniversalMorphismFromExactPushout( inf_1, inf_2, ZeroMorphism( I1, B2  ), def_2 );
    
    i_phi_1 := ExactInjectiveColift( phi_1, IdentityMorphism( I1 ) );
    
    i_phi_2 := ExactInjectiveColift( phi_2, IdentityMorphism( I2 ) );
    
    alpha := MorphismBetweenDirectSums(
      [
        [ i_phi_2, h1  ]
      ] );
    
    beta := MorphismBetweenDirectSums(
      [
        [ i_phi_1, h2  ]
      ] );
    
    m := PreCompose( InverseForMorphisms( alpha ), beta );
    
    return m;
    
end );


#           inf_1        def_1
#        A1 ------> P1 ------------> B
#
#
#        A2 ------> P2 ------------> B
#           inf_2        def_2
#
#        SchanuelsIsomorphism : A1 𐌈 P2 ----> A2 𐌈 P1
# In the stable category,  A1 ------> A1 𐌈 P2 ----> A2 𐌈 P1 -------> A2 is also supposed to be isomorphism.

InstallMethod( SchanuelsIsomorphism,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsString ],
          
  function( inf_1, def_1, inf_2, def_2, string )
    local A1, P1, A2, P2, phi_1, phi_2, h1, h2, i_phi_1, i_phi_2, alpha, beta;
    
    if not string = "right" then
      TryNextMethod();
    fi;
    
    A1 := Source( inf_1 );
    
    P1 := Range( inf_1 );
    
    A2 := Source( inf_2 );
    
    P2 := Range( inf_2 );
    
    phi_1 := ProjectionInFirstFactorOfExactFiberProduct( def_1, def_2 );
    
    phi_2 := ProjectionInSecondFactorOfExactFiberProduct( def_1, def_2 );
    
    h1 := UniversalMorphismIntoExactFiberProduct( def_1, def_2, inf_1, ZeroMorphism( A1, P2  ) );
    
    h2 := UniversalMorphismIntoExactFiberProduct( def_1, def_2, ZeroMorphism( A2, P1 ), inf_2 );
    
    i_phi_1 := ExactProjectiveLift( IdentityMorphism( P1 ), phi_1 );
    
    i_phi_2 := ExactProjectiveLift( IdentityMorphism( P2 ), phi_2 );
    
    alpha := MorphismBetweenDirectSums(
      [
        [ h1 ],
        [ i_phi_2 ]
      ] );
    
    beta := MorphismBetweenDirectSums(
      [
        [ h2 ],
        [ i_phi_1 ]
      ] );
    
    return PreCompose( alpha, InverseForMorphisms( beta ) );
    
end );

##
InstallMethod( AsResidueClassOfInflation,
          [ IsStableCategoryMorphism ],
          
  function( alpha )
    local stable_category, category, A, B, inf_A, m, D, to, fr;
    
    stable_category := CapCategory( alpha );
    
    category := UnderlyingCategory( stable_category );
    
    #if not ( HasIsFrobeniusCategory( category ) and IsFrobeniusCategory( category ) ) then
    #  Error( "The underlying category should be a frobenius category" );
    #fi;
    
    A := Source( alpha );
    B := Range( alpha );
    
    inf_A := InflationIntoSomeExactInjectiveObject( UnderlyingCell( A ) );
    
    m := MorphismBetweenDirectSums( [ [ inf_A, UnderlyingCell( alpha ) ] ] );
     
    D := StableCategoryObject( stable_category, Range( m ) );
    
    to := InjectionOfCofactorOfDirectSumWithGivenDirectSum(
                [ Range( inf_A ), UnderlyingCell( B ) ], 2, Range( m )
              );
    
    to := StableCategoryMorphism( B, to, D );
    
    SetIsoFromRangeToRangeOfResidueClassOfInflation( alpha, to );
    
    fr := ProjectionInFactorOfDirectSumWithGivenDirectSum(
                [ Range( inf_A ), UnderlyingCell( B ) ], 2, Range( m )
              );
    
    fr := StableCategoryMorphism( D, fr, B );
    
    SetIsoToRangeFromRangeOfResidueClassOfInflation( alpha, fr );
    
    return StableCategoryMorphism( A, m, D );
    
end );

##
InstallMethod( IsoFromRangeToRangeOfResidueClassOfInflation,
          [ IsStableCategoryMorphism ],
  function( alpha )
    local inf;
    
    inf := AsResidueClassOfInflation( alpha );
    return IsoFromRangeToRangeOfResidueClassOfInflation( alpha );
    
end );

##
InstallMethod( IsoFromRangeToRangeOfResidueClassOfInflation,
          [ IsStableCategoryMorphism ],
  function( alpha )
    local inf;
    
    inf := AsResidueClassOfInflation( alpha );
    return IsoFromRangeToRangeOfResidueClassOfInflation( alpha );
    
end );


##
InstallMethod( AsResidueClassOfDeflation,
          [ IsStableCategoryMorphism ],
          
  function( alpha )
    local stable_category, category, A, B, def_A, m, D;
    
    stable_category := CapCategory( alpha );
    
    category := UnderlyingCategory( stable_category );
    
    #if not ( HasIsFrobeniusCategory( category ) and IsFrobeniusCategory( category ) ) then
    #  Error( "The underlying category should be a frobenius category" );
    #fi;
    
    A := Source( alpha );
    
    B := Range( alpha );
    
    def_A := DeflationFromSomeExactProjectiveObject( UnderlyingCell( A ) );
    
    m := MorphismBetweenDirectSums( [ [ def_A ], [ UnderlyingCell( alpha ) ] ] );
    
    D := StableCategoryObject( stable_category, Source( m ) );
        
    return StableCategoryMorphism( D, m, B );
 
end );

#####################################
##
## Immediate Methods and Attributes
##
#####################################

#InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_EXACT_CATEGORY,
#               IsCapCategory and IsExactCategory,
#               0,
#
#   function( category )
#
#   AddPredicateImplicationFileToCategory( category,
#      Filename(
#        DirectoriesPackageLibrary( "FrobeniusCategories", "LogicForExactAndFrobeniusCategories" ),
#        "PredicateImplicationsForExactCategories.tex" ) );
#
#   TryNextMethod( );
#
#end );
#
#InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY,
#               IsCapCategory and IsFrobeniusCategory,
#               0,
#
#   function( category )
#
#   SetIsExactCategory( category, true );
#   SetIsExactCategoryWithEnoughExactProjectives( category, true );
#   SetIsExactCategoryWithEnoughExactInjectives( category, true );
#
#   AddPredicateImplicationFileToCategory( category,
#      Filename(
#        DirectoriesPackageLibrary( "FrobeniusCategories", "LogicForExactAndFrobeniusCategories" ),
#        "PredicateImplicationsForFrobeniusCategories.tex" ) );
#
#   TryNextMethod( );
#
#end );
