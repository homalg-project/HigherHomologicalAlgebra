





InstallOtherMethod( LaTeXStringOp,
        [ IsCapCategoryCellInAFullSubcategory ],
        
  cell -> LaTeXStringOp( UnderlyingCell( cell ) )
);
