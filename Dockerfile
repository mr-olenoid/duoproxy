FROM ubuntu:latest
WORKDIR /scr/douproxy
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install build-essential libffi-dev perl zlib1g-dev wget ca-certificates -y
RUN wget https://dl.duosecurity.com/duoauthproxy-latest-src.tgz
RUN tar xzf duoauthproxy-*.tgz
RUN cd duoauthproxy-*-src && make
RUN cd duoauthproxy-*-src/duoauthproxy-build && ./install --install-dir=/opt/duoauthproxy --service-user=duo_authproxy_svc --log-group=duo_authproxy_grp --create-init-script=yes --silent
RUN apt-get purge build-essential libffi-dev perl zlib1g-dev wget -y
RUN apt-get clean -y
RUN rm -rf /scr/douproxy
CMD /opt/duoauthproxy/bin/authproxy
