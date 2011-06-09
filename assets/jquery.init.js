jQuery.noConflict();
     

jQuery(document).ready(function(){
  
  // Accordion on features
  jQuery("#features .link").click(function() {
    jQuery(this).next().slideToggle(200);
  });
     
    
}); 
