# Alpine Docker GitHub Pages [![Image Layers](https://images.microbadger.com/badges/image/starefossen/github-pages.svg)](https://microbadger.com/#/images/starefossen/github-pages)

Alpine Docker image for running GitHub Pages / Jekyll projects. Only 70 MB.

![Demo using GitHub Page on Docker](https://raw.githubusercontent.com/Starefossen/docker-github-pages/master/assets/demo.gif)

## Supported tags and respective `Dockerfile` links

* [`latest` (Dockerfile)](https://github.com/Starefossen/docker-github-pages/blob/master/Dockerfile)
* [`onbuild` (Dockerfile)](https://github.com/Starefossen/docker-github-pages/blob/master/onbuild/Dockerfile)

## What is GitHub Pages

GitHub Pages are public webpages hosted and published directly through your
GitHub repository.

## How to use this image

This image makes it easy to run your GitHub Pages page locally while developing –
refreshing changes automatically as you make them. All you need to do is to mount
your page in a volume under `/usr/src/app` like this:

```
$ docker run -t --rm -v "$PWD":/usr/src/app -p "4000:4000" starefossen/github-pages
```

Your Jekyll page will be available on `http://localhost:4000`.

Remember to add all the gems to your `_config.yml` file in order to get all the
different things to work correctly:

```
repository: your/repo

gems:
- jekyll-github-metadata
- jekyll-mentions
- jekyll-redirect-from
- jekyll-sitemap
- jemoji
```

Also, in order for the `{{ site.github }}` metadata variables to be populated
you need to set the `JEKYLL_GITHUB_TOKEN` environment variable with your GitHub
token.

```
$ docker run \
  -t --rm \
  -v "$PWD":/usr/src/app \
  -e JEKYLL_GITHUB_TOKEN=my-github-token \
  -p "4000:4000" starefossen/github-pages
```

## Docker compose

If you want to use Docker Compose instead, you can move a lot of the options into a `docker-compose.yml` at the root of your project:

```
version: '3'
services:
  jekyll:
    image: starefossen/github-pages
    environment:
      - "JEKYLL_GITHUB_TOKEN:${JEKYLL_GITHUB_TOKEN}"
    ports:
      - "4000"
    volumes:
      - ./:/usr/src/app
    tty: true
```

Then start the container with `docker-compose run --rm jekyll`.

## Slow filesystem issues in Docker for Mac

When running this image in [Docker for Mac](https://docs.docker.com/docker-for-mac/) you might experience slow page generation times. This is due to some limitations in the Docker for Mac filesystem integration. Changing the volume configuration to `-v "$PWD":/usr/src/app:delegated` will massively improve the page generation time, at the cost of delaying the generated files showing up in your host system slightly. In case you don't even need the generated pages on your host system, you can also exclude the `_site/` folder completely from being mounted by adding a container-only volume: `-v site:/usr/src/app/_site`.

## Image Variants

The `starefossen/github-pages` images come in two flavors, each designed for a
specific use case.

`starefossen/github-pages:<version>`

This is the defacto image. If you are unsure about what your needs are, you
probably want to use this one. It is designed to be used both as a throw away
container (mount your source code and start the container to start your app), as
well as the base to build other images off of.

`starefossen/github-pages:onbuild`

This image makes building derivative images easier. For most use cases, creating
a `Dockerfile` in the base of your project directory with the line `FROM
starefossen/github-pages:onbuild` will be enough to create a stand-alone image
for your project.

## License

This Docker image is licensed under the [MIT License](https://github.com/Starefossen/docker-github-pages/blob/master/LICENSE).

Software contained in this image is licensed under the following:

* github-pages gem: [MIT License](https://github.com/github/pages-gem/blob/master/LICENSE)
* github-metadata gem: [MIT License](https://github.com/jekyll/github-metadata/blob/master/LICENSE)
* jekyll: [MIT License](https://github.com/jekyll/jekyll/blob/master/LICENSE)
* ruby: [2-clause BSDL](https://github.com/ruby/ruby/blob/trunk/COPYING)
* iojs: [MIT License](https://github.com/iojs/io.js/blob/master/LICENSE)

## Supported Docker versions

This image is officially supported on Docker version v17.

Support for older versions (down to v1.0) is provided on a best-effort basis.

## User Feedback

### Documentation

* [Docker](http://docs.docker.com)
* [Jekyll](https://jekyllrb.org)
* [GitHub Pages](https://pages.github.com)

### Issues

If you have any problems with or questions about this image, please contact us
through a [GitHub issue](https://github.com/Starefossen/docker-github-pages/issues).

### Contributing

You are invited to contribute new features, fixes, or updates, large or small;
we are always thrilled to receive pull requests, and do our best to process them
as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub
issue](https://github.com/Starefossen/docker-github-pages/issues), especially
for more ambitious contributions. This gives other contributors a chance to
point you in the right direction, give you feedback on your design, and help
you find out if someone else is working on the same thing.
