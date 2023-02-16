/* This is custom Javascript */
jQuery(document).ready(function(){
   jQuery(".tec_cancel_membership").click(function(e){
      e.preventDefault();
      if(kk_woajax_object.user_email){
         jQuery('.te_loader').removeClass('hide');
         jQuery('.tec_cancel_membership').hide();
         jQuery('.woocommerce .teachable_error').remove();
         //kk_woajax_object.user_email
         const api_data = [];
         api_data['user_email']= kk_woajax_object.user_email;
         api_data['auth_token']= "JFGYfqkCduAkc0hXecsM8MszXpdO0kNI";
         var settings = {
            "url": "https://integrations-dot-kodekloud.appspot.com/teachable/cancel_user_subscription",
            "method": "POST",
            "headers": {
              "Content-Type": "application/json"
            },
            "data": JSON.stringify(Object.assign({}, api_data)),
          };
          jQuery.ajax(settings).done(function (response) {
            if(response.status=='done'){
               //location.reload(true);
               window.location.href=window.location.href
            }else{
               jQuery('.woocommerce').prepend(`
               <ul class="woocommerce-error teachable_error" role="alert">
                   <li data-id="teachable_cancel">Oops something went wrong please try again!</li>
               </ul>`);
               jQuery('.te_loader').addClass('hide');
               jQuery('.tec_cancel_membership').show();
            }
          });
      }
   });
});