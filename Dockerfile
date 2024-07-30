FROM httpd:2.4
COPY target/tabletennis.war /usr/local/apache2/htdocs/
EXPOSE 80
CMD ["httpd-foreground"]
