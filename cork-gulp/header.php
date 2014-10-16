<!DOCTYPE html>
<!--[if lt IE 8]><html class="no-js lt-ie10 lt-ie9 lt-ie8  <?php is_mobile(); ?>" <?php language_attributes(); ?>> <![endif]-->
<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9  <?php is_mobile(); ?>" <?php language_attributes(); ?>> <![endif]-->
<!--[if IE 9]><html class="no-js lt-ie10  <?php is_mobile(); ?>" <?php language_attributes(); ?>> <![endif]-->
<!--[if gt IE 9]><!-->
<html class="no-js <?php is_mobile(); ?>" <?php language_attributes(); ?>><!--<![endif]-->
<head>
<title><?php wp_title('|', true, 'right'); ?></title>
<meta charset="<?php bloginfo('charset'); ?>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="title" content="<?php wp_title( '|', true, 'right' ); ?>">
<meta name="viewport" id="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=10.0,initial-scale=1.0" />
<link rel="pingback" href="<?php bloginfo('pingback_url'); ?>" />
<?php wp_head(); ?>
</head>
	<body <?php body_class(); ?>>
		<div id="app">
			<header>
				<p>Cork - Gulp</p>
				<h1><a href="<?php bloginfo('url'); ?>">!!!<?php bloginfo('name'); ?>!!</a></h1>
			</header>