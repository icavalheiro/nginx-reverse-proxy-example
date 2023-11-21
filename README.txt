install nginx and snapd: "sudo apt install nginx snapd -y"

install cerbot: "sudo apt install certbot --classic"

delete the default nginx link in sites enabled: "sudo rm /etc/nginx/sites-enabled/default"

put the file 'mywebsite.com' in "/etc/nginx/sites-available/"

create a link to sites enabled: "sudo ln -s /etc/nginx/sites-available/mywebsite.com /etc/nginx/sites-enabled/mywebsite.com"

make sure nginx is running "sudo service nginx start"

run certbot "sudo certbot --nginx"

now for automatic renew, put the "certbot" file in "/etc/cron.weekly/"
make sure to set it as executable "sudo chmod +x /etc/cron.weekly/certbot"

be happy