/* This is custom Javascript */

jQuery(document).ready(function(){
   jQuery(".start-lab-button button").click(function(){
      let version=jQuery(this).data('version');
      let type=jQuery(this).data('type');
      if (typeof version !== 'undefined' && version !== false) {
         if(version==1){
            LoadLabVersion1();
            
         }
         if(version==2){
            LoadLabVersion2();
         }
     }
     if (typeof type !== 'undefined' && type !== false) {
            if(type='quiz'){

               LoadQuiz();
            }
     }
   });
   /* lesson/topic sidebar scroll jump fix */
   jQuery(".lms-topic-sidebar-wrapper .lms-toggle-lesson").on("click", function() {
      let bbHeaderHeight = jQuery('#masthead').outerHeight();
      jQuery('.lms-topic-sidebar-data').trigger("sticky_kit:detach");
      if( jQuery('body').hasClass('sticky-header') ) {
         jQuery('.lms-topic-sidebar-data').stick_in_parent({offset_top: bbHeaderHeight + 30 });
      } else {
         jQuery('.lms-topic-sidebar-data').stick_in_parent({offset_top: 30});
      }
   })
});
function LoadLabVersion1(){
jQuery.ajax({
   type : "post",
   url : ajax_object.ajax_url,
   data : {action: "get_lab_embed_code", nonce: ajax_object.nonce,version:1,kodekloud_id:ajax_object.kodekloud_id,lab_id:ajax_object.lab_id},
    beforeSend: function(){
     jQuery('.lab_button_wrap').hide();
     jQuery('.lab_embed').show();
   },
   success: function(response) {
      if(response!=0) {
         obj = jQuery.parseJSON(response);
         jQuery('.lab_embed').html('<script type="text/javascript" src="https://katacoda.com/embed.js"></script><div data-katacoda-userid="'+obj.email+'" data-katacoda-token="'+obj.token+'" data-katacoda-command="export SCENARIO_NAME='+ajax_object.kodekloud_id+'" data-katacoda-hideintro="false" data-katacoda-id="'+ajax_object.lab_id+'" data-katacoda-color="004d7f" style="height: 90vh;"></div>');
         //Rajendra code Start-1200307957472741
         //Enable full screen as soon as lab start
         screenMode('maximize');
         //Rajendra code Stop-1200307957472741
      }
      else {
         jQuery('.lab_embed').html('oops!Something went wrong please reload the page');
      }
   }
}); 
}
function LoadLabVersion2(){
   jQuery.ajax({
      type : "post",
      url : ajax_object.ajax_url,
     
      data : {action: "get_lab_embed_code", nonce: ajax_object.nonce,version:2,environment_id:ajax_object.environment_id,scenarioid_id:ajax_object.scenarioid_id,id:ajax_object.kk_post_id,cloud_lab:ajax_object.cloud_lab,cloud_lab_profile:ajax_object.cloud_lab_profile},
       beforeSend: function(){
        jQuery('.lab_button_wrap').hide();
        jQuery('.lab_embed').show();
      },
      success: function(response) {
          var baseUrl  = document.location.hostname === 'kodekloud.com' ?
              'https://manager.labs.kodekloud.com' :
              'https://manager.kk-lab-dev.kodekloud.com';

          if(response!=0) {
            obj = jQuery.parseJSON(response);
            var $labtheme = (jQuery("body").hasClass("bb-dark-theme")) ? "dark" : "light";
            if(ajax_object.cloud_lab && ajax_object.cloud_lab_profile){
               if(ajax_object.cloud_lab_provider=='cloudlabs'){
                  lab_url = baseUrl+"/?userid="+obj.email+"&token="+obj.token+"&cloud_lab=true&cloud_lab_provider=cloudlabs&cloud_lab_id=" + ajax_object.cloud_lab_profile+"&theme="+$labtheme;
               }else{
                  lab_url = baseUrl + "/?userid="+obj.email+"&token="+obj.token+"&cloud_lab=true&cloud_lab_profile_id=" + ajax_object.cloud_lab_profile+"&theme="+$labtheme;
               }
            }else{
               lab_url = baseUrl + "/?userid="+obj.email+"&token="+obj.token+"&environmentid=" + ajax_object.environment_id + "&labscenario=" + ajax_object.scenarioid_id+ "&coursename=" + obj.course_name+"&theme="+$labtheme;
            }
            
            jQuery('.lab_embed img').remove();
            jQuery('<iframe>', {
                   src: lab_url,
                   id:  'labFrame',
                   frameborder: 0,
                   scrolling: 'no',
                   style: 'width: 100%; height: 90vh;',
                   allow:'clipboard-read; clipboard-write'
                   }).appendTo('.lab_embed');   
           //Rajendra code Start-1200307957472741
           //Enable full screen as soon as lab start
           screenMode('maximize');       
           //Rajendra code Stop-1200307957472741        
         }
         else {
            jQuery('.lab_embed').html('oops!Something went wrong please reload the page');
         }
      }
   }); 
}
function LoadQuiz(){
   jQuery.ajax({
      type : "post",
      url : ajax_object.ajax_url,
      data : {action: "get_lab_embed_code", nonce: ajax_object.nonce,type:'quiz',quiz_id:ajax_object.quiz_id},
       beforeSend: function(){
        jQuery('.lab_button_wrap').hide();
        jQuery('.lab_embed').show();
      },
      
      success: function(response) {
         if(response!=0) {
            obj = jQuery.parseJSON(response);
            var quizUrl  = document.location.hostname === 'kodekloud.com' ?
              'https://mcq-ui.kodekloud.com' :
              'https://mcq-ui-staging.kodekloud.com';

            quiz_url = quizUrl+"/#/quiz?name=" + ajax_object.quiz_id + "&email="+obj.email+"&userid="+obj.email+"&token="+obj.token;
            jQuery('.lab_embed img').remove();
            jQuery('<iframe>', {
                   src: quiz_url,
                   id:  'labFrame',
                   frameborder: 0,
                   scrolling: 'yes',
                   style: 'width: 100%; height: 100vh;'
                   }).appendTo('.lab_embed');
         }
         else {
            jQuery('.lab_embed').html('oops!Something went wrong please reload the page');
         }
      }
   }); 

}
//Rajendra code Start-1200307957472741
//Show hide tooltip on Maximize and Minimize Icon
function ShowHideTooltip(status,time=null){
  if(status==true){
    jQuery("#header-aside > div > a.header-minimize-link.course-toggle-view").attr("data-balloon-visible",true);
  }
  if(status==false && time){
    setTimeout(function() { jQuery("#header-aside > div > a.header-minimize-link.course-toggle-view").removeAttr("data-balloon-visible");   },time);
  }
}
//Rajendra code Stop-1200307957472741


