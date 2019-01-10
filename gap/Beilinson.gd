
#! @Chapter Beilinson Monads and $\mathrm{Coh}(\mathbb{P}^m)$

#! @Section Operations

#! @Arguments S
#! The input is a graded polynomial ring $S=k[x_0,\dots,x_m]$ and the output is the category of coherent sheaves over $\mathbb{P}^m$. 
#! @Returns a CAP category
DeclareAttribute( "CoherentSheavesOverProjectiveSpace", IsHomalgGradedRing );

#! @Arguments A, i
#! The input is a graded exterior algebra $A$ and an integer $i$. The output is the graded  $A$-lp $\omega_A(i)$.
#! @Returns graded lp
KeyDependentOperation("TwistedOmegaModule", IsExteriorRing, IsInt, ReturnTrue );

#! @Arguments S, i
#! The input is a graded polynomial ring $S$ and an integer $i$. The output is the graded  $S$-lp $S(i)$.
#! The sheafification of $S(i)$ is the structure sheaf $\mathcal{O}_{\mathbb{P}^m}(i)$.
#! @Returns graded lp
KeyDependentOperation( "TwistedStructureSheaf", IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, i
#! The input is a graded polynomial ring $S$ and an integer $i$. The output is the graded  $S$-lp $\Omega^i(i)$.
#! The sheafification of $\Omega^i(i)$ is the twisted cotangent sheaf $\Omega^i_{\mathbb{P}^m}(i)$.
#! @Returns graded lp
KeyDependentOperation( "TwistedCotangentSheaf", IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, i
#! The input is a graded polynomial ring $S$ and an integer $i$. The output is the chain complex of  $S$-lp's
#! whose objects are direct sums of twists of $S$ and its homology at $0$ is $\Omega^i(i)$. I.e., a chain complex that is
#! quasi-isomorphic to $\Omega^i(i)$.
#! @Returns chain complex
KeyDependentOperation( "TwistedCotangentSheafAsChain", IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments S, i
#! The input is a graded polynomial ring $S$ and an integer $i$. The output is the chain complex of  $S$-lp's
#! whose objects are direct sums of twists of $S$ and its homology at $0$ is $\Omega^i(i)$. I.e., a chain complex that is
#! quasi-isomorphic to $\Omega^i(i)$.
#! @Returns cochain complex
KeyDependentOperation( "TwistedCotangentSheafAsCochain", IsHomalgGradedRing, IsInt, ReturnTrue );

#! @Arguments A, i, j
#! The input is a graded exterior ring <C>A := KoszulDualRing(S)</C> with $S:=k[x_0,\dots,x_m]$ and two integers $i,j$ with 
#! $i\geq j$. The output is a basis of the external hom: 
#! $\mathrm{Hom}_A(\omega_A(i), \omega_A(j))$. If we denote the indeterminates of $A$ by $e_0,\dots, e_m$ and the 
#! $\ell$'th entry of the output by $\sigma_{ij}^{\ell}$ then we have
#! $\sigma_{i+1,i}^{\ell}=e_{\ell-1}$, thus 
#! $\sigma_{i+1,i}^{\ell_1} \sigma_{i,i-1}^{\ell_2}= -\sigma_{i+1,i}^{\ell_2} \sigma_{i,i-1}^{\ell_1}$.
#! @Returns a list
DeclareOperation( "BasisBetweenTwistedOmegaModules", [ IsExteriorRing, IsInt, IsInt ] );

#! @Arguments S, i, j
#! The input is a graded polynomial ring $S=k[x_0, \dots, x_m]$ and two integers $i,j$ with $i\leq j$. 
#! The output is a basis of the external hom: 
#! $\mathrm{Hom}_S(S(i), S(j))$. If we denote the $\ell$'th entry of the output by $\psi_{ij}^{\ell}$ then we have
#! $\psi_{i-1,i}^{\ell}=x_{\ell-1}$, thus 
#! $\psi_{i-1,i}^{\ell_1} \psi_{i,i+1}^{\ell_2}= \psi_{i-1,i}^{\ell_2} \psi_{i,i+1}^{\ell_1}$.
#! @Returns a list
DeclareOperation( "BasisBetweenTwistedStructureSheaves", [ IsHomalgGradedRing, IsInt, IsInt ] );

#! @Arguments S, i, j
#! The input is a graded polynomial ring $S=k[x_0, \dots, x_m]$ and two integers $0\leq j \leq i \leq m$. 
#! The output is a basis of the external hom: 
#! $\mathrm{Hom}_S(\Omega^i(i), \Omega^i(j))$. If we denote the $\ell$'th entry of the output by $\varphi_{ij}^{\ell}$ then we have
#! $\varphi_{i+1,i}^{\ell} \varphi_{i,i-1}^{\ell}=0$ and 
#! $\varphi_{i+1,i}^{\ell_1} \varphi_{i,i-1}^{\ell_2}= -\varphi_{i+1,i}^{\ell_2} \varphi_{i,i-1}^{\ell_1}$.
#! @Returns a list
DeclareOperation( "BasisBetweenTwistedCotangentSheaves", [ IsHomalgGradedRing, IsInt, IsInt ] );


DeclareOperation( "BasisBetweenTwistedCotangentSheavesAsChains", [ IsHomalgGradedRing, IsInt, IsInt ] );

#! @Description
#! @Arguments M
#! The input is graded $S$-lp, graded $A$-lp, chain complex or cochain complex of $S$-lp's. The output is a Beilinson monad of $M$.
#! @Returns a chain or cochain complex
DeclareAttribute( "BeilinsonReplacement", IsCapCategoryObject );

#! @Description
#! @Arguments phi
#! The input is graded $S$-lp morphism, graded $A$-lp morphism, chain morphism or cochain morphism of $S$-lp's. 
#! The output is a Beilinson monad morphism of $\phi$.
#! @Returns a chain or cochain complex
DeclareAttribute( "BeilinsonReplacement", IsCapCategoryMorphism );

#! @Description
#! @Arguments M
#! The input is graded $S$-lp $M$.
#! The output is a morphism from the sheafification of $M$ to the 
#! sheafification of the $0$'th object of its Beilinson replacement.
#! This morphism induces a quasi-isomorphism from sheafification of $M$ 
#! considered as a chain  complex concentrated in degree $0$ to the 
#! sheafification of the Beilinson replacement of $M$.
#! @Returns a morphism
DeclareAttribute( "MorphismFromGLPToZerothObjectOfBeilinsonReplacement", IsGradedLeftPresentation );

#! @Description
#! @Arguments M
#! The input is graded $S$-lp $M$.
#! The output is an isomorphism from the Sheafification of $M$ to the 
#! sheafification of the $0$'th homology of its Beilinson replacement.
#! @Returns a morphism
DeclareAttribute( "MorphismFromGLPToZerothHomologyOfBeilinsonReplacement", IsGradedLeftPresentation );

#! @Description
#! @Arguments M
#! The input is graded $S$-lp $M$.
#! The output is a morphism from the 
#! sheafification of the $0$'th object of the Beilinson replacement of $M$ to
#! the sheafification of $M$.
#! This morphism induces a quasi-isomorphism from the 
#! sheafification of the Beilinson replacement of $M$ to
#! sheafification of $M$ 
#! considered as a chain complex concentrated in degree $0$.
#! @Returns a morphism
DeclareAttribute( "MorphismFromZerothObjectOfBeilinsonReplacementToGLP", IsGradedLeftPresentation );

#! @Description
#! @Arguments M
#! The input is graded $S$-lp $M$.
#! The output is an isomorphism from the the 
#! sheafification of the $0$'th homology of its Beilinson replacement to
#! Sheafification of $M$.
#! @Returns a morphism
DeclareAttribute( "MorphismFromZerothHomologyOfBeilinsonReplacementToGLP", IsGradedLeftPresentation );


#! @Description
#! @Arguments M
#! The inpute is a homalg matrix or anything that has attribute <C>UnderlyingMatrix</C>. It views the entries using the browse package. To quit: <C>q+y</C>.
#! @Returns nothing
DeclareGlobalFunction( "ShowMatrix" );

#! @EndSection

##
DeclareOperation( "RECORD_TO_MORPHISM_OF_TWISTED_COTANGENT_SHEAVES", [ IsHomalgGradedRing, IsRecord ] );
DeclareAttribute( "MORPHISM_OF_TWISTED_OMEGA_MODULES_AS_LIST_OF_RECORDS", IsGradedLeftPresentationMorphism );
DeclareOperation( "LIST_OF_RECORDS_TO_MORPHISM_OF_TWISTED_COTANGENT_SHEAVES", [ IsHomalgGradedRing, IsList ] );

DeclareOperation( "PATH_FROM_j_TO_i_THROUGHT_TATE_COCHAIN", [ IsInt, IsInt, IsGradedLeftPresentation ] );
DeclareOperation( "TRUNCATION_MORPHISM", [ IsInt, IsGradedLeftPresentation ] );
DeclareOperation( "PATH_FROM_j_TO_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT_THROUGHT_TATE_COCHAIN",
[ IsInt, IsGradedLeftPresentation ] );

DeclareOperation(  "MORPHISM_FROM_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT_TO_GLP",
    [ IsInt, IsGradedLeftPresentation ] );

DeclareOperation(  "MORPHISM_FROM_GLP_TO_ZEROTH_HOMOLOGY_OF_BEILINSON_REPLACEMENT",
    [ IsInt, IsGradedLeftPresentation ] );

DeclareOperation( "PATH_FROM_j_TO_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT_THROUGHT_TATE_COCHAIN",
[ IsInt, IsGradedLeftPresentation ] );

DeclareOperation(  "MORPHISM_FROM_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT_TO_GLP",
    [ IsInt, IsGradedLeftPresentation ] );

DeclareOperation(  "MORPHISM_FROM_GLP_TO_ZEROTH_OBJECT_OF_BEILINSON_REPLACEMENT",
    [ IsInt, IsGradedLeftPresentation ] );

