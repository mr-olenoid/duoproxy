FROM ubuntu:focal
WORKDIR /scr/douproxy
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install build-essential libffi-dev perl zlib1g-dev wget ca-certificates -y
RUN wget https://dl.duosecurity.com/duoauthproxy-latest-src.tgz
RUN tar xzf duoauthproxy-*.tgz
RUN cd duoauthproxy-*-src && make
RUN cd duoauthproxy-*-src/duoauthproxy-build && ./install --install-dir=/opt/duoauthproxy --service-user=duo_authproxy_svc --log-group=duo_authproxy_grp --create-init-script=yes --silent
RUN apt-get clean -y
RUN rm -rf /scr/douproxy
CMD service duoauthproxy start && tail -F /opt/duoauthproxy/log/authevents.log
