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

if not IsBound( Reasons ) then 
    DeclareGlobalVariable( "Reasons" );
    InstallValue( Reasons, [ fail ] );
    DeclareGlobalVariable( "AddToReasons" );
    DeclareGlobalVariable( "why" );
    InstallValue( AddToReasons, function( s )
                                Add( Reasons, s, 1 ); 
                                MakeReadWriteGlobal("why");
                                why := s;
                                MakeReadOnlyGlobal("why");
                                end );
fi;


DeclareGlobalVariable( "CAP_INTERNAL_TRIANGULATED_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "TRIANGULATED_CATEGORIES_METHOD_NAME_RECORD" );

####################################
##
#! @Chapter Triangulated Categories
##
####################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of triangles in a category.
#! Let $\mathcal{C}$ be an additive category and $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ an additive automorphism. A triangle in $\mathcal{C}$ (w.r.t. 
#! $\Sigma$ ) is a diagram of the form
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! X \arrow[r, "f"] & Y \arrow[r, "g"] & Z \arrow[r, "h"] & \Sigma X
#! \end{tikzcd}
#! \end{center}
#! such that the compositions of $fg,gh$ and $h\Sigma f$ are zero. Such a triangle will be denoted by $\mathrm{Tr}(f,g,h)$.
#! @EndLatexOnly
#! @Arguments obj
DeclareCategory( "IsCapCategoryTriangle", IsCapCategoryObject );

#! @Description
#! The GAP category of morphisms of triangles.
#! Let $T_1, T_2$ be two triangles in the additive category $\mathcal{C}$. A morphism of triangles is a commutative diagram
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! X_1 \arrow[r, "f_1"] \arrow[d, "u"'] & Y_1 \arrow[r, "g"] \arrow[d, "v"] & Z_1 \arrow[r, "h"] \arrow[d, "w"] & \Sigma X_1 \arrow[d, "\Sigma u"] \\
#! X_2 \arrow[r, "f_2"'] & Y_2 \arrow[r, "g_2"'] & Z_2 \arrow[r, "h_2"'] & \Sigma X_2
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! The triangles and their morphisms define with obvious composition and identities an additive category. We denote this
#! category by $\mathrm{Triangles}(\mathcal{C})$ and called the category of triangles in $\mathcal{C}$.
#! @Arguments mor
DeclareCategory( "IsCapCategoryTrianglesMorphism", IsCapCategoryMorphism );

#! @Description
#! The GAP category of exact triangles.
#! An exact triangle in a triangulated category $\mathcal{C}$ w.r.t. 
#! $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ is a triangle in $\mathcal{C}$ that belongs 
#! to the class of exact triangles in $\mathcal{C}$. I.e., a triangle that is isomorphismic to some standard exact triangle in $\mathcal{C}$.
#! @Arguments obj
DeclareCategory( "IsCapCategoryExactTriangle", IsCapCategoryTriangle );

#! @Description
#! The GAP category of standard exact triangles.
#! A standard exact triangle in a triangulated category $\mathcal{C}$ w.r.t. 
#! $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ is a triangle in $\mathcal{C}$ that belongs 
#! to the class of standard exact triangles the defines the triangulated structure of $\mathcal{C}$.
#! @Arguments obj
DeclareCategory( "IsCapCategoryStandardExactTriangle", IsCapCategoryExactTriangle );

####################################
##
#! @Section Constructors
##
####################################

###################################
##
## construction operations
##
##################################

#! @Description
#! The arguments are three morphisms $f,g,h$ in a triangulated category $\mathcal{C}$ such that 
#! $\mathrm{Range}(f)=\mathrm{Source}(g), \mathrm{Range}(g)=\mathrm{Source}(h),\mathrm{Range}(h)=\Sigma \mathrm{Source}(f)$.
#! The output is the triangle $\mathrm{Tr}(f,g,h)$ as an object in $\mathrm{Triangles}(\mathcal{C})$.
#! @Arguments f, g, h
DeclareOperation( "CreateTriangle", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] ); 

#! @Description
#! The arguments are three morphisms $f,g,h$ in a triangulated category $\mathcal{C}$ such that 
#! $\mathrm{Range}(f)=\mathrm{Source}(g), \mathrm{Range}(g)=\mathrm{Source}(h),\mathrm{Range}(h)=\Sigma \mathrm{Source}(f)$.
#! The output is the exact triangle $\mathrm{Tr}(f,g,h)$ as an object in $\mathrm{Triangles}(\mathcal{C})$.
#! @Arguments f, g, h
DeclareOperation( "CreateExactTriangle", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ]); 

