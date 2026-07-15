# SPDX-License-Identifier: GPL-2.0-or-later
# DgComplexesCategories: Category of graded (co)chain complexes of an additive category
#
# Implementations
#

# _dgcomplexes_RandomDirectedCollectionDatum( objects_infos, nr_generating_morphisms )
#
# Randomly generates a directed collection datum suitable for
# DgCochainComplexCategoryFromGeneratorsAndRelations.
#
# Arguments:
#   objects_infos := [ nr_objects, bounds ]
#     - nr_objects: positive integer, the number of exceptional objects E_1 < ... < E_n
#     - bounds: [ lower, upper ], the cohomological support interval shared by all objects
#   nr_generating_morphisms: non-negative integer, the number of generating Hom-spaces to add
#     (each becomes a single degree-0 morphism E_i -> E_j with i < j, chosen randomly)
#
# Returns [ objects, morphisms, relations ] where each morphism f satisfies d(f) = 0.
BindGlobal( "_dgcomplexes_RandomDirectedCollectionDatum",
  
  function( objects_infos, nr_generating_morphisms )
    local nr_objects, bounds, objects, sources, ranges, generating_morphisms, morphisms, relations, name, latex, info, i;
    
    nr_objects := objects_infos[1];
    bounds := objects_infos[2];
    
    objects := List( [ 1 .. nr_objects ], i -> [ Concatenation( "E", String( i ) ), bounds, Concatenation( "E_{", String( i ), "}" ) ] );
    
    sources := List( [ 1 .. nr_generating_morphisms ], i -> Random( [ 1 .. nr_objects - 1 ] ) );
    ranges := List( [ 1 .. nr_generating_morphisms ], i -> Random( [ sources[i] + 1 .. nr_objects ] ) );
    
    generating_morphisms := Collected( ListN( sources, ranges, { s, r } -> [ s, r ] ) );
    
    morphisms := [];
    relations := [];
    
    for info in generating_morphisms do
      
      for i in [ 1 .. info[2] ] do
        
        name := Concatenation( "f", String( info[1][1] ), "_", String( info[1][2] ), "_", String( i ) );
        latex := Concatenation( "f_{", String( info[1][1] ), ",", String( info[1][2] ), ",", String( i ), "}" );
        
        Add( morphisms, [ name, [ objects[info[1][1]][1], objects[info[1][2]][1] ], 0, bounds, latex ] );
        Add( relations, [ Concatenation( "Differential( ", name, " )" ) ] );
        
      od;
        
    od;
    
    return [ objects, morphisms, relations ];
    
end );

# objects := [ [ "A", [ 0, 5 ] ],
#              [ "B", [ 1, 6 ] ] ];
# 
# morphisms := [ [ "phi", [ "A", "B" ], 1, [ 0, 5 ], "\\phi" ],
#           [ "psi", [ "B", "A" ], -1, [ 1, 6 ], "\\psi" ] ];
# 
# relations := [ [ "PreCompose( phi, psi )" ] ];

