FROM archlinux
RUN ln -sf /usr/share/zoneinfo/Europe/Budapest /etc/localtime && \
    echo -n 'Server = http://ftp.energia.mta.hu/pub/mirrors/ftp.archlinux.org/$repo/os/$arch' > /etc/pacman.d/mirrorlist && \
    pacman -Sy --noconfirm nettle squid && \
    pacman -Scc --noconfirm && \
    mkdir -p /etc/squid/cert && \
    chown proxy:proxy /etc/squid/cert/
EXPOSE 3128
COPY start.sh /start.sh
USER proxy
CMD ["/start.sh"]
