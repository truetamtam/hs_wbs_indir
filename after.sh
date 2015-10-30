#!/bin/sh                                                                             
                                                                                      
# If you would like to do some extra provisioning you may                             
# add any commands you wish to this file and they will                                
# be run after the Homestead machine is provisioned.                                  

# vim
#
sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /home/vagrant/.bashrc      
echo "syntax on\nset nu\n" > /home/vagrant/.vimrc                                     

# locale
#
locale-gen ru_RU.UTF-8                                                                
update-locale                                                                         


# stopping nginx
# installing apache2
#
service nginx stop
apt-get update
apt-get install -y apache2 php5 libapache2-mod-php5
# enabling rewrite module
a2enmod rewrite

# opcache
#
sed -i 's/;opcache.revalidate_freq=2/opcache.revalidate_freq=0/' /etc/php5/apache2/php.ini

# apache2 localhost error fix
#
echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
a2enconf fqdn

# apache2 config
#
sed -i '166s/None/All/' /etc/apache2/apache2.conf
sed -i 's,/var/www/html,/var/www/wbsdir.dev,' /etc/apache2/sites-available/000-default.conf
sed -i 's,#ServerName www.example.com,ServerName wbsdir.dev,' /etc/apache2/sites-available/000-default.conf
# running from vagrant user. Crusial for mac.
sed -i 's/www-data/vagrant/' /etc/apache2/envvars

service apache2 restart
