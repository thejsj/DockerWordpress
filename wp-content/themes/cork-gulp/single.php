<?php get_header(); ?>
<?php if(have_posts()) : while(have_posts()) : the_post(); ?>
<?php $this_page = new Post(get_the_ID()); ?>
<div id="main" role="main">
	<h2><?php the_title(); ?></h2>
	<?php the_content(); ?>
</div>
<?php endwhile; endif; ?>
<?php get_sidebar(); ?>
<?php get_footer(); ?>