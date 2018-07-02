FROM httpd:latest

ENV HUGO_VERSION 0.42.1
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb

ADD https://github.com/gohugoio/hugo/releases/download/v0.42.2/hugo_0.42.2_Linux-64bit.deb /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb \
	&& rm /tmp/hugo.deb

COPY ./hugo.conf /usr/local/apache2/conf/httpd.conf

COPY . /usr/local/apache2/htdocs/
WORKDIR /usr/local/apache2/htdocs/
RUN hugo
RUN chown -R www-data:www-data /usr/local/apache2/htdocs/