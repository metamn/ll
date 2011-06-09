jQuery.noConflict();
     

jQuery(document).ready(function(){
  
  // Accordion on features
  jQuery("#features .link").click(function() {
    jQuery(this).next().slideToggle(200);
  });
     
  // Hover on frontpage images
  jQuery("#index #features #item").hover(
    function () {
      jQuery(this).addClass('highlight');
    }, 
    function () {
      jQuery(this).removeClass('highlight');
    }
  );  
  
  // Tooltip in frontpage lessons
  jQuery("#index #courses li").tipTip({
    defaultPosition: "top",
    maxWidth: "300px",
    edgeOffset: 10
  });
  
}); 
