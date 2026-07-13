# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#

##
InstallMethod( CallFuncList,
          [ IsCapFunctor, IsList ],
  
  { F, a } -> ApplyFunctor( F, a[ 1 ] )
);

##
InstallGlobalFunction( CheckFunctoriality,
  
  { F, alpha, beta } -> IsCongruentForMorphisms( ApplyFunctor( F, PreCompose( alpha, beta ) ), PreCompose( ApplyFunctor( F, alpha ), ApplyFunctor( F, beta ) ) )
);

##
InstallGlobalFunction( CheckNaturality,
  
  { eta, alpha } -> IsCongruentForMorphisms(
                        PreCompose( ApplyFunctor( Source( eta ), alpha ), ApplyNaturalTransformation( eta, Range( alpha ) ) ),
                        PreCompose( ApplyNaturalTransformation( eta, Source( alpha ) ), ApplyFunctor( Range( eta ), alpha ) ) )
);

##
InstallMethod( CallFuncList,
          [ IsCapNaturalTransformation, IsList ],
  
  { nat, a } -> ApplyNaturalTransformation( nat, a[ 1 ] )
);

##
InstallMethod( Display,
          [ IsCapFunctor ],
  
  function ( F )
    
    Print( Concatenation( Name( F ), ":", "\n\n",
                          Name( SourceOfFunctor( F ) ), "\n",
                          "  |\n",
                          "  V\n",
                          Name( RangeOfFunctor( F ) ), "\n" ) );
    
end );
