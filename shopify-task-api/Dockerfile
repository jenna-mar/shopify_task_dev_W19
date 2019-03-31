# ./Dockerfile

FROM phusion/passenger-ruby23

# set some rails env vars
ENV RAILS_ENV production
ENV BUNDLE_PATH /bundle

# set the app directory var
ENV APP_HOME /home/app
ENV BUNDLE_PATH /bundle

RUN apt-get update -qq

# Install apt dependencies
RUN apt-get install -y --no-install-recommends \
  build-essential \
  curl libssl-dev \
  git \
  unzip \
  zlib1g-dev \
  libxslt-dev

# install bundler
RUN gem install bundler

# Separate task from `add . .` as it will be
# Skipped if gemfile.lock hasn't changed *
COPY Gemfile* ./

# Install gems to /bundle
RUN bundle install

ADD . .

# compile assets!
RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["/sbin/my_init"]