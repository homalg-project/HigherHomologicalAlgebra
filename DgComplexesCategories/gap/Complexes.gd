# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#

DeclareCategory( "IsDgComplex", IsCapCategoryObject );
DeclareCategory( "IsDgChainComplex", IsDgComplex );
DeclareCategory( "IsDgCochainComplex", IsDgComplex );

DeclareCategory( "IsBoundedBelowDgComplex", IsDgComplex );
DeclareCategory( "IsBoundedAboveDgComplex", IsDgComplex );
DeclareCategory( "IsBoundedDgComplex", IsBoundedBelowDgComplex and IsBoundedAboveDgComplex );

DeclareCategory( "IsBoundedBelowDgChainComplex", IsBoundedBelowDgComplex and IsDgChainComplex ); 
DeclareCategory( "IsBoundedAboveDgChainComplex", IsBoundedAboveDgComplex and IsDgChainComplex );
DeclareCategory( "IsBoundedDgChainComplex", IsBoundedDgComplex and IsDgChainComplex );

DeclareCategory( "IsBoundedBelowDgCochainComplex", IsBoundedBelowDgComplex and IsDgCochainComplex );
DeclareCategory( "IsBoundedAboveDgCochainComplex", IsBoundedAboveDgComplex and IsDgCochainComplex );
DeclareCategory( "IsBoundedDgCochainComplex", IsBoundedDgComplex and IsDgCochainComplex );




DeclareOperation( "DgCochainComplex", [ IsDgCochainComplexCategory, IsZFunction ] );
DeclareOperation( "DgCochainComplex", [ IsDgCochainComplexCategory, IsZFunction, IsInt, IsInt ] );
DeclareOperation( "DgCochainComplex", [ IsDgCochainComplexCategory, IsDenseList, IsInt ] );


DeclareAttribute( "Differentials", IsDgComplex );
KeyDependentOperation( "DifferentialAt", IsDgComplex, IsInt, ReturnTrue );

DeclareOperation( "\^", [ IsDgComplex, IsInt ] );

CapJitAddTypeSignature( "\^", [ IsDgComplex, IsInt ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareAttribute( "Objects", IsDgComplex );
KeyDependentOperation( "ObjectAt", IsDgComplex, IsInt, ReturnTrue );

DeclareOperation( "\[\]", [ IsDgComplex, IsInt ] );

CapJitAddTypeSignature( "\[\]", [ IsDgComplex, IsInt ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareAttribute( "LowerBoundOfDgComplex", IsDgComplex );

CapJitAddTypeSignature( "LowerBoundOfDgComplex", [ IsDgComplex ], IsInt );

DeclareAttribute( "UpperBoundOfDgComplex", IsDgComplex );

CapJitAddTypeSignature( "UpperBoundOfDgComplex", [ IsDgComplex ], IsInt );

DeclareOperation( "Display", [ IsDgComplex, IsInt, IsInt ] );

CapJitAddTypeSignature( "Minimum", [ IsInt, IsInt ], IsInt );
CapJitAddTypeSignature( "Maximum", [ IsInt, IsInt ], IsInt );