function getCookie(name) {
   var nameEQ = name + "=";
   var ca = document.cookie.split(';');
   for(var i=0;i < ca.length;i++) {
       var c = ca[i];
       while (c.charAt(0)==' ') c = c.substring(1,c.length);
       if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
   }
   return null;
}

function screenMode(type){
   if(!getCookie('lessonpanel')){
      if(type=='maximize'){
         jQuery( 'body' ).addClass( 'lms-side-panel-close' );
         jQuery( '.lms-topic-sidebar-wrapper' ).addClass( 'lms-topic-sidebar-close' );   
         ShowHideTooltip(true);
         ShowHideTooltip(false,5000);
      }
      if(type=='minimize'){
         jQuery( 'body' ).removeClass( 'lms-side-panel-close' );
         jQuery( '.lms-topic-sidebar-wrapper' ).removeClass( 'lms-topic-sidebar-close' );   
         ShowHideTooltip(true);
         ShowHideTooltip(false,5000);
      } 
     }
}


window.addEventListener('message', (event) => {
  if (event.data == "end_lab"){
   jQuery.ajax({
      type : "post",
      url : ajax_object.ajax_url,
      data : {action: "update_lab_topic_activity",nonce: ajax_object.nonce,id:ajax_object.kk_post_id},
       beforeSend: function(){
        jQuery('.lab_button_wrap').hide();
        jQuery('.lab_embed').show();
      },
      success: function(response) {

         //Success action
      }
   });
   screenMode('minimize');
  }
});
/*lab theme mode*/
jQuery( document ).on( 'click', '#bb-toggle-theme', function ( e ) {
      var $labtheme = (jQuery("body").hasClass("bb-dark-theme")) ? "light" : "dark";
      var  $labframe = document.getElementById("labFrame");
      if($labframe){
         console.log($labframe.contentWindow);
         var receiverUrl  = document.location.hostname === 'kodekloud.com' ?
              'https://manager.labs.kodekloud.com' :
              'https://manager.kk-lab-dev.kodekloud.com';
         $labframe.contentWindow.postMessage({ type: "theme", status: $labtheme }, receiverUrl);
         
      }
});