server {
    server_name mywebsite.com;

    # HTTP configuration
    listen 80;
    listen [::]:80;

    # HTTP to HTTPS
    # if ($scheme != "https") {
    #     return 301 https://$host$request_uri;
    # } # managed by Certbot

    # # HTTPS configuration
    # listen [::]:443 ssl ipv6only=on; # managed by Certbot
    # listen 443 ssl; # managed by Certbot
    # ssl_certificate /etc/letsencrypt/live/mywebsite.com/fullchain.pem; # managed by Certbot
    # ssl_certificate_key /etc/letsencrypt/live/mywebsite.com/privkey.pem; # managed by Certbot
    # include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    # ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    location / {
        proxy_pass http://localhost:3000;
        proxy_redirect off;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Cookie $http_cookie;
        proxy_set_header Origin $http_origin;
        proxy_read_timeout 900;
    }
}