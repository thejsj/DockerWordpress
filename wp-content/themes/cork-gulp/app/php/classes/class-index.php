<?php 

	class Index extends Post {

		function __construct() {
			$this->is_blog_home = $this->is_blog_home();
			$this->index_page_type = $this->get_index_page_type();
			$this->index_headline = $this->get_index_headline($this->is_blog_home, $this->index_page_type);
			$this->pagination = $this->pagination();
		}

		// 	IS BLOG HOME: 
		//	Returns boolean
		public function is_blog_home() {
			$is_blog_home = is_home() ? true: false;
			return $is_blog_home;
		}

		// 	INDEX PAGE TYPE: 
		//	Returns boolean
		public function get_index_page_type() {
			$index_page_type = (object) array();
			$index_page_type->is_blog_category = is_category() ? true: false;
			$index_page_type->is_blog_tag = is_tag() ? true: false;
			$index_page_type->is_blog_day = is_day() ? true: false;
			$index_page_type->is_blog_month = is_month() ? true: false;
			$index_page_type->is_blog_year = is_year() ? true: false;
			$index_page_type->is_blog_author = is_author() ? true: false;

			return $index_page_type;
		}

		//	INDEX HEADER VALUES
		//	Returns string
		public function get_index_headline($is_blog_home, $index_page_type) {
			if($is_blog_home) {
				$index_headline = 'Blog Index';
			} else {
				if($index_page_type->is_blog_category) {
					$category = single_term_title("", false);
					$index_headline = 'Archives for the "' . $category . '" Category';
				} elseif($index_page_type->is_blog_tag) {
					$tag = single_term_title("", false);
					$index_headline = 'Archives for the "' . $tag . '" Category';
				} elseif($index_page_type->is_blog_day) {
					$index_headline = 'Archive for ' . get_the_time('F jS, Y');	
				} elseif($index_page_type->is_blog_month) {
					$index_headline = 'Archive for ' . get_the_time('F Y');	
				} elseif($index_page_type->is_blog_year) {
					$index_headline = 'Archive for ' . get_the_time('Y');	
				} elseif($index_page_type->is_blog_author) {
					$index_headline = 'Author Archive';	
				} else {
					$index_headline = 'Blog Archives';
				}				
			}
			return $index_headline;
		}
	
		//	PAGINATION
		//	Returns HTML Links
		public function pagination($prev = '&laquo;', $next = '&raquo;') {
			global $wp_query, $wp_rewrite;
			$wp_query->query_vars['paged'] > 1 ? $current = $wp_query->query_vars['paged'] : $current = 1;
			$pagination = array(
				'base' => @add_query_arg('paged','%#%'),
				'format' => '',
				'total' => $wp_query->max_num_pages,
				'current' => $current,
				'prev_text' => __($prev),
				'next_text' => __($next),
				'type' => 'plain'
			);
			if($wp_rewrite->using_permalinks())
			$pagination['base'] = user_trailingslashit(trailingslashit(remove_query_arg('s', get_pagenum_link(1))) . 'page/%#%/', 'paged' );

			if(!empty($wp_query->query_vars['s']))
			$pagination['add_args'] = array('s' => get_query_var('s'));

			return paginate_links($pagination);
		}
	}