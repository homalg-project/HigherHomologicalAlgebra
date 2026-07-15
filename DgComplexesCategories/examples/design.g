#! @Chapter Examples and Tests

#! @Section DgCochainComplexCategoryFromGeneratorsAndRelations

#! In this example we build a small dg cochain complex category by specifying
#! two objects $A$ and $B$ supported on $[0,2]$, a degree-$0$ closed morphism
#! $f \colon A \to B$, and a degree-$1$ closed morphism $g \colon A \to B$.
#! The relation $\partial(f) = 0$ (resp.\ $\partial(g) = 0$) is imposed
#! explicitly so that the underlying algebroid is finite-dimensional.

#! @Example
LoadPackage( "DgComplexesCategories", false );
#! true
objects := [ [ "A", [ 0, 2 ], "A" ],
             [ "B", [ 0, 2 ], "B" ] ];;
morphisms := [ [ "f", [ "A", "B" ], 0, [ 0, 2 ], "f" ],
               [ "g", [ "A", "B" ], 1, [ 0, 1 ], "g" ] ];;
relations := [ [ "Differential( f )" ],
               [ "Differential( g )" ] ];;
dgCh := DgCochainComplexCategoryFromGeneratorsAndRelations(
            objects, morphisms, relations );;
IsIdenticalObj( CapCategory( A ), dgCh );
#! true
IsIdenticalObj( CapCategory( B ), dgCh );
#! true
IsIdenticalObj( Source( f ), A );
#! true
IsIdenticalObj( Range( f ), B );
#! true
DegreeOfDgComplexMorphism( f );
#! 0
IsClosedDgComplexMorphism( f );
#! true
DegreeOfDgComplexMorphism( g );
#! 1
IsClosedDgComplexMorphism( g );
#! true
IsIdenticalObj( Source( g ), A );
#! true
IsIdenticalObj( Range( g ), B );
#! true
#! @EndExample
