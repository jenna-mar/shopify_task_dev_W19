# Use an official Ruby image as a base
FROM ruby:2.3.3-slim
 
# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client
 
RUN mkdir /shopify_task_api

WORKDIR /shopify_task_api

# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
COPY Gemfile /shopify_task_api/Gemfile
 
COPY Gemfile.lock /shopify_task_api/Gemfile.lock
 
# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler
 
# Finish establishing our Ruby enviornment
RUN bundle install
 
# Copy the Rails application into place
COPY . /shopify_task_api

EXPOSE 3000

CMD bundle exec rails server -b 0.0.0.0