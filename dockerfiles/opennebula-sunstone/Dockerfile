FROM asteven/opennebula-packages:5.8.4 as builder

FROM ubuntu:18.04

LABEL maintainer="steven@armstrong.cc"

# Tini as pid 1.
COPY --from=builder /tini /tini
ENTRYPOINT ["/tini", "--", "/usr/bin/ruby", "/usr/lib/one/sunstone/sunstone-server.rb"]


# Install OpenNebula and ruby gems.
COPY --from=builder /packages /packages
RUN cat /packages/repo.list
RUN ln -s /packages/repo.list /etc/apt/sources.list.d/opennebula.list
RUN apt-get -y update \
 && ln -s /bin/true /usr/local/bin/systemd-tmpfiles \
 && apt-get -y install lsb-release libcurl4-openssl-dev opennebula-sunstone \
 && rm -f /usr/local/bin/systemd-tmpfiles \
 && apt-get -y clean

RUN sed -i 's/apt-get install/apt-get -y install/g' /usr/share/one/install_gems
RUN echo '0\n' | /usr/share/one/install_gems sunstone
RUN mkdir -p /var/log/one /var/lock/one
RUN chown oneadmin: /var/log/one /var/lock/one


# Logging to /dev/stdout, do not daemonize novnc-server
RUN sed -i 's|^\(SUNSTONE_LOG *=\).*|\1 "/dev/stdout"|' /usr/lib/one/sunstone/sunstone-server.rb \
 && sed -i 's|^\(VNC_LOG *=\).*|\1 "/dev/stdout"|' /usr/bin/novnc-server \
 && sed -i '/cmd *=/a\        exec(cmd)' /usr/lib/one/ruby/OpenNebulaVNC.rb

USER oneadmin