#! @Description
#! The arguments are three morphisms $f,g,h$ in a triangulated category $\mathcal{C}$ such that 
#! $\mathrm{Range}(f)=\mathrm{Source}(g), \mathrm{Range}(g)=\mathrm{Source}(h),\mathrm{Range}(h)=\Sigma \mathrm{Source}(f)$.
#! The output is the standard exact triangle $\mathrm{Tr}(f,g,h)$ as an object in $\mathrm{Triangles}(\mathcal{C})$.
#! @Arguments f, g, h
DeclareOperation( "CreateStandardExactTriangle", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ]); 

#! @Description
#! The arguments are two triangles $T_1,T_2$ and three morphisms $u,v$ and $w$. The output the triangles morphism 
#! $T_1 \rightarrow T_2$ given by these morphisms.
#! @Arguments T1, T2, u,v,w
DeclareOperation( "CreateTrianglesMorphism", 
                    [ IsCapCategoryTriangle, IsCapCategoryTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] ); 

DeclareAttribute( "TrivialExactTriangle", IsCapCategoryObject );

####################################
##
##  Methods Declarations in Records
##
####################################

####################################
##
#! @Section Categorical Operations
##
####################################

#! @Description
#! The arguments are four morphisms $\alpha:Y \rightarrow X,\beta:W\rightarrow X,\gamma:Z\rightarrow Y$ 
#! and $\delta:Z\rightarrow W$. Such that $ \alpha \circ \gamma \sim_{Z,X}  \beta\circ \delta$.
#! The output is a morphism $\lambda:Y\rightarrow W$ that is a colift of
#! $\delta$ along $\gamma$ and is a lift of $\alpha$ along $\beta$. I.e., 
#! $\lambda \circ \gamma \sim_{Z,W} \delta$ and $\beta \circ \lambda \sim_{Y,X} \alpha$; or fail if such a morphism doesn't exist.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#!   & Y \arrow[ld, "\alpha"'] \arrow[dd, "\lambda" description, dashed] &\\
#! X &  & Z \arrow[lu, "\gamma"'] \arrow[ld, "\delta"] \\
#!   & W \arrow[lu, "\beta"]&
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism in $\mathrm{Hom}(Y,W)$ + {$\mathtt{fail}$}
#! @Arguments alpha, beta, gamma, delta
DeclareOperation( "LiftColift", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#! @Description
#! The arguments are a category $\mathcal{C}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation LiftColift. The function $F$ maps a quadruple $\alpha,\beta,\gamma,\delta$ to 
#! a morphism $\lambda$ as described above if it exists or to fail otherwise.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLiftColift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftColift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftColift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftColift", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $X$ in a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$.
#! The output is $\Sigma X$.
#! @Returns an object
#! @Arguments X
DeclareAttribute( "ShiftOfObject", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation ShiftOfObject. The function $F$ maps an object $X$ to $\Sigma X$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddShiftOfObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftOfObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftOfObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftOfObject", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $f$ in a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$.
#! The output is $\Sigma f$.
#! @Returns a morphism
#! @Arguments f
DeclareAttribute( "ShiftOfMorphism", IsCapCategoryMorphism );
 
 #! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation ShiftOfMorphism. The function $F$ maps a morphism $f$ to $\Sigma f$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddShiftOfMorphism", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftOfMorphism", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftOfMorphism", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftOfMorphism", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $X$ in a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$.
#! The output is $\Sigma^{-1} X$.
#! @Returns an object
#! @Arguments X
DeclareAttribute( "ReverseShiftOfObject", IsCapCategoryObject );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation ReverseShiftOfObject. The function $F$ maps an object $X$ to $\Sigma^{-1} X$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddReverseShiftOfObject", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddReverseShiftOfObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseShiftOfObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseShiftOfObject", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $f$ in a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$.
#! The output is $\Sigma^{-1} f$.
#! @Returns a morphism
#! @Arguments f
DeclareAttribute( "ReverseShiftOfMorphism", IsCapCategoryMorphism );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation ShiftOfMorphism. The function $F$ maps a morphism $f$ to $\Sigma^{-1} f$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddReverseShiftOfMorphism", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddReverseShiftOfMorphism", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseShiftOfMorphism", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseShiftOfMorphism", [ IsCapCategory, IsList ] );


KeyDependentOperation( "Shift", IsCapCategoryCell, IsInt, ReturnTrue );

##
#! @Description
#! The arguments are list $L=[A_1,\dots,A_n]$ and two objects $X=\Sigma \bigoplus_i A_i, Y=\bigoplus_i \Sigma A_i$.
#! The output is the isomorphism $X \rightarrow Y$ associated to $\Sigma$.
#! @Returns a morphism
#! @Arguments X, L, Y
DeclareOperation( "ShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation ShiftExpandingIsomorphismWithGivenObjects. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a list $L=[A_1,\dots,A_n]$.
#! The output is the isomorphism $X \rightarrow Y$ associated to $\Sigma$, where 
#! $X=\Sigma \bigoplus_i A_i$ and $Y=\bigoplus_i \Sigma A_i$
#! @Returns a morphism
#! @Arguments L
DeclareOperation( "ShiftExpandingIsomorphism", [ IsList ] );
##



##
#! @Description
#! The arguments are list $L=[A_1,\dots,A_n]$ and two objects $Y=\bigoplus_i \Sigma A_i, X=\Sigma \bigoplus_i A_i$.
#! The output is the isomorphism $Y \rightarrow X$ associated to $\Sigma$.
#! @Returns a morphism
#! @Arguments Y, L, X
DeclareOperation( "ShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. This operation adds the given function $F$ to
#! the category for the basic operation AddShiftFactoringIsomorphismWithGivenObjects. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a list $L=[A_1,\dots,A_n]$.
#! The output is the isomorphism $Y \rightarrow X$ associated to $\Sigma$, where 
#! $Y=\bigoplus_i \Sigma A_i$ and $X=\Sigma \bigoplus_i A_i$.
#! @Returns a morphism
#! @Arguments L
DeclareOperation( "ShiftFactoringIsomorphism", [ IsList ] );


##
#! @Description
#! The arguments are list $L=[A_1,\dots,A_n]$ and two objects $X=\Sigma^{-1} \bigoplus_i A_i, Y=\bigoplus_i \Sigma^{-1} A_i$.
#! The output is the isomorphism $X \rightarrow Y$ associated to $\Sigma^{-1}$.
#! @Returns a morphism
#! @Arguments X, L, Y
DeclareOperation( "ReverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation ReverseShiftExpandingIsomorphismWithGivenObjects. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddReverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddReverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseShiftExpandingIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a list $L=[A_1,\dots,A_n]$.
#! The output is the isomorphism $X \rightarrow Y$ associated to $\Sigma$, where 
#! $X=\Sigma \bigoplus_i A_i$ and $Y=\bigoplus_i \Sigma A_i$
#! @Returns a morphism
#! @Arguments L
DeclareOperation( "ReverseShiftExpandingIsomorphism", [ IsList ] );

##
#! @Description
#! The arguments are list $L=[A_1,\dots,A_n]$ and two objects $Y=\bigoplus_i \Sigma^{-1} A_i, X=\Sigma^{-1} \bigoplus_i A_i$.
#! The output is the isomorphism $Y \rightarrow X$ associated to $\Sigma^{-1}$.
#! @Returns a morphism
#! @Arguments Y, L, X
DeclareOperation( "ReverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation ReverseShiftFactoringIsomorphismWithGivenObjects. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddReverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddReverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseShiftFactoringIsomorphismWithGivenObjects", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a list $L=[A_1,\dots,A_n]$.
#! The output is the isomorphism $Y \rightarrow X$ associated to $\Sigma^{-1}$, where 
#! $Y=\bigoplus_i \Sigma^{-1} A_i$ and $X=\Sigma^{-1} \bigoplus_i A_i$.
#! @Returns a morphism
#! @Arguments L
DeclareOperation( "ReverseShiftFactoringIsomorphism", [ IsList ] );

#! @Description
#! The argument is an object $X$.
#! The output is the isomorphism $X \rightarrow (\Sigma\circ\Sigma^{-1}) X$.
#! @Returns a morphism
#! @Arguments X
DeclareOperation( "IsomorphismIntoShiftOfReverseShift", [ IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation IsomorphismIntoShiftOfReverseShift. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismIntoShiftOfReverseShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoShiftOfReverseShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfReverseShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoShiftOfReverseShift", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $X$.
#! The output is the isomorphism $X \rightarrow (\Sigma^{-1}\circ\Sigma) X$.
#! @Returns a morphism
#! @Arguments X
DeclareOperation( "IsomorphismIntoReverseShiftOfShift", [ IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation IsomorphismIntoReverseShiftOfShift. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismIntoReverseShiftOfShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoReverseShiftOfShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoReverseShiftOfShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoReverseShiftOfShift", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $X$.
#! The output is the isomorphism $(\Sigma\circ\Sigma^{-1})X \rightarrow X$.
#! @Returns a morphism
#! @Arguments X
DeclareOperation( "IsomorphismFromShiftOfReverseShift", [ IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation IsomorphismFromShiftOfReverseShift. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromShiftOfReverseShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromShiftOfReverseShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfReverseShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromShiftOfReverseShift", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an object $X$.
#! The output is the isomorphism $(\Sigma^{-1}\circ\Sigma)X \rightarrow X$.
#! @Returns a morphism
#! @Arguments X
DeclareOperation( "IsomorphismFromReverseShiftOfShift", [ IsCapCategoryObject ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation IsomorphismFromReverseShiftOfShift. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromReverseShiftOfShift", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromReverseShiftOfShift", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromReverseShiftOfShift", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromReverseShiftOfShift", [ IsCapCategory, IsList ] );

DeclareAttribute( "ConeObject", IsCapCategoryMorphism );


DeclareOperation( "AddConeObject", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddConeObject", [ IsCapCategory, IsFunction ] );
DeclareOperation( "AddConeObject", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddConeObject", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a triangle $T\in\mathrm{Triangles}(\mathcal{C})$, where $\mathcal{C}$ a triangulated category $\mathcal{C}$. 
#! The output is true if $T$ is standard exact triangle, otherwise the output is false.
#! @Arguments T
DeclareProperty( "IsStandardExactTriangle", IsCapCategoryTriangle );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation IsStandardExactTriangle. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsStandardExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsStandardExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsStandardExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsStandardExactTriangle", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a triangle $T\in\mathrm{Triangles}(\mathcal{C})$, where $\mathcal{C}$ a triangulated category $\mathcal{C}$. 
#! The output is true if $T$ is exact triangle, otherwise the output is false.
#! @Arguments T
DeclareProperty( "IsExactTriangle", IsCapCategoryTriangle );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation IsExactTriangle. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactTriangle", [ IsCapCategory, IsList ] );

DeclareAttribute( "UnderlyingStandardExactTriangle", IsCapCategoryExactTriangle );

#! @Description
#! The argument is morphism $f$ in a triangulated category $\mathcal{C}$. 
#! The output is a standard exact triangle which exists by the axioms of triangulated structure.
#! We denote this standard exact triangle by $\mathrm{Tr}(f)$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! X \arrow[r, "f"] & Y \arrow[r, "\alpha(f)"] & C(f) \arrow[r, "\beta(f)"] & \Sigma X
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Arguments T
DeclareOperation( "CompleteMorphismToStandardExactTriangle", [ IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation CompleteMorphismToStandardExactTriangle. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCompleteMorphismToStandardExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCompleteMorphismToStandardExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCompleteMorphismToStandardExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCompleteMorphismToStandardExactTriangle", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an exact triangle $T=\mathrm{Tr}(f,g,h)\in\mathrm{Triangles}(\mathcal{C})$, where $\mathcal{C}$ a triangulated category. 
#! The output is a triangles isomorphism into the standard exact triangle $\mathrm{Tr}(f)$. The first two 
#! morphisms of the output should be identity morphisms.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! T:              & X \arrow[r, "f"] \arrow[d, "\mathrm{id}_X"'] & Y \arrow[r, "g"] \arrow[d, "\mathrm{id}_Y"] & Z \arrow[r, "h"] \arrow[d, "\lambda", dashed] & \Sigma X \arrow[d, "\mathrm{id}_{\Sigma X}"] \\
#! \mathrm{Tr}(f): & X \arrow[r, "f"'] & Y \arrow[r, "\alpha(f)"'] & C(f) \arrow[r, "\beta(f)"'] & \Sigma X
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns morphism in $\mathrm{Hom}(T, \mathrm{Tr}(f))$
#! @Arguments T
DeclareAttribute( "IsomorphismIntoStandardExactTriangle", IsCapCategoryExactTriangle );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation IsomorphismIntoStandardExactTriangle. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismIntoStandardExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismIntoStandardExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismIntoStandardExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismIntoStandardExactTriangle", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is an exact triangle $T=\mathrm{Tr}(f,g,h)\in\mathrm{Triangles}(\mathcal{C})$, where $\mathcal{C}$ a triangulated category. 
#! The output is a triangles isomorphism from the standard exact triangle $\mathrm{Tr}(f)$. The first two 
#! morphisms of the output should be identity morphisms.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! T:              & X \arrow[r, "f"] & Y \arrow[r, "g"] & Z \arrow[r, "h"] & \Sigma X \\
#! \mathrm{Tr}(f): & X \arrow[r, "f"'] \arrow[u, "\mathrm{id}_X"] & Y \arrow[r, "\alpha(f)"'] \arrow[u, "\mathrm{id}_Y"'] & C(f) \arrow[r, "\beta(f)"'] \arrow[u, "\lambda"', dashed] & \Sigma X \arrow[u, "\mathrm{id}_{\Sigma X}"']
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns morphism in $\mathrm{Hom}(\mathrm{Tr}(f), T)$
#! @Arguments T
DeclareAttribute( "IsomorphismFromStandardExactTriangle", IsCapCategoryExactTriangle );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation IsomorphismFromStandardExactTriangle. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromStandardExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromStandardExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsomorphismFromStandardExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsomorphismFromStandardExactTriangle", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a standard exact triangle $T=\mathrm{Tr}(f,\alpha(f),\beta(f))\in\mathrm{Triangles}(\mathcal{C})$, 
#! where $\mathcal{C}$ a triangulated category $\mathcal{C}$. 
#! The output is the exact triangle $\mathrm{Tr}(\alpha(f),\beta(f),-\Sigma f)$. If no methods for
#! IsomorphismFromStandardExactTriangle and IsomorphismIntoStandardExactTriangle are installed for the category, 
#! then the two attributes  IsomorphismFromStandardExactTriangle and IsomorphismIntoStandardExactTriangle should be set 
#! for the output $\mathrm{Tr}(\alpha(f),\beta(f),-\Sigma f)$.
#! @Returns an exact triangle
#! @Arguments T
DeclareAttribute( "RotationOfStandardExactTriangle", IsCapCategoryStandardExactTriangle );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation RotationOfStandardExactTriangle. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRotationOfStandardExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRotationOfStandardExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddRotationOfStandardExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddRotationOfStandardExactTriangle", [ IsCapCategory, IsList ] );


DeclareAttribute( "ReverseRotationOfStandardExactTriangle", IsCapCategoryStandardExactTriangle );

DeclareOperation( "AddReverseRotationOfStandardExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseRotationOfStandardExactTriangle", [ IsCapCategory, IsFunction ] );
DeclareOperation( "AddReverseRotationOfStandardExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseRotationOfStandardExactTriangle", [ IsCapCategory, IsList ] );

#! @Description
#! The argument is a exact triangle $T=\mathrm{Tr}(f,g,h)\in\mathrm{Triangles}(\mathcal{C})$, 
#! where $\mathcal{C}$ a triangulated category $\mathcal{C}$. 
#! The output is the exact triangle $\mathrm{Tr}(g,h,-\Sigma f)$.
#! @Returns an exact triangle
#! @Arguments T
DeclareAttribute( "RotationOfExactTriangle", IsCapCategoryExactTriangle );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation RotationOfExactTriangle. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRotationOfExactTriangle", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRotationOfExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddRotationOfExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddRotationOfExactTriangle", [ IsCapCategory, IsList ] );

DeclareAttribute( "ReverseRotationOfExactTriangle", IsCapCategoryExactTriangle );

DeclareOperation( "AddReverseRotationOfExactTriangle", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddReverseRotationOfExactTriangle", [ IsCapCategory, IsFunction ] );
DeclareOperation( "AddReverseRotationOfExactTriangle", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddReverseRotationOfExactTriangle", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two standard exact triangles 
#! $T_1=\mathrm{Tr}(f_1), T_2=\mathrm{Tr}(f_2)\in\mathrm{Triangles}(\mathcal{C})$ and two morphisms
#! $u,v$ in a triangulated category $\mathcal{C}$ with $v \circ f_1 \sim_{X_1,Y_2} f_2 \circ u$.
#! The output is a triangles morphism $T_1\rightarrow T_2$
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! X_1 \arrow[r, "f_1"] \arrow[d, "u"'] & Y_1 \arrow[r, "\alpha(f_1)"] \arrow[d, "v"] & C(f_1) \arrow[r, "\beta(f_1)"] \arrow[d, "w", dashed] & \Sigma X_1 \arrow[d, "\Sigma u"] \\
#! X_2 \arrow[r, "f_2"'] & Y_2 \arrow[r, "\alpha(f_2)"'] & C(f_2) \arrow[r, "\beta(f_2)"'] & \Sigma X_2
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a triangles morphism
#! @Arguments T
DeclareOperation( "CompleteToMorphismOfStandardExactTriangles",
             [ IsCapCategoryStandardExactTriangle, IsCapCategoryStandardExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a triangulated category $\mathcal{C}$ w.r.t. $\Sigma:\mathcal{C} \rightarrow \mathcal{C}$ and a function $F$. 
#! This operation adds the given function $F$ to
#! the category for the basic operation CompleteToMorphismOfStandardExactTriangles. 
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCompleteToMorphismOfStandardExactTriangles", [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCompleteToMorphismOfStandardExactTriangles", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCompleteToMorphismOfStandardExactTriangles", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCompleteToMorphismOfStandardExactTriangles", [ IsCapCategory, IsList ] );

DeclareOperation( "CompleteToMorphismOfExactTriangles",
             [ IsCapCategoryExactTriangle, IsCapCategoryExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddCompleteToMorphismOfExactTriangles", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCompleteToMorphismOfExactTriangles", [ IsCapCategory, IsFunction ] );
DeclareOperation( "AddCompleteToMorphismOfExactTriangles", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCompleteToMorphismOfExactTriangles", [ IsCapCategory, IsList ] );

DeclareOperation( "CompleteToMorphismOfStandardExactTriangles", 
             [ IsCapCategoryStandardExactTriangle, IsCapCategoryStandardExactTriangle, IsCapCategoryMorphism, IsCapCategoryMorphism, IsList ] );


#! @Description
#! The arguments are morphisms $f:X\rightarrow Y,g:Y\rightarrow Z$ in the triangulated category $\mathcal{C}$. 
#! The output is an exact triangle $T =\mathrm{Tr}(u,v,w)$ such that the following diagram is commutative.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! X \arrow[r, "f"] \arrow[rd, "h :=g\circ f"', bend right] & Y \arrow[r, "\alpha(f)"] \arrow[d, "g"] & C(f) \arrow[r, "\beta(f)"] \arrow[d, "u", dashed] & \Sigma X \arrow[d, "\mathrm{id}_{\Sigma X}"] \\
#!  & Z \arrow[d, "\alpha(g)"'] \arrow[r, "\alpha(h)"] & C(h) \arrow[r, "\beta(h)"] \arrow[d, "v", dashed] & \Sigma X \arrow[d, "\Sigma f"] \\
#!  & C(g) \arrow[d, "\beta(g)"'] \arrow[r, "\mathrm{id}_{C(g)}"] & C(g) \arrow[d, "w", dashed] \arrow[r, "\beta(g)"] & \Sigma Y \\
#!  & \Sigma Y \arrow[r, "\Sigma \alpha(f)"'] & \Sigma C(f) & 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! If no methods for IsomorphismFromStandardExactTriangle and IsomorphismIntoStandardExactTriangle are installed for
#! the category, then the two attributes IsomorphismFromStandardExactTriangle and IsomorphismIntoStandardExactTriangle should be set for the output $T$.
#! @Returns a triangle
#! @Arguments T
DeclareOperation( "OctahedralAxiom", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddOctahedralAxiom", [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddOctahedralAxiom", [ IsCapCategory, IsFunction ] );
DeclareOperation( "AddOctahedralAxiom", [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddOctahedralAxiom", [ IsCapCategory, IsList ] );

###############################
##
## Attributes
##
###############################

DeclareAttribute( "ShiftFunctorAttr", IsCapCategory );


if not IsBound( ShiftFunctor ) then
  DeclareOperation( "ShiftFunctor", [ IsCapCategory ] );
fi;

DeclareAttribute( "ReverseShiftFunctor", IsCapCategory );

DeclareAttribute( "NaturalIsomorphismFromIdentityIntoReverseShiftOfShift", IsCapCategory );

DeclareAttribute( "NaturalIsomorphismFromIdentityIntoShiftOfReverseShift", IsCapCategory );


DeclareAttribute( "NaturalIsomorphismFromReverseShiftOfShiftIntoIdentity", IsCapCategory );


DeclareAttribute( "NaturalIsomorphismFromShiftOfReverseShiftIntoIdentity", IsCapCategory );

DeclareAttribute( "UnderlyingCapCategory", IsCapCategoryTriangle );

DeclareAttribute( "UnderlyingCapCategory", IsCapCategoryTrianglesMorphism );

DeclareAttribute( "Source", IsCapCategoryTrianglesMorphism );

DeclareAttribute( "Range", IsCapCategoryTrianglesMorphism );

KeyDependentOperation( "MorphismAt", IsCapCategoryTriangle, IsInt, ReturnTrue );

KeyDependentOperation( "MorphismAt", IsCapCategoryTrianglesMorphism, IsInt, ReturnTrue );

KeyDependentOperation( "ObjectAt", IsCapCategoryTriangle, IsInt, ReturnTrue );


DeclareProperty( "IsTriangulatedCategory", IsCapCategory );

# This property is declared only to be set by the user, not to be computed in any way.
DeclareProperty( "IsTriangulatedCategoryWithShiftAutomorphism", IsCapCategory );

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_TRIANGULATED_CATEGORY", IsCapCategory );
