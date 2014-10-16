<?php

/* Enqueue Scripts & Stylesheets 
---------------------------------------------------------------------- */
require_once(trailingslashit(get_stylesheet_directory()) . 'app/php/functions/queue-scripts.php');

/* Enqueue Global Utility Functions 
---------------------------------------------------------------------- */
require_once(trailingslashit(get_stylesheet_directory()) . 'app/php/functions/global-utilities.php');

/* Initialize Custom Post Types 
---------------------------------------------------------------------- */
require_once(trailingslashit(get_stylesheet_directory()) . 'app/php/functions/post-types.php');

/* Initialize Custom Taxonomies 
---------------------------------------------------------------------- */
 require_once(trailingslashit(get_stylesheet_directory()) . 'app/php/functions/taxonomies.php');

/* Classes
---------------------------------------------------------------------- */
require_once(trailingslashit( get_stylesheet_directory()) . 'app/php/classes/class-post.php');
require_once(trailingslashit( get_stylesheet_directory()) . 'app/php/classes/class-index.php');

/* Views
---------------------------------------------------------------------- */
// require_once(trailingslashit( get_stylesheet_directory()) . 'app/php/views/view.php');