# Archlinux with Squid installed docker image

## Run with your own certificate

~~~ bash
sudo docker run -ti -v $PWD/conf/squid.conf:/etc/squid/squid.conf -v $PWD/conf/cert/:/etc/squid/cert/ -p 3128:3128 --name arch-squid archlinux/squid
~~~

## Run without a certificate, it is generated...

~~~ bash
sudo docker run -ti -v $PWD/conf/squid.conf:/etc/squid/squid.conf -p 3128:3128 --name arch-squid archlinux/squid
~~~
