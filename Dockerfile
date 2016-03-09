FROM starefossen/ruby-node:2-4

EXPOSE 4000

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install and configure UTF-8 locales
RUN apt-get -y update && \
  apt-get install -y locales && \
  dpkg-reconfigure locales && \
  locale-gen C.UTF-8 && \
  /usr/sbin/update-locale LANG=C.UTF-8 && \
  echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENV GITHUB_GEM_VERSION 54

RUN gem install --no-document \
  github-pages:${GITHUB_GEM_VERSION} \
  jekyll-github-metadata

CMD jekyll serve -d /_site --watch --force_polling -H 0.0.0.0 -P 4000
