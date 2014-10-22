#!/bin/bash

## Install Plugins
cd /app/wp/
wp plugin install advanced-custom-fields --allow-root
wp plugin install regenerate-thumbnails --allow-root
wp plugin install wp-migrate-db --allow-root
wp plugin install wp-super-cache --allow-root
wp plugin install http://www.colab-plugin-repository.com.php54-3.ord1-1.websitetestlink.com/plugins/acf-gallery.zip --allow-root
wp plugin install http://www.colab-plugin-repository.com.php54-3.ord1-1.websitetestlink.com/plugins/acf-options-page.zip --allow-root
wp plugin install http://www.colab-plugin-repository.com.php54-3.ord1-1.websitetestlink.com/plugins/acf-repeater.zip --allow-root
wp plugin install http://www.colab-plugin-repository.com.php54-3.ord1-1.websitetestlink.com/plugins/gravityforms_1.8.9.12.zip --allow-root
wp plugin uninstall hello --allow-root
wp plugin uninstall akismet --allow-root