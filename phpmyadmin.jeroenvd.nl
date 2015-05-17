<VirtualHost *:80>
        ServerName phpmyadmin.jeroenvd.nl

        RewriteEngine on
        RedirectMatch /(.*) https://phpmyadmin.jeroenvd.nl/$1
</VirtualHost>

<VirtualHost *:443>

        # Server Configuratie

        ServerName phpmyadmin.jeroenvd.nl:443
        
        # SSL Configuratie

        SSLEngine on
        ErrorLog /var/log/apache2/ssl_error_log
        TransferLog /var/log/apache2/ssl_access_log
        CustomLog /var/log/apache2/ssl_request_log "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
        LogLevel warn

        SSLCertificateFile      /ssl/jeroenvd.nl.crt
        SSLCertificateKeyFile   /ssl/jeroenvd.nl.key

        SSLProtocol all -SSLv2
        SSLCipherSuite ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW

        # Error Documents
        #Alias /maintenance /srv/www/htdocs/
        #ErrorDocument 503 /maintenance/

        #<Directory /srv/www/htdocs>
        #        Order deny,allow
        #        Allow from all
        #        DirectoryIndex index.html
        #</Directory>

        # PROXY Configuratie

        ProxyRequests Off
        ProxyPreserveHost On
        SSLProxyEngine on

        <Proxy *>
                Order deny,allow
                Allow from all
                
        </Proxy>

        ProxyPass /maintenance !
        
        ProxyPass /  https://phpmyadmin/
        ProxyPassReverse / https://phpmyadmin/

</VirtualHost>
