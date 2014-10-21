<?php /* Custom Taxonomies */

/* Create Taxonomies
---------------------------------------------------------------------- */
function create_taxonomies() {
	// taxonomy_init(
	// 	$settings = array(
	// 		'slug'      	=>  'sample',			// Required
	// 		'singular'  	=>  'Sample',			// Required
	// 		'plural'    	=>  'Samples',			// Required
	// 		'post_types'	=>  'your_CPT',			// Required
	// 	)
	// );
}

/* Programatically Register Taxonomies (*** DO NOT EDIT ***)
---------------------------------------------------------------------- */
add_action('init', 'create_taxonomies');
function taxonomy_init($settings) {
	$labels = array(
		'name'              =>  _x($settings['plural'], 'taxonomy general name'),
		'singular_name'     =>  _x($settings['singular'], 'taxonomy singular name'),
		'search_items'      =>  __('Search ' . $settings['plural']),
		'all_items'         =>  __('All ' . $settings['plural']),
		'parent_item'       =>  __('Parent ' . $settings['singular']),
		'parent_item_colon' =>  __('Parent ' . $settings['singular'] . ':'),
		'edit_item'         =>  __('Edit ' . $settings['singular']),
		'update_item'       =>  __('Update ' . $settings['singular']),
		'add_new_item'      =>  __('Add New ' . $settings['singular']),
		'new_item_name'     =>  __('New ' . $settings['singular'] . ' Name'),
		'menu_name'         =>  __($settings['singular']),
	);

	$args = array(
		'labels'            =>  $labels,
		'hierarchical'      =>  (isset($settings['hierarchical']) ? $settings['hierarchical'] : true),
		'show_ui'           =>  (isset($settings['show_ui']) ? $settings['show_ui'] : true),
		'show_admin_column' =>  (isset($settings['show_admin_column']) ? $settings['show_admin_column'] : true),
		'query_var'         =>  (isset($settings['query_var']) ? $settings['query_var'] : true),
		'rewrite'           =>  array('slug' => $settings['slug']),
	);

	register_taxonomy($settings['slug'], $settings['post_types'], $args);
}