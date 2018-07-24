FROM httpd:latest

RUN apt-get update -y && apt-get install git hugo curl -y
RUN curl https://getcaddy.com | bash -s personal
RUN chown root:root /usr/local/bin/caddy && chmod 755 /usr/local/bin/caddy

ADD https://github.com/gohugoio/hugo/releases/download/v0.42.2/hugo_0.42.2_Linux-64bit.deb /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb \
	&& rm /tmp/hugo.deb

COPY ./hugo.conf /usr/local/apache2/conf/httpd.conf

COPY . /usr/local/apache2/htdocs/
WORKDIR /usr/local/apache2/htdocs/

RUN git clone https://github.com/RealOrangeOne/hugo-theme-revealjs.git themes/hugo-theme-revealjs
RUN hugo
RUN chown -R www-data:www-data /usr/local/apache2/htdocs/
