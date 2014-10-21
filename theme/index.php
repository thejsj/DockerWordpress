<?php get_header(); ?>
<?php $index = new Index(get_the_ID()); ?>
<div id="main" role="main">
	<h1><?php echo $index->index_headline; ?></h1>
	<?php if(have_posts()) : while(have_posts()) : the_post(); ?>
		<?php $this_post = new Post(get_the_ID()); ?>
		<article role="article">
			<h2><a href="<?php the_permalink(); ?>"><?php the_title();?></a></h2>
			<?php the_excerpt(); ?>
		</article>
	<?php endwhile; ?>
	<?php else : ?>
		<div>
			<h2>Sorry!</h2>
			<p>No posts have been published just yet.</p>
		</div>
	<?php endif;?>
	<div class="pagination">
		<?php echo $index->pagination; ?>
	</div>
</div>
<?php get_sidebar(); ?>
<?php get_footer(); ?>
