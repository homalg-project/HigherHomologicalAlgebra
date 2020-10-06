# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#

##
DeclareOperation( "HomotopyCategoryObject",
        [ IsJuliaObject, IsInt ] );

DeclareOperation( "CreateDiagramInHomotopyCategory",
        [ IsJuliaObject, IsJuliaObject, IsJuliaObject, IsJuliaObject ] );
