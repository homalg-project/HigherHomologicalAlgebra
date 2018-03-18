#############################################################################
##
##  TriangulatedCategories.gi             TriangulatedCategories package
##
##  Copyright 2018,                       Kamal Saleh, Siegen University, Germany
##
#############################################################################


#################################
##
##  Declarations
##
#################################

DeclareGlobalVariable( "CAP_INTERNAL_TRIANGULATED_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD" );

DeclareCategory( "IsCapCategoryTriangle", IsObject );

DeclareCategory( "IsCapCategoryExactTriangle", IsCapCategoryTriangle );

DeclareCategory( "IsCapCategoryTrianglesMorphism", IsObject );

#################################
##
##  Saving time for declarations 
##
#################################

if not IsPackageMarkedForLoading( "FrobeniusCategoriesForCAP", ">0.1" ) then

##
 DeclareOperation( "DoDeclarationStuff", [ IsString ] );
 
## 
 InstallMethod( DoDeclarationStuff, 
                [ IsString ], 
 function( name_of_the_function )

 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsFunction, IsInt ] );
                   
 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsFunction ] );


 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsList, IsInt ] );
                   
 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsList ] );
 end );
 
fi;

#! @Chapter Creating triangulated categories and their operations
#! @Section Creating triangulated category.
#! bla bla.
#! @Section Primitive operations
#! In the following $T$ is the shift fuctor of the triangulated category $\mathcal{C}$. Its inverse will be 
#! denoted by $D$.

####################################
##
##  Methods Declarations in Records
##
####################################

