<VirtualHost *:80>
        ServerName seafile.jeroenvd.nl

        RewriteEngine on
        RedirectMatch /(.*) https://seafile.jeroenvd.nl/$1
</VirtualHost>

<VirtualHost *:443>

        # Server Configuratie

        ServerName seafile.jeroenvd.nl:443
        
        # SSL Configuratie

        SSLEngine on
        ErrorLog /var/log/apache2/seafile.jeroenvd.nl/ssl_error_log
        TransferLog /var/log/apache2/seafile.jeroenvd.nl/ssl_access_log
        CustomLog /var/log/apache2/seafile.jeroenvd.nl/ssl_request_log "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
        LogLevel warn

#        SSLCACertificateFile    /etc/apache2/ssl/COMODORSADomainValidationSecureServerCA.crt
#        SSLCertificateChainFile /etc/apache2/ssl/
         SSLCertificateFile      /etc/apache2/ssl/STAR_jeroenvd_nl.crt
        SSLCertificateKeyFile   /etc/apache2/ssl/jeroenvd.nl.key

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

        # Rewrite
        RewriteEngine on

<Proxy *>
                Order deny,allow
                Allow from all
                
        </Proxy>
       
       ProxyPass /seafhttp  http://192.168.88.162:8082/
       ProxyPass /  http://192.168.88.162:8000/
       
</VirtualHost>
