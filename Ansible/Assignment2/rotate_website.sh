#!/bin/bash

websites=("deepak" "aditya" "waseem")

# Get the current website from the nginx config file
current_site=$(awk '/root/ { print $2 }' /etc/nginx/sites-enabled/default | awk -F"/" '{print $4}' | awk -F";" '{print $1}')
current_site_index=0
serving_site_index=0

echo "current site $current_site"

for website in "${websites[@]}"
do
    if [ "$current_site" == "$website" ]; then
        break
    fi
    current_site_index=$((current_site_index+1))
done

echo "current site index $current_site_index"

serving_site_index=$((current_site_index+1))
if [ $serving_site_index -ge ${#websites[@]} ]; then
    serving_site_index=0
fi

new_website=${websites[$serving_site_index]}
echo "serving site: $new_website"

sed -i "s/${current_site}/${new_website}/" /etc/nginx/sites-enabled/default
sed -i "s/${current_site}/${new_website}/" /etc/apache2/sites-available/000-default.conf
nginx -s reload
systemctl reload apache2