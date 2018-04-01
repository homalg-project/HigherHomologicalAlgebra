############################################################################
#                                     GAP package
#
#  Copyright 2015,       Kamal Saleh  RWTH Aachen University
#
#! @Chapter StableCategoriesOfModulePresentationsOverExteriorAlgebra.gi
##
#############################################################################


########################
##
## Installer
##
########################


BindGlobal( "INSTALL_EXTRA_OPERATIONS_FOR_STABLE_CATEGORIES_OF_MODULE_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA",
  
  function( category )
  local test_function;
  
  test_function := TestFunctionForStableCategories( category );
  
  AddIsSplitMonomorphism( category, 
  
     function( mor )
     local M, R, m, A, id_M, sol, underlying_mor; 
     
     underlying_mor := UnderlyingMorphismOfTheStableMorphism( mor );
     
     if HasIsSplitMonomorphism( underlying_mor ) and IsSplitMonomorphism( underlying_mor ) then 
     
        return true;
        
     fi;
     
     M := UnderlyingMatrix( Source( mor ) );
     
     R := M!.ring;
     
     m := SyzygiesOfColumns( M );
     
     A := UnderlyingMatrix( mor );
     
     id_M := HomalgIdentityMatrix( NrColumns( M ), R );
     
     sol := SolveTwoSidedEquationOverExteriorAlgebra( UnionOfColumns( m, A ), M, -1*id_M );
     
     if sol = fail then 
     
        return false;
        
     else 
     
        return true;
        
     fi;
     
     end );
  
  AddIsSplitEpimorphism( category, 
  
     function( mor )
     local N, R, n, A, id_N, sol, underlying_mor; 
     
     underlying_mor := UnderlyingMorphismOfTheStableMorphism( mor );
     
     if HasIsSplitEpimorphism( underlying_mor ) and IsSplitEpimorphism( underlying_mor ) then 
     
        return true;
        
     fi;
     
     N := UnderlyingMatrix( Range( mor ) );
     
     R := N!.ring;
     
     n := SyzygiesOfColumns( N );
     
     A := UnderlyingMatrix( mor );
     
     id_N := HomalgIdentityMatrix( NrColumns( N ), R );
     
     sol := SolveTwoSidedEquationOverExteriorAlgebra( n, UnionOfRows( N, A ), -1*id_N );
     
     if sol = fail then 
     
        return false;
        
     else 
     
        return true;
        
     fi;
     
     end );
     
  AddIsIsomorphism( category, 
  
    function( mor )
    
    return IsSplitEpimorphism( mor ) and IsSplitMonomorphism( mor );
    
    end );
     
  end );
  
  
##################################
##
## Constructing the category
##
##################################

InstallMethod( StableCategoryOfLeftPresentationsOverExteriorAlgebra,
               [ IsHomalgRing ],
   function( R )
   local f, stable_cat;
   
   
   f := function( mor )
        local underlying_mor, M, N, A, sol, m;
        
        underlying_mor := UnderlyingMorphismOfTheStableMorphism( mor );
        
        if HasIsZero( underlying_mor ) and IsZero( underlying_mor ) then 
        
          return true;
          
        fi;
           
        M := UnderlyingMatrix( Source( mor ) );

        N := UnderlyingMatrix( Range( mor ) );
        
        # in this case M, N are free modules.
        if NrRows( M )= 0 or NrRows( N )= 0 then 
        
           return true; 
           
        fi;
        
        m := SyzygiesOfColumns( M );
        
        A := UnderlyingMatrix( mor );
        
        sol := SolveTwoSidedEquationOverExteriorAlgebra( m, N, A );
        
        if sol = fail then 
        
           return false;
           
        else 
        
           return true;
           
       fi;
       
       end;
       
   stable_cat := StableCategory( LeftPresentations( R ), f :FinalizeStableCategory := false );
   
   INSTALL_EXTRA_OPERATIONS_FOR_STABLE_CATEGORIES_OF_MODULE_PRESENTATIONS_OVER_EXTERIOR_ALGEBRA( stable_cat );
   
   return stable_cat;
   
end );


###############################
##
## Constructor
##
###############################
   
InstallMethod( AsLeftPresentationInStableCategory, 
                      [ IsHomalgMatrix ], 
   function( H )
   local R, cat; 
   
   R := H!.ring;
   
   cat :=  StableCategoryOfLeftPresentationsOverExteriorAlgebra( R );
   
   return AsStableCategoryObject( cat, AsLeftPresentation( H ) );
   
end );

InstallMethod( PresentationMorphismInStableCategory, 
                 [ IsStableCategoryObject, IsHomalgMatrix, IsStableCategoryObject ],
   function( M, H, N )
   local underlying_mor, R, cat; 
   
   R := H!.ring;
   
   cat :=  StableCategoryOfLeftPresentationsOverExteriorAlgebra( R );
   
   underlying_mor := PresentationMorphism( UnderlyingObjectOfTheStableObject( M ), H, UnderlyingObjectOfTheStableObject( N ) );
   
   return AsStableCategoryMorphism( cat, underlying_mor );
   
end );

   
   
   
   
   
   
   

