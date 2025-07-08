# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "ComplexesCategories",
Subtitle := "Category of (co)chain complexes of an additive category",
Version := "2025.07-01",
Date := (function ( ) if IsBound( GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE ) then return GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE; else return Concatenation( ~.Version{[ 1 .. 4 ]}, "-", ~.Version{[ 6, 7 ]}, "-01" ); fi; end)( ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Kamal",
    LastName := "Saleh",
    WWWHome := "https://github.com/kamalsaleh/",
    Email := "kamal.saleh@uni-siegen.de",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen University",
    Institution := "University of Siegen",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/homalg-project/", ~.PackageName )
),

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/HigherHomologicalAlgebra",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/ComplexesCategories",
PackageInfoURL  := "https://homalg-project.github.io/HigherHomologicalAlgebra/ComplexesCategories/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/HigherHomologicalAlgebra/ComplexesCategories/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/HigherHomologicalAlgebra/releases/download/ComplexesCategories-", ~.Version, "/ComplexesCategories-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "ComplexesCategories",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Category of (co)chain complexes of an additive category",
),

Dependencies := rec(
  GAP := ">= 4.13.0",
  NeededOtherPackages := [  [ "CAP", ">= 2024.10-06" ],
                            [ "ToolsForHigherHomologicalAlgebra", ">= 2022.12-05" ],
                            [ "PreSheaves", ">= 2024.11-06" ],
                         ],

  SuggestedOtherPackages := [ [ "Locales", ">= 2023.05-05" ],
                            ],

  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

Keywords := [ "Chains", "Cochains", "MappingCone", "MappingCylinder", "Homotopy" ],

));
