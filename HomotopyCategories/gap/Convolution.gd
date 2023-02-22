# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
KeyDependentOperation( "PostnikovSystemAt", IsCochainComplex, IsInt, ReturnTrue );
DeclareAttribute( "Convolution", IsCochainComplex );

KeyDependentOperation( "PostnikovSystemAt", IsCochainMorphism, IsInt, ReturnTrue );
DeclareAttribute( "Convolution", IsCochainMorphism );

