tutum-docker-wordpress-nosql
============================


Out-of-the-box Wordpress docker image which can be linked to MySQL.


Usage (standalone)
------------------

This image needs an external MySQL server or linked MySQL container. To create a MySQL container:

    docker run -d -e MYSQL_PASS="<your_password>" --name db -p 3306:3306 tutum/mysql:5.5

To run Wordpress by linking to the database created above:

    docker run -d --link db:db -e DB_PASS="<your_password>" -p 80:80 tutum/wordpress-stackable

Now, you can use your web browser to access Wordpress from the the follow address:

    http://localhost/

The installation wizard will appear.


Usage (as a base image)
-----------------------

If you want to use it as a base image to create your customized version of wordpress, you can do so by creating a `Dockerfile` similar to the following:

    FROM tutum/wordpress-stackable:latest

    # Add an initial data which will be automatically loaded when creating the database for the first time
    ADD initial_db.sql /initial_db.sql

    # Add custom themes, plugins and/or uploads
    ADD themes/ /app/wp-content/themes/
    ADD plugins/ /app/wp-content/plugins/
    ADD uploads/ /app/wp-content/uploads/
    RUN chown www-data:www-data /app/wp-content -R


Usage (using fig)
-----------------

To launch wordpress using `fig`, simply execute the following command:

    fig up -d

The first time that you run this command, a new MySQL container will be created, which will then be linked to the Wordpress container automatically. You can start using Wordpress from your browser at `http://localhost/`


Configuration (using fig)
-------------------------

Edit `fig.yml` to customize the wordpress service before running `fig up`:

The default `fig.yml` shows as follow:

    wordpress:
      build: .
      links:
       - db
      ports:
       - "80:80"
      environment:
        DB_NAME: wordpress
        DB_USER: admin
        DB_PASS: "**ChangeMe**"
        DB_HOST: "**LinkMe**"
        DB_PORT: "**LinkMe**"
    db:
      image: tutum/mysql:5.5
      environment:
        MYSQL_PASS: "**ChangeMe**"
	
- Change the ports `"80:80"` to map to a different port number: e.g. `"8080:80"` will run wordpress at port `8080`.

- Change the value of `DB_NAME`, `DB_PASS` credentials (name, password) to connect to MySQL. Value of `DB_USER` must be `admin` at this moment.

- Modify password of admin user in MySQL container by changing the value of `MYSQL_PASS`, must be the same value of `DB_PASS`.

- To use a MariaDB instead of MySQL, you can make the following changes to the `fig.yml` file:

        db:
          image: tutum/mariadb:latest
          environment:
            MARIADB_PASS: randpass

    And then, change `DB_PASS` to the same value as `MARIADB_PASS`.

