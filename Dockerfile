FROM turistforeningen/ruby-iojs

ENV GITHUB_GEM_VERSION 39

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN gem install --no-document \
  github-pages:${GITHUB_GEM_VERSION} \
  jekyll-github-metadata

EXPOSE 4000
CMD jekyll serve -d /_site --watch --force_polling -H 0.0.0.0 -P 4000
