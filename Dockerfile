FROM turistforeningen/ruby-iojs:2.2-1.8

ENV GITHUB_GEM_VERSION 38

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN gem install --no-document \
  github-pages:${GITHUB_GEM_VERSION} \
  jekyll-github-metadata

EXPOSE 4000
CMD jekyll serve -w --force_polling -H 0.0.0.0 -P 4000
