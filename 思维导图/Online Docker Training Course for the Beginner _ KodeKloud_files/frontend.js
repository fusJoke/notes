/* JavaScript for Frontend pages */
jQuery(document).ready(function($) {
	/**
	 * Returns the value of a cookie.
	 *
	 * @param string name The cookie name.
	 * @return mixed
	 */
	function get_cookie(name) {
		// If js-cookie is installed, use it
		if(typeof Cookies != 'undefined') {
			return Cookies.get(name);
		}
		if(typeof $.cookie != 'undefined') {
			return $.cookie(name);
		}
		return null;
	}

	/**
	 * Returns the value of a cookie.
	 *
	 * @param string name The cookie name.
	 * @param string cookie_path The cookie path.
	 * @return mixed
	 */
	function remove_cookie(name, cookie_path) {
		// If js-cookie is installed, use it
		if(typeof Cookies != 'undefined') {
			return Cookies.remove(name, { path: cookie_path } );
		}
		if(typeof $.cookie != 'undefined') {
			return $.removeCookie(name, { path: cookie_path } );
		}
		return false;
	}

	try {
		// Invalidate cache of WooCommerce minicart when user logs in. This will
		// ensure that the minicart is updated correctly
		var supports_html5_storage = ('sessionStorage' in window && window['sessionStorage'] !== null);
		if(supports_html5_storage && get_cookie('aelia_user_logged_in')) {
			// The fragment name might be generated dynamically by WooCommerce, so
			// we have to retrieve it from the WC parameters
			// @since WC 3.1
			var fragment_name = 'wc_fragments';
			if((typeof wc_cart_fragments_params !== 'undefined') && wc_cart_fragments_params && wc_cart_fragments_params.fragment_name) {
				fragment_name = wc_cart_fragments_params.fragment_name;
			}

			console.log('User logged in, refreshing cart fragments');
			sessionStorage.removeItem(fragment_name, '');

			// When set, the "user logged in" cookie contains the path for which it was
			// stored. This makes it easier to delete it, as we have the path handy
			var cookie_path = get_cookie('aelia_user_logged_in');
			remove_cookie('aelia_user_logged_in', cookie_path);
		}
	}
	catch(exception) {
		var error_msg = 'Aelia - Exception occurred while accessing window.sessionStorage. ' +
										'This could be caused by the browser disabling cookies. ' +
										'COOKIES MUST BE ENABLED for the site to work correctly. ' +
										'Exception details below.';
		console.log(error_msg);
		console.log(exception);
	}
});
