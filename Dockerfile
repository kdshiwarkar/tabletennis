FROM httpd:latest
WORKDIR target/
COPY target/tabletennis.war /var/www/html/
EXPOSE 80
CMD ["apachectl", "-DFOREGROUND"]
