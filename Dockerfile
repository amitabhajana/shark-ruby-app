FROM ruby:2.6.7-alpine

ENV BUNDLER_VERION=2.0.2

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      imagemagick \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs  \
      openssl \
      pkgconfig \
      postgresql-dev \
      tzdata \
      yarn \
      python2 

RUN gem install bundler -v 2.0.2
RUN gem install nokogiri
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle update
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install 

COPY package.json yarn.lock ./
RUN yarn install

COPY . ./

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]


