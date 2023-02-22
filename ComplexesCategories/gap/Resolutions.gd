# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#
KeyDependentOperation( "ProjectiveResolution", IsCochainComplex, IsBool, ReturnTrue );
KeyDependentOperation( "QuasiIsomorphismFromProjectiveResolution", IsCochainComplex, IsBool, ReturnTrue );
KeyDependentOperation( "MorphismBetweenProjectiveResolutions", IsCochainMorphism, IsBool, ReturnTrue );

KeyDependentOperation( "InjectiveResolution", IsCochainComplex, IsBool, ReturnTrue );
KeyDependentOperation( "QuasiIsomorphismIntoInjectiveResolution", IsCochainComplex, IsBool, ReturnTrue );
KeyDependentOperation( "MorphismBetweenInjectiveResolutions", IsCochainMorphism, IsBool, ReturnTrue );

