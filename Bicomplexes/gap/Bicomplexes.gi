# SPDX-License-Identifier: GPL-2.0-or-later
# Bicomplexes: Bicomplexes for Abelian categories
#
# Implementations
#

##
BindGlobal( "CREATE_BICOMPLEXES_CATEGORY",
  
  function ( cat, index_shift )
    local name, object_constructor, object_datum, morphism_constructor, morphism_datum, modeling_cat, modeling_tower_object_constructor, modeling_tower_object_datum, modeling_tower_morphism_constructor, modeling_tower_morphism_datum, bicomplexes_cat, category_filter, category_object_filter, category_morphism_filter, only_primitive_operations, FinalizeCategory;
    
    if index_shift = 1 then
      
      name := "cochains";
      modeling_cat := ComplexesCategoryByCochains( ComplexesCategoryByCochains( cat ) );
      category_filter := IsBicomplexesCategoryByCochains;
      category_object_filter := IsCochainBicomplex;
      category_morphism_filter := IsCochainBicomplexMorphism;
       
    elif index_shift = -1 then
      
      name := "chains";
      modeling_cat := ComplexesCategoryByChains( ComplexesCategoryByChains( cat ) );
      category_filter := IsBicomplexesCategoryByChains;
      category_object_filter := IsChainBicomplex;
      category_morphism_filter := IsChainBicomplexMorphism;
     
    else
      Error( "the index_shift must be either 1 or -1!" );
    fi;
    
    ##
    object_constructor := { bicomplexes_cat, datum } -> CreateCapCategoryObjectWithAttributes( bicomplexes_cat,
                                                                ObjectFunction, datum[1],
                                                                HorizontalDifferentialFunction, datum[2],
                                                                VerticalDifferentialFunction, datum[3],
                                                                LeftBound, datum[4],
                                                                RightBound, datum[5],
                                                                BelowBound, datum[6],
                                                                AboveBound, datum[7] );

    
    ##
    object_datum := { bicomplexes_cat, o } -> [ ObjectFunction( o ),
                                                HorizontalDifferentialFunction( o ),
                                                VerticalDifferentialFunction( o ),
                                                LeftBound( o ),
                                                RightBound( o ),
                                                BelowBound( o ),
                                                AboveBound( o ) ];
    
    ##
    morphism_constructor := { bicomplexes_cat, S, datum, R }  -> CreateCapCategoryMorphismWithAttributes( bicomplexes_cat,
                                                                    S, R,
                                                                    MorphismFunction, datum );
    
    ##
    morphism_datum := { bicomplexes_cat, m } -> MorphismFunction( m );
    
    ## from the raw object data to the object in the highest stage of the tower
    modeling_tower_object_constructor :=
      function ( bicomplexes_cat, datum )
        local modeling_cat, coch_cat, objects, diffs;
        
        modeling_cat := ModelingCategory( bicomplexes_cat );
        
        coch_cat := UnderlyingCategory( modeling_cat );
        
        objects := AsZFunction(
                      i -> CreateComplex( coch_cat,
                              AsZFunction( j -> datum[1](i, j) ),
                              AsZFunction( j -> (-1)^i * datum[3](i, j) ),
                              datum[6],
                              datum[7] ) );
        
        diffs := AsZFunction(
                      i -> CreateComplexMorphism( coch_cat,
                              objects[i],
                              AsZFunction( j -> datum[2]( i, j ) ),
                              objects[i+index_shift] ) );
        
        return CreateComplex( modeling_cat, objects, diffs, datum[4], datum[5] );
        
    end;
    
    ## from the object in the highest stage of the tower to the raw object datum
    modeling_tower_object_datum :=
                      { bicomplexes_cat, obj } ->
                            [ {i,j} -> obj[i][j],
                              {i,j} -> (obj^i)[j],
                              {i,j} -> (-1)^i * (obj[i])^j,
                              LowerBound( obj ),
                              UpperBound( obj ),
                              Minimum( List( [ LowerBound( obj ) .. UpperBound( obj ) ], i -> LowerBound( obj[i] ) ) ),
                              Maximum( List( [ LowerBound( obj ) .. UpperBound( obj ) ], i -> UpperBound( obj[i] ) ) ) ];
    
    ## from the raw morphism datum to the morphism in the highest stage of the tower
    modeling_tower_morphism_constructor :=
      function ( bicomplexes_cat, source, datum, range )
        local modeling_cat, coch_cat, morphisms;
        
        modeling_cat := ModelingCategory( bicomplexes_cat );
        
        coch_cat := UnderlyingCategory( modeling_cat );
        
        morphisms := AsZFunction(
                      i -> CreateComplexMorphism( coch_cat,
                            source[i],
                            AsZFunction( j -> datum( i, j ) ),
                            range[i] ) );
        
        return CreateComplexMorphism( modeling_cat,
                            source,
                            morphisms,
                            range );
        
    end;
    
    ## from the morphism in the highest stage of the tower to the raw morphism datum
    modeling_tower_morphism_datum :=
      { bicomplexes_cat, mor } -> {i,j} -> mor[i][j];
    
    ##
    bicomplexes_cat :=
      ReinterpretationOfCategory( modeling_cat,
              rec( name := Concatenation( "Bicomplexes category by ", name, " ( ", Name( cat ), " )" ),
                   category_filter := category_filter,
                   category_object_filter := category_object_filter,
                   category_morphism_filter := category_morphism_filter,
                   object_constructor := object_constructor,
                   object_datum := object_datum,
                   morphism_datum := morphism_datum,
                   morphism_constructor := morphism_constructor,
                   modeling_tower_object_constructor := modeling_tower_object_constructor,
                   modeling_tower_object_datum := modeling_tower_object_datum,
                   modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum := modeling_tower_morphism_datum,
                   only_primitive_operations := true ) : FinalizeCategory := false );
    
    SetUnderlyingCategory( bicomplexes_cat, cat );
    
    ## add extra methods
    
    Finalize( bicomplexes_cat );
    
    return bicomplexes_cat;
    
end );

