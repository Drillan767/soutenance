FROM debian:latest

RUN apt-get update -y && apt-get install git curl -y
RUN curl https://getcaddy.com | bash -s personal
RUN chown root:root /usr/local/bin/caddy && chmod 755 /usr/local/bin/caddy
RUN mkdir /srv/app
WORKDIR /srv/app
COPY . ./
RUN git clone https://github.com/RealOrangeOne/hugo-theme-revealjs.git themes/hugo-theme-revealjs
RUN apt-get install hugo -y
RUN hugo
EXPOSE 2015
CMD ["caddy"]
