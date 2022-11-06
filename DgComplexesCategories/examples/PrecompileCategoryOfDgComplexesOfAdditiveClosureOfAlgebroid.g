#! @Chapter Precompilation

#! @Section Precompiling the category of dg complexes

#! @Example

LoadPackage( "Algebroids", false );
#! true

LoadPackage( "FreydCategoriesForCAP", false );
#! true

LoadPackage( "DgComplexesCategories", false );
#! true

LoadPackage( "CompilerForCAP", false );
#! true

ReadPackage( "Algebroids", "gap/CompilerLogic.gi" );
#! true

ReadPackage( "DgComplexesCategories", "gap/CompilerLogic.gi" );
#! true

category_constructor := { Q, F } -> DgComplexesOfAdditiveClosureOfAlgebroid( Algebroid( F, MATRIX_CATEGORY( Q : FinalizeCategory := true ) : FinalizeCategory := true ) );

Q := HomalgFieldOfRationals( );;
quiver := RightQuiver( "q(3)[a:1->2,b:2->3]" );;
F := FreeCategory( quiver );
QF := Q[F];;
A := QF / [ QF.ab ];;

# only valid for the construction above
# FIXME: IsInt should be IsRat, but specializations of types are not yet supported by CompilerForCAP
CapJitAddTypeSignature( "CoefficientsOfPaths", [ IsList, IsQuiverAlgebraElement ], rec( filter := IsList, element_type := rec( filter := IsInt ) ) );

given_arguments := [ Q, F ];
compiled_category_name := "CategoryOfDgComplexesOfAdditiveClosureOfAlgebroidPrecompiled";;
package_name := "DgComplexesCategories";;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name
   : operations := "primitive"
);;

CategoryOfDgComplexesOfAdditiveClosureOfAlgebroidPrecompiled( Q, F );
#! DgCochainComplexCategory( Additive closure(
#! Algebroid( Q, FreeCategory( RightQuiver( "q(3)[a:1->2,b:2->3]" ) ) ) ) )

cat := DgComplexesOfAdditiveClosureOfAlgebroid( A );
#! DgCochainComplexCategory( Additive closure(
#! Algebroid( Q, FreeCategory( RightQuiver( "q(3)[a:1->2,b:2->3]" ) ) ) ) )

# Now we check whether the compiled code is loaded automatically.
# For this we use the name of the argument of `InitialObject`;
# for non-compiled code it is "cat", while for compiled code it is "cat_1":
argument_name := NamesLocalVariablesFunction(
    Last( cat!.added_functions.PreCompose )[1] )[1];;

(ValueOption( "no_precompiled_code" ) = true and argument_name = "cat") or
    (ValueOption( "no_precompiled_code" ) = fail and argument_name = "cat_1");
#! true

#! @EndExample
