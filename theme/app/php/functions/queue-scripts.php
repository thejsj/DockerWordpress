<?php /* Enqueue Scripts & Stylesheets */

/* Primary Styles
---------------------------------------------------------------------- */
function primary_styles() {
	$random = rand();
	global $is_IE;
	
	if (!is_admin()) {
		wp_register_style('primary-styles', get_bloginfo( 'stylesheet_directory' ) . '/dist/css/app.css', false, $random);
		wp_register_style('ie8_below', get_bloginfo( 'stylesheet_directory' ) . '/dist/css/app_nomq.css', false, $random);
		wp_register_style('ie9_up', get_bloginfo( 'stylesheet_directory' ) . '/dist/css/app.css', false, $random);
		// 'ie9_up' - This is tied to neg_conditional function located in global-utilities.php
		
		wp_style_add_data('ie8_below', 'conditional', '(lt IE 9) & (!IEMobile)');
		wp_style_add_data('ie9_up', 'conditional', '(gt IE 8) | (IEMobile)');
		if($is_IE) {
			wp_enqueue_style('ie8_below');
			wp_enqueue_style('ie9_up');
		} else {
			wp_enqueue_style('primary-styles');
		}
	}
}
add_action( 'wp_enqueue_scripts', 'primary_styles' );


/* Login Styles
---------------------------------------------------------------------- */
function custom_login_styles() {
	echo '<link rel="stylesheet" type="text/css" href="' . get_bloginfo('template_directory') . '/dist/css/login.css" />';
}
add_action('login_head', 'custom_login_styles');


/* Scripts
---------------------------------------------------------------------- */
function load_theme_scripts() {
	$random = rand();
	
		wp_register_script('header', get_bloginfo('template_directory') . '/dist/js/header.js', array(), false, false);
		wp_enqueue_script('header');

		wp_deregister_script('jquery');

		wp_register_script('global', get_bloginfo('template_directory') . '/dist/js/global.js', array(), false, true);
		wp_enqueue_script('global');

}
add_action( 'wp_enqueue_scripts', 'load_theme_scripts' );