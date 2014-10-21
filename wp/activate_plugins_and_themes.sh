## Activate Plugins
cd /app/wp/
wp plugin activate advanced-custom-fields --allow-root
wp plugin activate regenerate-thumbnails --allow-root
wp plugin activate wp-migrate-db --allow-root
wp plugin activate wp-super-cache --allow-root
wp plugin activate acf-gallery --allow-root
wp plugin activate acf-options-page --allow-root
wp plugin activate acf-repeater --allow-root
wp plugin activate gravityforms --allow-root

# Activate Theme
wp theme activate cork-gulp --allow-root