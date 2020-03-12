

#! @Chapter Z-functions

#! @Section Gap categories for Z functions

#! @Description
#!  Gap-categories of $\mathbb{Z}$-functions
DeclareCategory( "IsZFunction", IsObject );

#! @Description
#!  Gap-categories of inductive $\mathbb{Z}$-functions
DeclareCategory( "IsZFunctionWithInductiveSides", IsZFunction );

#! @Section Creating Z-functions

#! @Description
#! The global function has no arguments and the output is an empty $\mathbb{Z}$-function. That means, it can not be evaluated yet.
#! @Arguments func
#! @Returns an integer
DeclareGlobalFunction( "VoidZFunction" );

#! @Description
#! The argument is a function <A>func</A> that can be applied on integers.
#! The output is a $\mathbb{Z}$-function <C>z_func</C>. We call <A>func</A> the <C>UnderlyingFunction</C> function of <C>z_func</C>.
#! @Arguments func
#! @Returns a $\mathbb{Z}$-function
DeclareAttribute( "AsZFunction", IsFunction );

#! @Description
#! The argument is a <A>z_func</A>. The output is its <C>UnderlyingFunction</C> function. I.e., the function that will be applied on index <C>i</C>
#! whenever we call <A>z_func</A>[<C>i</C>].
#! @Arguments func
#! @Returns a $\mathbb{Z}$-function
DeclareAttribute( "UnderlyingFunction", IsZFunction );

#! @Description
#! The arguments are an integer <A>n</A>, a Gap object <A>val_n</A>, a function <A>neg_part_func</A>, a function <A>pos_part_func</A> and a function <A>compare_func</A>.
#! The output is the $\mathbb{Z}$-function <C>z_func</C> defined as follows
#! @BeginLatexOnly
#!     $$\begin{cases}
#!        \mathtt{neg\_part\_func( z\_func[ i + 1 ] )} & \quad \text{if}\quad i<n, \\
#!        \mathtt{val\_n} & \quad \text{if}\quad i=n,\\
#!        \mathtt{pos\_part\_func( z\_func[ i - 1 ] )} & \quad \text{if}\quad i>n. \\
#!     \end{cases}$$
#! @EndLatexOnly
#! At each call, the method compares the computed value to the previous or next value and in the affermative case, the method sets a positive or negative stable value.
#! @Arguments n, val_n, neg_part_func, pos_part_func, compare_func
#! @Returns a $\mathbb{Z}$-function with inductive sides
DeclareOperation( "ZFunctionWithInductiveSides",
      [ IsInt, IsObject, IsFunction, IsFunction, IsFunction ] );


#! @BeginGroup 9228
#! @Description
#! They are the attributes that define a $\mathbb{Z}$-function with inductive sides.
#! @Arguments z_func
#! @Returns a function
DeclareAttribute( "PosFunction", IsZFunctionWithInductiveSides );
#! @Arguments z_func
#! @Returns a function
DeclareAttribute( "NegFunction", IsZFunctionWithInductiveSides );
#! @Arguments z_func
#! @Returns an integer
DeclareAttribute( "FirstIndex", IsZFunctionWithInductiveSides );
#! @Arguments z_func
#! @Returns a Gap object
DeclareAttribute( "FirstValue", IsZFunctionWithInductiveSides );
#! @EndGroup
#! @Group 9228
#! @Arguments z_func
#! @Returns a function
DeclareAttribute( "CompareFunction", IsZFunctionWithInductiveSides );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A>. We say that <A>z_func</A> has a stable positive value <C>pos_val</C>,
#! if there is an index <C>pos_N</C> such that <A>z_func</A>[<C>i</C>] is equal to <C>pos_val</C> for all indices <C>i</C> greater or equal to <C>pos_N</C>.
#! In that case, the output is the value <C>pos_val</C>.
#! @Arguments func
#! @Returns a Gap object
DeclareAttribute( "StablePosValue", IsZFunction );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A> with a stable positive value <C>pos_val</C>. The output is some index where <A>z_func</A> starts to take
#! values equal to <C>pos_val</C>.
#! @Arguments func
#! @Returns an integer
DeclareAttribute( "IndexOfStablePosValue", IsZFunction );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A>. We say that <A>z_func</A> has a stable negative value <C>neg_val</C>,
#! if there is an index <C>neg_N</C> such that <A>z_func</A>[<C>i</C>] is equal to <C>neg_val</C> for all indices <C>i</C> less or equal to <C>neg_N</C>.
#! In that case, the output is the value <C>neg_val</C>.
#! @Arguments func
#! @Returns a Gap object
DeclareAttribute( "StableNegValue", IsZFunction );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A> with a stable negative value <C>neg_val</C>. The output is some index where <A>z_func</A> starts to take
#! values equal to <C>neg_val</C>.
#! @Arguments func
#! @Returns an integer
DeclareAttribute( "IndexOfStableNegValue", IsZFunction );

#! @Description
#! ?
#! @Arguments ?
#! @Returns ?
DeclareAttribute( "Reflection", IsZFunction );

#! @Description
#! ?
#! @Arguments ?
#! @Returns ?
DeclareAttribute( "BaseZFunctions", IsZFunction );

#! @Description
#! ?
#! @Arguments ?
#! @Returns ?
DeclareAttribute( "AppliedMap", IsZFunction );

#! @Description
#! ?
#! @Arguments ?
#! @Returns ?
DeclareOperation( "ApplyMap", [ IsZFunction, IsFunction ] );

#! @Description
#! ?
#! @Arguments ?
#! @Returns ?
DeclareOperation( "CombineZFunctions", [ IsList ] );

#! @Description
#! ?
#! @Arguments ?
#! @Returns ?
KeyDependentOperation( "ApplyShift", IsZFunction, IsInt, ReturnTrue );

#! @Description
#! ?
#! @Arguments ?
#! @Returns ?
DeclareOperation( "ApplyMap", [ IsDenseList, IsFunction ] );

#! @Description
#! ?
#! @Arguments ?
#! @Returns ?
KeyDependentOperation( "ZFunctionValue", IsZFunction, IsInt, ReturnTrue );

#! @Description
#! ?
#! @Arguments ?
#! @Returns ?
DeclareOperation( "\[\]", [ IsZFunction, IsInt ] );

########################################

if IsPackageMarkedForLoading( "InfiniteLists", ">= 2017.08.01" ) then
  
  DeclareAttribute( "AsZFunction", IsZList );
  
  InstallMethod( AsZFunction, [ IsZList ], z -> AsZFunction( i -> z[ i ] ) );
  
  DeclareAttribute( "AsZList", IsZFunction );
  
  InstallMethod( AsZList, [ IsZFunction ], z -> MapLazy( IntegersList, i -> z[ i ], 1 ) );
  
fi;
