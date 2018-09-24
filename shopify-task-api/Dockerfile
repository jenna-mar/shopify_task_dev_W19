# Use an official Ruby image as a base
FROM ruby:2.3.3-slim
 
# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client
 
# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/shopify_task_api
 
# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids
 
# Set our working directory inside the image
WORKDIR $RAILS_ROOT
 
# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
COPY Gemfile Gemfile
 
COPY Gemfile.lock Gemfile.lock
 
# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler
 
# Finish establishing our Ruby enviornment
RUN bundle install
 
# Copy the Rails application into place
COPY . .
 
# Define the script we want run once the container boots
# Use the "exec" form of CMD so our script shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "config/containers/app_cmd.sh" ]