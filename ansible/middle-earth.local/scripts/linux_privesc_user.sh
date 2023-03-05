#!/bin/bash

# create user
pass=$(perl -e 'print crypt($ARGV[0], "R+4hWKx*3HV5C#hYvdpn")' $password)
useradd -m -p "$pass" "tom" || true

echo '''#!/bin/bash

cp -r /var/www/glpi/ /backup
''' > /var/www/backup.sh
chown www-data:www-data /var/www/backup.sh
chmod +x /var/www/backup.sh

echo "* * * * * bash /var/www/backup.sh" | crontab -u tom -
