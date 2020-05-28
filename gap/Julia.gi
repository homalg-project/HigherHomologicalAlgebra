##
InstallMethod( HomotopyCategoryObject,
        [ IsJuliaObject, IsInt ],
        
  function( diffs, N )
    
    return HomotopyCategoryObject( ConvertJuliaToGAP( diffs ), N );
    
end );