# DgCochainComplexCategoryFromGeneratorsAndRelations( objects, morphisms, relations )
#
# Constructs a Dg cochain complex category from a generators-and-relations presentation.
# The underlying linear category is k-linear (over Q), taken as an additive closure of
# the path category of the induced quiver modulo the given relations plus d^2 = 0.
# As a side effect, each object and morphism name is declared as a global synonym
# for the corresponding DgCochainComplex / DgCochainComplexMorphism.
#
# Arguments:
#   objects: list of entries [ name, [ lower, upper ] ] or [ name, [ lower, upper ], latex ]
#     - name:  string, label for the object (also declared as a global synonym)
#     - [lower, upper]: cohomological support interval
#     - latex: optional LaTeX string (defaults to name)
#
#   morphisms: list of entries [ name, [ src_label, tgt_label ], degree, bounds, latex ]
#     - name:       string, label for the morphism (also declared as a global synonym)
#     - src_label, tgt_label: labels of source/target objects (strings)
#     - degree:     integer, the cohomological degree shift
#     - bounds:     [ lower, upper ] restricting which components exist, or fail for automatic
#     - latex:      optional LaTeX string (defaults to name)
#
#   relations: list of entries [ expr_string ]
#     - expr_string: GAP expression (string) evaluating to a DgCochainComplexMorphism
#
# Returns the Dg cochain complex category dgCh( AdditiveClosure( oid ) )
# where oid is the algebroid defined by the quiver with objects and morphisms modulo the given relations.
# Data tables can be accessed via CategoryDatum( oid ).
BindGlobal( "DgCochainComplexCategoryFromGeneratorsAndRelations",
        
  function ( arg )
    local objects, morphisms, relations, lower_bound, upper_bound, o, d, m, q, F, k, kF, additive_closure, dgCh_additive_closure, i,
      mat, linear_rels, rel, oid, morphism_info, object_info, obj, relation_info;

    if Length( arg ) = 1 then
        objects := arg[1][1];
        morphisms := arg[1][2];
        relations := arg[1][3];
    else
        objects := arg[1];
        morphisms := arg[2];
        relations := arg[3];
    fi;
    for object_info in objects do
        
        if not IsBound( object_info[3] ) then
            object_info[3] := object_info[1];
        fi;
        
    od;
     
    for morphism_info in morphisms do
        
        if IsString( morphism_info[2][1] ) then
            morphism_info[2] := [
                PositionProperty( objects, o -> o[1] = morphism_info[2][1] ),
                PositionProperty( objects, o -> o[1] = morphism_info[2][2] ) ];
        fi;
        
        if IsList( morphism_info[4] ) then
          
          morphism_info[4][1] := Maximum( objects[morphism_info[2][1]][2][1], objects[morphism_info[2][2]][2][1] - morphism_info[3], morphism_info[4][1] );
          morphism_info[4][2] := Minimum( objects[morphism_info[2][1]][2][2], objects[morphism_info[2][2]][2][2] - morphism_info[3], morphism_info[4][2] );
          
        elif morphism_info[4] = fail then
          
          morphism_info[4] := [ ];
          morphism_info[4][1] := Maximum( objects[morphism_info[2][1]][2][1], objects[morphism_info[2][2]][2][1] - morphism_info[3] );
          morphism_info[4][2] := Minimum( objects[morphism_info[2][1]][2][2], objects[morphism_info[2][2]][2][2] - morphism_info[3] );
          
        else
          
          Error( "Wrong input!\n" );
          
        fi;
        
        if not IsBound( morphism_info[5] ) then
            morphism_info[5] := morphism_info[1];
        fi;
        
    od;
    
    o := Concatenation(
                List( objects, object_info ->
                        List( [ object_info[2][1] .. object_info[2][2] ],
                          j -> [ Concatenation( object_info[1], "_", ReplacedString( String(j), "-", "m" ) ),
                                 Concatenation( object_info[3], "^{", String(j), "}" ) ] ) ) );
    
    d := Concatenation(
                List( objects,
                 object_info -> List( [ object_info[2][1] .. object_info[2][2] - 1 ],
                                   i -> [ Concatenation( "d", object_info[1], "_", ReplacedString( String( i ), "-", "m" ),
                                                         ":",
                                                         object_info[1], "_", ReplacedString( String( i ), "-", "m" ),
                                                         "->",
                                                         object_info[1], "_", ReplacedString( String( i + 1 ), "-", "m"  ) ),
                                          Concatenation( "\\partial_{", object_info[1], "}^{", String( i ), "}" ) ] ) ) );
    
    m := Concatenation(
                List( morphisms, morphism_info ->
                        List( [ morphism_info[4][1] .. morphism_info[4][2] ],
                            j -> [  Concatenation(
                                            morphism_info[1],
                                            "_",
                                            ReplacedString( String( j ), "-", "m" ),
                                            ":",
                                            Concatenation( objects[morphism_info[2][1]][1], "_", ReplacedString( String(j), "-", "m" ) ),
                                            "->",
                                            Concatenation( objects[morphism_info[2][2]][1], "_", ReplacedString( String(j+morphism_info[3]), "-", "m" ) ) ),
                                    Concatenation(
                                            morphism_info[5],
                                            "^{",
                                            String( j ),
                                            "}" ) ] ) ) );
    
    q := (function()
        local o_labels, parse_src, parse_tgt, dm;
        o_labels := List( o, z -> z[1] );
        parse_src := function( label )
            local colon, arrow;
            colon := Position( label, ':' );
            arrow := PositionSublist( label, "->", colon );
            return label{[ colon + 1 .. arrow - 1 ]};
        end;
        parse_tgt := function( label )
            local colon, arrow;
            colon := Position( label, ':' );
            arrow := PositionSublist( label, "->", colon );
            return label{[ arrow + 2 .. Length( label ) ]};
        end;
        dm := Concatenation( d, m );
        return FinQuiver( [
            "q",
            [ Length( o ),
              o_labels,
              List( o, z -> z[2] ) ],
            [ Length( dm ),
              List( dm, z -> Position( o_labels, parse_src( z[1] ) ) ),
              List( dm, z -> Position( o_labels, parse_tgt( z[1] ) ) ),
              List( dm, z -> SplitString( z[1], ":" )[1] ),
              List( dm, z -> z[2] ) ] ] );
    end)();
    
    F := PathCategory( q );
    
    k := HomalgFieldOfRationals( );
    
    kF := k[ F ];
    
    additive_closure := AdditiveClosure( kF );
    
    dgCh_additive_closure := DgCochainComplexCategory( additive_closure );
    
    for object_info in objects do
        
        MakeReadWriteGlobal( object_info[1] );
        
        DeclareSynonym( object_info[1],
            DgCochainComplex(
                dgCh_additive_closure,
                List( [ object_info[2][1] .. object_info[2][2] - 1 ],
                  i -> kF.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / additive_closure ),
                object_info[2][1] ) );
    od;
    
    for morphism_info in morphisms do
        
        MakeReadWriteGlobal( morphism_info[1] );
        
        DeclareSynonym( morphism_info[1],
            DgCochainComplexMorphism(
                dgCh_additive_closure,
                EvalString( objects[morphism_info[2][1]][1] ),
                EvalString( objects[morphism_info[2][2]][1] ),
                morphism_info[3],
                List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> kF.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / additive_closure ),
                morphism_info[4][1] ) );
    
    od;
    
    linear_rels := [ ];
    
    for object_info in objects do
        obj := EvalString( object_info[1] );
        for i in [ object_info[2][1] .. object_info[2][2] - 2 ] do
            Add( linear_rels, MorphismMatrix( PreCompose( obj^i, obj^(i+1) ) )[1,1] );
        od;
    od;
    
    for relation_info in relations do
        m := EvalString( relation_info[1] );
        for i in [ LowerBoundOfDgComplex( Source( m ) ) .. UpperBoundOfDgComplex( Source( m ) ) ] do
            mat := MorphismMatrix( m[i] );
            if IsBound( mat[1] ) and IsBound( mat[1][1] ) then
                Add( linear_rels, mat[1,1] );
            fi;
        od;
    od;
    
    oid := AlgebroidFromDataTables( kF / linear_rels );
    
    additive_closure := AdditiveClosure( oid );
    
    dgCh_additive_closure := DgCochainComplexCategory( additive_closure );
    
    for object_info in objects do
        
        MakeReadWriteGlobal( object_info[1] );
        
        DeclareSynonym( object_info[1],
            DgCochainComplex(
                dgCh_additive_closure,
                List( [ object_info[2][1] .. object_info[2][2] - 1 ],
                  i -> oid.( Concatenation( "d", object_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / additive_closure ),
                object_info[2][1] ) );
    od;
    
    for morphism_info in morphisms do
        
        MakeReadWriteGlobal( morphism_info[1] );
        
        DeclareSynonym( morphism_info[1],
            DgCochainComplexMorphism(
                dgCh_additive_closure,
                EvalString( objects[morphism_info[2][1]][1] ),
                EvalString( objects[morphism_info[2][2]][1] ),
                morphism_info[3],
                List( [ morphism_info[4][1] .. morphism_info[4][2] ], i -> oid.( Concatenation( morphism_info[1], "_", ReplacedString( String(i), "-", "m" ) ) ) / additive_closure ),
                morphism_info[4][1] ) );
    
    od;
    
    return dgCh_additive_closure;
    
end );
