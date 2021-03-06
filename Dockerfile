FROM debian:latest

RUN apt-get update -y && apt-get install git curl -y
ADD https://github.com/gohugoio/hugo/releases/download/v0.42.2/hugo_0.42.2_Linux-64bit.deb /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb && rm /tmp/hugo.deb
RUN curl https://getcaddy.com | bash -s personal
RUN chown root:root /usr/local/bin/caddy && chmod 755 /usr/local/bin/caddy
RUN mkdir /srv/app
WORKDIR /srv/app
COPY . ./
RUN git clone https://github.com/RealOrangeOne/hugo-theme-revealjs.git themes/hugo-theme-revealjs
RUN hugo
EXPOSE 2015
CMD ["caddy"]
