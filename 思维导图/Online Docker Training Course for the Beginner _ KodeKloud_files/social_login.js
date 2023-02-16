jQuery(window).load(function () {
    function mo_openid_set_cookie(cname,cvalue){var d=new Date();d.setTime(d.getTime()+(3*60*1000));var expires="expires="+d.toUTCString();document.cookie=cname+"="+cvalue+";"+expires+";path=/"}
    function mo_openid_get_cookie(cname){var name=cname+"=";var ca=document.cookie.split(';');for(var i=0;i<ca.length;i++){var c=ca[i];while(c.charAt(0)==' '){c=c.substring(1)}
        if(c.indexOf(name)==0){return c.substring(name.length,c.length)}}
        return""}

    // If cookie is set, scroll to the position saved in the cookie.
    if ( (mo_openid_get_cookie("scroll")) !== 'null' ) {
        jQuery(document).scrollTop( mo_openid_get_cookie("scroll") );
        mo_openid_set_cookie("scroll",null);
    }

    // When a button is clicked...
    jQuery('.mo_openid_custom-login-button').on("click", function() {
        // Set a cookie that holds the scroll position.
        mo_openid_set_cookie("scroll",jQuery(document).scrollTop());
    });

    jQuery('.login-button').on("click", function() {
        // Set a cookie that holds the scroll position.
        mo_openid_set_cookie("scroll",jQuery(document).scrollTop());
    });


});

jQuery(document).ready(function () {
    //show mcrypt extension installation reason

    jQuery("#openid_sharing_shortcode_title").click(function () {
        jQuery("#openid_sharing_shortcode").slideToggle(400);
    });

});

function moOpeniddeletelinkaccount(elem, userId, $identifier) {

    var confirm_dialog = confirm("Do you want to continue ?");
    if (confirm_dialog == true) {

        jQuery.ajax({
            url: my_ajax_object.ajax_url, //the page containing php script
            method: "POST", //request type,
            data: {action:"delete_account", user_id: userId, linked_social_app_identifier: $identifier},
            dataType:"text",
            success: function (success) {
                alert("Linked account is deleted. Press OK to continue.");
                window.location.reload(true);
            }
        });
    } else {
        window.location.reload(true);
        return false;
    }
}
