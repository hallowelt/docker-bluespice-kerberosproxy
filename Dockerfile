FROM debian:bookworm-slim
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
	&& apt-get update \
	&& apt-get install -y krb5-config \
	krb5-locales \
	krb5-user \
	apache2 \
	libapache2-mod-proxy-uwsgi \
	libapache2-mod-auth-gssapi
RUN a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests headers
COPY root-fs/etc/apache2/sites-enabled/kerberos-proxy.conf /etc/apache2/sites-available/000-default.conf
COPY kerberos-template /kerberos-template
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]