#
InstallMethod( BicomplexesCategoryByCochains,
        "for a CAP category",
        [ IsCapCategory ],
  
  cat -> CREATE_BICOMPLEXES_CATEGORY( cat, 1 )
);

#
InstallMethod( BicomplexesCategoryByChains,
        "for a CAP category",
        [ IsCapCategory ],
  
  cat -> CREATE_BICOMPLEXES_CATEGORY( cat, -1 )
);

######################################
#
# View, Display
#
######################################

BindGlobal( "_bicomplexes_ViewObj",
  
  function ( x )
    local b, cell, i;
    
    if IsCapCategoryObject( x ) then
      b := [ LeftBound( x ), RightBound( x ), BelowBound( x ), AboveBound( x ) ];
    else
      b := [ Minimum( LeftBound( Source( x ) ), LeftBound( Range( x ) )  ),
             Maximum( RightBound( Source( x ) ), RightBound( Range( x ) ) ),
             Minimum( BelowBound( Source( x ) ), BelowBound( Range( x ) ) ),
             Maximum( AboveBound( Source( x ) ), AboveBound( Range( x ) ) ) ];
    fi;
    
    for i in [ 1 .. 4 ] do
      
      if IsInt( b[i] ) then
        b[i] := String( b[i] );
      elif b[i] = infinity then
        b[i] := Concatenation( "+", TEXTMTRANSLATIONS!.infty );
      elif b[i] = -infinity then
        b[i] := Concatenation( "-", TEXTMTRANSLATIONS!.infty );
      fi;
      
    od;
    
    if IsCapCategoryObject( x ) then
        cell := "An object";
    elif IsCapCategoryMorphism( x ) then
        cell := "A morphism";
    fi;
    
    Print( "<", cell, " in ", Name( CapCategory( x ) ), " supported on the window [ ", b[1], " .. ", b[2], " ] x [ ", b[3], " .. ", b[4], " ]>" );
    
end );
