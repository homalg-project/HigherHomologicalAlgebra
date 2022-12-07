# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
#

DeclareCategory( "IsHomotopyCategory", IsQuotientCapCategory );

DeclareCategory( "IsHomotopyCategoryByCochains", IsHomotopyCategory );
DeclareCategory( "IsHomotopyCategoryByChains", IsHomotopyCategory );


DeclareAttribute( "HomotopyCategoryByCochains", IsCapCategory );
DeclareAttribute( "HomotopyCategoryByChains", IsCapCategory );

DeclareAttribute( "DefiningCategory", IsHomotopyCategory );
