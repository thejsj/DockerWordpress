<?php 

	class Post {

		function __construct($post_id) {
			$this->post_id = $post_id;
			$this->post = $this->get_post($this->post_id);
		}

		// 	GET POST: 
		//	Returns WP_Post object
		public function get_post($post_id) {
			return get_post($post_id);
		}
	}