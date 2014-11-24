get-passenger

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
sudo apt-get install apt-transport-https ca-certificates

Create a file /etc/apt/sources.list.d/passenger.list

deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main



sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 600 /etc/apt/sources.list.d/passenger.list
sudo apt-get update


sudo apt-get install nginx-extras passenger

Edit /etc/nginx/nginx.conf and uncomment passenger_root and passenger_ruby

sudo service nginx restart

make-passenger