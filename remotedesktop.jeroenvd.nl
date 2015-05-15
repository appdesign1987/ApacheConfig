<VirtualHost *:80>
        ServerName remotedesktop.jeroenvd.nl

        RewriteEngine on
        RedirectMatch /(.*) https://remotedesktop.jeroenvd.nl/$1
</VirtualHost>

<VirtualHost *:443>

        # Server Configuratie

        ServerName remotedesktop.jeroenvd.nl:443

        # SSL Configuratie

        SSLEngine on
        ErrorLog /var/log/apache2/remotedesktop.jeroenvd.nl/ssl_error_log
        TransferLog /var/log/apache2/remotedesktop.jeroenvd.nl/ssl_access_log
        CustomLog /var/log/apache2/remotedesktop.jeroenvd.nl/ssl_request_log "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
        LogLevel warn

         SSLCertificateFile      /etc/apache2/ssl/STAR_jeroenvd_nl.crt
        SSLCertificateKeyFile   /etc/apache2/ssl/jeroenvd.nl.key


        SSLProtocol all -SSLv2
        SSLCipherSuite ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW

#        SetEnvIf User-Agent ".*MSIE.*" nokeepalive ssl-unclean-shutdown downgrade-1.0 force-response-1.0
#        SetEnvIf User-Agent "Mail" blockAppleMail=1

        # Error Documents
       # Alias /maintenance /srv/www/htdocs/
       # ErrorDocument 503 /maintenance/

       # <Directory /srv/www/htdocs>
       #         Order deny,allow
       #         Allow from all
       #         DirectoryIndex index.html
       # </Directory>

        # Rewrite
        #RewriteEngine on
        #RewriteRule ^/$ /owa [R=301,L]

        # PROXY Configuratie

        ProxyRequests Off
        ProxyPreserveHost On
        SSLProxyEngine on

        <Proxy *>
                Order deny,allow
                Allow from all

        </Proxy>

        ProxyPass /maintenance !

        ProxyPass / https://192.168.88.201:8081/
        ProxyPassReverse / https://192.168.88.201:8081/
        
        </VirtualHost>
