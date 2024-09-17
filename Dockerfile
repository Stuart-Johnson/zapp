# Use the official Ruby image
FROM ruby:3.3.1

# Set environment
ENV RAILS_ENV=development

# Install required dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  postgresql-client

# Set up working directory
WORKDIR /app

# Install bundler and node modules
COPY Gemfile* ./
RUN bundle install

# Copy the entire app
COPY . .

# Precompile assets (if any)
RUN bundle exec rails assets:precompile

# Expose the port Rails will run on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