#! @Arguments a
#! @Returns object
#! @Description
#! The argument is an object $a$.
#! The output is $T(a)$.
 DeclareOperationWithCache( "ShiftOfObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "ShiftOfObject" );

#! @Arguments alpha
#! @Returns morphism
#! @Description
#! The argument is a morphism $\alpha$.
#! The output is $T(\alpha)$.
 DeclareOperationWithCache( "ShiftOfMorphism", [ IsCapCategoryMorphism ] );
 DoDeclarationStuff( "ShiftOfMorphism" );

#! @Arguments a
#! @Returns object
#! @Description
#! The argument is an object $a$.
#! The output is $D(a)$.
 DeclareOperationWithCache( "ReverseShiftOfObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "ReverseShiftOfObject" );
 
#! @Arguments alpha
#! @Returns morphism
#! @Description
#! The argument is a morphism $\alpha$.
#! The output is $D(\alpha)$.
 DeclareOperationWithCache( "ReverseShiftOfMorphism", [ IsCapCategoryMorphism ] );
 DoDeclarationStuff( "ReverseShiftOfMorphism" );
 
#! @Arguments a
#! @Returns morphism
#! @Description
#! The argument is an object $a$.
#! The output is an isomorphism $\alpha: a \rightarrow TD(a)$.
 DeclareOperationWithCache( "IsomorphismFromObjectToShiftAfterReverseShiftOfTheObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "IsomorphismFromObjectToShiftAfterReverseShiftOfTheObject" );
 
#! @Arguments a
#! @Returns morphism
#! @Description
#! The argument is an object $a$.
#! The output is an isomorphism $\alpha: a \rightarrow DT(a)$.
 DeclareOperationWithCache( "IsomorphismFromObjectToReverseShiftAfterShiftOfTheObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "IsomorphismFromObjectToReverseShiftAfterShiftOfTheObject" );
 
#! @Arguments tr
#! @Returns a boolian
#! @Description
#! The argument is a triangle in the category $\mathcal{C}$.
#! The output is <C>true</C> if $tr$ is exact. Otherwise the output is <C>false</C>.
 DeclareOperationWithCache( "IsExactForTriangles", [ IsCapCategoryTriangle ] );
 DoDeclarationStuff( "IsExactForTriangles" );
 
#! @Arguments alpha
#! @Returns an exact triangle.
#! @Description
#! The input is a morphism $\alpha:a\rightarrow b$. The output is an exact triangle 
#! $a \rightarrow b \rightarrow c \rightarrow T(a)$, in which the morphism from $a$ to $b$ is $\alpha$.
 DeclareOperationWithCache( "CompleteMorphismToExactTriangle", [ IsCapCategoryMorphism ] );
 DoDeclarationStuff( "CompleteMorphismToExactTriangle" );

#! @Arguments tr1, tr2, alpha, beta
#! @Returns a morphism.
#! @Description
#! The input is two triangles $tr_1, tr_2$ and two morphisms $\alpha, \beta$ as in axiom $\mathrm{TR?}$.
#! The output is a morphism $\gamma$ that complete the diagram in $\mathrm{TR?}$ into a morphism of exact triangles.
DeclareOperationWithCache( "CompleteToMorphismOfExactTriangles",
             [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism ] );
DoDeclarationStuff( "CompleteToMorphismOfExactTriangles" );

#! @Arguments alpha, beta
#! @Returns list.
#! @Description
#! The input is two morphisms $\alpha:a\rightarrow b, \beta: b\rightarrow c$. 
#! The output is a list of $4$ exact triangle satisfying the octohedral axiom.
DeclareOperationWithCache( "OctohedralAxiom", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
DoDeclarationStuff( "OctohedralAxiom" );
 

###################################
##
## General Methods declaration
##
##################################

#! @Section General operations

#! @Arguments a,n
#! @Returns object
#! @Description
#! The argument is an object $a$.
#! The output is $T^n(a)$.
DeclareOperationWithCache( "ApplyShift", [ IsCapCategoryObject,   IsInt ] );

#! @Arguments alpha,n
#! @Returns morphism
#! @Description
#! The argument is a morphism $\alpha$.
#! The output is $T^n(\alpha)$.
DeclareOperationWithCache( "ApplyShift", [ IsCapCategoryMorphism, IsInt ] );


DeclareOperationWithCache( "ApplyCreationTrianglesByTR2", [ IsCapCategoryTriangle, IsInt ] );

#! @Arguments alpha,beta, gamma
#! @Returns a triangle
#! @Description
#! The arguments are morphism $\alpha:a\rightarrow b,\beta:b \rightarrow c, \gamma: c\rightarrow T(a)$.
#! The output is the triangle defined by $\alpha,\beta,\gamma$.
DeclareOperationWithCache( "CreateTriangle", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ]); 

#! @Arguments alpha
#! @Returns object
#! @Description
#! The input is a morphism $\alpha:a\rightarrow b$. The output is an object $c$ such that there exsits an exact triangle 
#! $a \rightarrow b \rightarrow c \rightarrow T(a)$, in which the morphism from $a$ to $b$ is $\alpha$.
DeclareOperationWithCache( "ConeObject", [ IsCapCategoryMorphism ] );

#! @Arguments alpha,beta, gamma
#! @Returns a triangle
#! @Description
#! The arguments are morphism $\alpha:a\rightarrow b,\beta:b \rightarrow c, \gamma: c\rightarrow T(a)$.
#! The output is exact triangle defined by $\alpha,\beta,\gamma$.
DeclareOperationWithCache( "CreateExactTriangle", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ]); 
                    
#! @Arguments tr
#! @Returns exact triangle
#! @Description
#! The argument is a triangle $tr$. The output is an exact triangle that equals to $tr$ as triangles.
DeclareOperationWithCache( "CreateExactTriangle", 
                    [ IsCapCategoryTriangle ] );
#! @Arguments tr1, tr2
#! @Returns a boolian
#! @Description
#! The output is <C>true</C> if $tr_1 = tr_2$. Otherwise it returns <C>false</C>.
DeclareOperationWithCache( "IsEqualForTriangles", 
                    [ IsCapCategoryTriangle, IsCapCategoryTriangle ] );

#! @Arguments tr1, tr2, f,g,h
#! @Returns morphism of triangles
#! @Description
#! The output is a morphism of triangles defined by the input data.
DeclareOperationWithCache( "CreateMorphismOfTriangles", [ IsCapCategoryTriangle, IsCapCategoryTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] ); 

#! @Arguments mor1, mor2
#! @Returns morphism of triangles
#! @Description
#! The input is two morphisms of triangles $mor_1:tr_1 \rightarrow tr_2, mor_2: tr_2 \rightarrow tr_3$.
#! The output is their pre-composition.
DeclareOperationWithCache( "PreCompose", [ IsCapCategoryTrianglesMorphism, IsCapCategoryTrianglesMorphism ] );

#! @Arguments mor2, mor1
#! @Returns morphism of triangles
#! @Description
#! The input is two morphisms of triangles $mor_1:tr_1 \rightarrow tr_2, mor_2: tr_2 \rightarrow tr_3$.
#! The output is their post-composition.
DeclareOperationWithCache( "PostCompose", [ IsCapCategoryTrianglesMorphism, IsCapCategoryTrianglesMorphism ] );

#! @Arguments tr1, tr2, alpha, beta, list
#! @Returns morphism
#! @Description
#! The input is two exact triangles and two morphisms $\alpha, \beta$ and a <C>list</C>. The list is allowed to be $[1,2],[1,3]$ or $[2,3]$.  
#! It discribes between which objects in $tr_1,tr_2$ the morphisms $\alpha, \beta$ are. The output is a morphism that 
#! complete the diagram to a morphism of exact triangles.
DeclareOperationWithCache( "CompleteToMorphismOfExactTriangles", [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism, IsList ] );

DeclareOperation( "IsExactTriangleByAxioms", [ IsCapCategoryTriangle ] );

DeclareOperation( "IsExactTriangleByTR2Backward", [ IsCapCategoryTriangle ] );

DeclareOperation( "IsExactTriangleByTR2Forward", [ IsCapCategoryTriangle ] );

DeclareOperation( "Iso_Triangles", [ IsCapCategoryTriangle, IsList ] );

DeclareOperation( "CurrentIsoClassOfTriangle", [ IsCapCategoryTriangle ] );

DeclareOperation( "SetIsIsomorphicTriangles",
                  [ IsCapCategoryTriangle, IsCapCategoryTriangle ] );
DeclareOperation( "In", [ IsCapCategoryTriangle, IsList ] );
 
DeclareOperation( "IsIsomorphicTriangles", 
               [ IsCapCategoryTriangle, IsCapCategoryTriangle ] );

###############################
##
## Attributes
##
###############################
 
#! @Section Attributes

#! @Arguments C
#! @Returns a functor
#! @Description
#! The input is finalised triangulated category $\mathcal{C}$. The output is its shift functor $T$.
DeclareAttribute( "ShiftFunctor", IsCapCategory );

#! @Arguments C
#! @Returns a functor
#! @Description
#! The input is finalised triangulated category $\mathcal{C}$. The output is the inverse of its shift functor, i.e., $D$.
DeclareAttribute( "ReverseShiftFunctor", IsCapCategory );

#! @Arguments C
#! @Returns a natural transformation
#! @Description
#! The input is finalised triangulated category $\mathcal{C}$. The output is the natural isomorphism between the identity functor
#! and $D\circ T$.
DeclareAttribute( "NaturalIsomorphismFromIdentityToReverseShiftAfterShiftFunctor", IsCapCategory );

#! @Arguments C
#! @Returns a natural transformation
#! @Description
#! The input is finalised triangulated category $\mathcal{C}$. The output is the natural isomorphism between the identity functor
#! and $T\circ D$.
DeclareAttribute( "NaturalIsomorphismFromIdentityToShiftAfterReverseShiftFunctor", IsCapCategory );

#! @Arguments tr
#! @Returns Cap category
#! @Description The input is a triangle. The output is the category of $tr$.
DeclareAttribute( "CapCategory", IsCapCategoryTriangle );

DeclareAttribute( "CapCategory", IsCapCategoryTrianglesMorphism );

DeclareAttribute( "CreateTriangleByTR2Forward", IsCapCategoryTriangle );

DeclareAttribute( "CreateTriangleByTR2Backward", IsCapCategoryTriangle );

DeclareAttribute( "Source", IsCapCategoryTrianglesMorphism );

DeclareAttribute( "Range", IsCapCategoryTrianglesMorphism );

##############################
##
## Properties
##
##############################
 
#! @Section Properties

DeclareProperty( "IsExactTriangle", IsCapCategoryTriangle );

#! @Arguments C
#! @Returns a boolian
#! @Description The output is <C>true</C> if the category is triangulated. Otherwise <C>false</C>.
DeclareProperty( "IsTriangulatedCategory", IsCapCategory );

#! @Arguments mor 
#! @Returns a boolian
#! @Description The output is <C>true</C> if $mor$ is isomorphism. Otherwise <C>false</C>.
DeclareProperty( "IsIsomorphism", IsCapCategoryTrianglesMorphism );
