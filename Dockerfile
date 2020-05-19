FROM archlinux
RUN ln -sf /usr/share/zoneinfo/Europe/Budapest /etc/localtime && \
    echo -n 'Server = http://ftp.energia.mta.hu/pub/mirrors/ftp.archlinux.org/$repo/os/$arch' > /etc/pacman.d/mirrorlist && \
    pacman -Sy --noconfirm nettle squid && \
    pacman -Scc --noconfirm && \
    mkdir -p /etc/squid/cert && \
    chown proxy:proxy /etc/squid/cert/
VOLUME /etc/squid
EXPOSE 3128
COPY start.sh /start.sh
USER proxy
CMD ["/start.sh"]
#CMD ["sh", "-c", "/usr/lib/squid/security_file_certgen -c -s /var/cache/squid/ssl_db -M 4MB && \
#    /usr/sbin/squid -f /etc/squid/squid.conf -N -z && \
#    exec /usr/sbin/squid -YCd 1 -N -f /etc/squid/squid.conf"]
